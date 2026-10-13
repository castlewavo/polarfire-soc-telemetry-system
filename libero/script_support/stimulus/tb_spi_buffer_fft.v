`timescale 1ns/1ps

module tb_spi_buffer_fft;

    reg clk = 0;
    always #4 clk = ~clk;

    reg rst_n = 0;

    reg spi_sck  = 0;
    reg spi_mosi = 0;
    reg spi_cs_n = 1;

    wire [15:0] sample_data;
    wire sample_valid;

    wire block_ready, release_block;
    wire sample_rd_en, sample_rd_valid;
    wire [9:0] sample_rd_addr;
    wire [15:0] sample_rd_data;

    reg start = 0;
    wire busy, done, results_ready;

    reg result_rd_en = 0;
    reg [9:0] result_rd_addr = 0;
    wire signed [31:0] result_real, result_imag;
    wire result_valid;

    wire [63:0] power_data;
    wire power_valid;

    localparam real PI = 3.141592653589793;

    spi_rx receiver (
        .clk(clk),
        .rst_n(rst_n),
        .spi_sck(spi_sck),
        .spi_mosi(spi_mosi),
        .spi_cs_n(spi_cs_n),
        .sample_data(sample_data),
        .sample_valid(sample_valid)
    );

    sample_buffer buffer_dut (
        .clk(clk),
        .rst_n(rst_n),
        .sample_data(sample_data),
        .sample_valid(sample_valid),
        .block_ready(block_ready),
        .release_block(release_block),
        .rd_en(sample_rd_en),
        .rd_addr(sample_rd_addr),
        .rd_data(sample_rd_data),
        .rd_valid(sample_rd_valid)
    );

    fft_core fft (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .busy(busy),
        .done(done),
        .results_ready(results_ready),

        .block_ready(block_ready),
        .release_block(release_block),
        .sample_rd_en(sample_rd_en),
        .sample_rd_addr(sample_rd_addr),
        .sample_rd_data(sample_rd_data),
        .sample_rd_valid(sample_rd_valid),

        .result_rd_en(result_rd_en),
        .result_rd_addr(result_rd_addr),
        .result_real(result_real),
        .result_imag(result_imag),
        .result_valid(result_valid)
    );

    fft_magnitude magnitude (
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(result_valid),
        .in_real(result_real),
        .in_imag(result_imag),
        .out_valid(power_valid),
        .out_power(power_data)
    );

    // magnitude scoreboard expected value <-> accepted bin
    reg [63:0] expected_power [0:4095];
    integer power_sent = 0;
    integer power_checked = 0;

    longint signed ref_real;
    longint signed ref_imag;

    always @(posedge clk) begin
        if (!rst_n) begin
            power_sent = 0;
            power_checked = 0;
        end else begin
            if (result_valid === 1'b1) begin
                if ((^result_real === 1'bx) || (^result_imag === 1'bx))
                    $fatal(1, "uknown magnitude input");

                if (power_sent >= 4096)
                    $fatal(1, "scoreboard capacity exceeded");

                // sign-extend before multiplication
                ref_real = result_real;
                ref_imag = result_imag;

                expected_power[power_sent] = ref_real * ref_real + ref_imag * ref_imag;

                power_sent = power_sent + 1;
            end

            // check outputs after the DUT register updates
            #1;

            if (power_valid === 1'b1) begin
                if (power_checked >= power_sent)
                    $fatal(1, "Unexpected magnitude output");

                if (power_data !== expected_power[power_checked])
                    $fatal(1,
                        "Power %0d: got %0d, expected %0d", power_checked, power_data, expected_power[power_checked]);

                power_checked = power_checked + 1;
            end else if (power_valid !== 1'b0) begin
                $fatal(1, "Unknown power_valid");
            end
        end
    end

    task automatic send_word(input reg [15:0] value);
        integer b;
        begin
            for (b = 15; b >= 0; b = b - 1) begin
                spi_mosi = value[b];
                #667; spi_sck = 1;
                #667; spi_sck = 0;
            end
        end
    endtask

    task automatic run_fft;
        begin
            if (block_ready !== 1'b1)
                $fatal(1, "Input buffer not ready");

            if (busy !== 1'b0)
                $fatal(1, "FFT unexpectedly busy");

            @(negedge clk);
            start = 1;

            @(negedge clk);
            start = 0;

            if (results_ready !== 1'b0)
                $fatal(1, "FFT did not accept start");

            wait (results_ready === 1'b1);
        end
    endtask

    task automatic check_bin(
        input integer index,
        input integer expected_real,
        input integer expected_imag,
        input integer tolerance
    );
        longint signed error_real;
        longint signed error_imag;
        begin
            @(negedge clk);
            result_rd_addr = index;
            result_rd_en = 1;

            @(posedge clk);
            #1;

            if (result_valid !== 1'b1)
                $fatal(1, "Missing result_valid at bin %0d", index);

            if ((^result_real === 1'bx) || (^result_imag === 1'bx))
                $fatal(1, "Unknown FFT result at bin %0d", index);

            error_real = result_real;
            error_real = error_real - expected_real;

            error_imag = result_imag;
            error_imag = error_imag - expected_imag;

            if ((error_real > tolerance) || (error_real < -tolerance) ||
                (error_imag > tolerance) || (error_imag < -tolerance))
                $fatal(1,
                    "Bin %0d: got (%0d,%0d), expected (%0d,%0d)", index, result_real, result_imag, expected_real, expected_imag);
        end
    endtask

    // impulse_mode=0: constant input, impulse_mode=1: dirac delta
    task automatic test_frame(
        input integer value,
        input bit impulse_mode
    );
        integer i;
        integer expected_real;
        integer expected_imag;
        integer tolerance;
        integer checked_before;
        real angle;
        begin
            checked_before = power_checked;

            spi_cs_n = 0;
            #200;

            for (i = 0; i < 1024; i = i + 1) begin
                if (!impulse_mode || i == 1)
                    send_word(value[15:0]);
                else
                    send_word(16'd0);
            end

            #200;
            spi_cs_n = 1;
            #200;

            run_fft();

            for (i = 0; i < 1024; i = i + 1) begin
                if (!impulse_mode) begin
                    expected_real = (i == 0) ? value * 1024 : 0;
                    expected_imag = 0;
                    tolerance = 0;
                end else begin
                    angle = 2.0 * PI * i / 1024.0;
                    expected_real = $rtoi(value * $cos(angle));
                    expected_imag = $rtoi(-value * $sin(angle));
                    tolerance = 2;

                    case (i)
                        0: begin
                            expected_real = value;
                            expected_imag = 0;
                            tolerance = 0;
                        end
                        256: begin
                            expected_real = 0;
                            expected_imag = -value;
                            tolerance = 0;
                        end
                        512: begin
                            expected_real = -value;
                            expected_imag = 0;
                            tolerance = 0;
                        end
                        768: begin
                            expected_real = 0;
                            expected_imag = value;
                            tolerance = 0;
                        end
                    endcase
                end

                check_bin(i, expected_real, expected_imag, tolerance);
            end

            @(negedge clk);
            result_rd_en = 0;

            repeat (4) @(negedge clk);

            if (result_valid !== 1'b0 || power_valid !== 1'b0)
                $fatal(1, "Valid remained asserted after readout");

            if (block_ready !== 1'b0)
                $fatal(1, "Input buffer not released");

            if ((power_checked - checked_before) != 1024)
                $fatal(1, "Expected 1024 magnitude outputs this frame");

            if (power_checked != power_sent)
                $fatal(1, "Missing magnitude outputs");

            if (impulse_mode)
                $display("PASS: impulse at sample 1, FFT and magnitude");
            else
                $display("PASS: constant %0d, FFT and magnitude", value);
        end
    endtask

    initial begin
        repeat (10) @(negedge clk);
        rst_n = 1;
        #103;

        test_frame(100,   1'b0);
        test_frame(-50,   1'b0);
        test_frame(16384, 1'b1);

        $display("PASS: all tests; %0d magnitude outputs checked", power_checked);
        $finish;
    end

    initial begin
        #100000000;
        $fatal(1, "Simulation timed out");
    end

endmodule
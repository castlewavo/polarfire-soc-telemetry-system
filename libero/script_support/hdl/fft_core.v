module fft_core (
    input wire clk,
    input wire rst_n,

    // pulse start when block_ready=1 and busy=0
    input  wire start,
    output wire busy,
    output wire done,
    output reg  results_ready,

    // connection to sample_buffer
    input  wire        block_ready,
    output wire        release_block,
    output wire        sample_rd_en,
    output wire [9:0]  sample_rd_addr,
    input  wire [15:0] sample_rd_data,
    input  wire        sample_rd_valid,

    // ext read of completed FFT bins, addresses 0...1023
    input  wire               result_rd_en,
    input  wire [9:0]         result_rd_addr,
    output wire signed [31:0] result_real,
    output wire signed [31:0] result_imag,
    output reg                result_valid
);

    localparam [1:0] IDLE = 2'd0, LOAD = 2'd1, CALC = 2'd2;
    reg [1:0] state;

    wire start_accept = (state == IDLE) && start && block_ready;
    assign busy = (state != IDLE);

    // fft loader connections
    wire        load_done;
    wire        load_ram_en, load_ram_we;
    wire [9:0]  load_ram_addr;
    wire [63:0] load_ram_din;

    fft_loader loader (
        .clk(clk),
        .rst_n(rst_n),
        .start(start_accept),
        .block_ready(block_ready),
        .busy(),
        .done(load_done),

        .sample_rd_en(sample_rd_en),
        .sample_rd_addr(sample_rd_addr),
        .sample_rd_data(sample_rd_data),
        .sample_rd_valid(sample_rd_valid),

        .ram_en(load_ram_en),
        .ram_we(load_ram_we),
        .ram_addr(load_ram_addr),
        .ram_din(load_ram_din)
    );

    // sample buffer can be reused afre being loaded
    assign release_block = (state == LOAD) && load_done;

    // fft scheduler connections
    wire       calc_done;
    wire       calc_ram_en, calc_ram_we;
    wire [9:0] calc_addr_a, calc_addr_b;
    wire [8:0] twiddle_addr;
    wire       bf_in_valid, bf_out_valid;

    fft_scheduler scheduler (
        .clk(clk),
        .rst_n(rst_n),
        .start((state == LOAD) && load_done),
        .busy(),
        .done(calc_done),

        .ram_en(calc_ram_en),
        .ram_we(calc_ram_we),
        .ram_addr_a(calc_addr_a),
        .ram_addr_b(calc_addr_b),
        .twiddle_addr(twiddle_addr),

        .butterfly_in_valid(bf_in_valid),
        .butterfly_out_valid(bf_out_valid)
    );

    assign done = (state == CALC) && calc_done;

    // twiddle ROM
    wire signed [17:0] w_real, w_imag;

    twiddle_rom coefficients (
        .clk(clk),
        .addr(twiddle_addr),
        .w_real(w_real),
        .w_imag(w_imag)
    );

    // working RAM outputs and butterfly results
    wire [63:0] ram_dout_a, ram_dout_b;
    wire signed [31:0] y0_real, y0_imag;
    wire signed [31:0] y1_real, y1_imag;

    fft_butterfly butterfly (
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(bf_in_valid),

        .a_real(ram_dout_a[63:32]),
        .a_imag(ram_dout_a[31:0]),
        .b_real(ram_dout_b[63:32]),
        .b_imag(ram_dout_b[31:0]),
        .w_real(w_real),
        .w_imag(w_imag),

        .y0_real(y0_real),
        .y0_imag(y0_imag),
        .y1_real(y1_real),
        .y1_imag(y1_imag),
        .out_valid(bf_out_valid)
    );

    // result reads are allowed while idle until another FFT starts
    wire result_read_accept = (state == IDLE) && results_ready && result_rd_en && !start_accept;

    // select who controls working-RAM port A
    wire ram_en_a = (state == LOAD) ? load_ram_en :
                    (state == CALC) ? calc_ram_en :
                                      result_read_accept;
    wire ram_we_a = (state == LOAD) ? load_ram_we :
                    (state == CALC) ? calc_ram_we :
                                      1'b0;
    wire [9:0] ram_addr_a = (state == LOAD) ? load_ram_addr :
                            (state == CALC) ? calc_addr_a :
                                              result_rd_addr;
    wire [63:0] ram_din_a = (state == LOAD) ? load_ram_din :
                                              {y0_real, y0_imag};

    fft_work_ram working_memory (
        .clk(clk),

        .en_a(ram_en_a),
        .we_a(ram_we_a),
        .addr_a(ram_addr_a),
        .din_a(ram_din_a),
        .dout_a(ram_dout_a),
        
        // port B used only during FFT calculation
        .en_b((state == CALC) && calc_ram_en),
        .we_b((state == CALC) && calc_ram_we),
        .addr_b(calc_addr_b),
        .din_b({y1_real, y1_imag}),
        .dout_b(ram_dout_b)
    );

    assign result_real = ram_dout_a[63:32];
    assign result_imag = ram_dout_a[31:0];

    // FSM
    always @(posedge clk) begin
        if (!rst_n) begin
            state         <= IDLE;
            results_ready <= 1'b0;
            result_valid  <= 1'b0;
        end else begin
            result_valid <= result_read_accept;

            case (state)
                IDLE: begin
                    if (start_accept) begin
                        results_ready <= 1'b0;
                        state <= LOAD;
                    end
                end

                LOAD: begin
                    if (load_done)
                        state <= CALC;
                end

                CALC: begin
                    if (calc_done) begin
                        results_ready <= 1'b1;
                        state <= IDLE;
                    end
                end

                default: begin
                    state <= IDLE;
                    results_ready <= 1'b0;
                end
            endcase
        end
    end

endmodule
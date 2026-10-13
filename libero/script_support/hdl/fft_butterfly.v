module fft_butterfly (
    input wire clk,
    input wire rst_n,
    input wire in_valid,

    input wire signed [31:0] a_real, a_imag,
    input wire signed [31:0] b_real, b_imag,
    input wire signed [17:0] w_real, w_imag,

    output reg signed [31:0] y0_real, y0_imag,
    output reg signed [31:0] y1_real, y1_imag,
    output reg out_valid
);

    // Pipe stage 1
    reg signed [49:0] rr_s1, ii_s1;
    reg signed [49:0] ri_s1, ir_s1;
    reg signed [31:0] a_real_s1, a_imag_s1;
    reg valid_s1;

    // Pipe stage 2
    reg signed [50:0] product_real, product_imag;
    reg signed [31:0] a_real_s2, a_imag_s2;
    reg valid_s2;

    // Pipe stage 3
    reg signed [31:0] t_real, t_imag;
    reg signed [31:0] a_real_s3, a_imag_s3;
    reg valid_s3;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_s1  <= 1'b0;
            valid_s2  <= 1'b0;
            valid_s3  <= 1'b0;
            out_valid <= 1'b0;
        end else begin
            valid_s1  <= in_valid;
            valid_s2  <= valid_s1;
            valid_s3  <= valid_s2;
            out_valid <= valid_s3;
        end
    end

    always @(posedge clk) begin
        // stage 1
        if (in_valid) begin
            rr_s1 <= b_real * w_real;
            ii_s1 <= b_imag * w_imag;
            ri_s1 <= b_real * w_imag;
            ir_s1 <= b_imag * w_real;

            a_real_s1 <= a_real;
            a_imag_s1 <= a_imag;
        end

        // stage 2
        if (valid_s1) begin
            product_real <= $signed({rr_s1[49], rr_s1}) - $signed({ii_s1[49], ii_s1});
            product_imag <= $signed({ri_s1[49], ri_s1}) + $signed({ir_s1[49], ir_s1});

            a_real_s2 <= a_real_s1;
            a_imag_s2 <= a_imag_s1;
        end

        // stage 3
        if (valid_s2) begin
            t_real <= product_real >>> 16;
            t_imag <= product_imag >>> 16;

            a_real_s3 <= a_real_s2;
            a_imag_s3 <= a_imag_s2;
        end

        // stage 4
        if (valid_s3) begin
            y0_real <= a_real_s3 + t_real;
            y0_imag <= a_imag_s3 + t_imag;

            y1_real <= a_real_s3 - t_real;
            y1_imag <= a_imag_s3 - t_imag;
        end
    end

endmodule
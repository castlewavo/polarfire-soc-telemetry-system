module fft_magnitude (
    input wire clk,
    input wire rst_n,

    input wire               in_valid,
    input wire signed [31:0] in_real,
    input wire signed [31:0] in_imag,

    output reg        out_valid,
    output reg [63:0] out_power
);

    wire signed [63:0] real_product = in_real * in_real;
    wire signed [63:0] imag_product = in_imag * in_imag;

    reg [63:0] real_squared;
    reg [63:0] imag_squared;
    reg        squared_valid;

    // Valid pipeline
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            squared_valid <= 1'b0;
            out_valid     <= 1'b0;
        end else begin
            squared_valid <= in_valid;
            out_valid     <= squared_valid;
        end
    end

    always @(posedge clk) begin
        // Stage 1: square both components.
        if (in_valid) begin
            real_squared <= real_product;
            imag_squared <= imag_product;
        end

        // Stage 2: add the squares.
        if (squared_valid)
            out_power <= real_squared + imag_squared;
    end

endmodule
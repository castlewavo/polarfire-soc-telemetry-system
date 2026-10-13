module twiddle_rom (
    input  wire               clk,
    input  wire [8:0]         addr,

    output wire signed [17:0] w_real,
    output wire signed [17:0] w_imag
);

    reg [35:0] memory [0:511];
    reg [35:0] coefficient;

    initial begin
        $readmemh("../hdl/twiddle.hex", memory); 
    end

    always @(posedge clk) begin
        coefficient <= memory[addr];
    end

    assign w_real = coefficient[35:18];
    assign w_imag = coefficient[17:0];

endmodule
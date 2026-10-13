module fft_work_ram (
    input wire clk,

    // port A
    input  wire        en_a,
    input  wire        we_a,
    input  wire [9:0]  addr_a,
    input  wire [63:0] din_a,
    output reg  [63:0] dout_a,

    // port B
    input  wire        en_b,
    input  wire        we_b,
    input  wire [9:0]  addr_b,
    input  wire [63:0] din_b,
    output reg  [63:0] dout_b
);

    reg [63:0] memory [0:1023];

    always @(posedge clk) begin
        if (en_a) begin
            if (we_a)
                memory[addr_a] <= din_a;
            else
                dout_a <= memory[addr_a];
        end
    end

    always @(posedge clk) begin
        if (en_b) begin
            if (we_b)
                memory[addr_b] <= din_b;
            else
                dout_b <= memory[addr_b];
        end
    end

endmodule
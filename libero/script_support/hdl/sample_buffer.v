module sample_buffer (
    input  wire        clk,
    input  wire        rst_n,

    // from SPI rx
    input  wire [15:0] sample_data,
    input  wire        sample_valid,

    // from FFT
    input  wire        release_block,
    input  wire        rd_en,
    input  wire [9:0]  rd_addr,

    // to FFT
    output reg         block_ready,
    output reg  [15:0] rd_data,
    output reg         rd_valid
);

    reg [15:0] memory [0:1023];
    reg [9:0]  wr_addr;

    wire write_accept = sample_valid && !block_ready && !release_block;
    wire read_accept = rd_en && block_ready && !release_block;

    always @(posedge clk) begin
        if (rst_n) begin
            if (write_accept)
                memory[wr_addr] <= sample_data;

            if (read_accept)
                rd_data <= memory[rd_addr];
        end
    end

    // capture control
    always @(posedge clk) begin
        if (!rst_n) begin
            wr_addr     <= 10'd0;
            block_ready <= 1'b0;
            rd_valid    <= 1'b0;
        end else begin
            rd_valid <= read_accept;

            if (release_block) begin
                wr_addr     <= 10'd0;
                block_ready <= 1'b0;
            end else if (write_accept) begin
                if (wr_addr == 10'd1023)
                    block_ready <= 1'b1;
                else
                    wr_addr <= wr_addr + 1'b1;
            end
        end
    end

endmodule
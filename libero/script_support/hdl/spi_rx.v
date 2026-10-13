// SPI mode 0, MSB first. One sample per 16 bits; CS may span many samples.
// Intended operating point: clk=125 MHz, SCK<=1 MHz.
// Keep CS low and MOSI valid for at least 8 clk cycles before first SCK rise;
// keep CS low for at least 8 clk cycles after the final SCK rise.
// Each SCK half-period and the gap between frames must be >=8 clk cycles.
// rst_n must deassert synchronously to clk. No downstream backpressure.
// Preserve/identify synchronizer stages and constrain their first-stage
// input paths in Libero when integrating. This file adds no timing exceptions.
module spi_rx (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        spi_sck,
    input  wire        spi_mosi,
    input  wire        spi_cs_n,
    output reg  [15:0] sample_data,
    output reg         sample_valid
);
    reg sck_meta, sck_sync, sck_prev;
    reg mosi_meta, mosi_sync;
    reg cs_meta, cs_sync;
    reg [15:0] shift_reg;
    reg [3:0] bit_count;

    wire sck_rise = sck_sync && !sck_prev;

    always @(posedge clk) begin
        if (!rst_n) begin
            sck_meta  <= 1'b0;
            sck_sync  <= 1'b0;
            sck_prev  <= 1'b0;
            mosi_meta <= 1'b0;
            mosi_sync <= 1'b0;
            cs_meta   <= 1'b1;
            cs_sync   <= 1'b1;
        end else begin
            sck_meta  <= spi_sck;
            sck_sync  <= sck_meta;
            sck_prev  <= sck_sync;
            mosi_meta <= spi_mosi;
            mosi_sync <= mosi_meta;
            cs_meta   <= spi_cs_n;
            cs_sync   <= cs_meta;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg    <= 16'd0;
            bit_count    <= 4'd0;
            sample_data  <= 16'd0;
            sample_valid <= 1'b0;
        end else begin
            sample_valid <= 1'b0;
            if (cs_sync) begin
                bit_count <= 4'd0;
                shift_reg <= 16'd0;
            end else if (sck_rise) begin
                shift_reg <= {shift_reg[14:0], mosi_sync};
                if (bit_count == 4'd15) begin
                    sample_data  <= {shift_reg[14:0], mosi_sync};
                    sample_valid <= 1'b1;
                    bit_count    <= 4'd0;
                end else begin
                    bit_count <= bit_count + 1'b1;
                end
            end
        end
    end
endmodule

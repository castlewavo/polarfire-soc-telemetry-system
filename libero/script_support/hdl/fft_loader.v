module fft_loader (
    input wire clk,
    input wire rst_n,

    // control: pulse start for one cycle while idle
    input  wire start,
    input  wire block_ready,
    output wire busy,
    output reg  done,

    // sample-buffer read port
    output wire        sample_rd_en,
    output wire [9:0]  sample_rd_addr,
    input  wire [15:0] sample_rd_data,
    input  wire        sample_rd_valid,

    // working-RAM port A
    output wire        ram_en,
    output wire        ram_we,
    output wire [9:0]  ram_addr,
    output wire [63:0] ram_din
);

    localparam [1:0] IDLE = 2'd0, REQUEST = 2'd1, WAIT_DATA = 2'd2, WRITE = 2'd3;

    reg [1:0] state;
    reg [9:0] sample_index;
    reg [15:0] sample_reg;

    assign busy = (state != IDLE);

    assign sample_rd_en = (state == REQUEST);
    assign sample_rd_addr = sample_index;

    assign ram_en = (state == WRITE);
    assign ram_we = (state == WRITE);

    // reverse the ten address bits
    assign ram_addr = {sample_index[0], sample_index[1], sample_index[2], sample_index[3],
                       sample_index[4], sample_index[5], sample_index[6], sample_index[7],
                       sample_index[8], sample_index[9]};

    // 32 MSB: sign-extended real sample
    // 32 LSB: imaginary part = zero
    assign ram_din = {{16{sample_reg[15]}}, sample_reg, 32'd0};

    always @(posedge clk) begin
        if (!rst_n) begin
            state        <= IDLE;
            sample_index <= 10'd0;
            sample_reg   <= 16'd0;
            done         <= 1'b0;
        end else begin
            done <= 1'b0;
            case (state)
                IDLE: begin
                    if (start && block_ready) begin
                        sample_index <= 10'd0;
                        state <= REQUEST;
                    end
                end

                REQUEST: begin
                    state <= WAIT_DATA;
                end

                WAIT_DATA: begin
                    if (sample_rd_valid) begin
                        sample_reg <= sample_rd_data;
                        state <= WRITE;
                    end
                end

                WRITE: begin
                    // working RAM accepts the write at this edge.
                    if (sample_index == 10'd1023) begin
                        done  <= 1'b1;
                        state <= IDLE;
                    end else begin
                        sample_index <= sample_index + 1'b1;
                        state <= REQUEST;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
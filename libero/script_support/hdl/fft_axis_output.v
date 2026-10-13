module fft_axis_output (
    input wire clk,
    input wire rst_n,

    // pulse start when FFT results and DMA are ready
    input  wire start,
    input  wire results_ready,
    output wire busy,
    output reg  done,

    // FFT core read interface
    output wire       result_rd_en,
    output wire [9:0] result_rd_addr,

    // from fft_magnitude
    input wire        power_valid,
    input wire [63:0] power_data,

    // AXIS to DMA
    output wire [63:0] m_axis_tdata,
    output wire        m_axis_tvalid,
    input  wire        m_axis_tready,
    output wire        m_axis_tlast,
    output wire [7:0]  m_axis_tkeep,
    output wire [7:0]  m_axis_tstrb
);

    localparam [1:0] IDLE = 2'd0, REQUEST = 2'd1, WAIT_POWER = 2'd2, SEND = 2'd3;

    reg [1:0] state;
    reg [9:0] bin_index;
    reg [63:0] power_reg;

    assign busy = (state != IDLE);

    // 1-cycle read request for the current bin
    assign result_rd_en   = (state == REQUEST);
    assign result_rd_addr = bin_index;

    assign m_axis_tdata  = power_reg;
    //assign m_axis_tdata =  {54'd0, bin_index}; // debug
    assign m_axis_tvalid = (state == SEND);
    assign m_axis_tlast  = (state == SEND) && (bin_index == 10'd1023);

    assign m_axis_tkeep = 8'hFF;
    assign m_axis_tstrb = 8'hFF;

    always @(posedge clk) begin
        if (!rst_n) begin
            state     <= IDLE;
            bin_index <= 10'd0;
            power_reg <= 64'd0;
            done      <= 1'b0;
        end else begin
            done <= 1'b0;

            case (state)
                IDLE: begin
                    if (start && results_ready) begin
                        bin_index <= 10'd0;
                        state <= REQUEST;
                    end
                end

                REQUEST: begin
                    // FFT RAM accepts the read at this edge
                    state <= WAIT_POWER;
                end

                WAIT_POWER: begin
                    if (power_valid) begin
                        power_reg <= power_data;
                        state <= SEND;
                    end
                end

                SEND: begin
                    // TVALID is high in this state
                    if (m_axis_tready) begin
                        if (bin_index == 10'd1023) begin
                            done  <= 1'b1;
                            state <= IDLE;
                        end else begin
                            bin_index <= bin_index + 1'b1;
                            state <= REQUEST;
                        end
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
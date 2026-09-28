module AXI4_STREAM_DATA_GENERATOR_MINIMAL (
    input  wire        ACLK,
    input  wire        RSTN,
    input  wire        START,
    input  wire        TREADY,
    
    output wire [63:0] TDATA,
    output wire        TVALID,
    output wire        TLAST,
    output wire [7:0]  TKEEP,
    output wire [7:0]  TSTRB,
    output wire [1:0]  TDEST,
    output wire [7:0]  TID
);

    localparam integer NUM_WORDS = 128;

    reg [7:0] word_count;
    reg       tvalid_reg;
    reg       start_seen;
    reg [63:0] tdata_reg;

    assign TDEST = 2'b00;
    assign TID   = 8'b0;
    assign TKEEP = 8'hFF;
    assign TSTRB = 8'hFF;
    assign TDATA  = tdata_reg;
    assign TVALID = tvalid_reg;
    assign TLAST = tvalid_reg && (word_count == NUM_WORDS - 1);

    always @(posedge ACLK or negedge RSTN) begin
        if (!RSTN) begin
            word_count  <= 8'd0;
            tdata_reg   <= 64'd1;
            tvalid_reg  <= 1'b0;
            start_seen  <= 1'b0;
        end else begin
            if (!START)
                start_seen <= 1'b0;
            if (!tvalid_reg && START && !start_seen) begin
                tvalid_reg <= 1'b1;
                start_seen <= 1'b1;
                word_count <= 8'd0;
                tdata_reg  <= 64'd1;
            end
            else if (tvalid_reg && TREADY) begin
                if (word_count == NUM_WORDS - 1) begin
                    tvalid_reg <= 1'b0;
                    word_count <= 8'd0;
                    tdata_reg  <= 64'd1;
                end else begin
                    word_count <= word_count + 1'b1;
                    tdata_reg  <= tdata_reg + 1'b1;
                end
            end
        end
    end
endmodule
module fft_scheduler (
    input wire clk,
    input wire rst_n,

    // pulse start after the loader finishes
    input  wire start,
    output wire busy,
    output reg  done,

    // working RAM
    output wire       ram_en,
    output wire       ram_we,
    output wire [9:0] ram_addr_a,
    output wire [9:0] ram_addr_b,

    // twiddle ROM
    output wire [8:0] twiddle_addr,

    // butterfly handshake
    output wire butterfly_in_valid,
    input  wire butterfly_out_valid
);

    localparam [2:0] IDLE = 3'd0, READ = 3'd1, LAUNCH = 3'd2, WAIT = 3'd3, WRITE = 3'd4;

    reg [2:0] state;

    reg [3:0]  stage;      // 0 through 9
    reg [10:0] half_span;  // 1, 2, 4, ... 512
    reg [10:0] base;       // Start address of current group
    reg [10:0] offset;     // Pair index within current group

    wire [10:0] group_span = half_span << 1;

    assign busy = (state != IDLE);

    assign ram_en = (state == READ) || (state == WRITE);
    assign ram_we = (state == WRITE);

    assign ram_addr_a = base + offset;
    assign ram_addr_b = base + offset + half_span;

    // W index = offset × (1024 / group_span).
    assign twiddle_addr = offset << (4'd9 - stage);

    assign butterfly_in_valid = (state == LAUNCH);

    always @(posedge clk) begin
        if (!rst_n) begin
            state     <= IDLE;
            stage     <= 4'd0;
            half_span <= 11'd1;
            base      <= 11'd0;
            offset    <= 11'd0;
            done      <= 1'b0;
        end else begin
            done <= 1'b0;

            case (state)
                IDLE: begin
                    if (start) begin
                        stage     <= 4'd0;
                        half_span <= 11'd1;
                        base      <= 11'd0;
                        offset    <= 11'd0;
                        state     <= READ;
                    end
                end

                READ: begin
                    // RAM and twiddle ROM register their outputs at this edge
                    state <= LAUNCH;
                end

                LAUNCH: begin
                    // butterfly accepts those outputs at this edge
                    state <= WAIT;
                end

                WAIT: begin
                    if (butterfly_out_valid)
                        state <= WRITE;
                end

                WRITE: begin
                    // both RAM ports commit their results at this edge, before addresses advance
                    if (offset < half_span - 11'd1) begin
                        offset <= offset + 11'd1;
                        state  <= READ;

                    end else if (base + group_span < 11'd1024) begin
                        offset <= 11'd0;
                        base   <= base + group_span;
                        state  <= READ;

                    end else if (stage < 4'd9) begin
                        stage     <= stage + 4'd1;
                        half_span <= half_span << 1;
                        base      <= 11'd0;
                        offset    <= 11'd0;
                        state     <= READ;

                    end else begin
                        done  <= 1'b1;
                        state <= IDLE;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
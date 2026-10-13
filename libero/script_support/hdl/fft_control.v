module fft_control (
    input wire clk,
    input wire rst_n,

    // sw GPIO asserted only after DMA is armed
    input wire start_async,

    input wire block_ready,
    input wire fft_busy,
    input wire fft_results_ready,
    input wire axis_busy,
    input wire axis_done,

    output wire fft_start,
    output wire axis_start,
    output wire busy,
    output wire done
);

    // synchronize the software-controlled GPIO.
    reg start_meta;
    reg start_sync;

    always @(posedge clk) begin
        if (!rst_n) begin
            start_meta <= 1'b0;
            start_sync <= 1'b0;
        end else begin
            start_meta <= start_async;
            start_sync <= start_meta;
        end
    end

    localparam [2:0] IDLE  = 3'd0, WAIT_BLOCK = 3'd1, START_FFT = 3'd2, WAIT_FFT = 3'd3, START_AXIS = 3'd4, WAIT_AXIS = 3'd5, WAIT_LOW = 3'd6;

    reg [2:0] state;

    // each START state lasts 1 clk cycle
    assign fft_start  = (state == START_FFT);
    assign axis_start = (state == START_AXIS);

    assign busy = (state != IDLE);
    assign done = (state == WAIT_AXIS) && axis_done;

    always @(posedge clk) begin
        if (!rst_n) begin
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (start_sync)
                        state <= WAIT_BLOCK;
                end

                WAIT_BLOCK: begin
                    if (block_ready && !fft_busy && !axis_busy)
                        state <= START_FFT;
                end

                START_FFT: begin
                    state <= WAIT_FFT;
                end

                WAIT_FFT: begin
                    if (fft_results_ready && !fft_busy)
                        state <= START_AXIS;
                end

                START_AXIS: begin
                    state <= WAIT_AXIS;
                end

                WAIT_AXIS: begin
                    if (axis_done)
                        state <= WAIT_LOW;
                end

                WAIT_LOW: begin
                    // prevent repeated transfers if START stays high
                    if (!start_sync)
                        state <= IDLE;
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
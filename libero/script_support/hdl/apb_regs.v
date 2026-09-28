module apb_regs (
   // APB3 Interface
   input             pclk,
   input             reset_n,
   input      [ 4:0] paddr,   // offsets up to 0x1C
   input             pwrite,
   input             psel,
   input             penable,
   input      [31:0] pwdata,
   output reg [31:0] prdata,
   output            pready,
   output            pslverr,

   input      [31:0] status32,
   input      [15:0] status16,
   input      [ 7:0] status8,
   output reg [31:0] control32,
   output reg [15:0] control16,
   output reg [ 7:0] control8
);

   wire apb_write = psel & penable & pwrite;

   assign pready  = 1'b1;
   assign pslverr = 1'b0;

   // Write
   always @(posedge pclk or negedge reset_n) begin
      if (!reset_n) begin
         control32 <= 32'h0;
         control16 <= 16'h1234;
         control8  <= 8'h0;
      end else if (apb_write) begin
         case (paddr)
            5'h10 : control32 <= pwdata;
            5'h14 : control16 <= pwdata[15:0];
            5'h18 : control8  <= pwdata[7:0];
            default: ;
         endcase
      end
   end

   // Read
   always @(*) begin
      if (psel && !pwrite) begin
         case (paddr)
            5'h00 : prdata = status32;
            5'h04 : prdata = {16'h0, status16};
            5'h08 : prdata = {24'h0, status8};
            5'h10 : prdata = control32;
            5'h14 : prdata = {16'h0, control16};
            5'h18 : prdata = {24'h0, control8};
            5'h1C : prdata = 32'h00216948; // "Hi!" constant
            default: prdata = 32'h0000_0000;
         endcase
      end else begin
         prdata = 32'h0000_0000;
      end
   end

endmodule

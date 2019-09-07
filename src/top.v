/*
 * Top module for the crappy MAX II CPLD dev board.
 */

module top #(
  parameter F_CLK = 50000000
) (
  input wire clk_i,     // Reference oscillator 50 MHz.
  inout wire [16:0] p1, // Pin header P1.
  inout wire [19:0] p2, // Pin header P2.
  inout wire [18:0] p3, // Pin header P3.
  inout wire [19:0] p4  // Pin header P4.
);

// In a CPLD a clock can usually be divided like this (toggle FF).
reg clk_div2 = 1'b0;
always @ (posedge clk_i)
  clk_div2 <= !clk_div2;

reg clk_div4 = 1'b0;
always @ (posedge clk_div2)
  clk_div4 <= !clk_div4;

reg clk_div8 = 1'b0;
always @ (posedge clk_div4)
  clk_div8 <= !clk_div8;

reg clk_div16 = 1'b0;
always @ (posedge clk_div8)
  clk_div16 <= !clk_div16;

reg [17:0] cntr = F_CLK/(4*16);
reg led = 0;
always @ (posedge clk_div16)
begin
  cntr <= cntr - 1;
  if (cntr == 'd0) begin
    cntr <= F_CLK/4;
    led <= !led;
  end
end

assign p1 = 'bz;
assign p2 = 'bz;
assign p3[16:0] = 'bz;
assign p3[17] = led;
assign p3[18] = !led;
assign p4 = 'bz;

endmodule

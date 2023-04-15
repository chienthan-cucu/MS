`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules
module div (
   clk,
   x,
   y,
   MFCC_mean);
 
parameter WIDTH=40;  // width of numbers in bits
parameter FBITS=16;   // fractional bits (for fixed point)

input clk;
input [WIDTH-1:0] x;
input [WIDTH-1:0] y;
output [WIDTH-1:0] MFCC_mean;  // quotient

reg  busy;         
wire [WIDTH-1:0] MFCC_mean;  // quotient


    // avoid negative vector width when fractional bits are not used
localparam FBITSW = (FBITS) ? FBITS : 1;
reg [WIDTH-1:0] y1;           // copy of divisor
reg [WIDTH-1:0] q1, q1_next;  // intermediate quotient
reg [WIDTH:0] ac, ac_next;    // accumulator (1 bit wider)

localparam ITER = WIDTH+FBITS;  // iterations are dividend width + fractional bits
reg [$clog2(ITER)-1:0] i;     // iteration counter
wire [WIDTH-1:0] x1;
wire sign;
reg [WIDTH-1:0] q;
assign {sign,x1}=(x[WIDTH-1]===1)?{1,{~x+1}}:{0,x};
assign MFCC_mean=(sign===1)?{~q+1}:q;


always @(clk)
begin
        if (ac >= {1'b0,y1}) begin
            ac_next = ac - y1;
            {ac_next, q1_next} = {ac_next[WIDTH-1:0], q1, 1'b1};
        end else begin
            {ac_next, q1_next} = {ac, q1} << 1;
        end
end

always @(posedge clk) 
begin
    if (busy) 
    begin
         if (i == ITER-1) begin  // done
                busy <= 0;
                q <= q1_next;
          end else if (i == WIDTH-1 && q1_next[WIDTH-1:WIDTH-FBITSW]) begin // overflow?
                busy <= 0;
                q <= 0;
          end else begin  // next iteration
                i <= i + 1;
                ac <= ac_next;
                q1 <= q1_next;
          end
    end
    else 
    begin
        i <= 0;
        if (y === 0) begin  // catch divide by zero
            busy <= 0;
         end else begin
                busy <= 1;
                y1 <= y;
                {ac, q1} <= {{WIDTH{1'b0}}, x1, 1'b0};
         end
   end  
end
endmodule
// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    08:07:14 02/15/2022
//  Design Name: 
//  Module Name:    ereg - Behavioral 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module ereg (
   clk,
   rst_n,
   we,
   D,
   Q);
 

input   clk; 
input   rst_n; 
input   we; 
input   [38:0] D; 
output   [38:0] Q; 

reg     [38:0] Q; 


always @(posedge clk or negedge rst_n)
   begin : _reg_
   if (rst_n === 1'b 0)
      begin
      Q <= {39{1'b 0}};   
      end
   else if (clk === 1'b 1 )
      begin
      if (we === 1'b 1)
         begin
         Q <= D;   
         end
      end
   end


endmodule // module ereg


// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    06:47:41 01/22/2022 
//  Design Name: 
//  Module Name:    eadder - Behavioral 
//  Project Name: 
//  Tool versions: 
//  Description: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module eadder (
   clk,
   rst_n,
   enable,
   eadder_new,
   eadder_sel,
   ereg,
   mul_in,
   sum_out);
 

input   clk; 
input   rst_n; 
input   enable; 
input   eadder_new; 
input   eadder_sel; 
input   [38:0] ereg; 
input   [30:0] mul_in; 
output   [38:0] sum_out; 

wire    [38:0] sum_out; 
wire    [38:0] sum_temp1; 
wire    [38:0] sum_temp; 

assign sum_temp = eadder_new === 1'b 1 ? {39{1'b 0}} : 
	enable === 1'b 1 & eadder_sel === 1'b 1 ? sum_temp1 + 
      ereg : 
	enable === 1'b 1 & eadder_sel === 1'b 0 ? sum_temp1 + 
      {8'b 00000000, mul_in} : 
	sum_temp1; 
defparam
      reg_sum.N = 39;
_reg_ reg_sum (.clk(clk),
          .rst_n(rst_n),
          .D(sum_temp),
          .Q(sum_temp1));
assign sum_out = sum_temp1; 

endmodule // module eadder


// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    21:03:06 22/02/2022 
//  Design Name: 
//  Module Name:    addmel - Behavioral 
//  Project Name: MFCC
//  Tool versions: 
//  Description: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module addmel (
   clk,
   rst_n,
   enable,
   addmel_new,
   addmel_sel,
   regffte_out,
   regmel_out,
   addmel_out);
 

input   clk; 
input   rst_n; 
input   enable; 
input   addmel_new; 
input   addmel_sel; 
input   [38:0] regffte_out; 
input   [43:0] regmel_out; 
output   [43:0] addmel_out; 

wire    [43:0] addmel_out; 
wire    [43:0] sum_temp1; 
wire    [43:0] sum_temp; 

assign sum_temp = addmel_new === 1'b 1 ? {5'b 00000, regffte_out} : 
	enable === 1'b 1 & addmel_sel === 1'b 1 ? sum_temp1 + regmel_out : 
	enable === 1'b 1 & addmel_sel === 1'b 0 ? sum_temp1 + {5'b 00000, regffte_out} : sum_temp1; 
defparam
      reg_sum.N = 44;
_reg_ reg_sum (.clk(clk),
          .rst_n(rst_n),
          .D(sum_temp),
          .Q(sum_temp1));
assign addmel_out = sum_temp1; 

endmodule // module addmel


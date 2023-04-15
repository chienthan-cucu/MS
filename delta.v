// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    08:57:50 03/07/2022 
//  Design Name: 
//  Module Name:    delta - Behavioral 
//  Project Name: MFCC
//  Tool versions: 
//  Description: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules

module delta (
   clk,
   rst_n,
   delta_en,
   delta_new,
   delta_sub,
   delta_shift,
   regc_out,
   delta_out);
 

input   clk; 
input   rst_n; 
input   delta_en; 
input   delta_new; 
input   delta_sub; 
input   delta_shift; 
input   [15:0] regc_out; 
output   [15:0] delta_out; 

wire    [15:0] delta_out; 
wire    [17:0] output_temp; 
wire    [17:0] output_temp1; 
wire    [17:0] regc_out_sig; 
wire    [17:0] regc_out_sig1; 

assign regc_out_sig = regc_out[15] === 1'b 0 ? {2'b 00, regc_out} : 
	{2'b 11, regc_out}; 
assign regc_out_sig1 = regc_out[15] === 1'b 0 ? {1'b 0, regc_out, 1'b 0} : 
	{1'b 1, regc_out, 1'b 0}; 
assign output_temp = delta_new === 1'b 1 ? regc_out_sig : 
	delta_shift === 1'b 0 & delta_sub === 1'b 1 ? output_temp1 - 
      regc_out_sig : 
	delta_en === 1'b 1 & delta_shift === 1'b 0 & 
      delta_sub === 1'b 0 ? output_temp1 + regc_out_sig : 
	delta_shift === 1'b 1 & delta_sub === 1'b 1 ? {output_temp1[16:0], 
      1'b 0} - regc_out_sig1 : 
	delta_shift === 1'b 1 & delta_sub === 1'b 0 ? {output_temp1[16:0], 
      1'b 0} + regc_out_sig1 : 
	output_temp1; 
defparam
     reg_sum.N = 18;
_reg_ reg_sum (.clk(clk),
          .rst_n(rst_n),
          .D(output_temp),
          .Q(output_temp1));
assign delta_out = output_temp1[17:2]; 

endmodule // module delta


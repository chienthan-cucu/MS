// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    21:17:53 09/26/2022
//  Design Name: 
//  Module Name:    preem_sub - Behavioral 
//  Project Name: 
//  Tool versions: 
//  Description: Thuc hien phep tru giua 2 so co dau
// --------------------------------------------------------------------------------
`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module preem_sub (
   sub_in1,
   sub_in2,
   sub_out);
 

input   [16:0] sub_in1; 
input   [15:0] sub_in2; 
output   [16:0] sub_out; 

wire    [16:0] sub_out; 
wire    [16:0] sub_in2_temp; 

assign sub_in2_temp = sub_in2[15] === 1'b 0 ? {1'b 0, sub_in2} : 
	{1'b 1, sub_in2}; 
assign sub_out = sub_in2_temp + ~sub_in1 + 2'b 01; 

endmodule // module preem_sub


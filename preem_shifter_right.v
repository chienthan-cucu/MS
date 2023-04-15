// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    16:14:51 03/26/2022 
//  Design Name: 
//  Module Name:    preem_shifter_right - Behavioral 
//  Project Name: 
//  Tool versions: 
//  Description: Dich phai tin hieu vao sang phai 5 bit va cong them 1 bit vao, tin hieu dau ra la 17 bit
// --------------------------------------------------------------------------------
`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules

module preem_shifter_right (
   shift_in,
   shift_out);
 

input   [10:0] shift_in; 
output   [16:0] shift_out; 

wire    [16:0] shift_out; 

assign shift_out = shift_in[10] === 1'b 0 ? {6'b 000000, shift_in} : 
	shift_in[10] === 1'b 1 ? {6'b 111111, shift_in} :shift_out ; 
//  Mo rong bit dau

//  Mo rong bit dau

endmodule // module preem_shifter_right


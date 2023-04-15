// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    14:38:42 02/16/2022
//  Design Name: 
//  Module Name:    muxlog - Behavioral 
//  Project Name: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module muxlog (
   addmel_out,
   energy_out,
   log_sel,
   muxlog_out);
 

input   [43:0] addmel_out; 
input   [38:0] energy_out; 
input   log_sel; 
output   [43:0] muxlog_out; 

wire    [43:0] muxlog_out; 
wire    [43:0] energy_out_sig; 

assign muxlog_out = log_sel === 1'b 0 ? addmel_out : 
	energy_out_sig; 
assign energy_out_sig = energy_out[38] === 1'b 0 ? {5'b 00000, energy_out} : 
	{5'b 11111, energy_out}; 

endmodule // module muxlog


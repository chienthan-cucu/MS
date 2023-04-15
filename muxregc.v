// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    09:29:47 02/27/2022
//  Design Name: 
//  Module Name:    muxregc - Behavioral 
//  Project Name: MFCC
//  Target Devices: 
// --------------------------------------------------------------------------------
`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules

module muxregc (
   regc_out,
   log_out,
   addsubdct_out,
   delta_out,
   regc_sel,
   muxregc_out);
 

input   [15:0] regc_out; 
input   [15:0] log_out; 
input   [15:0] addsubdct_out; 
input   [15:0] delta_out; 
input   [1:0] regc_sel; 
output   [15:0] muxregc_out; 

wire    [15:0] muxregc_out;

assign muxregc_out = regc_sel === 2'b 00 ? regc_out : 
	regc_sel === 2'b 01 ? log_out : 
	regc_sel === 2'b 10 ? addsubdct_out : 
	delta_out; 
	
	 

endmodule // module muxregc


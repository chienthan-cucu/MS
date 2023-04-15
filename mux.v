// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    13:38:11 03/26/2022
//  Design Name: 
//  Module Name:    mux - Behavioral 
// --------------------------------------------------------------------------------


`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module mux (
   mux_in0,
   mux_in1,
   choose,
   mux_out);
 
parameter N = 17;

input   [N - 1:0] mux_in0; 
input   [N - 1:0] mux_in1; 
input   choose; 
output   [N - 1:0] mux_out; 

wire    [N - 1:0] mux_out; 

assign mux_out = choose === 1'b 0 ? mux_in0 : 
	mux_in1; 

endmodule // module mux


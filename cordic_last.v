// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    15:18:49 08/10/2022
//  Design Name: 
//  Module Name:    cordic_last - Behavioral 
//  Project Name: FFT_R2SDF
//  Description: in last stage_FFT, W=-j or 1
// --------------------------------------------------------------------------------
`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules

module cordic_last (
   iReal,
   iImage,
   Phi,
   oReal,
   oImage);
 

input   [36:0] iReal; 
input   [36:0] iImage; 
input   Phi; 
output   [36:0] oReal; 
output   [36:0] oImage; 

wire    [36:0] oReal; 
wire    [36:0] oImage; 

assign oReal = Phi === 1'b 0 ? iReal : 
	iImage; 
assign oImage = Phi === 1'b 0 ? iImage : 
	~iReal + 2'b 01; 

endmodule // module cordic_last


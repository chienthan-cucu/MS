// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    09:42:36 01/18/2022 
//  Design Name: 
//  Module Name:    mux_regffte - Behavioral 
//  Project Name: MFCC_Improve
//  Tool versions: 
//  Description: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module mux_regffte (
   regffte_addr0,
   regffte_addr1,
   insel,
   regffte_addr);
 

input   [5:0] regffte_addr0; 
input   [5:0] regffte_addr1; 
input   insel; 
output   [5:0] regffte_addr; 

wire    [5:0] regffte_addr; 

assign regffte_addr = insel === 1'b 0 ? regffte_addr0 : 
	regffte_addr1; 

endmodule // module mux_regffte


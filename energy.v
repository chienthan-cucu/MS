// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    07:21:53 11/22/2015 
//  Design Name: 
//  Module Name:    energy - Behavioral 
//  Project Name: 
//  Tool versions: 
//  Description: 
// --------------------------------------------------------------------------------
`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module energy (
   clk,
   rst_n,
   square_en,
   eadder_en,
   eadder_new,
   eadder_sel,
   ram_in,
   ereg_out,
   eadder_out);
 

input   clk; 
input   rst_n; 
input   square_en; 
input   eadder_en; 
input   eadder_new; 
input   eadder_sel; 
input   [15:0] ram_in; 
input   [38:0] ereg_out; 
output   [38:0] eadder_out; 

wire    [38:0] eadder_out; 
wire    [30:0] square_out; 

square block_square (.clk(clk),
          .rst_n(rst_n),
          .enable(square_en),
          ._input_(ram_in),
          ._output_(square_out));
eadder block_eadder (.clk(clk),
          .rst_n(rst_n),
          .enable(eadder_en),
          .eadder_new(eadder_new),
          .eadder_sel(eadder_sel),
          .ereg(ereg_out),
          .mul_in(square_out),
          .sum_out(eadder_out));

endmodule // module energy


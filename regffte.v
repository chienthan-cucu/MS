// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    15:05:40 02/10/2022 
//  Design Name: 
//  Module Name:    regffte - Behavioral 
//  Project Name: MFCC
// ---------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module regffte (
   clk,
   regffte_wren,
   regffte_addr,
   sroot_out,
   regffte_out);
 

input   clk; 
input   regffte_wren; 
input   [5:0] regffte_addr; 
input   [38:0] sroot_out; 
output   [38:0] regffte_out; 

wire    [38:0] regffte_out; 

defparam
      uut.data_length = 39,
      uut.addr_length = 6;
module_memory uut (.clk(clk),
          .read_write(regffte_wren),
          .address(regffte_addr),
          .data_in(sroot_out),
          .data_out(regffte_out));

endmodule // module regffte


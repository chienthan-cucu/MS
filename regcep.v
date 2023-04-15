// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    15:15:14 02/17/2022 
//  Design Name: 
//  Module Name:    regcep - Behavioral 
//  Project Name: MFCC
// --------------------------------------------------------------------------------
`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module regcep (
   clk,
   write_read,
   address,
   data_in,
   data_out);
 

input   clk; 
input   write_read; 
input   [12:0] address; 
input   [15:0] data_in; 
output   [15:0] data_out; 

wire    [15:0] data_out; 

defparam
      uut.data_length = 16,
      uut.addr_length = 13;
module_memory uut (.clk(clk),
          .read_write(write_read),
          .address(address),
          .data_in(data_in),
          .data_out(data_out));

endmodule // module regcep


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


module buff(
   clk,
   rst_n,
   write_read,
   address,
   framenum,
   data_in,
   data_out);
 

input   clk;
input   rst_n; 
input   write_read; 
input   [12:0] address; 
input   [7:0] framenum; 
input   [15:0] data_in; 
output   [31:0] data_out; 

wire    [31:0] data_out ; 

defparam
      uu.data_length = 40,
      uu.addr_length = 13;
memory2 uu (.clk(clk),
          .reset(rst_n),
          .read_write(write_read),
          .address(address),
          .framenum(framenum),
          .data_in(data_in),
          .data_out(data_out));

endmodule // module regcep


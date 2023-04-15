// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    14:53:15 02/17/2022
//  Design Name: 
//  Module Name:    regdct - Behavioral 
//  Project Name: MFCC
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module regdct (
   clk,
   write_read,
   address,
   data_in,
   data_out);
 

input   clk; 
input   write_read; 
input   [4:0] address; 
input   [15:0] data_in; 
output   [15:0] data_out; 

reg     [15:0] data_out; 
reg     [15:0] memory [22:0]; 
reg     [4:0]  process_1_i; 


always @(clk or write_read)
   begin : process_1
   process_1_i = address;   
   end


always @(posedge clk)
   begin : process_1_0
   if (clk === 1'b 1)
      begin
      if (write_read === 1'b 1)
         begin
         memory[process_1_i] <= data_in;   
         end
      else
         begin
         data_out <= memory[process_1_i];   
         end
      end
   end


endmodule // module regdct


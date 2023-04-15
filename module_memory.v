// --------------------------------------------------------------------------------
//  Company:  MSI
//  Engineer: Phan Van Chien
//  Create Date:    15:15:39 01/06/2022
//  Design Name: 
//  Module Name:    memory_module - Behavioral 
// -------------------------------------------------------------------------------
`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules



module module_memory (
   clk,
   read_write,
   address,
   data_in,
   data_out);
 
parameter data_length = 8;
parameter addr_length = 4;

input   clk; 
input   read_write; 
input   [addr_length - 1:0] address; 
input   [data_length - 1:0] data_in; 
output   [data_length - 1:0] data_out; 

reg     [data_length - 1:0] data_out; 
reg     [data_length - 1:0] memory [2**addr_length - 1:0]; 


always @(clk)
   begin : process_1
   if (clk === 1'b 1)
      begin
      if (read_write === 1'b 1)
         begin
         memory[address] <= data_in;
           
         end
      else
         begin
         data_out <= memory[address];   
         end
      end
   end




endmodule // module module_memory


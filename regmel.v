// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    15:05:40 02/14/2022 
//  Design Name: 
//  Module Name:    regmel - Behavioral 
// ---------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module regmel (
   clk,
   regmel_wren,
   regmel_addr,
   addmel_out,
   regmel_out);
 

input   clk; 
input   regmel_wren; 
input   [4:0] regmel_addr; 
input   [43:0] addmel_out; 
output   [43:0] regmel_out; 

reg     [43:0] regmel_out; 
reg     [43:0] memory [22:0]; 
reg     [4:0]  reg_p_i; 


always @(clk or regmel_wren)
   begin : reg_p
   reg_p_i = regmel_addr;   
   end


always @(posedge clk)
   begin : reg_p_0
   if (clk === 1'b 1)
      begin
      if (regmel_wren === 1'b 1)
         begin
         memory[reg_p_i] <= addmel_out;   
         end
      else
         begin
         regmel_out <= memory[reg_p_i];   
         end
      end
   end


endmodule // module regmel


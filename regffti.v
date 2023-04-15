// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    09:44:28 02/08/2022 
//  Design Name: 
//  Module Name:    regffti - Behavioral 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module regffti (
   clk,
   regfft_wren,
   regfft_addr,
   data_in,
   data_out);
 

input   clk; 
input   regfft_wren; 
input   [5:0] regfft_addr; 
input   [37:0] data_in; 
output   [37:0] data_out; 

reg     [37:0] data_out; 
reg     [37:0] memory [63:0]; 


always @(posedge clk)
   begin : write_read
   if (clk === 1'b 1)
      begin
      if (regfft_wren === 1'b 1)
         begin
         memory[regfft_addr] <= data_in;   
         end
      else
         begin
         data_out <= memory[regfft_addr];   
         end
      end
   end


endmodule // module regffti


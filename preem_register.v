// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    16:28:41 03/26/2022 
//  Design Name: 
//  Module Name:    preem_register - Behavioral 
//  Project Name: 
//  Tool versions: 
//  Description: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module preem_register (
   clk,
   rst_n,
   enable,
   reg_in,
   reg_out);
 

input   clk; 
input   rst_n; 
input   enable; 
input   [16:0] reg_in; 
output   [16:0] reg_out; 

reg     [16:0] reg_out; 


always @(posedge clk or negedge rst_n)
   begin : _reg_
   if (rst_n === 1'b 0)
      begin
      reg_out <= {17{1'b 0}};   
      end
   else if (clk === 1'b 1 )
      begin
      if (enable === 1'b 1)
         begin
         reg_out <= reg_in;   
         end
      else
         ;
      end
   end


endmodule // module preem_register


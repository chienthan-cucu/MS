// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    9:10:01 1/21/2022
//  Design Name: 
//  Module Name:    reg - Behavioral 
//  Project Name: 
//  Target Devices: 
//  Tool versions: 
//  Description: 
// --------------------------------------------------------------------------------
`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module _reg_ (
   clk,
   rst_n,
   D,
   Q);
 
parameter N = 16;

input   clk; 
input   rst_n; 
input   [N - 1:0] D; 
output   [N - 1:0] Q; 

reg     [N - 1:0] Q; 


always @(posedge clk or negedge rst_n)
   begin : reg_p
   if (rst_n === 1'b 0)
      begin
      Q <= {(N - 1 - 0 + 1){1'b 0}};   
      end
   else if (clk === 1'b 1 )
      begin
      Q <= D;   
      end
   end


endmodule // module _reg_


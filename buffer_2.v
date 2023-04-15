// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    10:03:05 08/04/2022
//  Design Name: 
//  Module Name:    buffer_2_FIFO - Behavioral 
//  Project Name: FFT_R2SDF
//  Description: 
// --------------------------------------------------------------------------------


`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules



module buffer_2 (
   iClk,
   iEn,
   iData_Re,
   iData_Im,
   oData_Re,
   oData_Im);
 

input   iClk; 
input   iEn; 
input   [36:0] iData_Re; 
input   [36:0] iData_Im; 
output   [36:0] oData_Re; 
output   [36:0] oData_Im; 

wire    [36:0] oData_Re; 
wire    [36:0] oData_Im; 
reg     [73:0] memory [1:0]; 

assign oData_Re = memory[1][73:37]; 
assign oData_Im = memory[1][36:0]; 

always @(posedge iClk)
   begin : process_1
   if (iClk === 1'b 1)
      begin
      if (iEn === 1'b 1)
         begin
         memory[1] <= memory[0];   
         memory[0] <= {iData_Re, iData_Im};   
         end
      else
         ;
      end
   end


endmodule // module buffer_2


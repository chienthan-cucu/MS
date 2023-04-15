// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    09:59:27 08/04/2022
//  Design Name: 
//  Module Name:    buffer_4_FIFO - Behavioral 
//  Project Name: FFT_R2SDF
//  Description: 
// --------------------------------------------------------------------------------
`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules

module buffer_4 (
   iClk,
   iEn,
   iData_Re,
   iData_Im,
   oData_Re,
   oData_Im);
 

input   iClk; 
input   iEn; 
input   [35:0] iData_Re; 
input   [35:0] iData_Im; 
output   [35:0] oData_Re; 
output   [35:0] oData_Im; 

wire    [35:0] oData_Re; 
wire    [35:0] oData_Im; 
reg     [71:0] memory [3:0]; 

assign oData_Re = memory[3][71:36]; 
assign oData_Im = memory[3][35:0]; 

always @(posedge iClk)
   begin : process_1
   if (iClk === 1'b 1)
      begin
      if (iEn === 1'b 1)
         begin
         memory[3] <= memory[2];   
         memory[2] <= memory[1];   
         memory[1] <= memory[0];   
         memory[0] <= {iData_Re, iData_Im};   
         end
      else
         ;
      end
   end


endmodule // module buffer_4


// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    10:05:52 08/04/2022 
//  Design Name: 
//  Module Name:    buffer_1_FIFO - Behavioral 
//  Project Name: FFT_R2SDF
//  Description: 
// --------------------------------------------------------------------------------
`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules



module buffer_1 (
   iClk,
   iEn,
   iData_Re,
   iData_Im,
   oData_Re,
   oData_Im);
 

input   iClk; 
input   iEn; 
input   [37:0] iData_Re; 
input   [37:0] iData_Im; 
output   [37:0] oData_Re; 
output   [37:0] oData_Im; 

wire    [37:0] oData_Re; 
wire    [37:0] oData_Im; 
reg     [75:0] memory; 

assign oData_Re = memory[75:38]; 
assign oData_Im = memory[37:0]; 

always @(posedge iClk)
   begin : process_1
   if (iClk === 1'b 1)
      begin
      if (iEn === 1'b 1)
         begin
         memory <= {iData_Re, iData_Im};   
         end
      else
         ;
      end
   end


endmodule // module buffer_1


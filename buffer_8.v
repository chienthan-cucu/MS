// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    09:55:20 08/04/2022
//  Module Name:    buffer_8_FIFO - Behavioral 
//  Project Name: FFT_R2SDF
//  Description: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module buffer_8 (
   iClk,
   iEn,
   iData_Re,
   iData_Im,
   oData_Re,
   oData_Im);
 

input   iClk; 
input   iEn; 
input   [34:0] iData_Re; 
input   [34:0] iData_Im; 
output   [34:0] oData_Re; 
output   [34:0] oData_Im; 

wire    [34:0] oData_Re; 
wire    [34:0] oData_Im; 
reg     [69:0] memory [7:0]; 

assign oData_Re = memory[7][69:35]; 
assign oData_Im = memory[7][34:0]; 

always @(posedge iClk)
   begin : process_1
   if (iClk === 1'b 1)
      begin
      if (iEn === 1'b 1)
         begin
         memory[7] <= memory[6];   
         memory[6] <= memory[5];   
         memory[5] <= memory[4];   
         memory[4] <= memory[3];   
         memory[3] <= memory[2];   
         memory[2] <= memory[1];   
         memory[1] <= memory[0];   
         memory[0] <= {iData_Re, iData_Im};   
         end
      else
         ;
      end
   end


endmodule // module buffer_8


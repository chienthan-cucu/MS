// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    09:44:40 08/04/2022
//  Design Name: 
//  Module Name:    buffer_16_FIFO - Behavioral 
//  Project Name: FFT_R2SDF
//  Description: 
// --------------------------------------------------------------------------------
`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module buffer_16 (
   iClk,
   iEn,
   iData_Re,
   iData_Im,
   oData_Re,
   oData_Im);
 

input   iClk; 
input   iEn; 
input   [33:0] iData_Re; 
input   [33:0] iData_Im; 
output   [33:0] oData_Re; 
output   [33:0] oData_Im; 

wire    [33:0] oData_Re; 
wire    [33:0] oData_Im; 
reg     [67:0] memory [15:0]; 

assign oData_Re = memory[15][67:34]; 
assign oData_Im = memory[15][33:0]; 

always @(posedge iClk)
   begin : process_1
   if (iClk === 1'b 1)
      begin
      if (iEn === 1'b 1)
         begin    
         memory[15] <= memory[14];   
         memory[14] <= memory[13];   
         memory[13] <= memory[12];   
         memory[12] <= memory[11];   
         memory[11] <= memory[10];   
         memory[10] <= memory[9];   
         memory[9] <= memory[8];   
         memory[8] <= memory[7];   
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


endmodule // module buffer_16


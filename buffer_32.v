// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    08:25:49 08/04/2022
//  Design Name: 
//  Module Name:    buffer_32_FIFO - Behavioral 
//  Project Name: FFT_R2SDF
//  Description: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module buffer_32 (
   iClk,
   iEn,
   iData_Re,
   iData_Im,
   oData_Re,
   oData_Im);
 

input   iClk; 
input   iEn; 
input   [32:0] iData_Re; 
input   [32:0] iData_Im; 
output   [32:0] oData_Re; 
output   [32:0] oData_Im; 

wire    [32:0] oData_Re; 
wire    [32:0] oData_Im; 
reg     [65:0] memory [31:0]; 

assign oData_Re = memory[31][65:33]; 
assign oData_Im = memory[31][32:0]; 

always @(posedge iClk)
   begin : process_1
   if (iClk === 1'b 1)
      begin
      if (iEn === 1'b 1)
         begin
         memory[31] <= memory[30];   
         memory[30] <= memory[29];   
         memory[29] <= memory[28];   
         memory[28] <= memory[27];   
         memory[27] <= memory[26];   
         memory[26] <= memory[25];   
         memory[25] <= memory[24];   
         memory[24] <= memory[23];   
         memory[23] <= memory[22];   
         memory[22] <= memory[21];   
         memory[21] <= memory[20];   
         memory[20] <= memory[19];   
         memory[19] <= memory[18];   
         memory[18] <= memory[17];   
         memory[17] <= memory[16];   
         memory[16] <= memory[15];   
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


endmodule // module buffer_32


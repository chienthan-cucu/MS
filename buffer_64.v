// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    08:03:14 08/04/2016 
//  Design Name: 
//  Module Name:    Buffer_FIFO - Behavioral 
//  Project Name: FFT_R2SDF
//  Revision 0.01 - File Created
//  Additional Comments: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module buffer_64 (
   iClk,
   iEn,
   iData,
   oData);
 

input   iClk; 
input   iEn; 
input   [21:0] iData; 
output   [21:0] oData; 

wire    [21:0] oData; 
reg     [21:0] memory [63:0]; 

assign oData = memory[63]; 

always @(posedge iClk)
   begin : process_1
   if (iClk === 1'b 1)
      begin
      if (iEn === 1'b 1)
         begin
         memory[63] <= memory[62];   
         memory[62] <= memory[61];   
         memory[61] <= memory[60];   
         memory[60] <= memory[59];   
         memory[59] <= memory[58];   
         memory[58] <= memory[57];   
         memory[57] <= memory[56];   
         memory[56] <= memory[55];   
         memory[55] <= memory[54];   
         memory[54] <= memory[53];   
         memory[53] <= memory[52];   
         memory[52] <= memory[51];   
         memory[51] <= memory[50];   
         memory[50] <= memory[49];   
         memory[49] <= memory[48];   
         memory[48] <= memory[47];   
         memory[47] <= memory[46];   
         memory[46] <= memory[45];   
         memory[45] <= memory[44];   
         memory[44] <= memory[43];   
         memory[43] <= memory[42];   
         memory[42] <= memory[41];   
         memory[41] <= memory[40];   
         memory[40] <= memory[39];   
         memory[39] <= memory[38];   
         memory[38] <= memory[37];   
         memory[37] <= memory[36];   
         memory[36] <= memory[35];   
         memory[35] <= memory[34];   
         memory[34] <= memory[33];   
         memory[33] <= memory[32];   
         memory[32] <= memory[31];   
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
         memory[0] <= iData;   
         end
      else
         ;
      end
   end


endmodule // module buffer_64


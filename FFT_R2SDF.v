// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    07:28:05 08/09/2022
//  Design Name: 
//  Module Name:    FFT_R2SDF - Behavioral 
//  Project Name:   FFT_R2SDF
//  Tool versions: 
//  Description: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module FFT_R2SDF (
   iClk,
   iRst_n,
   iData_valid,
   iData,
   oData_valid,
   oData_Re,
   oData_Im);
 

input   iClk; 
input   iRst_n; 
input   iData_valid; 
input   [20:0] iData; 
output   oData_valid; 
output   [37:0] oData_Re; 
output   [37:0] oData_Im; 

wire    oData_valid; 
wire    [37:0] oData_Re; 
wire    [37:0] oData_Im; 
wire    Data_valid1; 
wire    Data_valid2; 
wire    Data_valid3; 
wire    Data_valid4; 
wire    Data_valid5; 
wire    Data_valid6; 
wire    [31:0] Data1_Re; 
wire    [31:0] Data1_Im; 
wire    [32:0] Data2_Re; 
wire    [32:0] Data2_Im; 
wire    [33:0] Data3_Re; 
wire    [33:0] Data3_Im; 
wire    [34:0] Data4_Re; 
wire    [34:0] Data4_Im; 
wire    [35:0] Data5_Re; 
wire    [35:0] Data5_Im; 
wire    [36:0] Data6_Re; 
wire    [36:0] Data6_Im; 

first_stage stage_1 (.iClk(iClk),
          .iRst_n(iRst_n),
          .iData_valid(iData_valid),
          .iData(iData),
          .oData_valid(Data_valid1),
          .oData_Re(Data1_Re),
          .oData_Im(Data1_Im));
second_stage stage_2 (.iClk(iClk),
          .iRst_n(iRst_n),
          .iData_valid(Data_valid1),
          .iData_Re(Data1_Re),
          .iData_Im(Data1_Im),
          .oData_valid(Data_valid2),
          .oData_Re(Data2_Re),
          .oData_Im(Data2_Im));
third_stage stage_3 (.iClk(iClk),
          .iRst_n(iRst_n),
          .iData_valid(Data_valid2),
          .iData_Re(Data2_Re),
          .iData_Im(Data2_Im),
          .oData_valid(Data_valid3),
          .oData_Re(Data3_Re),
          .oData_Im(Data3_Im));
fourth_stage stage_4 (.iClk(iClk),
          .iRst_n(iRst_n),
          .iData_valid(Data_valid3),
          .iData_Re(Data3_Re),
          .iData_Im(Data3_Im),
          .oData_valid(Data_valid4),
          .oData_Re(Data4_Re),
          .oData_Im(Data4_Im));
fifth_stage stage_5 (.iClk(iClk),
          .iRst_n(iRst_n),
          .iData_valid(Data_valid4),
          .iData_Re(Data4_Re),
          .iData_Im(Data4_Im),
          .oData_valid(Data_valid5),
          .oData_Re(Data5_Re),
          .oData_Im(Data5_Im));
sixth_stage stage_6 (.iClk(iClk),
          .iRst_n(iRst_n),
          .iData_valid(Data_valid5),
          .iData_Re(Data5_Re),
          .iData_Im(Data5_Im),
          .oData_valid(Data_valid6),
          .oData_Re(Data6_Re),
          .oData_Im(Data6_Im));
seventh_stage stage_7 (.iClk(iClk),
          .iRst_n(iRst_n),
          .iData_valid(Data_valid6),
          .iData_Re(Data6_Re),
          .iData_Im(Data6_Im),
          .oData_valid(oData_valid),
          .oData_Re(oData_Re),
          .oData_Im(oData_Im));

endmodule // module FFT_R2SDF


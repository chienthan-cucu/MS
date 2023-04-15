// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    20:12:16 02/08/2022
//  Design Name: 
//  Module Name:    fourth_stage - Behavioral 
//  Project Name:   FFT_R2SDF
//  Target Devices: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules

module fourth_stage (
   iClk,
   iRst_n,
   iData_valid,
   iData_Re,
   iData_Im,
   oData_valid,
   oData_Re,
   oData_Im);
 

input   iClk; 
input   iRst_n; 
input   iData_valid; 
input   [33:0] iData_Re; 
input   [33:0] iData_Im; 
output   oData_valid; 
output   [34:0] oData_Re; 
output   [34:0] oData_Im; 

reg     oData_valid; 
reg     [34:0] oData_Re; 
reg     [34:0] oData_Im; 
wire    [34:0] iData_8_Re; 
//  buffer_32's input
wire    [34:0] iData_8_Im; 
//  buffer_32's input
wire    [34:0] oData_8_Re; 
//  buffer_32's output
wire    [34:0] oData_8_Im; 
//  buffer_32's output
wire    [34:0] Product_Re; 
//  from subtracton
wire    [34:0] Product_Im; 
//  from subtracton
wire    [34:0] Pos_data_Re; 
//  from Adder
wire    [34:0] Pos_data_Im; 
//  from Adder
wire    [34:0] Neg_data_Re; 
//  from Cordic_mid
wire    [34:0] Neg_data_Im; 
//  from Cordic_mid
wire    [34:0] Data_Re; 
wire    [34:0] Data_Im; 
reg     [7:0] Counter; 
wire    [5:0] Phi; 
wire    En; 
wire    Rst; 
wire    Data_valid; 

assign En = Counter[7] | iData_valid; 
assign Data_valid = Counter[7] | iData_valid & (Counter[6] | Counter[5] | 
      Counter[4] | Counter[3]); 
assign Rst = ~(~(Counter[7] & Counter[3]) & iRst_n); 
assign iData_8_Re = Counter[3] === 1'b 0 ? {iData_Re[33], iData_Re} : 
	Neg_data_Re; 
assign iData_8_Im = Counter[3] === 1'b 0 ? {iData_Im[33], iData_Im} : 
	Neg_data_Im; 

//  Adder
assign Pos_data_Re =iData_Re[33]===1'b1 ? (oData_8_Re - {~iData_Re+1'b1}):( oData_8_Re+iData_Re);; 
assign Pos_data_Im =iData_Im[33]===1'b1 ? (oData_8_Im - {~iData_Im+1'b1}):( oData_8_Im+iData_Im); 
//  Subtractor
assign Neg_data_Re =iData_Re[33]===1'b1 ? (oData_8_Re + {~iData_Re+1'b1}):( oData_8_Re-iData_Re);; 
assign Neg_data_Im =iData_Im[33]===1'b1 ? (oData_8_Im + {~iData_Im+1'b1}):( oData_8_Im-iData_Im); 
//  Output
assign Data_Re = Counter[3] === 1'b 0 ? Product_Re : 
	Pos_data_Re; 
assign Data_Im = Counter[3] === 1'b 0 ? Product_Im : 
	Pos_data_Im; 

always @(posedge iClk or posedge Rst)
   begin : Counter_process
   if (Rst === 1'b 1)
      begin
      Counter <= {8{1'b 0}};   
      end
   else if (iClk === 1'b 1 )
      begin
      if (En === 1'b 1)
         begin
         Counter <= Counter + 2'b 01;   
         end
      else
         begin
         Counter <= Counter;   
         end
      end
   end


always @(posedge iClk or negedge iRst_n)
   begin : Data_output
   if (iRst_n === 1'b 0)
      begin
      oData_valid <= 1'b 0;   
      oData_Re <= {35{1'b 0}};   
      oData_Im <= {35{1'b 0}};   
      end
   else if (iClk === 1'b 1 )
      begin
      oData_valid <= Data_valid;   
      oData_Re <= Data_Re;   
      oData_Im <= Data_Im;   
      end
   end

assign Phi = {Counter[2:0], 3'b 000}; 
defparam
      Cordic_mid_process.n = 35;
cordic_mid Cordic_mid_process (.iReal(oData_8_Re),
          .iImage(oData_8_Im),
          .iPhi(Phi),
          .oReal(Product_Re),
          .oImage(Product_Im));
buffer_8 Buffer_8_process (.iClk(iClk),
          .iEn(En),
          .iData_Re(iData_8_Re),
          .iData_Im(iData_8_Im),
          .oData_Re(oData_8_Re),
          .oData_Im(oData_8_Im));

endmodule // module fourth_stage


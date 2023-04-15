// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    16:32:46 08/08/2022 
//  Design Name: 
//  Module Name:    third_stage - Behavioral 
//  Project Name:   FFT_R2SDF
//  Target Devices: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module third_stage (
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
input   [32:0] iData_Re; 
input   [32:0] iData_Im; 
output   oData_valid; 
output   [33:0] oData_Re; 
output   [33:0] oData_Im; 

reg     oData_valid; 
reg     [33:0] oData_Re; 
reg     [33:0] oData_Im; 
wire    [33:0] iData_16_Re; 
//  buffer_32's input
wire    [33:0] iData_16_Im; 
//  buffer_32's input
wire    [33:0] oData_16_Re; 
//  buffer_32's output
wire    [33:0] oData_16_Im; 
//  buffer_32's output
wire    [33:0] Product_Re; 
//  from subtracton
wire    [33:0] Product_Im; 
//  from subtracton
wire    [33:0] Pos_data_Re; 
//  from Adder
wire    [33:0] Pos_data_Im; 
//  from Adder
wire    [33:0] Neg_data_Re; 
//  from Cordic_mid
wire    [33:0] Neg_data_Im; 
//  from Cordic_mid
wire    [33:0] Data_Re; 
wire    [33:0] Data_Im; 
reg     [7:0] Counter; 
wire    [5:0] Phi; 
wire    En; 
wire    Rst; 
wire    Data_valid; 

assign En = Counter[7] | iData_valid; 
assign Data_valid = Counter[7] | iData_valid & (Counter[6] | Counter[5] | 
      Counter[4]); 
assign Rst = ~(~(Counter[7] & Counter[4]) & iRst_n); 
assign iData_16_Re = Counter[4] === 1'b 0 ? {iData_Re[32], iData_Re} : 
	Neg_data_Re; 
assign iData_16_Im = Counter[4] === 1'b 0 ? {iData_Im[32], iData_Im} : 
	Neg_data_Im; 

//  Adder
assign Pos_data_Re =iData_Re[32]===1'b1 ? (oData_16_Re - {~iData_Re+1'b1}):( oData_16_Re+iData_Re);; 
assign Pos_data_Im =iData_Im[32]===1'b1 ? (oData_16_Im - {~iData_Im+1'b1}):( oData_16_Im+iData_Im);
//  Subtractor
assign Neg_data_Re =iData_Re[32]===1'b1 ? (oData_16_Re + {~iData_Re+1'b1}):( oData_16_Re-iData_Re);; 
assign Neg_data_Im =iData_Im[32]===1'b1 ? (oData_16_Im + {~iData_Im+1'b1}):( oData_16_Im-iData_Im); 

//  Output
assign Data_Re = Counter[4] === 1'b 0 ? Product_Re : 
	Pos_data_Re; 
assign Data_Im = Counter[4] === 1'b 0 ? Product_Im : 
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
      oData_Re <= {34{1'b 0}};   
      oData_Im <= {34{1'b 0}};   
      end
   else if (iClk === 1'b 1 )
      begin
      oData_valid <= Data_valid;   
      oData_Re <= Data_Re;   
      oData_Im <= Data_Im;   
      end
   end

assign Phi = {Counter[3:0], 2'b 00}; 
defparam
      Cordic_mid_process.n = 34;
cordic_mid Cordic_mid_process (.iReal(oData_16_Re),
          .iImage(oData_16_Im),
          .iPhi(Phi),
          .oReal(Product_Re),
          .oImage(Product_Im));
buffer_16 Buffer_16_process (.iClk(iClk),
          .iEn(En),
          .iData_Re(iData_16_Re),
          .iData_Im(iData_16_Im),
          .oData_Re(oData_16_Re),
          .oData_Im(oData_16_Im));

endmodule // module third_stage


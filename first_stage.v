// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    22:31:51 03/07/2022 
//  Design Name: 
//  Module Name:    first_stage - Behavioral 
//  Project Name:   FFT_R2SDF
//  Target Devices: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module first_stage (
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
output   oData_Re;
output   oData_Im;
wire iClk;
reg     oData_valid; 
reg     [31:0] oData_Re; 
reg     [31:0] oData_Im; 
wire    [21:0] iData_64; 
//  buffer_64's input
wire    [21:0] oData_64; 
//  buffer_64's output
wire    [21:0] Neg_data; 
//  from subtracton
wire    [21:0] Pos_data; 
//  from Adder
wire    [31:0] Product_Re; 
//  from Cordic_first
wire    [31:0] Product_Im; 
//  from Cordic_first
wire    [31:0] Pos_data_Re; 
//  from Adder
wire    [31:0] Pos_data_Im; 
//  from Adder
wire    [31:0] Data_Re;
wire    [31:0] Data_Im; 
reg     [7:0] Counter; 
wire    En; 
wire    Rst; 
wire    Data_valid; 
initial
begin
    oData_Re=32'b0; 
    oData_Im=32'b0;
end

//assign Data_Re=0;
assign En = Counter[7] | iData_valid; 
assign Data_valid = Counter[7] | iData_valid & Counter[6]; 
assign Rst = ~(~(Counter[7] & Counter[6]) & iRst_n); 
assign iData_64 = Counter[6] === 1'b 0 ? {iData[20], iData} : 
	Neg_data; 

//  Adder
assign Pos_data =iData[20]===1'b1 ? (oData_64 - {~iData+1'b1}):( oData_64+iData);

//  Subtractor
assign Neg_data =iData[20]===1'b1 ? (oData_64 + {~iData+1'b1}):( oData_64-iData);

assign Pos_data_Re = {Pos_data, 10'b 0000000000}; 
assign Pos_data_Im = {32{1'b 0}}; 

//  Output
assign Data_Re = Counter[6] === 1'b 0 ? Product_Re : 
	Pos_data_Re; 
assign Data_Im = Counter[6] === 1'b 0 ? Product_Im : 
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
      oData_Re <= {32{1'b 0}};   
      oData_Im <= {32{1'b 0}};   
      end
   else if (iClk === 1'b 1 )
      begin
      oData_valid <= Data_valid;   
      oData_Re <= Data_Re;   
      oData_Im <= Data_Im;   
      end
   end

cordic_first Cordic_first_process (.iReal(oData_64),
          .iPhi(Counter[5:0]),
          .oReal(Product_Re),
          .oImage(Product_Im));
buffer_64 Buffer_64_process (.iClk(iClk),
          .iEn(En),
          .iData(iData_64),
          .oData(oData_64));

endmodule // module first_stage


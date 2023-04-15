// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chiem
//  Create Date:    22:29:37 03/15/2022 
//  Design Name: 
//  Module Name:    multi - Behavioral 
//  Project Name: 
//  Tool versions: 
// --------------------------------------------------------------------------------
`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules

module multi (
   in1,
   in2,
   _output_);
 
parameter length_in1 = 31;
parameter length_in2 = 8;

input   [length_in1 - 1:0] in1; 
input   [length_in2 - 1:0] in2; 
output   [length_in1 + length_in2 - 2:0] _output_; 

wire    [length_in1 + length_in2 - 2:0] _output_; 
wire    [length_in1 - 2:0] mul_1; 
wire    [length_in2 - 2:0] mul_2; 
wire    [length_in1 + length_in2 - 3:0] tich; 

assign mul_1 = in1[length_in1 - 1] === 1'b 0 ? in1[length_in1 - 2:0] : 
	~in1[length_in1 - 2:0] + 2'b 01; 
assign mul_2 = in2[length_in2 - 1] === 1'b 0 ? in2[length_in2 - 2:0] : 
	~in2[length_in2 - 2:0] + 2'b 01; 
assign tich = mul_1 * mul_2; 
assign _output_ = in1[length_in1 - 1] === 1'b 0 & in2[length_in2 - 
      1] === 1'b 0 | in1[length_in1 - 1] === 
      1'b 1 & in2[length_in2 - 1] === 1'b 1 ? {1'b 0, 
      tich} : 
	{1'b 1, (~tich + 2'b 01)}; 

endmodule // module multi


// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    21:07:15 03/23/2022
//  Design Name: 
//  Module Name:    square - Behavioral 
//  Project Name: 
//  Tool versions: 
//  Description: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module square (
   clk,
   rst_n,
   enable,
   _input_,
   _output_);
 

input   clk; 
input   rst_n; 
input   enable; 
input   [15:0] _input_; 
output   [30:0] _output_; 

reg     [30:0] _output_; 
wire    [30:0] output_temp; 

defparam
      uut_multi.length_in1 = 16,
      uut_multi.length_in2 = 16;
multi uut_multi (.in1(_input_),
          .in2(_input_),
          ._output_(output_temp));

always @(negedge rst_n or posedge clk)
   begin : output_square
   if (rst_n === 1'b 0)
      begin
      _output_ <= {31{1'b 0}};   
      end
   else if (enable === 1'b 1 )
      begin
      _output_ <= output_temp;   
      end
   end


endmodule // module square


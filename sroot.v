// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van chien
//  Create Date:    14:08:10 03/04/2022
//  Design Name: 
//  Module Name:    sroot - Behavioral 
//  Project Name: 
//  Tool versions: 
//  Description: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module sroot (
   clk,
   rst_n,
   enable,
   regfftoutr,
   regfftouti,
   _output_);
 

input   clk; 
input   rst_n; 
input   enable; 
input   [37:0] regfftoutr; 
input   [37:0] regfftouti; 
output   [38:0] _output_; 

reg     [38:0] _output_; 
wire    [37:0] regfftoutr_abs; 
wire    [37:0] regfftouti_abs; 
wire    [37:0] max; 
wire    [35:0] min; 
wire    [38:0] sum; 

assign regfftoutr_abs =   abs (regfftoutr); 
assign regfftouti_abs =   abs (regfftouti); 
assign max = regfftoutr_abs > regfftouti_abs ? regfftoutr_abs : 
	regfftouti_abs; 
assign min = regfftoutr_abs < regfftouti_abs ? regfftoutr_abs[37:2] : 
	regfftouti_abs[37:2]; 
assign sum = {1'b 0, max} + {3'b 000, min}; 
//  min, max > 0

always @(posedge clk or negedge rst_n)
   begin : output_reg
   if (rst_n === 1'b 0)
      begin
      _output_ <= {39{1'b 0}};   
      end
   else if (clk === 1'b 1 )
      begin
      if (enable === 1'b 1)
         begin
         _output_ <= sum;   
         end
      end
   end



// Subprograms that are created by VHDL2V translator
function integer abs;
    input temp;
    integer temp;
    begin
        if(temp < 0) abs = - temp;
        else abs = temp; 
    end
endfunction // abs 

endmodule // module srootzz


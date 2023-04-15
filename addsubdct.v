// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    21:13:05 11/18/2022 
//  Design Name: 
//  Module Name:    addsubdct - Behavioral 
//  Project Name: MFCC
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules



module addsubdct (
   clk,
   rst_n,
   addsubdct_en,
   addsubdct_new,
   _input_,
   _output_);
 

input   clk; 
input   rst_n; 
input   addsubdct_en; 
input   addsubdct_new; 
input   [22:0] _input_; 
output   [15:0] _output_; 
reg     [11:0] dem_clk=1'b0;
wire    [15:0] _output_; 
wire    [33:0] Q_sig; 
wire    [33:0] Q_sig1; 

assign Q_sig = _input_[22] === 1'b 0 & addsubdct_new === 1'b 1 ? {11'b 00000000000, 
      _input_} : 
	_input_[22] === 1'b 1 & addsubdct_new === 1'b 1 ? {11'b 11111111111, 
      _input_} : 
	_input_[22] === 1'b 0 & addsubdct_en === 1'b 1 ? Q_sig1 + 
      {11'b 00000000000, _input_} : 
	_input_[22] === 1'b 1 & addsubdct_en === 1'b 1 ? Q_sig1 + 
      {11'b 11111111111, _input_} : 
	Q_sig1;

always @(posedge clk)
   begin : counter_clk
   if (clk === 1'b 1 )
      begin
      dem_clk <= dem_clk + 1;   
      if (dem_clk === 80)
         begin
         dem_clk <= 0;   
         end
      end
   end
 
defparam
      reg_dct.N = 34;
_reg_ reg_dct (.clk(clk),
          .rst_n(rst_n),
          .D(Q_sig),
          .Q(Q_sig1));
assign _output_ = Q_sig1[23:8]; 

endmodule // module addsubdct


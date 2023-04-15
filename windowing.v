// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    23:04:27 01/30/2022 
//  Design Name: 
//  Module Name:    windowing - Behavioral 
//  Project Name: 
//  Description:   Thuc hien phep nhan co dau giua so 17 bit va so 5 bit. Ket qua dau ra la so 21 bit
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module windowing (
   clk,
   rst_n,
   enable,
   in1_from_pre,
   in2_cham,
   _output_);
 

input   clk; 
input   rst_n; 
input   enable; 
input   [16:0] in1_from_pre; 
input   [3:0] in2_cham; 
output   [20:0] _output_; 

reg     [20:0] _output_; 
wire    [20:0] output_temp; 
wire    [4:0] cham; 

assign cham = {1'b 0, in2_cham}; 
defparam
      phep_nhan.length_in1 = 17,
      phep_nhan.length_in2 = 5;
multi phep_nhan (.in1(in1_from_pre),
          .in2(cham),
          ._output_(output_temp));

always @(negedge rst_n or posedge clk or negedge enable)
   begin : dau_ra
   if (rst_n === 1'b 0 | enable === 1'b 0)
      begin
      _output_ <= {21{1'b 0}};   
      end
   else if (enable === 1'b 1 )
      begin
      if (clk===1'b 1)
         begin
         if (in1_from_pre === 17'b 00000000000000000 | in2_cham === 4'b 0000)
            begin
            _output_ <= {21{1'b 0}};   
            end
         else
            begin
            _output_ <= output_temp;   
            end
         end
      end
   end


endmodule // module windowing


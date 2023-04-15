// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    21:02:23 1/18/2022 
//  Design Name: 
//  Module Name:    cepstral - Behavioral 
//  Project Name: MFCC
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module cepstral (
   clk,
   rst_n,
   muldct_en,
   regdct_out,
   cdct_data,
   addsubdct_en,
   addsubdct_new,
   addsubdct_out);
 

input   clk; 
input   rst_n; 
input   muldct_en; 
input   [15:0] regdct_out; 
input   [7:0] cdct_data; 
input   addsubdct_en; 
input   addsubdct_new; 
output   [15:0] addsubdct_out; 

wire    [15:0] addsubdct_out; 
reg     [22:0] muldct_out; 
wire    [22:0] muldct_out_temp; 

defparam
      mul_dct.length_in1 = 16,
      mul_dct.length_in2 = 8;
multi mul_dct (.in1(regdct_out),
          .in2(cdct_data),
          ._output_(muldct_out_temp));

always @(rst_n or muldct_en or muldct_out_temp)
   begin : muldct_output
   if (rst_n === 1'b 0)
      begin
      muldct_out <= {23{1'b 0}};   
      end
   else if (muldct_en === 1'b 1 )
      begin
      if (regdct_out === 16'b 0000000000000000 | cdct_data === 8'b 00000000)
         begin
         muldct_out <= {23{1'b 0}};   
         end
      else
         begin
         muldct_out <= muldct_out_temp;   
         end
      end
   else
      ;
   end

addsubdct addsub_dct (.clk(clk),
          .rst_n(rst_n),
          .addsubdct_en(addsubdct_en),
          .addsubdct_new(addsubdct_new),
          ._input_(muldct_out),
          ._output_(addsubdct_out));

endmodule // module cepstral


// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    23:05:58 1/27/2022
//  Design Name: 
//  Module Name:    log - Behavioral 
//  Project Name: MFCC
//  Tool versions: 
//  Description: Ket qua logarith duoc nhan voi 2**9
// --------------------------------------------------------------------------------
`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module log (
   clk,
   rst_n,
   enable,
   log_sel,
   _input_,
   _output_,
   overf);
 

input   clk; 
input   rst_n; 
input   enable; 
input   log_sel; 
input   [43:0] _input_; 
output   [15:0] _output_; 
output   overf; 

reg     [15:0] _output_; 
wire    overf; 
reg     [15:0] m; 
reg     [8:0] temp;
reg     [5:0] k_std; 
wire    [15:0] output_temp; 
integer  V2V_log_decoder_i=43; 
integer  log_decoder_k; 

initial 
   begin : process_1
   V2V_log_decoder_i = 43;   
   end

assign overf = enable === 1'b 1 & _input_ === 44'h 00000000000 & 
      log_sel === 1'b 1 ? 1'b 1 : 	1'b 0; 

always @(_input_)
   begin : log_decoder
   V2V_log_decoder_i = 43;
   while (V2V_log_decoder_i>=0 && _input_[V2V_log_decoder_i]!==1'b1)
      begin
      V2V_log_decoder_i=V2V_log_decoder_i-1;   
      end
   if (V2V_log_decoder_i>=0) log_decoder_k = V2V_log_decoder_i;
   else log_decoder_k=0;
   case (log_decoder_k)
   0:
      begin
      m <= {16{1'b 0}};   
      end
   1:
      begin
      m <= {7'b 0000000, _input_[0], 8'b 00000000};   
      end
   2:
      begin
      m <= {7'b 0000000, _input_[1:0], 7'b 0000000};   
      end
   3:
      begin
      m <= {7'b 0000000, _input_[2:0], 6'b 000000};   
      end
   4:
      begin
      m <= {7'b 0000000, _input_[3:0], 5'b 00000};   
      end
   5:
      begin
      m <= {7'b 0000000, _input_[4:0], 4'b 0000};   
      end
   6:
      begin
      m <= {7'b 0000000, _input_[5:0], 3'b 000};   
      end
   7:
      begin
      m <= {7'b 0000000, _input_[6:0], 2'b 00};   
      end
   8:
      begin
      m <= {7'b 0000000, _input_[7:0], 1'b 0};   
      end
   default:  
      begin  
      temp<=(_input_>>(log_decoder_k - 9));  
      end
   endcase
   k_std <= log_decoder_k[5:0];   
   end

assign output_temp = {1'b 0, k_std, 9'b 000000000} + temp; 


always @(posedge clk or negedge rst_n)
   begin : plus
   if (rst_n === 1'b 0)
      begin
      _output_ <= {16{1'b 0}};   
      end
   else 
      if (enable === 1'b 1)
         begin
         _output_ <= output_temp;   
         end
   end
endmodule // module log


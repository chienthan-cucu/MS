// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    22:53:38 02/24/2022
//  Module Name:    pre_emphasis - Behavioral 
//  Project Name: 
//  Target Devices: 
//  Tool versions: 
//  Description:  Tin hieu sel thay doi lien thuc theo clk, sau khi da tinh xong 1 bieu thuc thi no se
// 					  thay doi gia tri de tinh bieu thuc tiep theo.
// --------------------------------------------------------------------------------
`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module pre_emphasis (
   clk,
   rst_n,
   enable,
   new_subframe,
   _input_,
   _output_);
 

input   clk; 
input   rst_n; 
input   enable; 
input   new_subframe; 
input   [15:0] _input_; 
output   [16:0] _output_; 

reg     [16:0] _output_; 
parameter  length_data = 17; 

// TYPE state_type:
parameter state_type_s0 = 0;
parameter state_type_s1 = 1;

reg     state; 
//  Gom co 2 trang thai
wire    sel; 
wire    [length_data - 1:0] s_from_shift; 
wire    [length_data - 1:0] s_from_mux; 
wire    [length_data - 1:0] s_from_sub; 
wire    [length_data - 1:0] s_from_reg; 


always @(posedge clk or negedge rst_n)
   begin : next_state_fsm
   if (rst_n === 1'b 0)
      begin
      state <= state_type_s0;   
      end
   else if (clk === 1'b 1 )
      begin
      case (state)
      state_type_s0:
         begin
         if (new_subframe === 1'b 1)
            begin
            state <= state_type_s0;   
            end
         else if (enable === 1'b 1 )
            begin
            state <= state_type_s1;   
            end
         else
            begin
            state <= state_type_s0;   
            end
         end
      state_type_s1:
         begin
         if (new_subframe === 1'b 1)
            begin
            state <= state_type_s0;   
            end
         else if (enable === 1'b 1 )
            begin
            state <= state_type_s0;   
            end
         else
            begin
            state <= state_type_s1;   
            end
         end
      endcase
      end
   end

assign sel = state === state_type_s0 ? 1'b 1 : 	1'b 0; 
//  output logic FSM
preem_shifter_right shifter (.shift_in(_input_[15:5]),
          .shift_out(s_from_shift));
defparam
      mux_preem.N = 17;
mux mux_preem (.mux_in0(s_from_shift),
          .mux_in1(s_from_reg),
          .choose(sel),
          .mux_out(s_from_mux));
preem_sub sub (.sub_in1(s_from_mux),
          .sub_in2(_input_),
          .sub_out(s_from_sub));
preem_register _reg_ (.clk(clk),
          .rst_n(rst_n),
          .enable(enable),
          .reg_in(s_from_sub),
          .reg_out(s_from_reg));

always @(posedge clk or negedge rst_n)
   begin : pre_out
   if (rst_n === 1'b 0)
      begin
      _output_ <= {17{1'b 0}};   
      end
   else if (sel === 1'b0)
         _output_ <= s_from_reg;   
   end

endmodule // module pre_emphasis


//////////////////////////////////////////////////////////////////////////////////
// Company: MSI
// Engineer: Phan Van Chien
// Create Date: 03/22/2022 04:19:32 PM
// Design Name: 
// Module Name: pre_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module pre_control (
   clk,
   rst_n,
   start,
   ready,
   fs_control,
   log_overf,
   ram_addr,
   square_en,
   eadder_en,
   eadder_sel,
   eadder_new,
   ereg_we,
   log_en,
   log_sel,
   preemp_en,
   preemp_new,
   cham_addr,
   win_en,
   fft_en,
   reset_fft,
   regffte_addr,
   addmel_en,
   addmel_sel,
   addmel_new,
   regmel_addr,
   regmel_wren,
   regdct_addr,
   regdct_wren,
   cdct_addr,
   muldct_en,
   addsubdct_en,
   addsubdct_new,
   regc_addr,
   regc_wren,
   regc_sel,
   delta_new,
   delta_sub,
   delta_shift,
   delta_en,
   regcep_addr,
   regcep_wren,
   fefinish,
   framenum);
 
reg rst;
input   clk; 
input   rst_n; 
input   start; 
input   ready; 
input   fs_control; 
input   log_overf; 
output   [14:0] ram_addr; 
output   square_en; 
output   eadder_en; 
output   eadder_sel; 
output   eadder_new; 
output   ereg_we; 
output   log_en; 
output   log_sel; 
output   preemp_en; 
output   preemp_new; 
output   [6:0] cham_addr; 
output   win_en; 
output   fft_en; 
output   reset_fft; 
output   [5:0] regffte_addr; 
output   addmel_en; 
output   addmel_sel; 
output   addmel_new; 
output   [4:0] regmel_addr; 
output   regmel_wren; 
output   [4:0] regdct_addr; 
output   regdct_wren; 
output   [8:0] cdct_addr; 
output   muldct_en; 
output   addsubdct_en; 
output   addsubdct_new; 
output   [6:0] regc_addr; 
output   regc_wren; 
output   [1:0] regc_sel; 
output   delta_new; 
output   delta_sub; 
output   delta_shift; 
output   delta_en; 
output   [12:0] regcep_addr; 
output   regcep_wren; 
output   fefinish; 
output   [7:0] framenum; 

wire     [14:0] ram_addr; 
wire     square_en; 
wire     eadder_en; 
wire     eadder_sel; 
wire     eadder_new; 
wire     ereg_we; 
wire     log_en; 
wire     log_sel; 
wire     preemp_en; 
wire     preemp_new; 
wire     [6:0] cham_addr; 
wire     win_en; 
wire     fft_en; 
wire     reset_fft; 
wire     [5:0] regffte_addr; 
wire     addmel_en; 
wire     addmel_sel; 
wire     addmel_new; 
wire     [4:0] regmel_addr; 
wire     regmel_wren; 
wire     [4:0] regdct_addr; 
wire     regdct_wren; 
wire     [8:0] cdct_addr; 
wire     muldct_en; 
wire     addsubdct_en; 
wire     addsubdct_new; 
wire     [6:0] regc_addr; 
wire     regc_wren; 
wire     [1:0] regc_sel; 
wire     delta_new; 
wire     delta_sub; 
wire     delta_shift; 
wire     delta_en; 
wire     [12:0] regcep_addr; 
wire     regcep_wren; 
wire     fefinish; 
wire     [7:0] framenum; 
always @(posedge clk)
begin:prepare
    rst<=rst_n;
end ;
controller MFCC_controller(.clk(clk),
          .rst_n(rst),
          .start(start),
          .ready(ready),
          .fs_control(fs_control),
          .log_overf(log_overf),
          .ram_addr(ram_addr),
          .square_en(square_en),
          .eadder_en(eadder_en),
          .eadder_sel(eadder_sel),
          .eadder_new(eadder_new),
          .ereg_we(ereg_we),
          .log_en(log_en),
          .log_sel(log_sel),
          .preemp_en(preemp_en),
          .preemp_new(preemp_new),
          .cham_addr(cham_addr),
          .win_en(win_en),
          .fft_en(fft_en),
          .reset_fft(reset_fft),
          .regffte_addr(regffte_addr),
          .addmel_en(addmel_en),
          .addmel_sel(addmel_sel),
          .addmel_new(addmel_new),
          .regmel_addr(regmel_addr),
          .regmel_wren(regmel_wren),
          .regdct_addr(regdct_addr),
          .regdct_wren(regdct_wren),
          .cdct_addr(cdct_addr),
          .muldct_en(muldct_en),
          .addsubdct_en(addsubdct_en),
          .addsubdct_new(addsubdct_new),
          .regc_addr(regc_addr),
          .regc_wren(regc_wren),
          .regc_sel(regc_sel),
          .delta_new(delta_new),
          .delta_sub(delta_sub),
          .delta_shift(delta_shift),
          .delta_en(delta_en),
          .regcep_addr(regcep_addr),
          .regcep_wren(regcep_wren),
          .fefinish(fefinish),
          .framenum(framenum));
endmodule

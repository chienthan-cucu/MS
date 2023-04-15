// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    08:13:09 02/02/2022 
//  Module Name:    MFCC - Behavioral 
//  Project Name: MFCC
//  Target Devices: 
//  Tool versions: 
//  Description: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module MFCC (
   clk,
   rst_n,
   start,
   ready,
   fs_control,
   ram_data,
   ram_addr,
   speaker_out,
   fefinish);
 

input   clk; 
input   rst_n; 
input   start; 
input   ready; 
input   fs_control; 
input   [15:0] ram_data; 
output   [14:0] ram_addr; 
//output   [7:0] framenum; 
output   fefinish; 
output  [31:0] speaker_out;
wire    rst_mem;
wire    [14:0] ram_addr; 
wire    [31:0] MFCC_mean;
wire    [7:0] framenum; 
wire    fefinish; 
wire    preemp_en; 
wire    preemp_new; 
wire    [16:0] preemp_out; 
wire    win_en; 
wire    [6:0] cham_addr; 
wire    [3:0] cham_data; 
wire    [20:0] win_out; 
wire    fft_en; 
wire    reset_fft; 
wire    fft_valid; 
wire    [37:0] fft_outr1; 
wire    [37:0] fft_outi1; 
reg     [37:0] fft_outr; 
reg     [37:0] fft_outi; 
wire    regfft_wren; 
wire    [5:0] regfft_addr; 
wire    [37:0] regfft_outr; 
wire    [37:0] regfft_outi; 
wire    sroot_en; 
wire    [38:0] sroot_out; 
wire    [5:0] regffte_addr0; 
wire    [5:0] regffte_addr1; 
wire    [5:0] regffte_addr; 
wire    regffte_wren; 
wire    [38:0] regffte_out; 
wire    addmel_en; 
wire    addmel_sel; 
wire    addmel_new; 
wire    [43:0] addmel_out; 
wire    [4:0] regmel_addr; 
wire    regmel_wren; 
wire    [43:0] regmel_out; 
wire    square_en; 
wire    eadder_en; 
wire    eadder_sel; 
wire    eadder_new; 
wire    ereg_we; 
wire    [38:0] ereg_out; 
wire    [38:0] eadder_out; 
wire    [43:0] muxlog_out; 
wire    log_en; 
wire    [15:0] log_out; 
wire    log_overf; 
wire    log_sel; 
wire    [4:0] regdct_addr; 
wire    regdct_wren; 
wire    [15:0] regdct_out; 
wire    [8:0] cdct_addr; 
wire    [7:0] cdct_data; 
wire    muldct_en; 
wire    addsubdct_en; 
wire    addsubdct_new; 
wire    [15:0] addsubdct_out; 
wire    [15:0] muxregc_out; 
wire    [6:0] regc_addr; 
wire    regc_wren; 
wire    [1:0] regc_sel; 
wire    [15:0] regc_out; 
wire    delta_new; 
wire    delta_sub; 
wire    delta_shift; 
wire    delta_en; 
wire    [15:0] delta_out; 
wire    [12:0] regcep_addr;
wire    [12:0] regcep_addr2; 
wire    regcep_wren; 
wire [31:0] memory;
wire [31:0] speaker_out;

controller MFCC_controller (.clk(clk),
          .rst_n(rst_n),
          .rst_mem(rst_mem),
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
          .regffte_addr(regffte_addr0),
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
          .regcep_addr2(regcep_addr2),
          .regcep_wren(regcep_wren),
          .fefinish(fefinish),
          .framenum(framenum));
pre_emphasis MFCC_preem (.clk(clk),
          .rst_n(rst_n),
          .enable(preemp_en),
          .new_subframe(preemp_new),
          ._input_(ram_data),
          ._output_(preemp_out));
reghw MFCC_reghw (.clk(clk),
          .address(cham_addr),
          .data_out(cham_data));
windowing MFCC_windowing (.clk(clk),
          .rst_n(rst_n),
          .enable(win_en),
          .in1_from_pre(preemp_out),
          .in2_cham(cham_data),
          ._output_(win_out));
FFT_R2SDF MFCC_FFT (.iClk(clk),
          .iRst_n(rst_n),
          .iData_valid(fft_en),
          .iData(win_out),
          .oData_valid(fft_valid),
          .oData_Re(fft_outr1),
          .oData_Im(fft_outi1));

always @(posedge clk or negedge rst_n)
   begin : process_1
   if (rst_n === 1'b 0)
      begin
      fft_outr <= {38{1'b 0}};   
      fft_outi <= {38{1'b 0}};   
      end
   else if (clk === 1'b 1 )
      begin
      fft_outr <= fft_outr1;   
      fft_outi <= fft_outi1;   
      end
   end

regfftr MFCC_regfftr (	
//  Thanh ghi FFT luu thanh phan thuc
          .clk(clk),
          .regfft_wren(regfft_wren),
          .regfft_addr(regfft_addr),
          .data_in(fft_outr),
          .data_out(regfft_outr));
regffti MFCC_regffti (	
//  Thanh ghi FFT luu thanh phan ao
          .clk(clk),
          .regfft_wren(regfft_wren),
          .regfft_addr(regfft_addr),
          .data_in(fft_outi),
          .data_out(regfft_outi));
control_fft MFCC_control_fft (.clk(clk),
          .rst_n(reset_fft),
          .enable(fft_valid),
          .regfft_addr(regfft_addr),
          .regfft_wren(regfft_wren),
          .sroot_en(sroot_en));
sroot MFCC_sroot (.clk(clk),
          .rst_n(rst_n),
          .enable(sroot_en),
          .regfftoutr(regfft_outr),
          .regfftouti(regfft_outi),
          ._output_(sroot_out));
control_regffte MFCC_control_regffte (.clk(clk),
          .rst_n(reset_fft),
          .sroot_en(sroot_en),
          .addmel_en(addmel_en),
          .regffte_addr(regffte_addr1),
          .regffte_wren(regffte_wren));
mux_regffte MFCC_mux_regffte (.regffte_addr0(regffte_addr0),
          .regffte_addr1(regffte_addr1),
          .insel(sroot_en),
          .regffte_addr(regffte_addr));
regffte MFCC_regffte (.clk(clk),
          .regffte_wren(regffte_wren),
          .regffte_addr(regffte_addr),
          .sroot_out(sroot_out),
          .regffte_out(regffte_out));
addmel MFCC_addmel (.clk(clk),
          .rst_n(rst_n),
          .enable(addmel_en),
          .addmel_new(addmel_new),
          .addmel_sel(addmel_sel),
          .regffte_out(regffte_out),
          .regmel_out(regmel_out),
          .addmel_out(addmel_out));
regmel MFCC_regmel (.clk(clk),
          .regmel_wren(regmel_wren),
          .regmel_addr(regmel_addr),
          .addmel_out(addmel_out),
          .regmel_out(regmel_out));
energy MFCC_energy (.clk(clk),
          .rst_n(rst_n),
          .square_en(square_en),
          .eadder_en(eadder_en),
          .eadder_new(eadder_new),
          .eadder_sel(eadder_sel),
          .ram_in(ram_data),
          .ereg_out(ereg_out),
          .eadder_out(eadder_out));
ereg MFCC_ereg (.clk(clk),
          .rst_n(rst_n),
          .we(ereg_we),
          .D(eadder_out),
          .Q(ereg_out));
muxlog MFCC_muxlog (.addmel_out(addmel_out),
          .energy_out(eadder_out),
          .log_sel(log_sel),
          .muxlog_out(muxlog_out));
log MFCC_logarith (.clk(clk),
          .rst_n(rst_n),
          .enable(log_en),
          .log_sel(log_sel),
          ._input_(muxlog_out),
          ._output_(log_out),
          .overf(log_overf));
regdct MFCC_regdct (.clk(clk),
          .write_read(regdct_wren),
          .address(regdct_addr),
          .data_in(log_out),
          .data_out(regdct_out));
regcdct MFCC_regcdct (.clk(clk),
          .address(cdct_addr),
          .data_out(cdct_data));
cepstral MFCC_cepstral (.clk(clk),
          .rst_n(rst_n),
          .muldct_en(muldct_en),
          .regdct_out(regdct_out),
          .cdct_data(cdct_data),
          .addsubdct_en(addsubdct_en),
          .addsubdct_new(addsubdct_new),
          .addsubdct_out(addsubdct_out));
muxregc MFCC_muxregc (.regc_out(regc_out),
          .log_out(log_out),
          .addsubdct_out(addsubdct_out),
          .delta_out(delta_out),
          .regc_sel(regc_sel),
          .muxregc_out(muxregc_out));
regc MFCC_regc (.clk(clk),
          .write_read(regc_wren),
          .address(regc_addr),
          .data_in(muxregc_out),
          .data_out(regc_out));
delta MFCC_delta (.clk(clk),
          .rst_n(rst_n),
          .delta_en(delta_en),
          .delta_new(delta_new),
          .delta_sub(delta_sub),
          .delta_shift(delta_shift),
          .regc_out(regc_out),
          .delta_out(delta_out));
//regcep MFCC_regcep (.clk(clk),
//          .write_read(regcep_wren),
//          .address(regcep_addr),
//          .data_in(muxregc_out),
//          .data_out(MFCC_out));

buff MFCC_buff(.clk(clk),
          .rst_n(rst_mem),
          .write_read(regcep_wren),
          .address(regcep_addr2),
          .framenum(framenum),
          .data_in(muxregc_out),
          .data_out(speaker_out));

endmodule // module MFCC


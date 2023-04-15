// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    15:18:49 08/10/2022
//  Design Name: 
//  Module Name:    control_fft - Behavioral 
//  Project Name: MFCC_Improve
//  Tool versions: 
//  Description: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module control_fft (
   clk,
   rst_n,
   enable,
   regfft_addr,
   regfft_wren,
   sroot_en);
 

input   clk; 
input   rst_n; 
input   enable; 
output   [5:0] regfft_addr; 
output   regfft_wren; 
output   sroot_en; 

reg     [5:0] regfft_addr; 
reg     regfft_wren; 
reg     sroot_en; 
reg     [7:0] count; 
wire    [6:0] daobit; 
wire    daobit_int; 
wire    count_int; 
reg     enable_reg; 
reg     end_fft; 
reg     start_sroot; 
reg     [5:0]  address_for_regfft_addr_sig; 
reg      address_for_regfft_sroot_end; 


always @(posedge clk or negedge rst_n)
   begin : process_1
   if (rst_n === 1'b 0)
      begin
      count <= {8{1'b 0}};   
      start_sroot <= 1'b 0;   
      end
   else if (clk === 1'b 1 )
      begin
      if (enable === 1'b 1)
         begin
         if (count !== 8'b 11111111)
            begin
            count <= count + 2'b 01;   
            end
         else
            ;
         end
      else if (end_fft === 1'b 1 )
         begin
         start_sroot <= 1'b 1;   
         end
      end
   end


always @(posedge clk)
   begin : reg_enable
   if (clk === 1'b 1)
      begin
      enable_reg <= enable;   
      end
   end


always @(posedge clk or negedge rst_n)
   begin : process_2
   if (rst_n === 1'b 0)
      begin
      end_fft <= 1'b 0;   
      end
   else if (clk === 1'b 1 )
      begin
      if (enable_reg === 1'b 1 & enable === 1'b 0)
         begin
         end_fft <= 1'b 1;   
         end
      end
   end

assign daobit[0] = count[6]; 
assign daobit[1] = count[5]; 
assign daobit[2] = count[4]; 
assign daobit[3] = count[3]; 
assign daobit[4] = count[2]; 
assign daobit[5] = count[1]; 
assign daobit[6] = count[0]; 
assign count_int = ({1'b 0, count}); 
assign daobit_int = ({1'b 0, daobit}); 

//always @(clk or rst_n)
//   begin : address_for_regfft
      
//   end


always @(posedge clk or negedge rst_n)
   begin : address_for_regfft_1
   if (rst_n === 1'b 0)
      begin
      address_for_regfft_addr_sig = {6{1'b 0}};   
      regfft_wren <= 1'b 0;   
      sroot_en <= 1'b 0;   
      address_for_regfft_sroot_end = 1'b 0;   
      end
   else if (clk === 1'b 1 )
      begin
      if (enable === 1'b 1)
         begin
         if (count <= 127)
            begin
            if (daobit <= 63)
               begin
               regfft_wren <= 1'b 1;   
               address_for_regfft_addr_sig = daobit[5:0];   
               end
            else
               begin
               regfft_wren <= 1'b 0;   
               end
            end
         end
      else if (end_fft === 1'b 1 )
         begin
         if (start_sroot === 1'b 0)
            begin
            regfft_wren <= 1'b 0;   
            address_for_regfft_addr_sig = {6{1'b 0}};   
            end
         else
            begin
            if (address_for_regfft_addr_sig === 6'b 111111 & address_for_regfft_sroot_end === 1'b 0)
               begin
               address_for_regfft_sroot_end = 1'b 1;   
               end
            else if (address_for_regfft_addr_sig === 6'b 000000 & address_for_regfft_sroot_end === 1'b 1 )
               begin
               sroot_en <= 1'b 0;   
               end
            else
               begin
               address_for_regfft_addr_sig = address_for_regfft_addr_sig + 2'b 01;   
               sroot_en <= 1'b 1;   
               end
            end
         end
      end
      regfft_addr <= address_for_regfft_addr_sig;
   end


endmodule // module control_fft


// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    15:18:49 08/10/2022
//  Design Name: 
//  Module Name:    control_regffte - Behavioral 
//  Project Name: MFCC
//  Tool versions: 
//  Description: 
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module control_regffte (
   clk,
   rst_n,
   sroot_en,
   addmel_en,
   regffte_addr,
   regffte_wren);
 

input   clk; 
input   rst_n; 
input   sroot_en; 
input   addmel_en; 
output   [5:0] regffte_addr; 
output   regffte_wren; 

reg     [5:0] regffte_addr; 
reg     regffte_wren; 
reg     start_sroot; 
reg     [5:0]  process_2_address_sig; 
reg      process_2_end_sroot; 


always @(posedge clk or negedge rst_n)
   begin : process_1
   if (rst_n === 1'b 0)
      begin
      start_sroot <= 1'b 0;   
      end
   else if (clk === 1'b 1 )
      begin
      if (sroot_en === 1'b 1)
         begin
         if (start_sroot === 1'b 0)
            begin
            start_sroot <= 1'b 1;   
            end
         else
            begin
            start_sroot <= start_sroot;   
            end
         end
      end
   end


always @(clk or rst_n)
   begin : process_2
   regffte_addr <= process_2_address_sig;   
   end


always @(posedge clk or negedge rst_n)
   begin : process_2_1
   if (rst_n === 1'b 0)
      begin
      process_2_address_sig = {6{1'b 0}};   
      process_2_end_sroot = 1'b 0;   
      regffte_wren <= 1'b 0;   
      end
   else if (clk === 1'b 1 )
      begin
      if (sroot_en === 1'b 1 & start_sroot === 1'b 0)
         begin
         regffte_wren <= 1'b 1;   
         end
      else if (start_sroot === 1'b 1 )
         begin
         if (process_2_address_sig === 6'b 111111)
            begin
            regffte_wren <= 1'b 0;   
            end
         else
            ;
         if (process_2_end_sroot === 1'b 0)
            begin
            if (process_2_address_sig === 6'b 111111)
               begin
               regffte_wren <= 1'b 0;   
               process_2_end_sroot = 1'b 1;   
               end
            else
               begin
               regffte_wren <= 1'b 1;   
               process_2_address_sig = process_2_address_sig + 2'b 01;   
               end
            end
         else
            ;
         end
      end
   end


endmodule // module control_regffte


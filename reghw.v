// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    14:27:17 02/25/2016 
//  Design Name: 
//  Module Name:    reghw - Behavioral 
//  Project Name: MFCC
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module reghw (
   clk,
   address,
   data_out);
 

input   clk; 
input   [6:0] address; 
output   [3:0] data_out; 

reg     [3:0] data_out; 
reg     [5:0] addr; 
reg     [3:0] data; 


always @(addr)
   begin : romhw
   case (addr)
   6'b 000000:
      begin
      data <= 4'b 0001;   
      end
   6'b 000001:
      begin
      data <= 4'b 0001;   
      end
   6'b 000010:
      begin
      data <= 4'b 0001;   
      end
   6'b 000011:
      begin
      data <= 4'b 0001;   
      end
   6'b 000100:
      begin
      data <= 4'b 0001;   
      end
   6'b 000101:
      begin
      data <= 4'b 0001;   
      end
   6'b 000110:
      begin
      data <= 4'b 0010;   
      end
   6'b 000111:
      begin
      data <= 4'b 0010;   
      end
   6'b 001000:
      begin
      data <= 4'b 0010;   
      end
   6'b 001001:
      begin
      data <= 4'b 0011;   
      end
   6'b 001010:
      begin
      data <= 4'b 0011;   
      end
   6'b 001011:
      begin
      data <= 4'b 0011;   
      end
   6'b 001100:
      begin
      data <= 4'b 0100;   
      end
   6'b 001101:
      begin
      data <= 4'b 0100;   
      end
   6'b 001110:
      begin
      data <= 4'b 0101;   
      end
   6'b 001111:
      begin
      data <= 4'b 0101;   
      end
   6'b 010000:
      begin
      data <= 4'b 0110;   
      end
   6'b 010001:
      begin
      data <= 4'b 0111;   
      end
   6'b 010010:
      begin
      data <= 4'b 0111;   
      end
   6'b 010011:
      begin
      data <= 4'b 1000;   
      end
   6'b 010100:
      begin
      data <= 4'b 1000;   
      end
   6'b 010101:
      begin
      data <= 4'b 1001;   
      end
   6'b 010110:
      begin
      data <= 4'b 1001;   
      end
   6'b 010111:
      begin
      data <= 4'b 1010;   
      end
   6'b 011000:
      begin
      data <= 4'b 1011;   
      end
   6'b 011001:
      begin
      data <= 4'b 1011;   
      end
   6'b 011010:
      begin
      data <= 4'b 1100;   
      end
   6'b 011011:
      begin
      data <= 4'b 1100;   
      end
   6'b 011100:
      begin
      data <= 4'b 1101;   
      end
   6'b 011101:
      begin
      data <= 4'b 1101;   
      end
   6'b 011110:
      begin
      data <= 4'b 1110;   
      end
   6'b 011111:
      begin
      data <= 4'b 1110;   
      end
   6'b 100000:
      begin
      data <= 4'b 1110;   
      end
   6'b 100001:
      begin
      data <= 4'b 1111;   
      end
   6'b 100010:
      begin
      data <= 4'b 1111;   
      end
   6'b 100011:
      begin
      data <= 4'b 1111;   
      end
   6'b 100100:
      begin
      data <= 4'b 1111;   
      end
   6'b 100101:
      begin
      data <= 4'b 1111;   
      end
   6'b 100110:
      begin
      data <= 4'b 1111;   
      end
   6'b 100111:
      begin
      data <= 4'b 1111;   
      end
   default:
      begin
      data <= 4'b 0000;   
      end
   endcase
   end


always @(address)
   begin : mod_address
   if (address[6] === 1'b 1 | address >= 7'b 0101000)
      begin
      addr <= ~address[5:0] + 6'b 010000;   
      end
   else
      begin
      addr <= address[5:0];   
      end
   end


always @(posedge clk)
   begin : get_data
   if (clk === 1'b 1)
      begin
      data_out <= data;   
      end
   end


endmodule // module reghw


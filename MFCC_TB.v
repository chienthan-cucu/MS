

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules



module MFCC_TB ;
 

// Inputs
reg     clk; 
reg     rst_n; 
reg     start; 
reg     ready; 
reg     fs_control; 

wire     [15:0] ram_data1;
// Outputs
wire    [14:0] ram_addr; 

wire    [31:0] speaker_out; 
wire    fefinish; 
integer output_file;
parameter SF = 2.0**-8.0;
//  Instantiate the Unit Under Test (UUT)
always 
   begin : clk_process
   clk <= 1'b 0;   
   #1; 
   clk <= 1'b 1;   
   #1; 
   end

initial 
   begin : process_1 
   ready = 1'b 0;  
   fs_control = 1'b 1;
   start =1;
   rst_n = 1'b 0;   
   end
   
always 
begin : process
   #100
   ready = 1'b 1;  
   fs_control = 1'b 1;
   start = 0; 
   rst_n = 1'b 1;  
   
end
   

MFCC uut (.clk(clk),
          .rst_n(rst_n),
          .start(start),
          .ready(ready),
          .fs_control(fs_control),
          .ram_data(ram_data1),
          .ram_addr(ram_addr),
          .speaker_out(speaker_out),
          .fefinish(fefinish));
          
mem_test uut2 (.clk(clk), 
              .ram_addr(ram_addr), 
              .ram_data(ram_data1));



initial begin
  output_file = $fopen ("output_file.txt","a");
end

always@(uut.speaker_out)
begin
        $fdisplay(output_file,uut.speaker_out);
end
endmodule // module MFCC_TB


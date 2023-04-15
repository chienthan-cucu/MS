// ------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
// 
//  Create Date:   22:55:47 03/02/2022
//  Design Name:   
//  Module Name:   D:/Hoc tap/Career/Speed_recognition/MFCC/sub_Testbench.vhd
//  Project Name:  MFCC
//  Target Device:  
//  Tool versions:  
//  Description:   

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module sub_Testbench ;
 



// Inputs
reg     [33:0] sub_in1; 
reg     [32:0] sub_in2; 
reg     clock; 

// Outputs
wire    [33:0] sub_out; 

//  No clocks detected in port list. Replace <clock> below with 
//  appropriate port name 
parameter clock_period = 10; 

//  Instantiate the Unit Under Test (UUT)

initial 
   begin : process_2
   sub_in2 = {33{1'b 0}};   
   end

initial 
   begin : process_1
   sub_in1 = {34{1'b 0}};   
   end

preem_sub1 uut (.sub_in1(sub_in1),
          .sub_in2(sub_in2),
          .sub_out(sub_out));

always 
   begin : clock_process
   clock <= 1'b 0;   
   #( clock_period / 2 ); 
   clock <= 1'b 1;   
   #( clock_period / 2 ); 
   end

//  Stimulus process

//  Clock process definitions
initial 
   begin : stim_proc
   #( 100 ); 
   #( clock_period * 10 ); 
   #( 50 ); 
   sub_in1 <= 34'b 0000000000000000000010001100101100;   
   sub_in2 <= 33'b 111111111111111111111100110101101; 
  
//  insert stimulus here 
   #( 50 ); 
   sub_in1 <= 34'b 1111111111111111111011010001101100;   
   sub_in2 <= 33'b 111111111111111111110100001011101;   


   end


//  hold reset state for 100 ns.

//  Component Declaration for the Unit Under Test (UUT)

endmodule // module sub_Testbench


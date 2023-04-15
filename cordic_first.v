// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    15:18:49 08/10/2022
//  Design Name: 
//  Module Name:    cordic_first - Behavioral 
//  Project Name: FFT_R2SDF
//  Description: in first stage_FFT, image = 0
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module cordic_first (
   iReal,
   iPhi,
   oReal,
   oImage);
 

input   [21:0] iReal; 
input   [5:0] iPhi; 
output   [31:0] oReal; 
output   [31:0] oImage; 

wire    [31:0] oReal; 
wire    [31:0] oImage; 
parameter [7:0] alpha0 = 8'b 00110010; 
parameter [7:0] alpha1 = 8'b 00011110; 
parameter [7:0] alpha2 = 8'b 00010000; 
parameter [7:0] alpha3 = 8'b 00001000; 
parameter [7:0] alpha4 = 8'b 00000100; 
parameter [7:0] alpha5 = 8'b 00000010; 
parameter [7:0] alpha6 = 8'b 00000001; 
wire    [33:0] x1; 
wire    [33:0] x2; 
wire    [33:0] x3; 
wire    [33:0] x4; 
wire    [33:0] x5; 
wire    [33:0] x6; 
wire    [33:0] x7; 
wire    [33:0] x; 
//  Image  || Thuc, ao hoan doi cho nhau vi goc 
wire    [33:0] y0; 
wire    [33:0] y1; 
wire    [33:0] y2; 
wire    [33:0] y3; 
wire    [33:0] y4; 
wire    [33:0] y5; 
wire    [33:0] y6; 
wire    [33:0] y7; 
wire    [33:0] y; 
//  Real	  || iPhi am, nen chieu quay nguoc lai
wire    [7:0] z0; 
wire    [7:0] z1; 
wire    [7:0] z2; 
wire    [7:0] z3; 
wire    [7:0] z4; 
wire    [7:0] z5; 
wire    [7:0] z6; 
wire    [5:0] Phi; 

assign Phi = (iPhi[5] & (iPhi[4] | iPhi[3] | iPhi[2] | 
      iPhi[1] | iPhi[0])) === 1'b 1 ? {1'b 0, iPhi[4:0]} : 
	iPhi; 

//  (iPhi(5)and(iPhi(4)or iPhi(3)or iPhi(2)or iPhi(1)or iPhi(0))) = '1' => iPhi > 32
assign y0 = {iReal[21], iReal[21], iReal, 10'b 0000000000}; 
assign z0 = {Phi, 2'b 00} - {2'b 00, Phi} + 
      {5'b 00000, Phi[5:3]}; 
// Phi*pi

// -- Cordic stage 0
assign x1 = ~y0 + 2'b 01; 
//  x1 = x0 - y0, (x0 = 0);
assign y1 = y0; 
//  y1 = y0 + x0, (x0 = 0);
assign z1 = z0 - alpha0; 
//  z0 >0 --> z1 <= z0 - alpha0

// -- Cordic stage 1
assign x2 = z1[7] === 1'b 0 ? x1 - {y1[33], y1[33:1]} : 
	x1 + {y1[33], y1[33:1]}; 
assign y2 = z1[7] === 1'b 0 ? y1 + {x1[33], x1[33:1]} : 
	y1 - {x1[33], x1[33:1]} + 2'b 01; 
assign z2 = z1[7] === 1'b 0 ? z1 - alpha1 : 
	z1 + alpha1; 

// -- Cordic stage 2
assign x3 = z2[7] === 1'b 0 ? x2 - {y2[33], y2[33], 
      y2[33:2]} : 
	x2 + {y2[33], y2[33], y2[33:2]}; 
assign y3 = z2[7] === 1'b 0 ? y2 + {x2[33], x2[33], 
      x2[33:2]} : 
	y2 - {x2[33], x2[33], x2[33:2]} + 
      2'b 01; 
assign z3 = z2[7] === 1'b 0 ? z2 - alpha2 : 
	z2 + alpha2; 

// -- Cordic stage 3
assign x4 = z3[7] === 1'b 0 ? x3 - {y3[33], y3[33], 
      y3[33], y3[33:3]} : 
	x3 + {y3[33], y3[33], y3[33], 
      y3[33:3]}; 
assign y4 = z3[7] === 1'b 0 ? y3 + {x3[33], x3[33], 
      x3[33], x3[33:3]} : 
	y3 - {x3[33], x3[33], x3[33], 
      x3[33:3]} + 2'b 01; 
assign z4 = z3[7] === 1'b 0 ? z3 - alpha3 : 
	z3 + alpha3; 

// -- Cordic stage 4
assign x5 = z4[7] === 1'b 0 ? x4 - {y4[33], y4[33], 
      y4[33], y4[33], y4[33:4]} : 
	x4 + {y4[33], y4[33], y4[33], 
      y4[33], y4[33:4]}; 
assign y5 = z4[7] === 1'b 0 ? y4 + {x4[33], x4[33], 
      x4[33], x4[33], x4[33:4]} : 
	y4 - {x4[33], x4[33], x4[33], 
      x4[33], x4[33:4]} + 2'b 01; 
assign z5 = z4[7] === 1'b 0 ? z4 - alpha4 : 
	z4 + alpha4; 

// -- Cordic stage 5
assign x6 = z5[7] === 1'b 0 ? x5 - {y5[33], y5[33], 
      y5[33], y5[33], y5[33], y5[33:5]} : 
	x5 + {y5[33], y5[33], y5[33], 
      y5[33], y5[33], y5[33:5]}; 
assign y6 = z5[7] === 1'b 0 ? y5 + {x5[33], x5[33], 
      x5[33], x5[33], x5[33], x5[33:5]} : 
	y5 - {x5[33], x5[33], x5[33], 
      x5[33], x5[33], x5[33:5]} + 2'b 01; 
assign z6 = z5[7] === 1'b 0 ? z5 - alpha5 : 
	z5 + alpha5; 

// -- Cordic stage 6
assign x7 = z6[7] === 1'b 0 ? x6 - {y6[33], y6[33], 
      y6[33], y6[33], y6[33], y6[33], 
      y6[33:6]} : 
	x6 + {y6[33], y6[33], y6[33], 
      y6[33], y6[33], y6[33], y6[33:6]}; 
assign y7 = z6[7] === 1'b 0 ? y6 + {x6[33], x6[33], 
      x6[33], x6[33], x6[33], x6[33], 
      x6[33:6]} : 
	y6 - {x6[33], x6[33], x6[33], 
      x6[33], x6[33], x6[33], x6[33:6]} + 
      2'b 01; 

//  Divide  K by x10,y10: Cononical Signed Digit algorithm
assign x = {x7[33], x7[33:1]} + {x7[33], x7[33], 
      x7[33], x7[33:3]} - {x7[33], x7[33], 
      x7[33], x7[33], x7[33], x7[33], 
      x7[33:6]} - {x7[33], x7[33], x7[33], 
      x7[33], x7[33], x7[33], x7[33], 
      x7[33], x7[33], x7[33:9]} - {x7[33], 
      x7[33], x7[33], x7[33], x7[33], 
      x7[33], x7[33], x7[33], x7[33], 
      x7[33], x7[33], x7[33], x7[33:12]} + 
      {x7[33], x7[33], x7[33], x7[33], 
      x7[33], x7[33], x7[33], x7[33], 
      x7[33], x7[33], x7[33], x7[33], 
      x7[33], x7[33], x7[33:14]} - {x7[33], 
      x7[33], x7[33], x7[33], x7[33], 
      x7[33], x7[33], x7[33], x7[33], 
      x7[33], x7[33], x7[33], x7[33], 
      x7[33], x7[33], x7[33], x7[33:16]}; 
assign y = {y7[33], y7[33:1]} + {y7[33], y7[33], 
      y7[33], y7[33:3]} - {y7[33], y7[33], 
      y7[33], y7[33], y7[33], y7[33], 
      y7[33:6]} - {y7[33], y7[33], y7[33], 
      y7[33], y7[33], y7[33], y7[33], 
      y7[33], y7[33], y7[33:9]} - {y7[33], 
      y7[33], y7[33], y7[33], y7[33], 
      y7[33], y7[33], y7[33], y7[33], 
      y7[33], y7[33], y7[33], y7[33:12]} + 
      {y7[33], y7[33], y7[33], y7[33], 
      y7[33], y7[33], y7[33], y7[33], 
      y7[33], y7[33], y7[33], y7[33], 
      y7[33], y7[33], y7[33:14]} - {y7[33], 
      y7[33], y7[33], y7[33], y7[33], 
      y7[33], y7[33], y7[33], y7[33], 
      y7[33], y7[33], y7[33], y7[33], 
      y7[33], y7[33], y7[33], y7[33:16]}; 
assign oReal = (iPhi[5] & (iPhi[4] | iPhi[3] | iPhi[2] | 
      iPhi[1] | iPhi[0])) === 1'b 0 ? y[31:0] : 
	x[31:0]; 
assign oImage = (iPhi[5] & (iPhi[4] | iPhi[3] | iPhi[2] | 
      iPhi[1] | iPhi[0])) === 1'b 0 ? x[31:0] : 
	~y[31:0] + 2'b 01; 

endmodule // module cordic_first


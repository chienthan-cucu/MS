// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien
//  Create Date:    13:15:46 02/27/2022 
//  Design Name: 
//  Module Name:    regcdct - Behavioral 
//  Project Name: MFCC
// --------------------------------------------------------------------------------

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module regcdct (
   clk,
   address,
   data_out);
 

input   clk; 
input   [8:0] address; 
output   [7:0] data_out; 

reg     [7:0] data_out; 
reg     [7:0] data; 


always @(clk or address)
   begin : behavior
   case (address)
   0:
      begin
      data <= 8'b 01111111;   
      end
   1:
      begin
      data <= 8'b 01111100;   
      end
   2:
      begin
      data <= 8'b 01111000;   
      end
   3:
      begin
      data <= 8'b 01110000;   
      end
   4:
      begin
      data <= 8'b 01101000;   
      end
   5:
      begin
      data <= 8'b 01011101;   
      end
   6:
      begin
      data <= 8'b 01010000;   
      end
   7:
      begin
      data <= 8'b 01000010;   
      end
   8:
      begin
      data <= 8'b 00110010;   
      end
   9:
      begin
      data <= 8'b 00100010;   
      end
   10:
      begin
      data <= 8'b 00010000;   
      end
   11:
      begin
      data <= {8{1'b 0}};   
      end
   12:
      begin
      data <= 8'b 11110000;   
      end
   13:
      begin
      data <= 8'b 11011110;   
      end
   14:
      begin
      data <= 8'b 11001110;   
      end
   15:
      begin
      data <= 8'b 10111110;   
      end
   16:
      begin
      data <= 8'b 10110000;   
      end
   17:
      begin
      data <= 8'b 10100011;   
      end
   18:
      begin
      data <= 8'b 10011000;   
      end
   19:
      begin
      data <= 8'b 10001111;   
      end
   20:
      begin
      data <= 8'b 10001000;   
      end
   21:
      begin
      data <= 8'b 10000100;   
      end
   22:
      begin
      data <= 8'b 10000001;   
// ---
      end
   23:
      begin
      data <= 8'b 01111110;   
      end
   24:
      begin
      data <= 8'b 01110100;   
      end
   25:
      begin
      data <= 8'b 01100010;   
      end
   26:
      begin
      data <= 8'b 01001001;   
      end
   27:
      begin
      data <= 8'b 00101011;   
      end
   28:
      begin
      data <= 8'b 00001000;   
      end
   29:
      begin
      data <= 8'b 11100111;   
      end
   30:
      begin
      data <= 8'b 11000110;   
      end
   31:
      begin
      data <= 8'b 10101010;   
      end
   32:
      begin
      data <= 8'b 10010100;   
      end
   33:
      begin
      data <= 8'b 10000110;   
      end
   34:
      begin
      data <= 8'b 10000001;   
      end
   35:
      begin
      data <= 8'b 10000110;   
      end
   36:
      begin
      data <= 8'b 10010100;   
      end
   37:
      begin
      data <= 8'b 10101010;   
      end
   38:
      begin
      data <= 8'b 11000110;   
      end
   39:
      begin
      data <= 8'b 11100111;   
      end
   40:
      begin
      data <= 8'b 11111000;   
      end
   41:
      begin
      data <= 8'b 00101010;   
      end
   42:
      begin
      data <= 8'b 01001001;   
      end
   43:
      begin
      data <= 8'b 01100010;   
      end
   44:
      begin
      data <= 8'b 01110100;   
      end
   45:
      begin
      data <= 8'b 01111110;   
// --
      end
   46:
      begin
      data <= 8'b 01111100;   
      end
   47:
      begin
      data <= 8'b 01101000;   
      end
   48:
      begin
      data <= 8'b 01000010;   
      end
   49:
      begin
      data <= 8'b 00010000;   
      end
   50:
      begin
      data <= 8'b 11011110;   
      end
   51:
      begin
      data <= 8'b 10110000;   
      end
   52:
      begin
      data <= 8'b 10010000;   
      end
   53:
      begin
      data <= 8'b 10000001;   
      end
   54:
      begin
      data <= 8'b 10001000;   
      end
   55:
      begin
      data <= 8'b 10100011;   
      end
   56:
      begin
      data <= 8'b 11001110;   
      end
   57:
      begin
      data <= {8{1'b 0}};   
      end
   58:
      begin
      data <= 8'b 00110010;   
      end
   59:
      begin
      data <= 8'b 01011101;   
      end
   60:
      begin
      data <= 8'b 01111000;   
      end
   61:
      begin
      data <= 8'b 01111111;   
      end
   62:
      begin
      data <= 8'b 01110001;   
      end
   63:
      begin
      data <= 8'b 01010000;   
      end
   64:
      begin
      data <= 8'b 00100010;   
      end
   65:
      begin
      data <= 8'b 11110000;   
      end
   66:
      begin
      data <= 8'b 10111110;   
      end
   67:
      begin
      data <= 8'b 10011000;   
      end
   68:
      begin
      data <= 8'b 10000100;   
// --
      end
   69:
      begin
      data <= 8'b 01111010;   
      end
   70:
      begin
      data <= 8'b 01010110;   
      end
   71:
      begin
      data <= 8'b 00011001;   
      end
   72:
      begin
      data <= 8'b 11010110;   
      end
   73:
      begin
      data <= 8'b 10011110;   
      end
   74:
      begin
      data <= 8'b 10000010;   
      end
   75:
      begin
      data <= 8'b 10001100;   
      end
   76:
      begin
      data <= 8'b 10110111;   
      end
   77:
      begin
      data <= 8'b 11111000;   
      end
   78:
      begin
      data <= 8'b 00111100;   
      end
   79:
      begin
      data <= 8'b 01101100;   
      end
   80:
      begin
      data <= 8'b 01111111;   
      end
   81:
      begin
      data <= 8'b 00111100;   
      end
   82:
      begin
      data <= 8'b 00111010;   
      end
   83:
      begin
      data <= 8'b 11111000;   
      end
   84:
      begin
      data <= 8'b 10110111;   
      end
   85:
      begin
      data <= 8'b 10001100;   
      end
   86:
      begin
      data <= 8'b 10000010;   
      end
   87:
      begin
      data <= 8'b 10011110;   
      end
   88:
      begin
      data <= 8'b 11010110;   
      end
   89:
      begin
      data <= 8'b 00011001;   
      end
   90:
      begin
      data <= 8'b 01010110;   
      end
   91:
      begin
      data <= 8'b 01111010;   
// --
      end
   92:
      begin
      data <= 8'b 01111000;   
      end
   93:
      begin
      data <= 8'b 01000001;   
      end
   94:
      begin
      data <= 8'b 11110000;   
      end
   95:
      begin
      data <= 8'b 10100011;   
      end
   96:
      begin
      data <= 8'b 10000001;   
      end
   97:
      begin
      data <= 8'b 10011000;   
      end
   98:
      begin
      data <= 8'b 11011110;   
      end
   99:
      begin
      data <= 8'b 00110010;   
      end
   100:
      begin
      data <= 8'b 01110000;   
      end
   101:
      begin
      data <= 8'b 01111100;   
      end
   102:
      begin
      data <= 8'b 01010000;   
      end
   103:
      begin
      data <= {8{1'b 0}};   
      end
   104:
      begin
      data <= 8'b 10110000;   
      end
   105:
      begin
      data <= 8'b 10000100;   
      end
   106:
      begin
      data <= 8'b 10001111;   
      end
   107:
      begin
      data <= 8'b 11001110;   
      end
   108:
      begin
      data <= 8'b 00100010;   
      end
   109:
      begin
      data <= 8'b 01101000;   
      end
   110:
      begin
      data <= 8'b 01111111;   
      end
   111:
      begin
      data <= 8'b 01011101;   
      end
   112:
      begin
      data <= 8'b 00010000;   
      end
   113:
      begin
      data <= 8'b 10111110;   
      end
   114:
      begin
      data <= 8'b 10001000;   
// --
      end
   115:
      begin
      data <= 8'b 01110100;   
      end
   116:
      begin
      data <= 8'b 00101010;   
      end
   117:
      begin
      data <= 8'b 11000110;   
      end
   118:
      begin
      data <= 8'b 10000110;   
      end
   119:
      begin
      data <= 8'b 10010100;   
      end
   120:
      begin
      data <= 8'b 11100111;   
      end
   121:
      begin
      data <= 8'b 01001001;   
      end
   122:
      begin
      data <= 8'b 01111110;   
      end
   123:
      begin
      data <= 8'b 01100010;   
      end
   124:
      begin
      data <= 8'b 00001000;   
      end
   125:
      begin
      data <= 8'b 10101010;   
      end
   126:
      begin
      data <= 8'b 10000001;   
      end
   127:
      begin
      data <= 8'b 10101010;   
      end
   128:
      begin
      data <= 8'b 00001000;   
      end
   129:
      begin
      data <= 8'b 01100010;   
      end
   130:
      begin
      data <= 8'b 01111110;   
      end
   131:
      begin
      data <= 8'b 01001001;   
      end
   132:
      begin
      data <= 8'b 11100111;   
      end
   133:
      begin
      data <= 8'b 10010100;   
      end
   134:
      begin
      data <= 8'b 10000110;   
      end
   135:
      begin
      data <= 8'b 11000110;   
      end
   136:
      begin
      data <= 8'b 00101010;   
      end
   137:
      begin
      data <= 8'b 01110100;   
// --
      end
   138:
      begin
      data <= 8'b 01110000;   
      end
   139:
      begin
      data <= 8'b 00010000;   
      end
   140:
      begin
      data <= 8'b 10100100;   
      end
   141:
      begin
      data <= 8'b 10000100;   
      end
   142:
      begin
      data <= 8'b 11001110;   
      end
   143:
      begin
      data <= 8'b 01000001;   
      end
   144:
      begin
      data <= 8'b 01111111;   
      end
   145:
      begin
      data <= 8'b 01010000;   
      end
   146:
      begin
      data <= 8'b 11011110;   
      end
   147:
      begin
      data <= 8'b 10001000;   
      end
   148:
      begin
      data <= 8'b 10011000;   
      end
   149:
      begin
      data <= {8{1'b 0}};   
      end
   150:
      begin
      data <= 8'b 01101000;   
      end
   151:
      begin
      data <= 8'b 01111000;   
      end
   152:
      begin
      data <= 8'b 00100010;   
      end
   153:
      begin
      data <= 8'b 10110000;   
      end
   154:
      begin
      data <= 8'b 10000001;   
      end
   155:
      begin
      data <= 8'b 10111110;   
      end
   156:
      begin
      data <= 8'b 00110010;   
      end
   157:
      begin
      data <= 8'b 01111100;   
      end
   158:
      begin
      data <= 8'b 01011101;   
      end
   159:
      begin
      data <= 8'b 11110000;   
      end
   160:
      begin
      data <= 8'b 10001111;   
// --
      end
   161:
      begin
      data <= 8'b 01101100;   
      end
   162:
      begin
      data <= 8'b 11111000;   
      end
   163:
      begin
      data <= 8'b 10001100;   
      end
   164:
      begin
      data <= 8'b 10011110;   
      end
   165:
      begin
      data <= 8'b 00011001;   
      end
   166:
      begin
      data <= 8'b 01111010;   
      end
   167:
      begin
      data <= 8'b 01010110;   
      end
   168:
      begin
      data <= 8'b 11010110;   
      end
   169:
      begin
      data <= 8'b 10000010;   
      end
   170:
      begin
      data <= 8'b 10110111;   
      end
   171:
      begin
      data <= 8'b 00111010;   
      end
   172:
      begin
      data <= 8'b 01111111;   
      end
   173:
      begin
      data <= 8'b 00111010;   
      end
   174:
      begin
      data <= 8'b 10110111;   
      end
   175:
      begin
      data <= 8'b 10000010;   
      end
   176:
      begin
      data <= 8'b 11010110;   
      end
   177:
      begin
      data <= 8'b 01010110;   
      end
   178:
      begin
      data <= 8'b 01111010;   
      end
   179:
      begin
      data <= 8'b 00011001;   
      end
   180:
      begin
      data <= 8'b 10011110;   
      end
   181:
      begin
      data <= 8'b 10001100;   
      end
   182:
      begin
      data <= 8'b 11111000;   
      end
   183:
      begin
      data <= 8'b 01101100;   
// --
      end
   184:
      begin
      data <= 8'b 01101000;   
      end
   185:
      begin
      data <= 8'b 11011110;   
      end
   186:
      begin
      data <= 8'b 01111111;   
      end
   187:
      begin
      data <= 8'b 11001110;   
      end
   188:
      begin
      data <= 8'b 01011100;   
      end
   189:
      begin
      data <= 8'b 01110000;   
      end
   190:
      begin
      data <= 8'b 11110000;   
      end
   191:
      begin
      data <= 8'b 10000100;   
      end
   192:
      begin
      data <= 8'b 10111110;   
      end
   193:
      begin
      data <= 8'b 01010000;   
      end
   194:
      begin
      data <= 8'b 01111000;   
      end
   195:
      begin
      data <= {8{1'b 0}};   
      end
   196:
      begin
      data <= 8'b 10001000;   
      end
   197:
      begin
      data <= 8'b 10110000;   
      end
   198:
      begin
      data <= 8'b 01000010;   
      end
   199:
      begin
      data <= 8'b 01111100;   
      end
   200:
      begin
      data <= 8'b 00010000;   
      end
   201:
      begin
      data <= 8'b 10001111;   
      end
   202:
      begin
      data <= 8'b 11101001;   
      end
   203:
      begin
      data <= 8'b 00110010;   
      end
   204:
      begin
      data <= 8'b 01111111;   
      end
   205:
      begin
      data <= 8'b 00100010;   
      end
   206:
      begin
      data <= 8'b 10011000;   
// --
      end
   207:
      begin
      data <= 8'b 01100010;   
      end
   208:
      begin
      data <= 8'b 11000110;   
      end
   209:
      begin
      data <= 8'b 10000110;   
      end
   210:
      begin
      data <= 8'b 00001000;   
      end
   211:
      begin
      data <= 8'b 01111110;   
      end
   212:
      begin
      data <= 8'b 00101010;   
      end
   213:
      begin
      data <= 8'b 10010100;   
      end
   214:
      begin
      data <= 8'b 10101010;   
      end
   215:
      begin
      data <= 8'b 01001001;   
      end
   216:
      begin
      data <= 8'b 01110100;   
      end
   217:
      begin
      data <= 8'b 11100111;   
      end
   218:
      begin
      data <= 8'b 10000001;   
      end
   219:
      begin
      data <= 8'b 11100111;   
      end
   220:
      begin
      data <= 8'b 01110100;   
      end
   221:
      begin
      data <= 8'b 10110111;   
      end
   222:
      begin
      data <= 8'b 10101010;   
      end
   223:
      begin
      data <= 8'b 10010100;   
      end
   224:
      begin
      data <= 8'b 00101010;   
      end
   225:
      begin
      data <= 8'b 01111110;   
      end
   226:
      begin
      data <= 8'b 00001000;   
      end
   227:
      begin
      data <= 8'b 10000110;   
      end
   228:
      begin
      data <= 8'b 11000110;   
      end
   229:
      begin
      data <= 8'b 01100010;   
// --
      end
   230:
      begin
      data <= 8'b 01011100;   
      end
   231:
      begin
      data <= 8'b 10110000;   
      end
   232:
      begin
      data <= 8'b 10011000;   
      end
   233:
      begin
      data <= 8'b 01000010;   
      end
   234:
      begin
      data <= 8'b 01110000;   
      end
   235:
      begin
      data <= 8'b 11001110;   
      end
   236:
      begin
      data <= 8'b 10001000;   
      end
   237:
      begin
      data <= 8'b 00100010;   
      end
   238:
      begin
      data <= 8'b 01111100;   
      end
   239:
      begin
      data <= 8'b 11110000;   
      end
   240:
      begin
      data <= 8'b 10000001;   
      end
   241:
      begin
      data <= {8{1'b 0}};   
      end
   242:
      begin
      data <= 8'b 01111111;   
      end
   243:
      begin
      data <= 8'b 00010000;   
      end
   244:
      begin
      data <= 8'b 10000100;   
      end
   245:
      begin
      data <= 8'b 11011110;   
      end
   246:
      begin
      data <= 8'b 01111000;   
      end
   247:
      begin
      data <= 8'b 00110010;   
      end
   248:
      begin
      data <= 8'b 10001111;   
      end
   249:
      begin
      data <= 8'b 10111110;   
      end
   250:
      begin
      data <= 8'b 01101000;   
      end
   251:
      begin
      data <= 8'b 01010000;   
      end
   252:
      begin
      data <= 8'b 10100011;   
// --
      end
   253:
      begin
      data <= 8'b 01010110;   
      end
   254:
      begin
      data <= 8'b 10011110;   
      end
   255:
      begin
      data <= 8'b 10110111;   
      end
   256:
      begin
      data <= 8'b 01101100;   
      end
   257:
      begin
      data <= 8'b 00111010;   
      end
   258:
      begin
      data <= 8'b 10001100;   
      end
   259:
      begin
      data <= 8'b 11010110;   
      end
   260:
      begin
      data <= 8'b 01111010;   
      end
   261:
      begin
      data <= 8'b 00011001;   
      end
   262:
      begin
      data <= 8'b 10000010;   
      end
   263:
      begin
      data <= 8'b 11111000;   
      end
   264:
      begin
      data <= 8'b 01111111;   
      end
   265:
      begin
      data <= 8'b 11111000;   
      end
   266:
      begin
      data <= 8'b 10000010;   
      end
   267:
      begin
      data <= 8'b 00011001;   
      end
   268:
      begin
      data <= 8'b 01111010;   
      end
   269:
      begin
      data <= 8'b 11010110;   
      end
   270:
      begin
      data <= 8'b 10001100;   
      end
   271:
      begin
      data <= 8'b 00111010;   
      end
   272:
      begin
      data <= 8'b 01101100;   
      end
   273:
      begin
      data <= 8'b 10110111;   
      end
   274:
      begin
      data <= 8'b 10011110;   
      end
   275:
      begin
      data <= 8'b 01010110;   
      end
   default:
      begin
      data <= 8'b 00000000;   
      end
   endcase
   end


always @(posedge clk)
   begin : get_data
   if (clk === 1'b 1)
      begin
      data_out <= data;   
      end
   end


// signal addr: 

endmodule // module regcdct


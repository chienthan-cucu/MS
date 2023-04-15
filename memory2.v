// --------------------------------------------------------------------------------
//  Company:  MSI
//  Engineer: Phan Van Chien
//  Create Date:    15:15:39 01/06/2022
//  Design Name: 
//  Module Name:    memory_module - Behavioral 
// -------------------------------------------------------------------------------

`define MaxTestSamples 30

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules



module memory2 (
   clk,
   reset,
   read_write,
   address,
   framenum,
   data_in,
   data_out);
 
parameter data_length = 40;
parameter addr_length = 8;

reg [23:0] in;
reg in_valid;
reg [7:0] fileName[23:0];
reg s_axi_awvalid;
reg [31:0] s_axi_awaddr;
wire s_axi_awready;
reg [31:0] s_axi_wdata;
reg s_axi_wvalid;
wire s_axi_wready;
wire s_axi_bvalid;
reg s_axi_bready;
wire intr;
reg [31:0] axiRdData;
reg [31:0] s_axi_araddr;
wire [31:0] s_axi_rdata;
reg s_axi_arvalid;
wire s_axi_arready;
wire s_axi_rvalid;
reg s_axi_rready;

wire [31:0] numNeurons[31:1];
wire [31:0] numWeights[31:1];

input   clk; 
input   reset;
input   read_write; 
input   [addr_length - 1:0] address;
input   [7:0] framenum; 
input   [15:0] data_in;
output   [31:0] data_out;
integer i;
reg     [data_length - 1:0] memory[51:0];  
wire     [data_length - 1:0] memory2[25:0];  
wire     [data_length - 1:0] memory3[25:0];  
wire     [data_length - 1:0] memory4[25:0];  
wire     [23:0] in_mem[25:0];  

reg     [data_length - 1:0] tmp;  

wire     [data_length - 1:0] y;
reg [data_length-1:0] mean[25:0];  // quotient
reg [data_length-1:0] scalar[25:0];  // quotient
wire   [31:0] data_out;

assign data_out=axiRdData;

initial
begin
    $readmemh("mean.txt",mean);
    $readmemh("scale.txt",scalar);
    s_axi_awvalid = 1'b0;
    s_axi_bready = 1'b0;
    s_axi_wvalid = 1'b0;
    s_axi_arvalid = 1'b0;
    for (i=0;i<52;i=i+1)
    memory[i]=0;

end

always @(posedge clk)
   begin : process_1
      if (read_write === 1'b 1)
         begin
         if (framenum>=6) 
         begin
            if (data_in[15]==1) memory[address-26] = {8'hff,data_in,16'h00}; 
            else memory[address-26] = {8'h00,data_in,16'h00};
            if (address==51)
            for (i=26;i<52;i=i+1)
                  memory[i]=memory[i]+memory[i-26];
            i=0;
         end
         end
       
   end

genvar j;
generate for (j=26;j<52;j=j+1)
begin 
assign y={16'h0000,framenum-8,16'h0000};
div MFCC_div(
        .clk(clk),
        .x(memory[j]),
        .y(y),
        .MFCC_mean(memory2[j-26]));
assign memory3[j-26]=memory2[j-26]-mean[j-26];
//assign memory3[j-26] =mean[j-26][39]===1'b1 ? (memory2[j-26] - {~mean[j-26]+1'b1}):( memory2[j-26]+mean[j-26]); 

div MFCC_div2(
        .clk(clk),
        .x(memory3[j-26]),
        .y(scalar[j-26]),
        .MFCC_mean(memory4[j-26]));

assign in_mem[j-26]=memory4[j-26];  

end


endgenerate
    
assign numNeurons[1] = 30;
    assign numNeurons[2] = 30;
    assign numNeurons[3] = 10;
    assign numNeurons[4] = 10;
    
    assign numWeights[1] = 784;
    assign numWeights[2] = 30;
    assign numWeights[3] = 30;
    assign numWeights[4] = 10;
    
    integer right=0;
    integer wrong=0;
    
    zyNet dut(
    .s_axi_aclk(clk),
    .s_axi_aresetn(reset),
    .s_axi_awaddr(s_axi_awaddr),
    .s_axi_awprot(0),
    .s_axi_awvalid(s_axi_awvalid),
    .s_axi_awready(s_axi_awready),
    .s_axi_wdata(s_axi_wdata),
    .s_axi_wstrb(4'hF),
    .s_axi_wvalid(s_axi_wvalid),
    .s_axi_wready(s_axi_wready),
    .s_axi_bresp(),
    .s_axi_bvalid(s_axi_bvalid),
    .s_axi_bready(s_axi_bready),
    .s_axi_araddr(s_axi_araddr),
    .s_axi_arprot(0),
    .s_axi_arvalid(s_axi_arvalid),
    .s_axi_arready(s_axi_arready),
    .s_axi_rdata(s_axi_rdata),
    .s_axi_rresp(),
    .s_axi_rvalid(s_axi_rvalid),
    .s_axi_rready(s_axi_rready),
    .axis_in_data(in),
    .axis_in_data_valid(in_valid),
    .axis_in_data_ready(),
    .intr(intr)
    );
    
            
    
    function [7:0] to_ascii;
      input integer a;
      begin
        to_ascii = a+48;
      end
    endfunction
    
    always @(posedge clk)
    begin
        s_axi_bready <= s_axi_bvalid;
        s_axi_rready <= s_axi_rvalid;
    end
    
    task writeAxi(
    input [31:0] address,
    input [31:0] data
    );
    begin
        @(posedge clk);
        s_axi_awvalid <= 1'b1;
        s_axi_awaddr <= address;
        s_axi_wdata <= data;
        s_axi_wvalid <= 1'b1;
        wait(s_axi_wready);
        @(posedge clk);
        s_axi_awvalid <= 1'b0;
        s_axi_wvalid <= 1'b0;
        @(posedge clk);
    end
    endtask
    
    task readAxi(
    input [31:0] address
    );
    begin
        @(posedge clk);
        s_axi_arvalid <= 1'b1;
        s_axi_araddr <= address;
        wait(s_axi_arready);
        @(posedge clk);
        s_axi_arvalid <= 1'b0;
        wait(s_axi_rvalid);
        @(posedge clk);
        axiRdData <= s_axi_rdata;
        @(posedge clk);
    end
    endtask
    
    task configWeights();
    integer i,j,k,t;
    integer neuronNo_int;
    reg [`dataWidth:0] config_mem [783:0];
    begin
        @(posedge clk);
        for(k=1;k<=`numLayers;k=k+1)
        begin
            writeAxi(12,k);//Write layer number
            for(j=0;j<numNeurons[k];j=j+1)
            begin
                neuronNo_int = j;
                fileName[0] = "f";
                fileName[1] = "i";
                fileName[2] = "m";
                fileName[3] = ".";
                if(j > 9)
                begin
                    fileName[4] = 48;
                    fileName[5] = 48;
                    i=0;
                    while(neuronNo_int != 0)
                    begin
                        fileName[i+4] = to_ascii(neuronNo_int%10);
                        neuronNo_int = neuronNo_int/10;
                        i=i+1;
                    end 
                    fileName[6] = "_";
                    fileName[7] = to_ascii(k);
                    fileName[8] = "_";
                    fileName[9] = "w";
                end
                else
                begin
                    fileName[4] = 48;
                    i=0;
                    while(neuronNo_int != 0)
                    begin
                        fileName[i+4] = to_ascii(neuronNo_int%10);
                        neuronNo_int = neuronNo_int/10;
                        i=i+1;
                    end 
                    fileName[5] = "_";
                    fileName[6] = to_ascii(k);
                    fileName[7] = "_";
                    fileName[8] = "w";
                end
                $readmemb(fileName, config_mem);
                writeAxi(16,j);//Write neuron number
                for (t=0; t<numWeights[k]; t=t+1) begin
                    writeAxi(0,{15'd0,config_mem[t]});
                end 
            end
        end
    end
    endtask
    
    task configBias();
    integer i,j,k,t;
    integer neuronNo_int;
    reg [31:0] bias[0:0];
    begin
        @(posedge clk);
        for(k=1;k<=`numLayers;k=k+1)
        begin
            writeAxi(12,k);//Write layer number
            for(j=0;j<numNeurons[k];j=j+1)
            begin
                neuronNo_int = j;
                fileName[0] = "f";
                fileName[1] = "i";
                fileName[2] = "m";
                fileName[3] = ".";
                if(j>9)
                begin
                    fileName[4] = 48;
                    fileName[5] = 48;
                    i=0;
                    while(neuronNo_int != 0)
                    begin
                        fileName[i+4] = to_ascii(neuronNo_int%10);
                        neuronNo_int = neuronNo_int/10;
                        i=i+1;
                    end 
                    fileName[6] = "_";
                    fileName[7] = to_ascii(k);
                    fileName[8] = "_";
                    fileName[9] = "b";
                end
                else
                begin
                    fileName[4] = 48;
                    i=0;
                    while(neuronNo_int != 0)
                    begin
                        fileName[i+4] = to_ascii(neuronNo_int%10);
                        neuronNo_int = neuronNo_int/10;
                        i=i+1;
                    end 
                    fileName[5] = "_";
                    fileName[6] = to_ascii(k);
                    fileName[7] = "_";
                    fileName[8] = "b";               
                end
                $readmemh(fileName, bias);
                writeAxi(16,j);//Write neuron number
                writeAxi(4,{15'd0,bias[0]});
            end
        end
    end
    endtask
    
    
    task sendData();
    integer t;
    begin
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        for (t=0; t <26; t=t+1) begin
            @(posedge clk);
            in <= in_mem[t];
            in_valid <= 1;
        end 
        @(posedge clk);
        in_valid <= 0;
    end
    endtask
   
    integer layerNo=1;
    integer start;
    initial
    begin
        in_valid = 0;
        writeAxi(28,0);//clear soft reset
        start = $time;
        `ifndef pretrained
            configWeights();
            configBias();
        `endif
        start = $time;
        sendData();
        @(posedge intr);
        readAxi(8);
        $stop;
    end
    

endmodule

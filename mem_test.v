module mem_test (clk, ram_addr, ram_data);
input clk;
input [14:0] ram_addr;// Note
output [15:0] ram_data;
reg    [15:0] ram_data;

integer input_file;
reg [15:0] mem[16383:0];
 

initial
begin
  $readmemh("input_file.txt",mem);
end

always@(posedge clk) begin
    ram_data <= mem[ram_addr]; 
end
endmodule


// --------------------------------------------------------------------------------
//  Company: MSI
//  Engineer: Phan Van Chien 
//  Create Date:    14:25:00 02/20/2022
//  Design Name: 
//  remule Name:    controller - Behavioral 
//  Project Name: 
//  Description: Tao ra cac tin hieu dieu khien cho cac khoi khac lam viec
// --------------------------------------------------------------------------------
`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module controller (
   clk,
   rst_n,
   rst_mem,
   start,
   ready,
   fs_control,
   log_overf,
   ram_addr,
   square_en,
   eadder_en,
   eadder_sel,
   eadder_new,
   ereg_we,
   log_en,
   log_sel,
   preemp_en,
   preemp_new,
   cham_addr,
   win_en,
   fft_en,
   reset_fft,
   regffte_addr,
   addmel_en,
   addmel_sel,
   addmel_new,
   regmel_addr,
   regmel_wren,
   regdct_addr,
   regdct_wren,
   cdct_addr,
   muldct_en,
   addsubdct_en,
   addsubdct_new,
   regc_addr,
   regc_wren,
   regc_sel,
   delta_new,
   delta_sub,
   delta_shift,
   delta_en,
   regcep_addr,
   regcep_addr2,
   regcep_wren,
   fefinish,
   framenum);
 

input   clk; 
input   rst_n; 
input   start; 
input   ready; 
input   fs_control; 
input   log_overf; 
output   [14:0] ram_addr; 
output   square_en; 
output   eadder_en; 
output   eadder_sel; 
output   eadder_new; 
output   ereg_we; 
output   log_en; 
output   log_sel; 
output   preemp_en; 
output   preemp_new; 
output   [6:0] cham_addr; 
output   win_en; 
output   fft_en; 
output   reset_fft; 
output   [5:0] regffte_addr; 
output   addmel_en; 
output   addmel_sel; 
output   addmel_new; 
output   [4:0] regmel_addr; 
output   regmel_wren; 
output   [4:0] regdct_addr; 
output   regdct_wren; 
output   [8:0] cdct_addr; 
output   muldct_en; 
output   addsubdct_en; 
output   addsubdct_new; 
output   [6:0] regc_addr; 
output   regc_wren; 
output   [1:0] regc_sel; 
output   delta_new; 
output   delta_sub; 
output   delta_shift; 
output   delta_en; 
output   [12:0] regcep_addr;
output   [12:0] regcep_addr2; 
output   regcep_wren; 
output   fefinish; 
output   [7:0] framenum; 
output   rst_mem;
reg     [14:0] ram_addr; 
reg     square_en; 
reg     eadder_en; 
reg     eadder_sel; 
reg     eadder_new; 
reg     ereg_we; 
reg     log_en; 
reg     log_sel; 
reg     preemp_en; 
reg     preemp_new; 
reg     [6:0] cham_addr; 
reg     win_en; 
reg     fft_en; 
reg     reset_fft; 
reg     [5:0] regffte_addr; 
reg     addmel_en; 
reg     addmel_sel; 
reg     addmel_new; 
reg     [4:0] regmel_addr; 
reg     regmel_wren; 
reg     [4:0] regdct_addr; 
reg     regdct_wren; 
reg     [8:0] cdct_addr; 
reg     muldct_en; 
reg     addsubdct_en; 
reg     addsubdct_new; 
reg     [6:0] regc_addr; 
reg     regc_wren; 
reg     [1:0] regc_sel; 
reg     delta_new; 
reg     delta_sub; 
reg     delta_shift; 
reg     delta_en; 
reg     [12:0] regcep_addr; 
reg     [12:0] regcep_addr2; 

reg     regcep_wren; 
reg     fefinish; 
reg     [7:0] framenum; 

// TYPE state_type:
parameter state_type_s0 = 0;
parameter state_type_s1 = 1;

reg     state; 
// s0: trang thai ban dau, khong lam viec; s1: trang thai lam viec
reg     start_reg; 
reg     [11:0] dem_clk; 
reg     the_end; 
reg     [8:0]  output_logic_subframe_num; 
reg     [14:0]  output_logic_ram_addr_sig; 
reg     [12:0]  output_logic_regcep_addr_sig;
reg     [12:0]  output_logic_regcep_addr_sig9; 
reg     [6:0]  output_logic_cham_addr_sig; 
reg     [5:0]  output_logic_regffte_addr_sig; 
reg     [6:0]  output_logic_regc_addr_cepstral; 
reg     [6:0]  output_logic_regc_addr_sig; 
reg     [6:0]  output_logic_regc_addr_sig1; 
reg     [6:0]  output_logic_regc_addr_sig2; 
reg     [6:0]  output_logic_regc_addr_sig3; 
reg     [6:0]  output_logic_regc_addr_sig4; 
reg     [4:0]  output_logic_regmel_addr_sig; 
reg     [4:0]  output_logic_regdct_addr_sig; 
reg     [8:0]  output_logic_cdct_addr_sig; 
reg     [10:0]  output_logic_dem; 
reg [15:0] i;
reg rst_mem;

initial 
   begin : process_3
   output_logic_dem = 0;
   rst_mem=0;   
   end

initial 
   begin : process_2
   output_logic_subframe_num = 0;   
   end

initial 
   begin : process_1
   dem_clk = 0;   
   end


always @(posedge clk)
   begin : reg_start
   if (clk === 1'b 1)
      begin
      start_reg <= start;   
      end
   end


always @(rst_n or  clk)
   begin : next_state
   if (rst_n === 1'b 0)
      begin
      state <= state_type_s0;   
      end
   else if (clk === 1'b 1 )
      begin
      case (state)
      state_type_s0:
         begin
         if (start_reg === 1'b 1 & start === 1'b 0 & 
      ready === 1'b 1 & fs_control === 1'b 1)
            begin
            state <= state_type_s1;   
            end
         else
            begin
            state <= state_type_s0;   
            end
         end
      state_type_s1:
         begin
         if (ready === 1'b 1 & fs_control === 1'b 1 & 
      the_end === 1'b 0)
            begin
            state <= state_type_s1;   
            end
         else
            begin
            state <= state_type_s0;   
            end
         end
      endcase
      end
   end

always @(posedge clk or negedge fefinish)
begin
    if (fefinish==1) 
    begin
        i<=16'b0;
    end
    else   if (i===1000) 
    begin
        i<=16'b0;
        rst_mem=1;
    end
    else i<=i+2'b01; 
end

always @(negedge state or posedge clk)
   begin : counter_clk
   if (state === state_type_s0)
      begin
      dem_clk <= 0;   
      end
   else if (clk === 1'b 1 )
      begin
      dem_clk <= dem_clk + 1;   
      if (dem_clk === 1166)
         begin
         dem_clk <= 0;   
         end
      end
   end


always @(state or clk)
   begin : output_logic
   ram_addr <= output_logic_ram_addr_sig;  
   
   cham_addr <= output_logic_cham_addr_sig;   
   regffte_addr <= output_logic_regffte_addr_sig;   
   regcep_addr <= output_logic_regcep_addr_sig;   
   regcep_addr2 <= output_logic_regcep_addr_sig9;   
   regc_addr <= output_logic_regc_addr_sig;   
   regmel_addr <= output_logic_regmel_addr_sig;   
   regdct_addr <= output_logic_regdct_addr_sig;   
   cdct_addr <= output_logic_cdct_addr_sig;   
   case (state)
   state_type_s0:
      begin
      ram_addr <= {15{1'b 0}};   
      square_en <= 1'b 0;   
      eadder_en <= 1'b 0;   
      eadder_sel <= 1'b 0;   
      eadder_new <= 1'b 0;   
      ereg_we <= 1'b 0;   
      log_en <= 1'b 0;   
      log_sel <= 1'b 0;   
      preemp_en <= 1'b 0;   
      preemp_new <= 1'b 0;   
      cham_addr <= {7{1'b 0}};   
      win_en <= 1'b 0;   
      fft_en <= 1'b 0;   
      reset_fft <= 1'b 0;   
      regffte_addr <= {6{1'b 0}};   
      addmel_en <= 1'b 0;   
      addmel_sel <= 1'b 0;   
      addmel_new <= 1'b 0;   
      regmel_addr <= {5{1'b 0}};   
      regmel_wren <= 1'b 0;   
      regdct_addr <= {5{1'b 0}};   
      regdct_wren <= 1'b 0;   
      cdct_addr <= {9{1'b 0}};   
      muldct_en <= 1'b 0;   
      addsubdct_en <= 1'b 0;   
      addsubdct_new <= 1'b 0;   
      output_logic_regc_addr_sig = {7{1'b 0}};   
      regc_wren <= 1'b 0;   
      regc_sel <= {2{1'b 0}};   
      delta_new <= 1'b 0;   
      delta_sub <= 1'b 0;   
      delta_shift <= 1'b 0;   
      delta_en <= 1'b 0;   
      regcep_addr <= {13{1'b 0}}; 
      regcep_addr2 <= {13{1'b 0}};   
      regcep_wren <= 1'b 0;   
      fefinish <= 1'b 0;   
//      framenum <= {8{1'b 0}};   
      output_logic_ram_addr_sig = {15{1'b 0}}; 
//      $display("%b",0);   
      
      output_logic_cham_addr_sig = {7{1'b 0}};   
      output_logic_regc_addr_cepstral = {7{1'b 0}};   
      output_logic_regc_addr_sig1 = {7{1'b 0}};   
      output_logic_regc_addr_sig2 = {7{1'b 0}};   
      output_logic_regc_addr_sig3 = {7{1'b 0}};   
      output_logic_regc_addr_sig4 = {7{1'b 0}};   
      output_logic_regdct_addr_sig = {5{1'b 0}};   
      output_logic_cdct_addr_sig = {9{1'b 0}};   
      output_logic_regcep_addr_sig = {13{1'b 0}};   
      output_logic_regcep_addr_sig9 = {13'b 11010};   
      the_end <= 1'b 0;   
      end
   state_type_s1:
      begin
      if (clk===1'b1)
         begin
         if (dem_clk === 1166 & the_end === 1'b 0)
            begin
            output_logic_subframe_num = output_logic_subframe_num + 1;
            framenum=output_logic_subframe_num; 

            end
         if (dem_clk === 0)
            begin
            if (log_overf === 1'b 1)
               begin
               fefinish <= 1'b 1;   
               the_end <= 1'b 1;   
               framenum <= (output_logic_subframe_num);
               output_logic_regcep_addr_sig9<=0;   
               end
            if (output_logic_subframe_num === 0)
               begin
               output_logic_regcep_addr_sig = {13{1'b 1}};   
               output_logic_regcep_addr_sig9 = {13'b 11011};   
      
               output_logic_ram_addr_sig = {15{1'b 0}};   
               end
            end

// ---------------------------------------------- log_overf = '0' -----------------------------------------------------
         if (log_overf === 1'b 0)
            begin

//  Chay dia chi ram
            if (dem_clk === 2 | dem_clk === 5 | 
      dem_clk === 8 | dem_clk === 11 | 
      dem_clk === 14 | dem_clk === 17 | 
      dem_clk === 20 | dem_clk === 23 | 
      dem_clk === 26 | dem_clk === 29 | 
      dem_clk === 32 | dem_clk === 35 | 
      dem_clk === 38 | dem_clk === 41 | 
      dem_clk === 44 | dem_clk === 47 | 
      dem_clk === 50 | dem_clk === 53 | 
      dem_clk === 56 | dem_clk === 59 | 
      dem_clk === 62 | dem_clk === 65 | 
      dem_clk === 68 | dem_clk === 71 | 
      dem_clk === 74 | dem_clk === 77 | 
      dem_clk === 80 | dem_clk === 83 | 
      dem_clk === 86 | dem_clk === 89 | 
      dem_clk === 92 | dem_clk === 95 | 
      dem_clk === 98 | dem_clk === 101 | 
      dem_clk === 104 | dem_clk === 107 | 
      dem_clk === 110 | dem_clk === 113 | 
      dem_clk === 116 | dem_clk === 119 | 
      dem_clk === 122 | dem_clk === 125 | 
      dem_clk === 128 | dem_clk === 131 | 
      dem_clk === 134 | dem_clk === 137 | 
      dem_clk === 140 | dem_clk === 143 | 
      dem_clk === 146 | dem_clk === 149 | 
      dem_clk === 152 | dem_clk === 155 | 
      dem_clk === 158 | dem_clk === 161 | 
      dem_clk === 164 | dem_clk === 167 | 
      dem_clk === 170 | dem_clk === 173 | 
      dem_clk === 176 | dem_clk === 179 | 
      dem_clk === 182 | dem_clk === 185 | 
      dem_clk === 188 | dem_clk === 191 | 
      dem_clk === 194 | dem_clk === 197 | 
      dem_clk === 200 | dem_clk === 203 | 
      dem_clk === 206 | dem_clk === 209 | 
      dem_clk === 212 | dem_clk === 215 | 
      dem_clk === 218 | dem_clk === 221 | 
      dem_clk === 224 | dem_clk === 227 | 
      dem_clk === 230 | dem_clk === 233 | 
      dem_clk === 236 | dem_clk === 239)
               begin

// (dem_clk rem(3) = 2) and (dem_clk <= 238)
               output_logic_ram_addr_sig = output_logic_ram_addr_sig + 2'b 01;   
               end

//  control pre-emphasis --
            if (dem_clk <= 238)
               begin
               if (dem_clk === 2 | dem_clk === 5 | 
      dem_clk === 8 | dem_clk === 11 | 
      dem_clk === 14 | dem_clk === 17 | 
      dem_clk === 20 | dem_clk === 23 | 
      dem_clk === 26 | dem_clk === 29 | 
      dem_clk === 32 | dem_clk === 35 | 
      dem_clk === 38 | dem_clk === 41 | 
      dem_clk === 44 | dem_clk === 47 | 
      dem_clk === 50 | dem_clk === 53 | 
      dem_clk === 56 | dem_clk === 59 | 
      dem_clk === 62 | dem_clk === 65 | 
      dem_clk === 68 | dem_clk === 71 | 
      dem_clk === 74 | dem_clk === 77 | 
      dem_clk === 80 | dem_clk === 83 | 
      dem_clk === 86 | dem_clk === 89 | 
      dem_clk === 92 | dem_clk === 95 | 
      dem_clk === 98 | dem_clk === 101 | 
      dem_clk === 104 | dem_clk === 107 | 
      dem_clk === 110 | dem_clk === 113 | 
      dem_clk === 116 | dem_clk === 119 | 
      dem_clk === 122 | dem_clk === 125 | 
      dem_clk === 128 | dem_clk === 131 | 
      dem_clk === 134 | dem_clk === 137 | 
      dem_clk === 140 | dem_clk === 143 | 
      dem_clk === 146 | dem_clk === 149 | 
      dem_clk === 152 | dem_clk === 155 | 
      dem_clk === 158 | dem_clk === 161 | 
      dem_clk === 164 | dem_clk === 167 | 
      dem_clk === 170 | dem_clk === 173 | 
      dem_clk === 176 | dem_clk === 179 | 
      dem_clk === 182 | dem_clk === 185 | 
      dem_clk === 188 | dem_clk === 191 | 
      dem_clk === 194 | dem_clk === 197 | 
      dem_clk === 200 | dem_clk === 203 | 
      dem_clk === 206 | dem_clk === 209 | 
      dem_clk === 212 | dem_clk === 215 | 
      dem_clk === 218 | dem_clk === 221 | 
      dem_clk === 224 | dem_clk === 227 | 
      dem_clk === 230 | dem_clk === 233 | 
      dem_clk === 236)
                  begin
                  preemp_en <= 1'b 0;  
                  end
               else
                  begin
                  preemp_en <= 1'b 1;   
                  //$display("%b",oData_64);
// dem_clk rem(3) = 0 or dem_clk rem(3) = 1
                  end
               end
            else
               begin
               preemp_en <= 1'b 0;   
               end
            if (dem_clk === 0)
               begin
               preemp_new <= 1'b 1;   
               end
            else
               begin
               preemp_new <= 1'b 0;   
               end

//  control windowing --
            if (dem_clk >= 2 & dem_clk <= 240)
               begin
               if (dem_clk === 4 | dem_clk === 7 | 
      dem_clk === 10 | dem_clk === 13 | 
      dem_clk === 16 | dem_clk === 19 | 
      dem_clk === 22 | dem_clk === 25 | 
      dem_clk === 28 | dem_clk === 31 | 
      dem_clk === 34 | dem_clk === 37 | 
      dem_clk === 40 | dem_clk === 43 | 
      dem_clk === 46 | dem_clk === 49 | 
      dem_clk === 52 | dem_clk === 55 | 
      dem_clk === 58 | dem_clk === 61 | 
      dem_clk === 64 | dem_clk === 67 | 
      dem_clk === 70 | dem_clk === 73 | 
      dem_clk === 76 | dem_clk === 79 | 
      dem_clk === 82 | dem_clk === 85 | 
      dem_clk === 88 | dem_clk === 91 | 
      dem_clk === 94 | dem_clk === 97 | 
      dem_clk === 100 | dem_clk === 103 | 
      dem_clk === 106 | dem_clk === 109 | 
      dem_clk === 112 | dem_clk === 115 | 
      dem_clk === 118 | dem_clk === 121 | 
      dem_clk === 124 | dem_clk === 127 | 
      dem_clk === 130 | dem_clk === 133 | 
      dem_clk === 136 | dem_clk === 139 | 
      dem_clk === 142 | dem_clk === 145 | 
      dem_clk === 148 | dem_clk === 151 | 
      dem_clk === 154 | dem_clk === 157 | 
      dem_clk === 160 | dem_clk === 163 | 
      dem_clk === 166 | dem_clk === 169 | 
      dem_clk === 172 | dem_clk === 175 | 
      dem_clk === 178 | dem_clk === 181 | 
      dem_clk === 184 | dem_clk === 187 | 
      dem_clk === 190 | dem_clk === 193 | 
      dem_clk === 196 | dem_clk === 199 | 
      dem_clk === 202 | dem_clk === 205 | 
      dem_clk === 208 | dem_clk === 211 | 
      dem_clk === 214 | dem_clk === 217 | 
      dem_clk === 220 | dem_clk === 223 | 
      dem_clk === 226 | dem_clk === 229 | 
      dem_clk === 232 | dem_clk === 235 | 
      dem_clk === 238)
                  begin

//  dem_clk rem(3) = 1
                  win_en <= 1'b 0;   
                  output_logic_cham_addr_sig = output_logic_cham_addr_sig + 2'b 01;   
                  end
               else
                  begin
                  win_en <= 1'b 1;   
                  end
               end
            else
               begin
               output_logic_cham_addr_sig = {7{1'b 0}};   
               win_en <= 1'b 0;   
               end

//  tinh energy --
            if (dem_clk <= 239)
               begin
               if (dem_clk === 2 | dem_clk === 5 | 
      dem_clk === 8 | dem_clk === 11 | 
      dem_clk === 14 | dem_clk === 17 | 
      dem_clk === 20 | dem_clk === 23 | 
      dem_clk === 26 | dem_clk === 29 | 
      dem_clk === 32 | dem_clk === 35 | 
      dem_clk === 38 | dem_clk === 41 | 
      dem_clk === 44 | dem_clk === 47 | 
      dem_clk === 50 | dem_clk === 53 | 
      dem_clk === 56 | dem_clk === 59 | 
      dem_clk === 62 | dem_clk === 65 | 
      dem_clk === 68 | dem_clk === 71 | 
      dem_clk === 74 | dem_clk === 77 | 
      dem_clk === 80 | dem_clk === 83 | 
      dem_clk === 86 | dem_clk === 89 | 
      dem_clk === 92 | dem_clk === 95 | 
      dem_clk === 98 | dem_clk === 101 | 
      dem_clk === 104 | dem_clk === 107 | 
      dem_clk === 110 | dem_clk === 113 | 
      dem_clk === 116 | dem_clk === 119 | 
      dem_clk === 122 | dem_clk === 125 | 
      dem_clk === 128 | dem_clk === 131 | 
      dem_clk === 134 | dem_clk === 137 | 
      dem_clk === 140 | dem_clk === 143 | 
      dem_clk === 146 | dem_clk === 149 | 
      dem_clk === 152 | dem_clk === 155 | 
      dem_clk === 158 | dem_clk === 161 | 
      dem_clk === 164 | dem_clk === 167 | 
      dem_clk === 170 | dem_clk === 173 | 
      dem_clk === 176 | dem_clk === 179 | 
      dem_clk === 182 | dem_clk === 185 | 
      dem_clk === 188 | dem_clk === 191 | 
      dem_clk === 194 | dem_clk === 197 | 
      dem_clk === 200 | dem_clk === 203 | 
      dem_clk === 206 | dem_clk === 209 | 
      dem_clk === 212 | dem_clk === 215 | 
      dem_clk === 218 | dem_clk === 221 | 
      dem_clk === 224 | dem_clk === 227 | 
      dem_clk === 230 | dem_clk === 233 | 
      dem_clk === 236 | dem_clk === 239)
                  begin

// dem_clk rem(3) = 2
                  square_en <= 1'b 0;   
                  eadder_en <= 1'b 1;   
                  end
               else
                  begin
                  square_en <= 1'b 1;   
// (dem_clk rem(3) = 0) or (dem_clk rem(3) = 1)
                  eadder_en <= 1'b 0;   
                  end
               end
            if (dem_clk === 0)
               begin
               eadder_new <= 1'b 1;   
               end
            else
               begin
               eadder_new <= 1'b 0;   
               end
            if (dem_clk === 240)
               begin
               ereg_we <= 1'b 1;   
               if (output_logic_subframe_num >= 1)
                  begin

//  Tai vi tri nay ket thuc tinh nang luong cua 1 subframe 
                  eadder_sel <= 1'b 1;   
//  va luu gia tri vua tinh xong vao ereg, dong thoi tinh nang luong cua 
                  eadder_en <= 1'b 1;   
//  frame thong thuong (tinh tong gia tri trong thanh ghi hien tai 
                  end
               else
                  begin
                  eadder_sel <= 1'b 0;   
//  va gia tri trong thanh ghi ereg hien tai)
                  eadder_en <= 1'b 0;   
                  end
               end
            else
               begin
               eadder_sel <= 1'b 0;   
               ereg_we <= 1'b 0;   
               end
            if (dem_clk === 241)
               begin
               eadder_en <= 1'b 0;   
               end

//  log_energy --> regc, regcep
            if (dem_clk === 246)
               begin

//  Tinh log cho gia tri nang luong, roi luu vao regc
               if (output_logic_subframe_num >= 1)
                  begin
                  regc_sel <= 2'b 01;   
                  regc_wren <= 1'b 1;   
                  regcep_wren <= 1'b 1;   
                  output_logic_regcep_addr_sig = output_logic_regcep_addr_sig + 2'b 01;   
                  output_logic_regcep_addr_sig9 = output_logic_regcep_addr_sig9 + 2'b 01;  
                  if (output_logic_subframe_num === 1)
                     begin
                     output_logic_regc_addr_sig = {7{1'b 0}};   
                     end
                  else if (output_logic_subframe_num === 2 )
                     begin
                     output_logic_regc_addr_sig = 7'b 0000001;   
                     end
                  else if (output_logic_subframe_num === 3 )
                     begin
                     output_logic_regc_addr_sig = 7'b 0000010;   
                     end
                  else if (output_logic_subframe_num === 4 )
                     begin
                     output_logic_regc_addr_sig = 7'b 0000011;   
                     end
                  else
                     begin
                     output_logic_regc_addr_sig = 7'b 0000100;   
                     end
                  end
               end
            else if (dem_clk === 247 )
               begin
               regc_wren <= 1'b 0;   
               regcep_wren <= 1'b 0;   
               end

//  Tinh toan logarithm cua he so nang luong
            if (output_logic_subframe_num >= 1)
               begin
               if (dem_clk === 244 | dem_clk === 245)
                  begin

//  Tinh logarith cua he so nang luong
                  log_sel <= 1'b 1;   
                  log_en <= 1'b 1;   
                  end
               else if (dem_clk === 246 )
                  begin
                  log_en <= 1'b 0;   
                  log_sel <= 1'b 0;   
                  end
               end
            end
// ---------------------------------------------- ket thuc log_overf = '0' -----------------------------------------------				
//  Tinh fft		
         if (log_overf === 1'b 1)
            begin
            fft_en <= 1'b 0;   
            end
         else if (dem_clk === 0 )
            begin
            reset_fft <= 1'b 0;   
            end
         else if (dem_clk === 1 )
            begin
            reset_fft <= 1'b 1;   
            end
         else if (dem_clk >= 3 & dem_clk <= 297 )
            begin
            if (dem_clk >= 3 & dem_clk <= 241)
               begin
               if (dem_clk === 3 | dem_clk === 6 | 
      dem_clk === 9 | dem_clk === 12 | 
      dem_clk === 15 | dem_clk === 18 | 
      dem_clk === 21 | dem_clk === 24 | 
      dem_clk === 27 | dem_clk === 30 | 
      dem_clk === 33 | dem_clk === 36 | 
      dem_clk === 39 | dem_clk === 42 | 
      dem_clk === 45 | dem_clk === 48 | 
      dem_clk === 51 | dem_clk === 54 | 
      dem_clk === 57 | dem_clk === 60 | 
      dem_clk === 63 | dem_clk === 66 | 
      dem_clk === 69 | dem_clk === 72 | 
      dem_clk === 75 | dem_clk === 78 | 
      dem_clk === 81 | dem_clk === 84 | 
      dem_clk === 87 | dem_clk === 90 | 
      dem_clk === 93 | dem_clk === 96 | 
      dem_clk === 99 | dem_clk === 102 | 
      dem_clk === 105 | dem_clk === 108 | 
      dem_clk === 111 | dem_clk === 114 | 
      dem_clk === 117 | dem_clk === 120 | 
      dem_clk === 123 | dem_clk === 126 | 
      dem_clk === 129 | dem_clk === 132 | 
      dem_clk === 135 | dem_clk === 138 | 
      dem_clk === 141 | dem_clk === 144 | 
      dem_clk === 147 | dem_clk === 150 | 
      dem_clk === 153 | dem_clk === 156 | 
      dem_clk === 159 | dem_clk === 162 | 
      dem_clk === 165 | dem_clk === 168 | 
      dem_clk === 171 | dem_clk === 174 | 
      dem_clk === 177 | dem_clk === 180 | 
      dem_clk === 183 | dem_clk === 186 | 
      dem_clk === 189 | dem_clk === 192 | 
      dem_clk === 195 | dem_clk === 198 | 
      dem_clk === 201 | dem_clk === 204 | 
      dem_clk === 207 | dem_clk === 210 | 
      dem_clk === 213 | dem_clk === 216 | 
      dem_clk === 219 | dem_clk === 222 | 
      dem_clk === 225 | dem_clk === 228 | 
      dem_clk === 231 | dem_clk === 234 | 
      dem_clk === 237 | dem_clk === 240)
                  begin
                  fft_en <= 1'b 1;   
                  end
               else
                  begin
                  fft_en <= 1'b 0;   
                  end
               end
            else
               begin
               fft_en <= 1'b 1;   
               end
            end
         else
            begin
            fft_en <= 1'b 0;   
            end

// ------------------------------------------------------------------------------------------------------------------------
//  Tinh he so cong suat addmel
         if (output_logic_subframe_num >= 1)
            begin
            if (dem_clk >= 0 & dem_clk <= 166)
               begin
               if (dem_clk >= 1 & dem_clk <= 166)
                  begin
                  if (output_logic_subframe_num >= 2)
                     begin
                     addmel_en <= 1'b 1;   
                     end
                  else if (dem_clk === 3 | dem_clk === 7 | 
      dem_clk === 12 | dem_clk === 17 | 
      dem_clk === 21 | dem_clk === 26 | 
      dem_clk === 31 | dem_clk === 36 | 
      dem_clk === 42 | dem_clk === 48 | 
      dem_clk === 54 | dem_clk === 60 | 
      dem_clk === 67 | dem_clk === 75 | 
      dem_clk === 83 | dem_clk === 91 | 
      dem_clk === 99 | dem_clk === 108 | 
      dem_clk === 118 | dem_clk === 129 | 
      dem_clk === 141 | dem_clk === 153 | 
      dem_clk === 166 )
                     begin
                     addmel_en <= 1'b 0;   
                     end
                  else
                     begin
                     addmel_en <= 1'b 1;   
                     end
                  end
               else
                  begin
                  addmel_en <= 1'b 0;   
                  end
               if (dem_clk === 0)
                  begin
                  output_logic_regmel_addr_sig = {5{1'b 0}};   
                  output_logic_regffte_addr_sig = {6{1'b 0}};   
                  end
               else if (dem_clk === 3 )
                  begin
                  output_logic_regffte_addr_sig = {6{1'b 0}};   
                  end
               else if (dem_clk === 7 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 000001;   
                  end
               else if (dem_clk === 12 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 000010;   
                  end
               else if (dem_clk === 17 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 000100;   
                  end
               else if (dem_clk === 21 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 000101;   
                  end
               else if (dem_clk === 26 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 000110;   
                  end
               else if (dem_clk === 31 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 001000;   
                  end
               else if (dem_clk === 36 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 001001;   
                  end
               else if (dem_clk === 42 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 001011;   
                  end
               else if (dem_clk === 48 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 001101;   
                  end
               else if (dem_clk === 54 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 001111;   
                  end
               else if (dem_clk === 60 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 010001;   
                  end
               else if (dem_clk === 67 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 010011;   
                  end
               else if (dem_clk === 75 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 010110;   
                  end
               else if (dem_clk === 83 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 011001;   
                  end
               else if (dem_clk === 91 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 011100;   
                  end
               else if (dem_clk === 99 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 011111;   
                  end
               else if (dem_clk === 108 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 100010;   
                  end
               else if (dem_clk === 118 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 100110;   
                  end
               else if (dem_clk === 129 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 101010;   
                  end
               else if (dem_clk === 141 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 101111;   
                  end
               else if (dem_clk === 153 )
                  begin
                  output_logic_regffte_addr_sig = 6'b 110100;   
                  end
               else if (dem_clk === 2 | dem_clk === 6 | 
      dem_clk === 11 | dem_clk === 16 | 
      dem_clk === 20 | dem_clk === 25 | 
      dem_clk === 30 | dem_clk === 35 | 
      dem_clk === 41 | dem_clk === 47 | 
      dem_clk === 53 | dem_clk === 59 | 
      dem_clk === 66 | dem_clk === 74 | 
      dem_clk === 82 | dem_clk === 90 | 
      dem_clk === 98 | dem_clk === 107 | 
      dem_clk === 117 | dem_clk === 128 | 
      dem_clk === 140 | dem_clk === 152 | 
      dem_clk === 165 )
                  ;
               else
                  begin
                  output_logic_regffte_addr_sig = output_logic_regffte_addr_sig + 2'b 01;   
                  end
               if (dem_clk === 1 | dem_clk === 4 | 
      dem_clk === 8 | dem_clk === 13 | 
      dem_clk === 18 | dem_clk === 22 | 
      dem_clk === 27 | dem_clk === 32 | 
      dem_clk === 37 | dem_clk === 43 | 
      dem_clk === 49 | dem_clk === 55 | 
      dem_clk === 61 | dem_clk === 68 | 
      dem_clk === 76 | dem_clk === 84 | 
      dem_clk === 92 | dem_clk === 100 | 
      dem_clk === 109 | dem_clk === 119 | 
      dem_clk === 130 | dem_clk === 142 | 
      dem_clk === 154)
                  begin
                  addmel_new <= 1'b 1;   
                  end
               else
                  begin
                  addmel_new <= 1'b 0;   
                  end
               if (dem_clk === 3 | dem_clk === 7 | 
      dem_clk === 12 | dem_clk === 17 | 
      dem_clk === 21 | dem_clk === 26 | 
      dem_clk === 31 | dem_clk === 36 | 
      dem_clk === 42 | dem_clk === 48 | 
      dem_clk === 54 | dem_clk === 60 | 
      dem_clk === 67 | dem_clk === 75 | 
      dem_clk === 83 | dem_clk === 91 | 
      dem_clk === 99 | dem_clk === 108 | 
      dem_clk === 118 | dem_clk === 129 | 
      dem_clk === 141 | dem_clk === 153 | 
      dem_clk === 166)
                  begin
                  regmel_wren <= 1'b 1;   
                  if (output_logic_subframe_num >= 2)
                     begin
                     addmel_sel <= 1'b 1;   
                     end
                  else
                     begin
                     addmel_sel <= 1'b 0;   
                     end
                  end
               else
                  begin
                  regmel_wren <= 1'b 0;   
                  addmel_sel <= 1'b 0;   
                  end
               if (dem_clk === 7 | dem_clk === 12 | 
      dem_clk === 17 | dem_clk === 21 | 
      dem_clk === 26 | dem_clk === 31 | 
      dem_clk === 36 | dem_clk === 42 | 
      dem_clk === 48 | dem_clk === 54 | 
      dem_clk === 60 | dem_clk === 67 | 
      dem_clk === 75 | dem_clk === 83 | 
      dem_clk === 91 | dem_clk === 99 | 
      dem_clk === 108 | dem_clk === 118 | 
      dem_clk === 129 | dem_clk === 141 | 
      dem_clk === 153 | dem_clk === 166)
                  begin
                  output_logic_regmel_addr_sig = output_logic_regmel_addr_sig + 2'b 01;   
                  end
               end
            else
               begin
               regmel_wren <= 1'b 0;   
               addmel_en <= 1'b 0;   
               addmel_sel <= 1'b 0;   
               end

//  Luu gia tri he so cong suat vao thanh ghi regdct
            if (output_logic_subframe_num >= 2)
               begin
               if (dem_clk >= 3 & dem_clk <= 169)
                  begin
                  if (dem_clk === 6)
                     begin
                     output_logic_regdct_addr_sig = {5{1'b 0}};   
                     regdct_wren <= 1'b 1;   
                     end
                  else if (dem_clk === 10 | dem_clk === 15 | 
      dem_clk === 20 | dem_clk === 24 | 
      dem_clk === 29 | dem_clk === 34 | 
      dem_clk === 39 | dem_clk === 45 | 
      dem_clk === 51 | dem_clk === 57 | 
      dem_clk === 63 | dem_clk === 70 | 
      dem_clk === 78 | dem_clk === 86 | 
      dem_clk === 94 | dem_clk === 102 | 
      dem_clk === 111 | dem_clk === 121 | 
      dem_clk === 132 | dem_clk === 144 | 
      dem_clk === 154 | dem_clk === 169 )
                     begin
                     regdct_wren <= 1'b 1;   
                     output_logic_regdct_addr_sig = output_logic_regdct_addr_sig + 2'b 01;   
                     end
                  else
                     begin
                     regdct_wren <= 1'b 0;   
                     end
                  end
               else
                  begin
                  regdct_wren <= 1'b 0;   
                  end
               end

//  Tinh logarithm cua he so cong suat
            if (dem_clk >= 3 & dem_clk <= 168)
               begin
               if (dem_clk === 4 | dem_clk === 8 | 
      dem_clk === 13 | dem_clk === 18 | 
      dem_clk === 22 | dem_clk === 27 | 
      dem_clk === 32 | dem_clk === 37 | 
      dem_clk === 43 | dem_clk === 49 | 
      dem_clk === 55 | dem_clk === 61 | 
      dem_clk === 68 | dem_clk === 76 | 
      dem_clk === 84 | dem_clk === 92 | 
      dem_clk === 100 | dem_clk === 109 | 
      dem_clk === 119 | dem_clk === 130 | 
      dem_clk === 142 | dem_clk === 154 | 
      dem_clk === 167)
                  begin
                  log_en <= 1'b 1;   
                  log_sel <= 1'b 0;   
                  end
               else
                  begin
                  log_en <= 1'b 0;   
                  log_sel <= 1'b 1;   
                  end
               end
            if (dem_clk >= 169)
               begin
               log_sel <= 1'b 1;   
               end
            end

// ---------------------------------------------------------------------------------------------------------------------
//  Tinh he so cepstral
         if (output_logic_subframe_num >= 2)
            begin
            if (dem_clk >= 172 & dem_clk <= 998)
               begin
               if (dem_clk === 172 | dem_clk === 241 | 
      dem_clk === 310 | dem_clk === 379 | 
      dem_clk === 448 | dem_clk === 517 | 
      dem_clk === 586 | dem_clk === 655 | 
      dem_clk === 724 | dem_clk === 793 | 
      dem_clk === 862 | dem_clk === 931)
                  begin
                  output_logic_regdct_addr_sig = {5{1'b 0}};   
                  end
               else if (dem_clk === output_logic_dem + 3 )
                  begin
                  output_logic_regdct_addr_sig = output_logic_regdct_addr_sig + 2'b 01;   
                  end
               end
            else
               begin
               addsubdct_new <= 1'b 0;   
               end
            if (dem_clk >= 172 & dem_clk <= 1000)
               begin
               if (dem_clk === 172)
                  begin
                  output_logic_cdct_addr_sig = {9{1'b 0}};   
                  output_logic_dem = 172;   
                  end
               else if (dem_clk === output_logic_dem + 3 )
                  begin

//  dem_clk rem (3) = 2
                  output_logic_dem = dem_clk;   
                  output_logic_cdct_addr_sig = output_logic_cdct_addr_sig + 2'b 01;   
                  muldct_en <= 1'b 0;   
                  addsubdct_en <= 1'b 1;   
                  end
               else
                  begin
                  muldct_en <= 1'b 1;   
                  addsubdct_en <= 1'b 0;   
                  end
               if (dem_clk === 173 | dem_clk === 242 | 
      dem_clk === 311 | dem_clk === 380 | 
      dem_clk === 449 | dem_clk === 518 | 
      dem_clk === 587 | dem_clk === 656 | 
      dem_clk === 725 | dem_clk === 794 | 
      dem_clk === 863 | dem_clk === 932)
                  begin

//  dem_clk rem (69) = 63
                  addsubdct_new <= 1'b 1;   
                  end
               else
                  begin
                  addsubdct_new <= 1'b 0;   
                  end
               end
            else
               begin
               muldct_en <= 1'b 0;   
               addsubdct_en <= 1'b 0;   
               end

//  cepstral --> Luu vao thanh ghi regc, regcep   => Co nen gom 2 doan if lai voi nhau khong
            if (dem_clk >= 242 & dem_clk <= 1002)
               begin
               if (dem_clk === 242 | dem_clk === 311 | 
      dem_clk === 380 | dem_clk === 449 | 
      dem_clk === 518 | dem_clk === 587 | 
      dem_clk === 656 | dem_clk === 725 | 
      dem_clk === 794 | dem_clk === 863 | 
      dem_clk === 932 | dem_clk === 1001)
                  begin

// dem_clk rem(69) = 63
                  regc_wren <= 1'b 1;   
                  regc_sel <= 2'b 10;   
                  regcep_wren <= 1'b 1;   
                  output_logic_regcep_addr_sig = output_logic_regcep_addr_sig + 2'b 01;
                  output_logic_regcep_addr_sig9 = output_logic_regcep_addr_sig9 + 2'b 01;   
                  end
               else
                  begin
                  regcep_wren <= 1'b 0;   
                  if (dem_clk === 246)
                     begin
                     regc_wren <= 1'b 1;   
                     regcep_wren <= 1'b 1;   
                     end
                  else
                     begin
                     regc_wren <= 1'b 0;   
                     end
                  end
               if (dem_clk === 242)
                  begin
                  if (output_logic_subframe_num === 2)
                     begin
                     output_logic_regc_addr_sig = 7'b 0000101;   
                     output_logic_regc_addr_cepstral = 7'b 0000101;   
                     end
                  else if (output_logic_subframe_num === 3 )
                     begin
                     output_logic_regc_addr_sig = 7'b 0010001;   
                     output_logic_regc_addr_cepstral = 7'b 0010001;   
                     end
                  else if (output_logic_subframe_num === 4 )
                     begin
                     output_logic_regc_addr_sig = 7'b 0011101;   
                     output_logic_regc_addr_cepstral = 7'b 0011101;   
                     end
                  else if (output_logic_subframe_num === 5 )
                     begin
                     output_logic_regc_addr_sig = 7'b 0101001;   
                     output_logic_regc_addr_cepstral = 7'b 0101001;   
                     end
                  else if (output_logic_subframe_num >= 6 )
                     begin
                     output_logic_regc_addr_sig = 7'b 0110101;   
                     output_logic_regc_addr_cepstral = 7'b 0110101;   
                     end
                  end
               else if (dem_clk === 311 | dem_clk === 380 | 
      dem_clk === 449 | dem_clk === 518 | 
      dem_clk === 587 | dem_clk === 656 | 
      dem_clk === 725 | dem_clk === 794 | 
      dem_clk === 863 | dem_clk === 932 | 
      dem_clk === 1001 )
                  begin

//  dem_clk rem (69) = 63
                  output_logic_regc_addr_sig = output_logic_regc_addr_cepstral + 2'b 01;   
                  output_logic_regc_addr_cepstral = output_logic_regc_addr_cepstral + 2'b 01;   
                  end
               end
            end

// ----------------------------------------------------------------------------------------------------------------------
//  Sap xep lai regc -- Dich chuyen thu tu cua cac vi tri thanh ghi lui lai 1 don vi	(sau 1 lan tinh xong delta			
//  regc_energy
         if (output_logic_subframe_num >= 5)
            begin
            if (dem_clk >= 1062 & dem_clk <= 1069)
               begin
               regc_sel <= 2'b 00;   
               if (dem_clk === 1062)
                  begin
                  output_logic_regc_addr_sig = 7'b 0000001;   
                  output_logic_regc_addr_sig1 = 7'b 0000001;   
                  end
               else
                  begin
                  if (dem_clk % 2 === 1)
                     begin
                     output_logic_regc_addr_sig = output_logic_regc_addr_sig1 - 2'b 01;   
                     regc_wren <= 1'b 1;   
                     end
                  else if (dem_clk % 2 === 0 )
                     begin
                     output_logic_regc_addr_sig = output_logic_regc_addr_sig1 + 2'b 01;   
                     output_logic_regc_addr_sig1 = output_logic_regc_addr_sig1 + 2'b 01;   
                     regc_wren <= 1'b 0;   
                     end
                  end
               end
            else if (dem_clk === 1070 )
               begin
               regc_wren <= 1'b 0;   
               end
            end

// regc_cepstral
         if (output_logic_subframe_num >= 6)
            begin
            if (dem_clk >= 1070 & dem_clk <= 1165)
               begin
               regc_sel <= 2'b 00;   
               if (dem_clk === 1070)
                  begin
                  output_logic_regc_addr_sig = 7'b 0010001;   
                  output_logic_regc_addr_sig1 = 7'b 0010001;   
                  regc_wren <= 1'b 0;   
                  end
               else
                  begin
                  if (dem_clk % 2 === 1)
                     begin
                     output_logic_regc_addr_sig = output_logic_regc_addr_sig1 - 7'b 0001100;   
                     regc_wren <= 1'b 1;   
                     end
                  else if (dem_clk % 2 === 0 )
                     begin
                     output_logic_regc_addr_sig = output_logic_regc_addr_sig1 + 2'b 01;   
                     output_logic_regc_addr_sig1 = output_logic_regc_addr_sig1 + 2'b 01;   
                     regc_wren <= 1'b 0;   
                     end
                  end
               end
            if (dem_clk === 1166)
               begin
               regc_wren <= 1'b 0;   
               end
            end

// ----------------------------------------------------------------------------------------------------------------------				
//  Tinh he so delta
         if (dem_clk >= 1003 & dem_clk <= 1058)
            begin
            if (output_logic_subframe_num >= 5)
               begin
               regc_sel <= 2'b 11;   
               end

//  Tinh delta energy
            if (log_overf === 1'b 0)
               begin
               if (output_logic_subframe_num >= 5)
                  begin
                  if (dem_clk >= 1003 & dem_clk <= 1007)
                     begin
                     if (dem_clk === 1003)
                        begin
                        output_logic_regc_addr_sig = 7'b 0000100;   
                        end
                     else if (dem_clk === 1004 )
                        begin
                        output_logic_regc_addr_sig = 7'b 0000000;   
                        delta_en <= 1'b 1;   
                        delta_new <= 1'b 1;   
                        delta_shift <= 1'b 0;   
                        delta_sub <= 1'b 0;   
                        end
                     else if (dem_clk === 1005 )
                        begin
                        output_logic_regc_addr_sig = 7'b 0000011;   
                        delta_new <= 1'b 0;   
                        delta_shift <= 1'b 1;   
                        delta_sub <= 1'b 1;   
                        end
                     else if (dem_clk === 1006 )
                        begin
                        output_logic_regc_addr_sig = 7'b 0000001;   
                        delta_shift <= 1'b 0;   
                        delta_sub <= 1'b 0;   
                        end
                     else if (dem_clk === 1007 )
                        begin
                        delta_shift <= 1'b 0;   
                        delta_sub <= 1'b 1;   
                        end
                     end
                  else if (dem_clk === 1008 )
                     begin
                     delta_en <= 1'b 0;   
                     delta_sub <= 1'b 0;   
                     regcep_wren <= 1'b 1;   
                     output_logic_regcep_addr_sig = output_logic_regcep_addr_sig + 2'b 01;
                     output_logic_regcep_addr_sig9 = output_logic_regcep_addr_sig9 + 2'b 01;   
                     end
                  else if (dem_clk === 1009 )
                     begin
                     regcep_wren <= 1'b 0;   
                     end
                  end
               end

//  Tinh delta cepstral	-- Sau khi log_overf = 1 thi delta_cepstral van tinh cho den het chu ki tinh subframe			
            if (output_logic_subframe_num >= 6)
               begin
               if (dem_clk >= 1008 & dem_clk <= 1055)
                  begin
                  if (dem_clk === 1008)
                     begin
                     delta_en <= 1'b 0;   
                     output_logic_regc_addr_sig = 7'b 0110101;   
                     output_logic_regc_addr_sig1 = 7'b 0110101;   
                     end
                  else if (dem_clk === 1009 )
                     begin
                     output_logic_regc_addr_sig = 7'b 0000101;   
                     output_logic_regc_addr_sig2 = 7'b 0000101;   
                     delta_en <= 1'b 1;   
                     delta_new <= 1'b 1;   
                     delta_shift <= 1'b 0;   
                     delta_sub <= 1'b 0;   
                     end
                  else if (dem_clk === 1010 )
                     begin
                     output_logic_regc_addr_sig = 7'b 0101001;   
                     output_logic_regc_addr_sig3 = 7'b 0101001;   
                     delta_new <= 1'b 0;   
                     delta_shift <= 1'b 1;   
                     delta_sub <= 1'b 1;   
                     end
                  else if (dem_clk === 1011 )
                     begin
                     output_logic_regc_addr_sig = 7'b 0010001;   
                     output_logic_regc_addr_sig4 = 7'b 0010001;   
                     delta_shift <= 1'b 0;   
                     delta_sub <= 1'b 0;   
                     end
                  else
                     begin
                     if (dem_clk % 4 === 0)
                        begin
                        output_logic_regc_addr_sig = output_logic_regc_addr_sig1 + 2'b 01;   
                        output_logic_regc_addr_sig1 = output_logic_regc_addr_sig1 + 2'b 01;   
                        delta_shift <= 1'b 0;   
                        delta_sub <= 1'b 1;   
                        end
                     else if (dem_clk % 4 === 1 )
                        begin
                        output_logic_regc_addr_sig = output_logic_regc_addr_sig2 + 2'b 01;   
                        output_logic_regc_addr_sig2 = output_logic_regc_addr_sig2 + 2'b 01;   
                        delta_new <= 1'b 1;   
                        delta_shift <= 1'b 0;   
                        delta_sub <= 1'b 0;   
                        regcep_wren <= 1'b 1;   
                        output_logic_regcep_addr_sig = output_logic_regcep_addr_sig + 2'b 01;
                        output_logic_regcep_addr_sig9 = output_logic_regcep_addr_sig9 + 2'b 01;   
                        end
                     else if (dem_clk % 4 === 2 )
                        begin
                        output_logic_regc_addr_sig = output_logic_regc_addr_sig3 + 2'b 01;   
                        output_logic_regc_addr_sig3 = output_logic_regc_addr_sig3 + 2'b 01;   
                        delta_new <= 1'b 0;   
                        delta_shift <= 1'b 1;   
                        delta_sub <= 1'b 1;   
                        regcep_wren <= 1'b 0;   
                        end
                     else if (dem_clk % 4 === 3 )
                        begin
                        output_logic_regc_addr_sig = output_logic_regc_addr_sig4 + 2'b 01;   
                        output_logic_regc_addr_sig4 = output_logic_regc_addr_sig4 + 2'b 01;   
                        delta_shift <= 1'b 0;   
                        delta_sub <= 1'b 0;   
                        end
                     end
                  end
               else if (dem_clk === 1056 )
                  begin
                  delta_shift <= 1'b 0;   
                  delta_sub <= 1'b 1;   
                  end
               else if (dem_clk === 1057 )
                  begin
                  delta_en <= 1'b 0;   
                  delta_sub <= 1'b 0;   
                  regcep_wren <= 1'b 1;   
                  output_logic_regcep_addr_sig9 = 13'b 11010;
//                  output_logic_regcep_addr_sig=output_logic_regcep_addr_sig+2'b1;
                  end
               else if (dem_clk === 1058 )
                  begin
                  regcep_wren <= 1'b 0;
                  
                  end
               end
            end
         else
            begin
            delta_en <= 1'b 0;   
            delta_sub <= 1'b 0;   
            end
         end


         
      end
   endcase
   end


endmodule // module controller


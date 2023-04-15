--------------------------------------------------------------------------------
--
-- File Type:    VHDL 
-- Tool Version: verilog2vhdl 20.51
-- Input file was: C:\MFCC_verilog_v1\MFCC\mem_test.v.vpp
-- Command line was: C:\SynaptiCAD\bin\win32\verilog2vhdl.exe C:\MFCC_verilog_v1\MFCC\mem_test.v -p -ncc
-- Date Created: Sun Feb 05 23:47:40 2023
--
--------------------------------------------------------------------------------



LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY ASC;
USE ASC.numeric_std.all;
ENTITY mem_test IS	-- 
    PORT (
        SIGNAL clk : IN std_logic;	
        SIGNAL ram_addr : IN std_logic_vector(14 DOWNTO 0);	
        SIGNAL ram_data : OUT std_logic_vector(15 DOWNTO 0));	
END mem_test;



LIBRARY ASC;

LIBRARY Std;
ARCHITECTURE VeriArch OF mem_test IS
    USE ASC.FUNCTIONS.ALL;
    USE ASC.v2v_types.ALL;
    USE Std.textio.ALL;
    USE ASC.READMEM.ALL;
    USE ASC.timing.ALL;
TYPE MEMORY_0 IS ARRAY (16383 DOWNTO 0) OF std_logic_vector(15 DOWNTO 0); 
-- Intermediate signal for ram_data
    SIGNAL V2V_ram_data : std_logic_vector(15 DOWNTO 0) REGISTER ;	
--  Note
    SIGNAL input_file : v2v_integer REGISTER ;	

    SIGNAL mem : MEMORY_0 REGISTER ;	

    SIGNAL GUARD : boolean:= TRUE;	
    FILE memfile0 : TEXT OPEN READ_MODE IS "input_file.txt";

    PROCEDURE readMEMORY_0h (FILE memfile : TEXT;
                 SIGNAL memname : INOUT MEMORY_0;
                 CONSTANT start_address : IN integer := -1;
                 CONSTANT end_address : IN integer := -1)   
 IS 
        VARIABLE tempmem : MEMORY(memname'RANGE);	

BEGIN
    readmemh(memfile, tempmem, memname(v2v_to_integer(memname'LEFT)), start_address, 
          end_address);	


    IF start_address = -1 OR end_address = -1 THEN


        FOR i IN memname'RANGE LOOP
            memname(i) <= to_stdlogicvector(tempmem(i), memname(i)'LENGTH);	

        END LOOP;

    ELSIF start_address <= end_address THEN


        FOR i IN start_address TO end_address LOOP
            memname(i) <= to_stdlogicvector(tempmem(i), memname(i)'LENGTH);	

        END LOOP;

    ELSE


        FOR i IN start_address DOWNTO end_address LOOP
            memname(i) <= to_stdlogicvector(tempmem(i), memname(i)'LENGTH);	

        END LOOP;

    END IF;
    WAIT FOR 0 ns;
END;
BEGIN

    PROCESS 
    BEGIN
        readMEMORY_0h(memfile0, mem);	
        WAIT;
    END PROCESS;


    PROCESS 
    BEGIN
        WAIT UNTIL POSEDGE(clk);
        V2V_ram_data <= to_stdlogicvector(mem(v2v_to_integer(ram_addr)), 16);	

    END PROCESS;

    ram_data <= V2V_ram_data;	
END VeriArch;


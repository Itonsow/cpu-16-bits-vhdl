LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
--pega os 3 bits do opcode e decide oq vai ser da instrução
ENTITY ControlUnit IS
    PORT (
        WB: OUT STD_LOGIC_VECTOR(0 TO 1) := "00";--sinais para o wb
        MEM: OUT STD_LOGIC_VECTOR(0 TO 2) := "000";--sinais pro mem
        EX: OUT STD_LOGIC_VECTOR(0 TO 4) := "00000";--sinais pro ex
        INSTRUCTION: IN STD_LOGIC_VECTOR(0 TO 15)--instrucao 16bits inteira
    );
END ControlUnit;

ARCHITECTURE UC OF ControlUnit IS
BEGIN
    PROCESS (INSTRUCTION)
    BEGIN
        -- NOP=000, 
        --ADD/SUB=011, 
        --ADDI=100, 
        --SUBI=101
        
        CASE INSTRUCTION(0 TO 2) IS
            WHEN "000" => -- NOP
                WB <= "00"; --nada
                MEM <= "000"; --nada
                EX <= "00000"; --nada
                
            WHEN "001" => -- LW
                WB <= "10"; --regwrite = 1
                MEM <= "010"; -- memread = 1
                EX <= "00001"; --imm
                
            WHEN "010" => -- SW
                WB <= "0X"; --regwrite = 0
                MEM <= "001";--memwrite = 1
                EX <= "00001";
                
            WHEN "011" => -- TYPE R (ADD/SUB)
                WB <= "11"; --regwrite = 1 e memtoreg = 1
                MEM <= "0X0"; --n acessa memoria
                EX <= "10100"; --regdest= 1
                
            WHEN "100" => -- ADDI
                WB <= "11"; --regwrite = 1
                MEM <= "0X0"; --n acessa
                EX <= "00111";
                
            WHEN "101" => -- SUBI
                WB <= "11"; --msm coisa que o addi
                MEM <= "0X0";
                EX <= "01001";
                
            WHEN OTHERS =>
                WB <= "00";
                MEM <= "0X0";
                EX <= "XXXXX";
        END CASE;
    END PROCESS;
END UC;
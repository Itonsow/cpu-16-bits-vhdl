LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY AluControl IS
    PORT (
        ALU_OP : IN STD_LOGIC_VECTOR(0 TO 2); --entreda de 3bits vinda da unidade de controle
        FUNCT : IN STD_LOGIC; --bit usado pra decidir se vai ser add ou sub
        ULA_CODE : OUT STD_LOGIC_VECTOR(0 TO 1)
    );
END AluControl;

ARCHITECTURE AC OF AluControl IS
BEGIN
    PROCESS (ALU_OP, FUNCT)
    BEGIN
        --I-TYPE - LW and SW (ALU_OP = "000")
        IF (ALU_OP = "000") THEN
            ULA_CODE <= "00";--ADD
        END IF;

        --R-TYPE (ALU_OP = "010")
        --FUNCT = '0' para ADD, '1' para SUB
        IF (ALU_OP = "010") THEN --se for tipo R, ele vai olhar pro funct, pra ver c vai ser soma ou sub
            IF (FUNCT = '0') THEN
                ULA_CODE <= "00";--ADD
            ELSE
                ULA_CODE <= "01";--SUB
            END IF;
        END IF;

        --I-TYPE ADDI (ALU_OP = "011")
        IF (ALU_OP = "011") THEN
            ULA_CODE <= "00";--ADD
        END IF;
        
        --I-TYPE SUBI (ALU_OP = "100")
        IF (ALU_OP = "100") THEN
            ULA_CODE <= "01";--SUB
        END IF;
    END PROCESS;
END AC;
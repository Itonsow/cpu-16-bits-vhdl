LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY InstructionMemory IS
    PORT (
        ADDRESS : IN STD_LOGIC_VECTOR(0 TO 15);
        INSTRUCTION : OUT STD_LOGIC_VECTOR(0 TO 15) := "0000000000000000"
    );
END InstructionMemory;

ARCHITECTURE MEM OF InstructionMemory IS
    TYPE MEM_TYPE IS ARRAY(0 TO 400) OF STD_LOGIC_VECTOR(0 TO 7);
    SIGNAL MEMORY : MEM_TYPE;
BEGIN
    -------------------------------------------------------------------
    -- Programa de 16 bits:
    -- Formato Tipo I (ADDI/SUBI/LW/SW): 3bits OP, 4bits RS, 4bits RT, 5bits OFFSET
    -- Formato Tipo R (ADD/SUB):         3bits OP, 4bits RS, 4bits RT, 4bits RD, 1bit ADD/SUB
    --
    -- Opcodes: NOP=000, LW=001, SW=010, ADD/SUB=011, ADDI=100, SUBI=101
    --
    -- 0: ADDI $1, $0, 3   ; R1 = 3
    -- 1: ADDI $2, $0, 2   ; R2 = 2
    -- 2: NOP
    -- 3: NOP
    -- 4: SUBI $3, $1, 2   ; R3 = R1 - 2 = 1
    -- 5: NOP
    -- 6: NOP
    -- 7: ADD  $3, $1, $2  ; R3 = R1 + R2 = 5
    -------------------------------------------------------------------

    -- Instrução 0: ADDI $1, $0, 3  (endereço 0)
    -- opcode = 100 (ADDI)
    -- rs = $0  = 0000
    -- rt = $1  = 0001
    -- imm = 3  = 00011
    -- Binário: 100_0000_0001_00011 = 10000000 00100011
    MEMORY(000) <= "10000000";
    MEMORY(001) <= "00100011";

    -- Instrução 1: ADDI $2, $0, 2  (endereço 2)
    -- opcode = 100 (ADDI)
    -- rs = $0  = 0000
    -- rt = $2  = 0010
    -- imm = 2  = 00010
    -- Binário: 100_0000_0010_00010 = 10000000 01000010
    MEMORY(002) <= "10000000";
    MEMORY(003) <= "01000010";

    -- Instrução 2: NOP (endereço 4)
    -- opcode = 000 (NOP)
    -- Binário: 000_0000_0000_00000 = 00000000 00000000
    MEMORY(004) <= "00000000";
    MEMORY(005) <= "00000000";

    -- Instrução 3: NOP (endereço 6)
    MEMORY(006) <= "00000000";
    MEMORY(007) <= "00000000";

    -- Instrução 4: SUBI $3, $1, 2  (endereço 8)
    -- opcode = 101 (SUBI)
    -- rs = $1  = 0001
    -- rt = $3  = 0011
    -- imm = 2  = 00010
    -- Binário: 101_0001_0011_00010 = 10100010 01100010
    MEMORY(008) <= "10100010";
    MEMORY(009) <= "01100010";

    -- Instrução 5: NOP (endereço 10)
    MEMORY(010) <= "00000000";
    MEMORY(011) <= "00000000";

    -- Instrução 6: NOP (endereço 12)
    MEMORY(012) <= "00000000";
    MEMORY(013) <= "00000000";

    -- Instrução 7: ADD $3, $1, $2  (endereço 14)
    -- opcode = 011 (ADD/SUB tipo R)
    -- rs = $1  = 0001
    -- rt = $2  = 0010
    -- rd = $3  = 0011
    -- add/sub = 0 (ADD)
    -- Binário: 011_0001_0010_0011_0 = 01100010 01000110
    MEMORY(014) <= "01100010";
    MEMORY(015) <= "01000110";

    -------------------------------------------------------------------
    -- resto zerado (opcional)
    -------------------------------------------------------------------
    MEMORY(016) <= "00000000";
    MEMORY(017) <= "00000000";

    PROCESS (ADDRESS)
    BEGIN
        INSTRUCTION <= MEMORY(TO_INTEGER(UNSIGNED(ADDRESS))) &
                       MEMORY(TO_INTEGER(UNSIGNED(ADDRESS)) + 1);
    END PROCESS;
END;

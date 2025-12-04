LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY FileRegister IS
    PORT (
        -- IN --
        REGWRITE : IN STD_LOGIC; --sinal pra escrever no reg
        CLOCK : IN STD_LOGIC;
        READ_REGISTER_1 : IN STD_LOGIC_VECTOR(0 TO 3);--endereços dos reg
        READ_REGISTER_2 : IN STD_LOGIC_VECTOR(0 TO 3); -- //
        WRITE_REGISTER : IN STD_LOGIC_VECTOR(0 TO 3);id do registrador que vai ser escrito
        WRITE_DATA : IN STD_LOGIC_VECTOR(0 TO 15); --data que vai escrever
        -- OUT --
        READ_DATA_1 : OUT STD_LOGIC_VECTOR(0 TO 15); --conteudo do reg1
        READ_DATA_2 : OUT STD_LOGIC_VECTOR(0 TO 15); --conteudo do reg2
        DEB_FILE_REG_1 : OUT STD_LOGIC_VECTOR(0 TO 15);--mostra conteudo do reg1
        DEB_FILE_REG_2 : OUT STD_LOGIC_VECTOR(0 TO 15);--conteudo do reg2
        DEB_FILE_REG_3 : OUT STD_LOGIC_VECTOR(0 TO 15);--conteudo do reg3
        DEB_FILE_REG_AUX : OUT STD_LOGIC);--sinal quando escrita acontece
END FileRegister;

ARCHITECTURE REGS OF FileRegister IS
    TYPE REGISTER_TYPE IS ARRAY(0 TO 15) OF STD_LOGIC_VECTOR(0 TO 15);
    SIGNAL REGISTERS : REGISTER_TYPE;
BEGIN
    DEB_FILE_REG_1 <= REGISTERS(1);
    DEB_FILE_REG_2 <= REGISTERS(2);
    DEB_FILE_REG_3 <= REGISTERS(3);
    PROCESS (CLOCK)
    BEGIN
        IF (CLOCK'EVENT AND CLOCK = '1' AND REGWRITE = '1' AND NOT (WRITE_REGISTER = "0000")) THEN--entra na borda de subida
            DEB_FILE_REG_AUX <= '1';
            REGISTERS(TO_INTEGER(UNSIGNED(WRITE_REGISTER))) <= WRITE_DATA;--coloca o dado
        END IF;
    END PROCESS;
    READ_DATA_1 <= REGISTERS(TO_INTEGER(UNSIGNED(READ_REGISTER_1)));
    READ_DATA_2 <= REGISTERS(TO_INTEGER(UNSIGNED(READ_REGISTER_2)));
END;
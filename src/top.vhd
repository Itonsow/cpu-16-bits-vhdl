library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    CLOCK_50 : in  std_logic;
    KEY      : in  std_logic_vector(3 downto 0);  -- KEY(0) = clock, passar intru
    SW       : in  std_logic_vector(17 downto 0); 

    LEDR     : out std_logic_vector(17 downto 0); --led pra sinais
    HEX0     : out std_logic_vector(6 downto 0); --
    HEX1     : out std_logic_vector(6 downto 0);
    HEX2     : out std_logic_vector(6 downto 0);
    HEX3     : out std_logic_vector(6 downto 0);
    HEX4     : out std_logic_vector(6 downto 0);
    HEX5     : out std_logic_vector(6 downto 0);
    HEX6     : out std_logic_vector(6 downto 0);
    HEX7     : out std_logic_vector(6 downto 0)
  );
end entity;

architecture rtl of top is
  signal key0_sync_0   : std_logic := '1';
  signal key0_sync_1   : std_logic := '1';
  signal key0_prev     : std_logic := '1';
  signal cpu_clk_pulse : std_logic := '0';

--sinais pra debug
  signal instr_ifid      : std_logic_vector(0 to 15);
  signal dbg_pc          : std_logic_vector(0 to 15);
  signal dbg_control     : std_logic;
  signal dbg_alu_in1     : std_logic_vector(0 to 15);
  signal dbg_alu_in2     : std_logic_vector(0 to 15);
  signal dbg_alu_out     : std_logic_vector(0 to 15);
  signal dbg_mux_memwb   : std_logic;
  signal dbg_reg_write   : std_logic;
  signal dbg_reg1        : std_logic_vector(0 to 15);
  signal dbg_reg2        : std_logic_vector(0 to 15);
  signal dbg_reg3        : std_logic_vector(0 to 15);
  signal dbg_reg_aux     : std_logic;

begin
-------
--evitar duas vezes
  process(CLOCK_50)
  begin
    if rising_edge(CLOCK_50) then
      -- sincroniza o botão
      key0_sync_0 <= KEY(0);
      key0_sync_1 <= key0_sync_0;

      -- detecta borda de descida: 1 -> 0
      if (key0_prev = '1') and (key0_sync_1 = '0') then
        cpu_clk_pulse <= '1';
      else
        cpu_clk_pulse <= '0';
      end if;

      key0_prev <= key0_sync_1;
    end if;
  end process;


  u_cpu : entity work.Cpu
    generic map (
      DATA_SIZE => 16
    )
    port map (
      CLOCK               => cpu_clk_pulse,
      INSTRUCTION_OUT_IFID=> instr_ifid,
      DEB_REGS_PC         => dbg_pc,
      DEB_CONTROL         => dbg_control,
      DEB_ULA_IN_1        => dbg_alu_in1,
      DEB_ULA_IN_2        => dbg_alu_in2,
      DEB_OUT_ULA         => dbg_alu_out,
      DEB_SINAL_MUX_MEMWB => dbg_mux_memwb,
      DEB_SINAL_REG_WRITE => dbg_reg_write,
      DEB_FILE_REG_1      => dbg_reg1,
      DEB_FILE_REG_2      => dbg_reg2,
      DEB_FILE_REG_3      => dbg_reg3,
      DEB_FILE_REG_AUX    => dbg_reg_aux
    );


  --LEDR <= (others => '0');
  LEDR(0) <= dbg_reg_write; --'1' quando escreve em registrador
  LEDR(1) <= dbg_mux_memwb; -- '1' = WB vem da memória
  LEDR(2) <= dbg_control; -- bit de controle
  LEDR(3) <= dbg_reg_aux;  -- flag interna do regfile

  -- HEX7 -> PC (4 bits)
  u_hex7 : entity work.hex7seg
    port map (
      hex => dbg_pc(12 to 15),      -- 4 últimos bits do PC de 16 bits
      seg => HEX7
    );

  -- HEX6 -> instrução IF/ID (4 bits)
  u_hex6 : entity work.hex7seg
    port map (
      hex => instr_ifid(12 to 15),
      seg => HEX6
    );

			-- HEX5 -> operando A da ULA
  u_hex5 : entity work.hex7seg
    port map (
      hex => dbg_alu_in1(12 to 15),
      seg => HEX5
    );

			-- HEX4 -> operando B da ULA
  u_hex4 : entity work.hex7seg
    port map (
      hex => dbg_alu_in2(12 to 15),
      seg => HEX4
    );

		-- HEX3 -> resultado da ULA (EX)
  u_hex3 : entity work.hex7seg
    port map (
      hex => dbg_alu_out(12 to 15),
      seg => HEX3
    );

		-- HEX2 -> conteúdo do registrador 1
  u_hex2 : entity work.hex7seg
    port map (
      hex => dbg_reg1(12 to 15),
      seg => HEX2
    );

			-- HEX1 -> conteúdo do registrador 2
  u_hex1 : entity work.hex7seg
    port map (
      hex => dbg_reg2(12 to 15),
      seg => HEX1
    );

			-- HEX0 -> dado final que vai para o registrador (writeback)
--  u_hex0 : entity work.hex7seg
--    port map (
--      hex => dbg_write_data(28 to 31),
--      seg => HEX0
--    );
-- Usa:
	-- Usa:
	u_hex0 : entity work.hex7seg
	  port map (
		hex => dbg_reg3(12 to 15),        -- DEB_FILE_REG_3 = REGISTERS(3)
		seg => HEX0
	);

end architecture;

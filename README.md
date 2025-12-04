# CPU 16-bits (VHDL)

Projeto: Implementação em VHDL de uma CPU de 16 bits educacional, com unidades de ALU, registradores, memória e unidade de controle.

## Visão geral
Este repositório contém uma implementação didática de uma CPU de 16 bits escrita em VHDL. O objetivo é servir como base para estudo de microarquitetura, pipelines simples, decodificação de instruções e integração com memórias e periféricos em FPGAs ou simuladores.

Principais características:
- Largura de dados de 16 bits.
- Banco de registradores.
- ALU com operações aritméticas e lógicas básicas (NOP, ADD, SUB, AND, OR, ADDI, SUBI).
- Unidade de controle simples (microprogramada/decodificada).
- Memória de instruções e memória de dados (ROM/RAM simples).

## Estrutura do repositório
- src/ — código VHDL principal (componentes, CPU, ALU, registradores, memória, controle).
- doc/ — documentação adicional (ex.: conjunto de instruções, diagramas).

## Requisitos / Ferramentas recomendadas
- ModelSim/Altera
- Ferramentas de síntese específicas do fabricante (Intel Quartus) para implantação em FPGA
- Placa EP4CE115F29C7

## Licença
Este projeto usa licença MIT. Consulte o arquivo LICENSE para mais detalhes.

## Contato
Autor: Itonsow
Repo: https://github.com/Itonsow/cpu-16-bits-vhdl

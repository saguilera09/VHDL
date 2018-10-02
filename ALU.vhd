----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.08.2018 09:43:01
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
--  Port ( );
port(
A: in unsigned (3 downto 0);
B: in unsigned (3 downto 0);
op: in unsigned (3 downto 0);

salida: buffer unsigned (3 downto 0); 
Acarreo: out std_ulogic;
igualdad: out std_ulogic;
Compara: out std_ulogic
);
end ALU;
architecture flujo_ALU of ALU is
    signal A1: unsigned (4 downto 0);
    signal B1: unsigned (4 downto 0);
    signal R: unsigned (4 downto 0); 
    begin
    with op select

    salida <= 
    ( A + B ) when "0000",
    ( A - B ) when "0001",
    ( not A ) when "0010",
    ( not A ) + "0001" when "0011",
    ( A rol 1 ) when "0100", 
    ( A ror 1 ) when "0101", 
    ( A sll 1 ) when "0110", 
    ( A srl 1 ) when "0111", 
    ( A and B ) when "1000",
    ( A nand B ) when "1001", 
    ( A or B ) when "1010", 
    ( A nor B ) when "1011",
    ( A xor B ) when "1100", 
    ( A xnor B ) when "1101",
    "0000" when others;
    igualdad <= '1' when ( (op="1110" ) and ( A=B ) )else '0';
    Compara <= '1' when ( ( op="1110" ) and ( A>B ) ) else '0';

A1(4) <= '0' ;
A1( 3 downto 0 ) <= A;
B1(4) <= '0' ;
B1( 3 downto 0 ) <= B;
R <= ( A1 + B1 ) when ( op="0000" ) else
( A1 - B1 ) when ( op="0001" ) else "00000";
Acarreo <= R(4) when ( op="0000" ) or ( op="0001" ) else '0' ;


end flujo_ALU;

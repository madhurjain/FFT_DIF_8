library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pkg_complex.ALL;

entity butterfly is
    Port (
        xt1, xt2 : in complex;
        W_k  : in complex;
        Xk1, Xk2 : out complex        
     );
end butterfly;

architecture Behavioral of butterfly is
begin
    Xk1 <= xt1 + xt2;
    Xk2 <= (xt1 - xt2) * W_k;    
end Behavioral;

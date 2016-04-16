library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pkg_complex.ALL;

library ieee_proposed;
use ieee_proposed.fixed_pkg.ALL;

entity test_fft_8 is
end test_fft_8;

architecture Behavioral of test_fft_8 is
    signal x_t, X_k : complex_array_8 := (others => (to_sfixed(0, 9, -6), to_sfixed(0, 9, -6)));
    signal op : real_complex_array_8;
    --signal s1,s2 : sfixed(8 downto -6);
    --signal s4 : sfixed(9 downto -6);
begin

    --s1 <=  to_sfixed (5.75,s1);         -- s1 = "00101110" = 5.75
    --s2 <=  to_sfixed (-6.5,s2);         -- s2 = "11001100" = -6.5
    --s4 <= resize(s2*s1, 9, -6);                        -- s4 = "1111011010101000" = -37.375 

    uut : entity work.fft_dif_8 port map (
        xt => x_t,
        Xk => X_k
    );
    
    stimulus : process
    begin
        x_t(0) <= to_complex(-2.0, 1.2);
        x_t(1) <= to_complex(-2.2, 1.7);
        x_t(2) <= to_complex(1.0, -2.0);
        x_t(3) <= to_complex(-3.0,-3.2);
        x_t(4) <= to_complex(4.5, -2.5);
        x_t(5) <= to_complex(-1.6, 0.2);
        x_t(6) <= to_complex(0.5, 1.5);
        x_t(7) <= to_complex(-2.8, -4.2);
        wait;
    end process;
    
    process(X_k)
    begin
        op(0) <= to_real_complex(X_k(0));
        op(1) <= to_real_complex(X_k(1));
        op(2) <= to_real_complex(X_k(2));
        op(3) <= to_real_complex(X_k(3));
        op(4) <= to_real_complex(X_k(4));
        op(5) <= to_real_complex(X_k(5));
        op(6) <= to_real_complex(X_k(6));
        op(7) <= to_real_complex(X_k(7));
    end process;
end Behavioral;

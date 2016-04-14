library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pkg_complex.ALL;

entity test_fft_8 is
end test_fft_8;

architecture Behavioral of test_fft_8 is
    signal x_t, X_k : complex_array_8;
begin

    uut : entity work.fft_dif_8 port map (
        xt => x_t,
        Xk => X_k
    );
    
    stimulus : process
    begin
        x_t(0) <= (-2.0, 1.2);
        x_t(1) <= (-2.2, 1.7);
        x_t(2) <= (1.0, -2.0);
        x_t(3) <= (-3.0, -3.2);
        x_t(4) <= (4.5, -2.5);
        x_t(5) <= (-1.6, 0.2);
        x_t(6) <= (0.5, 1.5);
        x_t(7) <= (-2.8, -4.2);
        wait;
    end process;
end Behavioral;

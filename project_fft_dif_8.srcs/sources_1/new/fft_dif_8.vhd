library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pkg_complex.ALL;
library ieee_proposed;
use ieee_proposed.fixed_pkg.ALL;

entity fft_dif_8 is    
    Port ( 
        xt : in complex_array_8;
        Xk : out complex_array_8
    );
end fft_dif_8;

architecture Behavioral of fft_dif_8 is
    component butterfly is
        port(
            xt1, xt2 : in complex;   -- time domain inputs
            W_k  : in complex;       -- twiddle factor
            Xk1, Xk2 : out complex   -- intermediate outputs
        ); 
    end component;
    signal g1, g2 : complex_array_8 := (others => (to_sfixed(0.0, 9, -6), to_sfixed(0.0, 9, -6)));
    -- twiddle/phase factor, Wk_N = e^(-j*2*Pi*k/N), N = 8
    -- Wk_N = cos(2*Pi*k/N) - jsin(2*Pi*k/N), where k = 0 to 7
    constant Wk_N : complex_array_4 := (
        (to_sfixed(1.0, 9, -6), to_sfixed(0.0, 9, -6)),
        (to_sfixed(0.7071, 9, -6), to_sfixed(-0.7071, 9, -6)),
        (to_sfixed(0.0, 9, -6), to_sfixed(-1.0, 9, -6)),
        (to_sfixed(-0.7071, 9, -6), to_sfixed(-0.7071, 9, -6))
    );
begin

--generate_butterfly:
--   for <name> in <lower_limit> to <upper_limit> generate
--      begin
--         <statement>;
--         <statement>;
--   end generate;

-- stage 1
bf11:   butterfly port map(xt(0), xt(4), Wk_N(0), g1(0), g1(4));
bf12:   butterfly port map(xt(1), xt(5), Wk_N(1), g1(1), g1(5));
bf13:   butterfly port map(xt(2), xt(6), Wk_N(2), g1(2), g1(6));
bf14:   butterfly port map(xt(3), xt(7), Wk_N(3), g1(3), g1(7));

-- stage 2
bf21:   butterfly port map(g1(0), g1(2), Wk_N(0), g2(0), g2(2));
bf22:   butterfly port map(g1(1), g1(3), Wk_N(2), g2(1), g2(3));
bf23:   butterfly port map(g1(4), g1(6), Wk_N(0), g2(4), g2(6));
bf24:   butterfly port map(g1(5), g1(7), Wk_N(2), g2(5), g2(7));

-- stage 3
bf31:   butterfly port map(g2(0), g2(1), Wk_N(0), Xk(0), Xk(4));
bf32:   butterfly port map(g2(2), g2(3), Wk_N(0), Xk(2), Xk(6));
bf33:   butterfly port map(g2(4), g2(5), Wk_N(0), Xk(1), Xk(5));
bf34:   butterfly port map(g2(6), g2(7), Wk_N(0), Xk(3), Xk(7));

end Behavioral;

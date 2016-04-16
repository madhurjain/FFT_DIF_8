library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library ieee_proposed;
use ieee_proposed.fixed_pkg.ALL;

package pkg_complex is
    subtype fpoint16 is sfixed(9 downto -6);        
    type complex is record
        re : sfixed(9 downto -6);
        im : sfixed(9 downto -6);
    end record;
    type real_complex is record
        re : real;
        im : real;
    end record;
    
    type real_complex_array_8 is array(0 to 7) of real_complex;
    type complex_array_8 is array(0 to 7) of complex;
    type complex_array_4 is array(0 to 3) of complex;
    function "+" (a,b: complex) return complex;
    function "-" (a,b: complex) return complex;
    --function "=" (a:real) return fpoint16;
    --function "=" (a,b:real) return complex;
    function to_complex (a,b:real) return complex;
    function to_real_complex(a: complex) return real_complex;
    function "*" (a,b: complex) return complex;
end pkg_complex;

package body pkg_complex is

--function "=" (a: real) return fpoint16 is
--begin
--    return to_sfixed(a, 9, -6); 
--end function;

function to_complex(a, b: real) return complex is
begin
    return (to_sfixed(a, 9, -6), to_sfixed(b, 9, -6));  
end function;

function to_real_complex(a: complex) return real_complex is
begin
    return (to_real(a.re), to_real(a.im));  
end function;

--function "=" (a, b: real) return complex is
--begin
--    return (to_sfixed(a, 9, -6), to_sfixed(b, 9, -6));  
--end function;

function "+" (a,b: complex) return complex is
    variable sum : complex;
begin
   sum.re := resize(a.re + b.re, 9, -6);
   sum.im := resize(a.im + b.im, 9, -6);
   return sum;
end function;

function "-" (a,b: complex) return complex is
    variable diff : complex;
begin
   diff.re := resize(a.re - b.re, 9, -6);
   diff.im := resize(a.im - b.im, 9, -6);
   return diff;
end function;

function "*" (a, b: complex) return complex is
    variable prod : complex;
    variable z : sfixed(9 downto -6);
begin
    -- (R + jI) = (X + jY)(C + jS)
    -- R = XC - YS, I = XS + YC (4 multiplications, 2 add/sub)
    --prod.re := (a.re * b.re) - (a.im * b.im);
    --prod.im := (a.re * b.im) + (a.im * b.re);
    
    -- optimized
    -- R = (C - S)Y + Z, I = (C + S)X - Z, Z = C(X - Y) (3 multiplications, 3 add/sub)
    -- a = X + jY, b = C + jS  
   
   z := resize(b.re * (a.re - a.im), 9, -6);
   prod.re := resize((b.re - b.im) * a.im + z, 9, -6);
   prod.im := resize((b.re + b.im) * a.re - z, 9, -6);          
   return prod;   
end function;

end pkg_complex;

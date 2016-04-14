library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package pkg_complex is
    type complex is record
        re : real;
        im : real;
    end record;
    type complex_array_8 is array(0 to 7) of complex;
    type complex_array_4 is array(0 to 3) of complex;
    function "+" (a,b: complex) return complex;
    function "-" (a,b: complex) return complex;
    function "*" (a,b: complex) return complex;
end pkg_complex;

package body pkg_complex is

function "+" (a,b: complex) return complex is
    variable sum : complex;
begin
   sum.re := a.re + b.re;
   sum.im := a.im + b.im;
   return sum;
end function;

function "-" (a,b: complex) return complex is
    variable diff : complex;
begin
   diff.re := a.re - b.re;
   diff.im := a.im - b.im;
   return diff;
end function;

function "*" (a, b: complex) return complex is
    variable prod : complex;
    variable z : real;
begin
    -- (R + jI) = (X + jY)(C + jS)
    -- R = XC - YS, I = XS + YC (4 multiplications, 2 add/sub)
    --prod.re := (a.re * b.re) - (a.im * b.im);
    --prod.im := (a.re * b.im) + (a.im * b.re);
    
    -- optimized
    -- R = (C - S)Y + Z, I = (C + S)X - Z, Z = C(X - Y) (3 multiplications, 3 add/sub)
    -- a = X + jY, b = C + jS  
   
   z := b.re * (a.re - a.im);
   prod.re := (b.re - b.im) * a.im + z;
   prod.im := (b.re + b.im) * a.re - z;          
   return prod;
end function;

end pkg_complex;

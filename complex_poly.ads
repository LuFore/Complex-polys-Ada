with Ada.Numerics.generic_Complex_Types;

generic 
	type real is digits <>; --not actually a real type, just a numeric
package complex_poly is
--Maths types & functions
	package complex_pkg is new Ada.Numerics.generic_Complex_Types(real);
	use complex_pkg;
	--Main polynomial type
	--Index of polynomial corrisponds to 
	type polynomial is array(natural range <>) of complex;
	
	type num_array is array(natural range <>) of real;

	czero : constant complex := (0.0,0.0);

--Functions for converting to and from real polynomials
	--real poly -> complex
	function input_real(me:num_array)return polynomial;
	--complex poly -> real;
	function output_real(me:polynomial)return num_array;


--mathmatical types & functions
	--Return the result of the polynomial
	function f(me:polynomial; x:complex) return complex;

	--Following functions will do as expected
	function "+"(left,right:polynomial) return polynomial; 
	function "-"(left,right:polynomial) return polynomial; 
	function "*"(left,right:polynomial) return polynomial; 
	function "/"(left,right:polynomial) return polynomial;
	function "rem"(left,right:polynomial)return polynomial;

	function "+"(left:complex;right:polynomial) return polynomial; 
	function "-"(left:polynomial;right:complex) return polynomial; 
	function "*"(left:complex;right:polynomial) return polynomial; 
	function "/"(left:polynomial;right:complex) return polynomial; 

	function "+"(left:real;right:polynomial) return polynomial; 
	function "-"(left:polynomial;right:real) return polynomial; 
	function "*"(left:real;right:polynomial) return polynomial; 
	function "/"(left:polynomial;right:real) return polynomial;

	function "abs"(left:polynomial) return polynomial;

	--return derivative of current polynomial
	function derivative(me:polynomial) return polynomial;
	
--non-maths types & functions
	--return in string form as (coeffn)x^n..+ (coeff1)x^1 + coeff0
	--function image(me:polynomial) return string;
	
	--reverse the coeffs of a polynomial
	--useful for inputing polynomials, will turn an input of (5.0,1.0,2.0) to 
	--5x**2 + 1x**1 + 2
	function invert(me:polynomial) return polynomial;

	--remove leading 0s 
	function compact(me:polynomial) return polynomial;

	--Used for returning both the remanider and quotient from a polynomial div
	type division_return(Qlast,Rlast:natural) is record
		Q : polynomial(0..Qlast); --quotient
		R : polynomial(0..Rlast); --remanider
	end record;
	--divide, returning type above instead of just Q or R like '/' or rem
	function meta_div(left,right:polynomial) return division_return with
	pre => (left(left'last) /= czero and 
		left'length >= right'length and
		right(right'last) /= czero );


	function image(me:polynomial) return string;

	private
	function leading_i(me:polynomial)return natural;

--check if not leading with a 0 
	function compacted(me:polynomial) return boolean;
	--return the highest power of both polynomials
	function biggest(p1,p2:polynomial)return natural;
	
end complex_poly;

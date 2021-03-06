-- Copyright 2015 Hadrien Grasland
--
-- This file is part of Numerical Cookbook.
--
-- Numerical Cookbook is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- Numerical Cookbook is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with Numerical Cookbook.  If not, see <http://www.gnu.org/licenses/>.


generic
   type Item_Type is private;
   Zero : Item_Type;
   One : Item_Type;
   with function "+" (Left, Right : Item_Type) return Item_Type is <>;
   with function "*" (Left, Right : Item_Type) return Item_Type is <>;
   with function "=" (Left, Right : Item_Type) return Boolean is <>;
package Cookbook.Generic_Containers is

   -- This can be changed to actual vector/matrix classes if the need arises. But that would be inconvenient in Ada as
   -- it is hard to implement custom indexing operators in this language.
   type Vector is array (Index_Type range <>) of Item_Type;
   type Matrix is array (Index_Type range <>, Index_Type range <>) of Item_Type;

   -- Comparison uses the custom equality operator defined in cookbook.ads
   overriding function "=" (Left, Right : Matrix) return Boolean;
   overriding function "=" (Left, Right : Vector) return Boolean;

   -- Multiplication by a scalar is business as usual
   function "*" (Left : Item_Type; Right : Matrix) return Matrix
     with
       Post => ("*"'Result'Length (1) = Right'Length (1) and then "*"'Result'Length (2) = Right'Length (2));
   function "*" (Left : Item_Type; Right : Vector) return Vector
     with
       Post => ("*"'Result'Length = Right'Length);

   -- Product between matrices and vectors follow NR's definition
   function "*" (Left, Right : Matrix) return Matrix
     with
       Pre => (Left'Length (2) = Right'Length (1)),
       Post => ("*"'Result'Length (1) = Left'Length (1) and then "*"'Result'Length (2) = Right'Length (2));
   function "*" (Left : Matrix; Right : Vector) return Vector
     with
       Pre => (Left'Length (2) = Right'Length),
       Post => ("*"'Result'Length = Left'Length (1));
   function "*" (Left : Vector; Right : Matrix) return Vector
     with
       Pre => (Left'Length = Right'Length (1)),
       Post => ("*"'Result'Length = Right'Length (2));
   function "*" (Left, Right : Vector) return Item_Type
     with
       Pre => (Left'Length = Right'Length);

   -- The identity matrix is often useful, so we'll provide a cheap function to generate it
   function Identity_Matrix (Size : Size_Type) return Matrix
     with
       Pre => (Size > 0),
       Post => (Identity_Matrix'Result'Length (1) = Identity_Matrix'Result'Length (2) and then
                      Identity_Matrix'Result'Length (1) = Size);

end Cookbook.Generic_Containers;

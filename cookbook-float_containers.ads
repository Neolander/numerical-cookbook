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


with Cookbook.Generic_Containers;

generic
package Cookbook.Float_Containers is

   package Implementation is new Cookbook.Generic_Containers (Item_Type => Float_Type,
                                                              Zero => 0.0,
                                                              One => 1.0,
                                                              "=" => Cookbook."=");

   subtype Vector is Implementation.Vector;
   subtype Matrix is Implementation.Matrix;

   function Identity_Matrix (Size : Size_Type) return Matrix renames Implementation.Identity_Matrix;

   -- TODO : Implement unit tests once matrix functionality has stabilized

end Cookbook.Float_Containers;

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
package Cookbook.Linear_Equations.LU_Decomp is

   -- LU decompositions are stored inside an opaque object. This allows for storage and stability optimizations.
   type LU_Decomposition (<>) is private;
   function Matrix_Size (LU : LU_Decomposition) return Size_Type;
   function Is_LU_Decomposition_Of (LU : LU_Decomposition; Original_Matrix : F_Containers.Matrix) return Boolean;

   -- LU decomposition may be computed using Crout's algorithm.
   -- As with Gauss-Jordan, the algorithm may throw Singular_Matrix even if all preconditions are satisfied if the input is singular.
   function Crout_LU_Decomposition (Matrix : F_Containers.Matrix) return LU_Decomposition
     with
       Pre => (Is_Square_Matrix (Matrix)),
       Post => (Matrix_Size (Crout_LU_Decomposition'Result) = Matrix'Length (1) and then
                      Is_LU_Decomposition_Of (Crout_LU_Decomposition'Result, Matrix));

   -- Sometimes, it is useful to retrieve the original matrix from an LU decomposition, e.g. to evaluate decomposition quality or verify a contract
   function Compute_Original_Matrix (LU : LU_Decomposition) return F_Containers.Matrix
     with
       Post => (Is_Square_Matrix (Compute_Original_Matrix'Result) and then Compute_Original_Matrix'Result'Length (1) = Matrix_Size (LU));

   -- Efficiently solve linear equation systems involving the previously decomposed matrix for certain right-hand-side vectors
   function Solve (LU : LU_Decomposition; Right_Hand_Vector : F_Containers.Vector) return F_Containers.Vector
     with
       Pre => (Right_Hand_Vector'Length = Matrix_Size (LU)),
       Post => (Solve'Result'Length = Right_Hand_Vector'Length and then
                  Compute_Original_Matrix (LU) * Solve'Result = Right_Hand_Vector);
   function Solve (LU : LU_Decomposition; Right_Hand_Vectors : F_Containers.Matrix) return F_Containers.Matrix
     with
       Pre => (Right_Hand_Vectors'Length (1) = Matrix_Size (LU)),
       Post => (Solve'Result'Length (1) = Right_Hand_Vectors'Length (1) and then Solve'Result'Length (2) = Right_Hand_Vectors'Length (2) and then
                      Compute_Original_Matrix (LU) * Solve'Result = Right_Hand_Vectors);

   -- Compute the inverse of a matrix from its LU decomposition
   function Inverse_Matrix (LU : LU_Decomposition) return F_Containers.Matrix
     with
       Post => (Is_Square_Matrix (Inverse_Matrix'Result) and then Inverse_Matrix'Result'Length (1) = Matrix_Size (LU) and then
                      Inverse_Matrix'Result * Compute_Original_Matrix (LU) = F_Containers.Identity_Matrix (Matrix_Size (LU)));

   -- Compute the determinant of a matrix from its LU decomposition
   function Determinant (LU : LU_Decomposition) return Float_Type;

   -- TODO : Add remaining stuff, with appropriate pre/postconditions

   -- Test the functions within this package
   procedure Test_Child;

private

   -- Ideally, we would specify the matrix offset and size instead of the full matrix bounds, to avoid information duplication between Last_Row
   -- and Last_Col along with a risk of ending up with a non-square matrix in the event of a coding error.
   --
   -- However, the rules of Ada 2012 (RM12 3.8.12/3) forbid the use of expressions containing multiple discriminants, like "First_Row + Mat_Size",
   -- in many scenarios including the definition of array boundaries.
   type Index_Array is array (Index_Type range <>) of Index_Type;
   type LU_Decomposition (First_Row, Last_Row, First_Col, Last_Col : Index_Type) is
      record
         Data : F_Containers.Matrix (First_Row .. Last_Row, First_Col .. Last_Col);
         Determinant_Multiplier : Float_Type;
         Initial_Row_Positions : Index_Array (First_Row .. Last_Row);
         -- TODO : Add components to store permutations, etc.
      end record;
   function Matrix_Size (LU : LU_Decomposition) return Size_Type is
     (LU.Last_Row - LU.First_Row + 1);

   -- First, let's define what we mean by lower-triangular and upper-triangular matrices
   function Is_Lower_Triangular (Matrix : F_Containers.Matrix) return Boolean
     with
       Pre => (Is_Square_Matrix (Matrix));
   function Is_Upper_Triangular (Matrix : F_Containers.Matrix) return Boolean
     with
       Pre => (Is_Square_Matrix (Matrix));

   -- To improve the stability of the algorithm, we do not LU-decompose the original matrix, but a row-wise permutation of it.
   -- This is why we make these useful functions private : they require some care to be used.
   function Lower (LU : LU_Decomposition) return F_Containers.Matrix
     with
       Post => (Is_Square_Matrix (Lower'Result) and then
                      Lower'Result'Length (1) = Matrix_Size (LU) and then
                      Is_Lower_Triangular (Lower'Result));
   function Upper (LU : LU_Decomposition) return F_Containers.Matrix
     with
       Post => (Is_Square_Matrix (Upper'Result) and then
                      Upper'Result'Length (1) = Matrix_Size (LU) and then
                      Is_Upper_Triangular (Upper'Result));
   function Unscramble (LU_Permutation : LU_Decomposition; Scrambled_Matrix : F_Containers.Matrix) return F_Containers.Matrix
     with
       Pre => (LU_Permutation.First_Row = Scrambled_Matrix'First (1) and then LU_Permutation.Last_Row = Scrambled_Matrix'Last (1) and then
                     LU_Permutation.First_Col = Scrambled_Matrix'First (2) and then LU_Permutation.Last_Col = Scrambled_Matrix'Last (2)),
       Post => (Is_Square_Matrix (Unscramble'Result) and then
                      Unscramble'Result'Length (1) = Scrambled_Matrix'Length (1));

end Cookbook.Linear_Equations.LU_Decomp;

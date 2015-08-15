generic
package Cookbook.Linear_Equations.LU_Decomp is

   -- LU decompositions are stored inside an opaque object, which allows for some storage optimizations.
   -- Components are indirectly available through member functions.
   type LU_Decomposition (<>) is private
     with
       Type_Invariant => Lower (LU_Decomposition) * Upper (LU_Decomposition) = Original_Matrix (LU_Decomposition);
   function Matrix_Size (LU : LU_Decomposition) return Size_Type;
   function Lower (LU : LU_Decomposition) return F_Containers.Matrix
     with
       Post => (Lower'Result'Length (1) = Lower'Result'Length (2) and then
                      Lower'Result'Length (1) = Matrix_Size (LU));
   function Upper (LU : LU_Decomposition) return F_Containers.Matrix
     with
       Post => (Upper'Result'Length (1) = Upper'Result'Length (2) and then
                      Upper'Result'Length (1) = Matrix_Size (LU));
   function Original_Matrix (LU : LU_Decomposition) return F_Containers.Matrix
     with
       Post => (Original_Matrix'Result'Length (1) = Original_Matrix'Result'Length (2) and then
                      Original_Matrix'Result'Length (1) = Matrix_Size (LU));

   -- LU decomposition may be computed using Crout's algorithm, and opens many possibilities for efficient computations on the original matrix
   --
   -- As before, the algorithm may throw Singular_Matrix even if all preconditions are satisfied if the input is singular.
   function Crout_LU_Decomposition (Matrix : F_Containers.Matrix) return LU_Decomposition
     with
       Pre => (Matrix'Length (1) = Matrix'Length (2)),
       Post => (Matrix_Size (Crout_LU_Decomposition'Result) = Matrix'Length (1) and then
                      Lower (Crout_LU_Decomposition'Result) * Upper (Crout_LU_Decomposition'Result) = Matrix);
   -- TODO : Add RHS solver, inverse computation, determinant, and all that jazz, with appropriate pre/postconditions


   -- TODO : Once everything has stabilized, test LU decomposition too
   -- procedure Test;

private

   -- Ideally, we would specify the matrix offset and size instead of the full matrix bounds, to avoid information duplication between Last_Row
   -- and Last_Col along with a risk of ending up with a non-square matrix in the event of a coding error.
   --
   -- However, the rules of Ada 2012 (RM12 3.8.12/3) forbid the use of expressions containing multiple discriminants, like "First_Row + Mat_Size",
   -- in many scenarios including the definition of array boundaries.
   type Index_Array is array (Index_Type range <>) of Index_Type;
   type LU_Decomposition (First_Row, Last_Row, First_Col, Last_Col : Index_Type) is
      record
         Decomposition : F_Containers.Matrix (First_Row .. Last_Row, First_Col .. Last_Col);
         Determinant_Multiplier : Float_Type;
         Initial_Row_Positions : Index_Array (First_Row .. Last_Row);
         -- TODO : Add components to store permutations, etc.
      end record;

   function Matrix_Size (LU : LU_Decomposition) return Size_Type is
      (LU.Last_Row - LU.First_Row + 1);

end Cookbook.Linear_Equations.LU_Decomp;
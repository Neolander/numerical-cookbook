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


with Cookbook.Test;

package body Cookbook.Float_Containers is

   use type Matrix, Vector;


   package Test_Runner is new Cookbook.Test;


   procedure Test is
      use Test_Runner;

      procedure Test_Matrix_Equality is
      begin
         declare
            Mat0x0_1 : constant Matrix (2 .. 1, 7 .. 6) := (others => (others => <>));
            Mat0x0_2 : constant Matrix (12 .. 11, 36 .. 35) := (others => (others => <>));
            Mat1x0_1 : constant Matrix (54 .. 54, 22 .. 21) := (others => (others => <>));
            Mat1x0_2 : constant Matrix (42 .. 42, 80 .. 79) := (others => (others => <>));
            Mat0x1_1 : constant Matrix (80 .. 79, 62 .. 62) := (others => (others => <>));
            Mat0x1_2 : constant Matrix (60 .. 59, 42 .. 42) := (others => (others => <>));
         begin
            Test_Element_Property (Mat0x0_1 = Mat0x0_2, "should work with zero-sized matrices");
            Test_Element_Property (Mat1x0_1 = Mat1x0_2, "should work with zero-sized matrices");
            Test_Element_Property (Mat0x1_1 = Mat0x1_2, "should work with zero-sized matrices");
         end;

         declare
            Mat1x1_1 : constant Matrix (3 .. 3, 6 .. 6) := (3 => (6 => 0.1));
            Mat1x1_2 : constant Matrix (7 .. 7, 2 .. 2) := (7 => (2 => 0.1));
            Mat1x1_3 : constant Matrix (69 .. 69, 50 .. 50) := (69 => (50 => 0.2));
         begin
            Test_Element_Property (Mat1x1_1 = Mat1x1_2, "should work with equal 1x1 matrices");
            Test_Element_Property (Mat1x1_1 /= Mat1x1_3, "should work with distinct 1x1 matrices");
         end;

         declare
            Mat1x2_1 : constant Matrix (5 .. 5, 10 .. 11) := (5 => (3.1, 4.1));
            Mat1x2_2 : constant Matrix (27 .. 27, 53 .. 54) := (27 => (3.1, 4.1));
            Mat1x2_3 : constant Matrix (77 .. 77, 85 .. 86) := (77 => (3.2, 4.1));
            Mat1x2_4 : constant Matrix (33 .. 33, 32 .. 33) := (33 => (3.1, 4.2));
            Mat1x2_5 : constant Matrix (56 .. 56, 40 .. 41) := (56 => (3.2, 4.2));
            Mat1x1 : constant Matrix (3 .. 3, 6 .. 6) := (3 => (6 => 0.1));
         begin
            Test_Element_Property (Mat1x2_1 = Mat1x2_2, "should work with equal 1x2 matrices");
            Test_Element_Property (Mat1x2_1 /= Mat1x2_3, "should work with 1x2 matrices differing by first element");
            Test_Element_Property (Mat1x2_1 /= Mat1x2_4, "should work with 1x2 matrices differing by second element");
            Test_Element_Property (Mat1x2_1 /= Mat1x2_5, "should work with 1x2 matrices differing by both elements");
            Test_Element_Property (Mat1x2_1 /= Mat1x1, "should work with matrices of different size");
         end;

         declare
            Mat2x1_1 : constant Matrix (80 .. 81, 92 .. 92) := ((92 => 3.1), (92 => 4.1));
            Mat2x1_2 : constant Matrix (27 .. 28, 33 .. 33) := ((33 => 3.1), (33 => 4.1));
            Mat2x1_3 : constant Matrix (77 .. 78, 12 .. 12) := ((12 => 3.2), (12 => 4.1));
            Mat2x1_4 : constant Matrix (55 .. 56, 55 .. 55) := ((55 => 3.1), (55 => 4.2));
            Mat2x1_5 : constant Matrix (7 .. 8, 2 .. 2) := ((2 => 3.2), (2 => 4.2));
            Mat1x1 : constant Matrix (3 .. 3, 6 .. 6) := (3 => (6 => 0.1));
         begin
            Test_Element_Property (Mat2x1_1 = Mat2x1_2, "should work with equal 2x1 matrices");
            Test_Element_Property (Mat2x1_1 /= Mat2x1_3, "should work with 2x1 matrices differing by first element");
            Test_Element_Property (Mat2x1_1 /= Mat2x1_4, "should work with 2x1 matrices differing by second element");
            Test_Element_Property (Mat2x1_1 /= Mat2x1_5, "should work with 2x1 matrices differing by both elements");
            Test_Element_Property (Mat2x1_1 /= Mat1x1, "should work with matrices of different size");
         end;
      end Test_Matrix_Equality;

      procedure Test_Vector_Equality is
      begin
         declare
            Vec0_1 : constant Vector (55 .. 54) := (others => <>);
            Vec0_2 : constant Vector (2 .. 1) := (others => <>);
         begin
            Test_Element_Property (Vec0_1 = Vec0_2, "should work with vectors of size 0");
         end;

         declare
            Vec1_1 : constant Vector (42 .. 42) := (42 => 0.5);
            Vec1_2 : constant Vector (2 .. 2) := (2 => 0.5);
            Vec1_3 : constant Vector (16 .. 16) := (16 => 0.6);
            Vec0 : constant Vector (55 .. 54) := (others => <>);
         begin
            Test_Element_Property (Vec1_1 = Vec1_2, "should work with equal vectors of size 1");
            Test_Element_Property (Vec1_1 /= Vec1_3, "should work with distinct vectors of size 1");
            Test_Element_Property (Vec1_1 /= Vec0, "should work with vectors of different sizes");
         end;

         declare
            Vec_2_1 : constant Vector (5 .. 6) := (0.1, 0.2);
            Vec_2_2 : constant Vector (86 .. 87) := (0.1, 0.2);
            Vec_2_3 : constant Vector (100 .. 101) := (0.2, 0.2);
            Vec_2_4 : constant Vector (52 .. 53) := (0.1, 0.3);
            Vec_2_5 : constant Vector (24 .. 25) := (0.5, 0.6);
         begin
            Test_Element_Property (Vec_2_1 = Vec_2_2, "should work with equal vectors of size 2");
            Test_Element_Property (Vec_2_1 /= Vec_2_3, "should work with vectors of size 2 differing by first component");
            Test_Element_Property (Vec_2_1 /= Vec_2_4, "should work with vectors of size 2 differing by second component");
            Test_Element_Property (Vec_2_1 /= Vec_2_5, "should work with vectors of size 2 differing by both components");
         end;
      end Test_Vector_Equality;

      procedure Test_Scalar_Matrix_Multiply is
      begin
         declare
            Mat0x0 : constant Matrix (2 .. 1, 7 .. 6) := (others => (others => <>));
            Mat1x0 : constant Matrix (54 .. 54, 22 .. 21) := (others => (others => <>));
            Mat0x1 : constant Matrix (80 .. 79, 62 .. 62) := (others => (others => <>));
         begin
            Test_Element_Property (5.0 * Mat0x0 = Mat0x0, "should work with zero-sized matrices");
            Test_Element_Property (10.0 * Mat1x0 = Mat1x0, "should work with zero-sized matrices");
            Test_Element_Property (0.1 * Mat0x1 = Mat0x1, "should work with zero-sized matrices");
         end;

         declare
            Mat1x1_1 : constant Matrix (3 .. 3, 6 .. 6) := (3 => (6 => 0.1));
         begin
            Test_Element_Property (2.0 * Mat1x1_1 = (3 => (6 => 0.2)), "should work with 1x1 matrices");
         end;

         declare
            Mat1x2 : constant Matrix (5 .. 5, 10 .. 11) := (5 => (3.1, 4.1));
         begin
            Test_Element_Property (6.0 * Mat1x2 = (5 => (18.6, 24.6)), "should work with 1x2 matrices");
         end;

         declare
            Mat2x1 : constant Matrix (80 .. 81, 92 .. 92) := ((92 => 3.1), (92 => 4.1));
         begin
            Test_Element_Property (4.0 * Mat2x1 = ((92 => 12.4), (92 => 16.4)), "should work with 2x1 matrices");
         end;
      end Test_Scalar_Matrix_Multiply;

      procedure Test_Scalar_Vector_Multiply is
      begin
         declare
            Vec0 : constant Vector (55 .. 54) := (others => <>);
         begin
            Test_Element_Property (2.0 * Vec0 = Vec0, "should work with zero-sized vectors");
         end;

         declare
            Vec1 : constant Vector (42 .. 42) := (42 => 0.5);
         begin
            Test_Element_Property (3.0 * Vec1 = (42 => 1.5), "should work with vectors of size 1");
         end;

         declare
            Vec_2 : constant Vector (5 .. 6) := (0.1, 0.2);
         begin
            Test_Element_Property (6.0 * Vec_2 = (0.6, 1.2), "should work with vectors of size 2");
         end;
      end Test_Scalar_Vector_Multiply;

      procedure Test_Matrix_Matrix_Multiply is
      begin
         declare
            Mat0x0_1 : constant Matrix (2 .. 1, 7 .. 6) := (others => (others => <>));
            Mat0x0_2 : constant Matrix (12 .. 11, 36 .. 35) := (others => (others => <>));
            Mat1x0 : constant Matrix (42 .. 42, 80 .. 79) := (others => (others => <>));
            Mat0x1 : constant Matrix (80 .. 79, 62 .. 62) := (others => (others => <>));
         begin
            Test_Element_Property (Mat0x0_1 * Mat0x0_2 = Mat0x0_1, "should work with zero-sized matrices");
            Test_Element_Property (Mat0x1 * Mat1x0 = Mat0x0_1, "should work with zero-sized matrices");
            -- NOTE : The last product would actually produce a 1x1 matrix of implementation-dependent garbage, even if it worked !
         end;

         declare
            Mat1x1_1 : constant Matrix (3 .. 3, 6 .. 6) := (3 => (6 => 0.1));
            Mat1x1_2 : constant Matrix (69 .. 69, 50 .. 50) := (69 => (50 => 0.2));
         begin
            Test_Element_Property (Mat1x1_1 * Mat1x1_2 = (3 => (50 => 0.02)), "should work with 1x1 matrices");
         end;

         declare
            Mat1x1 : constant Matrix (3 .. 3, 6 .. 6) := (3 => (6 => 0.1));
            Mat1x2 : constant Matrix (5 .. 5, 10 .. 11) := (5 => (3.1, 4.1));
         begin
            Test_Element_Property (Mat1x1 * Mat1x2 = (3 => (0.31, 0.41)), "should work with 1x1 and 1x2 matrices");
         end;

         declare
            Mat2x1 : constant Matrix (7 .. 8, 2 .. 2) := ((2 => 3.2), (2 => 4.2));
            Mat1x1 : constant Matrix (3 .. 3, 6 .. 6) := (3 => (6 => 0.1));
            Mat1x2 : constant Matrix (5 .. 5, 10 .. 11) := (5 => (3.1, 4.1));
         begin
            Test_Element_Property (Mat2x1 * Mat1x1 = ((6 => 0.32), (6 => 0.42)), "should work with 2x1 and 1x1 matrices");
            Test_Element_Property (Mat2x1 * Mat1x2 = ((9.92,  13.12),
                                                      (13.02, 17.22)), "should work with 2x1 and 1x2 matrices");
            Test_Element_Property (Mat1x2 * Mat2x1 = (5 => (2 => 27.14)), "should work with 1x2 and 2x1 matrices");
         end;
      end Test_Matrix_Matrix_Multiply;

      procedure Test_Matrix_Vector_Multiply is
      begin
         declare
            Mat0x0 : constant Matrix (2 .. 1, 7 .. 6) := (others => (others => <>));
            Vec0 : constant Vector (55 .. 54) := (others => <>);
         begin
            Test_Element_Property (Mat0x0 * Vec0 = Vec0, "should work will null matrices and vectors");
         end;

         declare
            Mat1x1 : constant Matrix (3 .. 3, 6 .. 6) := (3 => (6 => 0.1));
            Mat2x1 : constant Matrix (7 .. 8, 2 .. 2) := ((2 => 3.2), (2 => 4.2));
            Vec1 : constant Vector (42 .. 42) := (42 => 0.5);
         begin
            Test_Element_Property (Mat1x1 * Vec1 = (3 => 0.05), "should work with 1x1 matrices and vectors of size 1");
            Test_Element_Property (Mat2x1 * Vec1 = (1.6, 2.1), "should work with 2x1 matrices and vectors of size 1");
         end;

         declare
            Mat1x2 : constant Matrix (5 .. 5, 10 .. 11) := (5 => (3.1, 4.1));
            Vec_2 : constant Vector (5 .. 6) := (0.1, 0.2);
         begin
            Test_Element_Property (Mat1x2 * Vec_2 = (5 => 1.13), "should work with 1x2 matrices and vectors of size 2");
         end;
      end Test_Matrix_Vector_Multiply;

      procedure Test_Vector_Matrix_Multiply is
      begin
         declare
            Vec0 : constant Vector (55 .. 54) := (others => <>);
            Mat0x0 : constant Matrix (2 .. 1, 7 .. 6) := (others => (others => <>));
         begin
            Test_Element_Property (Vec0 * Mat0x0 = Vec0, "should work will null matrices and vectors");
         end;

         declare
            Vec1 : constant Vector (42 .. 42) := (42 => 0.5);
            Mat1x1 : constant Matrix (3 .. 3, 6 .. 6) := (3 => (6 => 0.1));
            Mat1x2 : constant Matrix (5 .. 5, 10 .. 11) := (5 => (3.1, 4.1));
         begin
            Test_Element_Property (Vec1 * Mat1x1 = (42 => 0.05), "should work with vectors of size 1 and 1x1 matrices");
            Test_Element_Property (Vec1 * Mat1x2 = (1.55, 2.05), "should work with vectors of size 1 and 1x2 matrices");
         end;

         declare
            Vec_2 : constant Vector (5 .. 6) := (0.1, 0.2);
            Mat2x1 : constant Matrix (7 .. 8, 2 .. 2) := ((2 => 3.2), (2 => 4.2));
         begin
            Test_Element_Property (Vec_2 * Mat2x1 = (1 => 1.16), "should work with vectors of size 2 and 2x1 matrices");
         end;
      end Test_Vector_Matrix_Multiply;

      procedure Test_Vector_Vector_Multiply is
      begin
         declare
            Vec0_1 : constant Vector (55 .. 54) := (others => <>);
            Vec0_2 : constant Vector (2 .. 1) := (others => <>);
         begin
            Test_Element_Property (Vec0_1 * Vec0_2 = 0.0, "should work with null vectors (!)");
         end;

         declare
            Vec1_1 : constant Vector (42 .. 42) := (42 => 0.5);
            Vec1_2 : constant Vector (16 .. 16) := (16 => 0.6);
         begin
            Test_Element_Property (Vec1_1 * Vec1_2 = 0.3, "should work with vectors of size 1");
         end;

         declare
            Vec_2_1 : constant Vector (5 .. 6) := (0.1, 0.2);
            Vec_2_2 : constant Vector (24 .. 25) := (0.5, 0.6);
         begin
            Test_Element_Property (Vec_2_1 * Vec_2_2 = 0.17, "should work with vectors of size 2");
         end;
      end Test_Vector_Vector_Multiply;

      procedure Test_Identity_Matrix is
      begin
         -- NOTE : 0x0 identity matrices are forbidden by a precondition, so we don't have to test for them

         declare
            Id_1x1 : constant Matrix := Identity_Matrix (1);
         begin
            Test_Element_Property (Id_1x1'Length (1) = 1, "should produce 1x1 identity matrices");
            Test_Element_Property (Id_1x1'Length (2) = 1, "should produce 1x1 identity matrices");
            Test_Element_Property (Id_1x1 (Id_1x1'First (1), Id_1x1'First (2)) = 1.0, "should produce 1x1 identity matrices");
         end;

         declare
            Id_2x2 : constant Matrix := Identity_Matrix (2);
         begin
            Test_Element_Property (Id_2x2 = ((1.0, 0.0), (0.0, 1.0)), "should produce 2x2 identity matrices");
         end;
      end Test_Identity_Matrix;

      procedure Test_Containers_Package is
      begin
         Test_Package_Element (To_Entity_Name ("Matrix_Equality"), Test_Matrix_Equality'Access);
         Test_Package_Element (To_Entity_Name ("Vector_Equality"), Test_Vector_Equality'Access);
         Test_Package_Element (To_Entity_Name ("Scalar_Matrix_Multiply"), Test_Scalar_Matrix_Multiply'Access);
         Test_Package_Element (To_Entity_Name ("Scalar_Vector_Multiply"), Test_Scalar_Vector_Multiply'Access);
         Test_Package_Element (To_Entity_Name ("Matrix_Matrix_Multiply"), Test_Matrix_Matrix_Multiply'Access);
         Test_Package_Element (To_Entity_Name ("Matrix_Vector_Multiply"), Test_Matrix_Vector_Multiply'Access);
         Test_Package_Element (To_Entity_Name ("Vector_Matrix_Multiply"), Test_Vector_Matrix_Multiply'Access);
         Test_Package_Element (To_Entity_Name ("Vector_Vector_Multiply"), Test_Vector_Vector_Multiply'Access);
         Test_Package_Element (To_Entity_Name ("Identity_Matrix"), Test_Identity_Matrix'Access);
      end Test_Containers_Package;
   begin
      Test_Package (To_Entity_Name ("Float_Containers"), Test_Containers_Package'Access);
   end Test;

begin

   -- Automatically test the package when it is included
   Test_Runner.Elaboration_Self_Test (Test'Access);

end Cookbook.Float_Containers;

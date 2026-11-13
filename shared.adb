package body Shared is

   protected body Data is

      procedure Set_Distances (F, B, L, R : Distance_cm) is
      begin
         Front := F;
         Back  := B;
         Left  := L;
         Right := R;
      end Set_Distances;

      procedure Get_Distances (F, B, L, R : out Distance_cm) is
      begin
         F := Front;
         B := Back;
         L := Left;
         R := Right;
      end Get_Distances;

      procedure Set_Direction (D : Directions) is
      begin
         Dir := D;
      end Set_Direction;

      function Get_Direction return Directions is
      begin
         return Dir;
      end Get_Direction;

   end Data;

end Shared;
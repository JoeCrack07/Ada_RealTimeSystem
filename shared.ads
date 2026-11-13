with MicroBit.Types; use MicroBit.Types;
with MicroBit.MyMotorDriver; use MicroBit.MyMotorDriver;

package Shared is

   protected Data is
      procedure Set_Distances (F, B, L, R : Distance_cm);
      procedure Get_Distances (F, B, L, R : out Distance_cm);
      procedure Set_Direction (D : Directions);
      function Get_Direction return Directions;
   private
      Front : Distance_cm := 0;
      Back  : Distance_cm := 0;
      Left  : Distance_cm := 0;
      Right : Distance_cm := 0;
      Dir   : Directions := Stop;
   end Data;

end Shared;
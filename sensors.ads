with MicroBit.Types; use MicroBit.Types;

package Sensors is

   procedure Read_Front (Front : out Distance_cm);
   procedure Read_Back  (Back  : out Distance_cm);
   procedure Read_Left  (Left  : out Distance_cm);
   procedure Read_Right (Right : out Distance_cm);

   --procedure Read_All (Front, Back, Left, Right : out Distance_cm);

end Sensors;
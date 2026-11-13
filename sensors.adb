with MicroBit;
with MicroBit.Ultrasonic;

package body Sensors is

   package Front_Sensor is new MicroBit.Ultrasonic (MicroBit.MB_P0,  MicroBit.MB_P1);
   package Back_Sensor  is new MicroBit.Ultrasonic (MicroBit.MB_P2,  MicroBit.MB_P16);
   package Left_Sensor  is new MicroBit.Ultrasonic (MicroBit.MB_P14, MicroBit.MB_P15);
   package Right_Sensor is new MicroBit.Ultrasonic (MicroBit.MB_P12, MicroBit.MB_P13);

   procedure Read_Front (Front : out Distance_cm) is
   begin
      Front := Front_Sensor.Read;
   end Read_Front;

   procedure Read_Back (Back : out Distance_cm) is
   begin
      Back := Back_Sensor.Read;
   end Read_Back;

   procedure Read_Left (Left : out Distance_cm) is
   begin
      Left := Left_Sensor.Read;
   end Read_Left;

   procedure Read_Right (Right : out Distance_cm) is
   begin
      Right := Right_Sensor.Read;
   end Read_Right;
   

  -- procedure Read_All (Front, Back, Left, Right : out Distance_cm) is
  -- begin
      Front := Front_Sensor.Read;
      Back  := Back_Sensor.Read;
      Left  := Left_Sensor.Read;
      Right := Right_Sensor.Read;
  -- end Read_All;

end Sensors;
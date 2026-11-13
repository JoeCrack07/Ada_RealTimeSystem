with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MyMotorDriver; use MicroBit.MyMotorDriver;
with Shared; use Shared;
with Sense;
with Think;
with Act;

procedure Main is
   pragma Priority (0);
   F, B, L, R : Distance_cm;
   Next   : Time := Clock;
   Period : constant Time_Span := Milliseconds (500);
   
begin
   loop
      Data.Get_Distances (F, B, L, R);
          Put_Line ("Front:" & Distance_cm'Image (F) &
               " Back:" & Distance_cm'Image (B) &
               " Left:" & Distance_cm'Image (L) &
               " Right:" & Distance_cm'Image (R) &
               " Dir: " & Directions'Image (Data.Get_Direction));

      Next := Next + Period;
      delay until Next;
   end loop;
end Main;
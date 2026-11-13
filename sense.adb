with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Types; use MicroBit.Types;
with Sensors;
with Shared; use Shared;
with MicroBit.Console; use MicroBit.Console;

package body Sense is

   task body Sense_Task is
      Next   : Time := Clock;
      Period : constant Time_Span := Milliseconds (100);
      F, B, L, R : Distance_cm := 0;
      New_Value  : Distance_cm;
      F_Zeros, B_Zeros, L_Zeros, R_Zeros : Natural := 0;
      Turn   : Natural range 0 .. 2 := 0;
      
      -- Måling
      Start : Time;
      Max_C : Time_Span := Time_Span_Zero;

      -- 0 betyr ingen ekko. Behold forrige verdi til
      -- limit nuller på rad, da tolkes det som fritt.
      procedure Update (Value : Distance_cm;
                        Old   : in out Distance_cm;
                        Zeros : in out Natural;
                        Limit : Natural) is
      begin
         if Value /= 0 then
            Old := Value;
            Zeros := 0;
         else
            if Zeros < Limit then
               Zeros := Zeros + 1;
            end if;
            if Zeros >= Limit then
               Old := 0;
            end if;
         end if;
      end Update;


   begin
      loop

      Start := Clock;

         -- fronten leses hver gang (3 nuller = 300 ms)
         Sensors.Read_Front (New_Value);
         Update (New_Value, F, F_Zeros, 3);

         -- de andre leses hver tredje gang (2 nuller = 600 ms)
         case Turn is
            when 0 =>
               Sensors.Read_Back (New_Value);
               Update (New_Value, B, B_Zeros, 2);
            when 1 =>
               Sensors.Read_Left (New_Value);
               Update (New_Value, L, L_Zeros, 2);
            when 2 =>
               Sensors.Read_Right (New_Value);
               Update (New_Value, R, R_Zeros, 2);
         end case;
         Turn := (Turn + 1) mod 3;

         Data.Set_Distances (F, B, L, R);
         
         -- Måling
         if Clock - Start > Max_C then
            Max_C := Clock - Start;
            Put_Line ("Sense max C (us):" &
            Integer'Image (Integer (To_Duration (Max_C) * 1_000_000)));
         end if;

         Next := Next + Period;
         if Next < Clock then
            Next := Clock;  -- for å ikke prøve å ta igjen en treig avlesnin
         end if;
         delay until Next;
      end loop;
   end Sense_Task;

end Sense;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MyMotorDriver; use MicroBit.MyMotorDriver;
with Shared; use Shared;
with MicroBit.Console; use MicroBit.Console;


package body Think is

   task body Think_Task is
      Next   : Time := Clock;
      Period : constant Time_Span := Milliseconds (100);
      F, B, L, R : Distance_cm;

      -- Måling
      Start : Time;
      Max_C : Time_Span := Time_Span_Zero;

      -- plass på en av sidene? (0 = fritt)
      function Side_Free return Boolean is
      begin
         return (L = 0 or L > 20) or (R = 0 or R > 20);
      end Side_Free;

      -- snu mot siden med mest plass
      function Best_Turn return Directions is
      begin
         if L = 0 or (R /= 0 and L > R) then
            return Rotating_Left;
         else
            return Rotating_Right;
         end if;
      end Best_Turn;

   begin
      loop

               Start := Clock;
         Data.Get_Distances (F, B, L, R);

         if Data.Get_Direction = Rotating_Left or Data.Get_Direction = Rotating_Right then
            -- snur, fortsett samme vei til fronten er fri
            if F = 0 or F > 55 then
               Data.Set_Direction (Forward);
            end if;

         elsif Data.Get_Direction = Backward then
            -- rygger ut av blindvei, snur når en side åpner seg,
            -- eller når det ikke er plass til å rygge mer
            if Side_Free or (B /= 0 and B < 15) then
               Data.Set_Direction (Best_Turn);
            end if;

         elsif F /= 0 and F < 40 then
            -- noe foran
            if Side_Free then
               Data.Set_Direction (Best_Turn);      -- vanlig hindring, snu
            elsif B = 0 or B > 20 then
               Data.Set_Direction (Backward);       -- blindvei, rygg ut
            else
               Data.Set_Direction (Best_Turn);      -- helt innestengt, snu på stedet
            end if;

         else
            Data.Set_Direction (Forward);
         end if;

         Next := Next + Period;

           -- Måling
         if Clock - Start > Max_C then
            Max_C := Clock - Start;
            Put_Line ("Think max C (us):" &
            Integer'Image (Integer (To_Duration (Max_C) * 1_000_000)));
         end if;

         delay until Next;
      end loop;
   end Think_Task;

end Think;
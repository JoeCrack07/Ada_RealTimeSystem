with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.MyMotorDriver; use MicroBit.MyMotorDriver;
with Shared; use Shared;
with MicroBit.Console; use MicroBit.Console;

package body Act is

   task body Act_Task is
      Next   : Time := Clock;
      Period : constant Time_Span := Milliseconds (100);
      -- Måling
      Start : Time;
      Max_C : Time_Span := Time_Span_Zero;
   
   begin
      loop
         Start := Clock;
         Drive (Data.Get_Direction, (2000, 2000, 2000, 2000));
         Next := Next + Period;

                  -- Måling
                  if Clock - Start > Max_C then
                     Max_C := Clock - Start;
                     Put_Line ("Act max C (us):" &
                     Integer'Image (Integer (To_Duration (Max_C) * 1_000_000)));
                  end if;

         delay until Next;
      end loop;
   end Act_Task;

end Act;
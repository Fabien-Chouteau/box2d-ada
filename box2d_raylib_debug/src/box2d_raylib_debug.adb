with Ada.Numerics.Generic_Elementary_Functions;
--  with Ada.Text_IO; use Ada.Text_IO;
with System;
with Raylib; use Raylib;
with Box2D; use Box2D;
with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

package body Box2D_Raylib_Debug is

   package C_float_Funcs
   is new Ada.Numerics.Generic_Elementary_Functions (C_float);
   use C_float_Funcs;

   procedure DrawPolygonCallback (vertices    : access Vec2_Array_Indef;
                                  vertexCount : Interfaces.C.int;
                                  color       : HexColor;
                                  context     : System.Address)
     with Convention => C;

   procedure DrawSolidPolygonCallback (transform_p : Box2D.Transform;
                                       vertices : access Vec2_Array_Indef;
                                       vertexCount : Interfaces.C.int;
                                       radius : Interfaces.C.C_float;
                                       color : HexColor;
                                       context : System.Address)
     with Convention => C;

   procedure DrawCircleCallback (center  : Vec2;
                                 radius  : Interfaces.C.C_float;
                                 color   : HexColor;
                                 context : System.Address)
     with Convention => C;

   procedure DrawSolidCircleCallback  (transform_p : Box2D.Transform;
                                       radius : Interfaces.C.C_float;
                                       color : HexColor;
                                       context : System.Address)
     with Convention => C;

   procedure DrawSolidCapsuleCallback (p1 : Vec2; p2 : Vec2;
                                       radius : Interfaces.C.C_float;
                                       color : HexColor;
                                       context : System.Address)
     with Convention => C;

   procedure DrawSegmentCallback (p1 : Vec2; p2 : Vec2;
                                  color : HexColor;
                                  context : System.Address)
     with Convention => C;

   procedure DrawTransformCallback (transform_p : Box2D.Transform;
                                    context : System.Address)
     with Convention => C;

   procedure DrawPointCallback (p : Vec2;
                                size : Interfaces.C.C_float;
                                color : HexColor;
                                context : System.Address)
     with Convention => C;

   procedure DrawStringCallback (p : Vec2;
                                 s : Interfaces.C.Strings.chars_ptr;
                                 color : HexColor;
                                 context : System.Address)
     with Convention => C;

   pragma Suppress_All;

   ----------------------
   -- Setup_Draw_Debug --
   ----------------------

   procedure Setup_Draw_Debug (DBG : in out Box2D.DebugDraw) is
   begin
      DBG.DrawPolygonFcn := DrawPolygonCallback'Unrestricted_Access;
      DBG.DrawSolidPolygonFcn := DrawSolidPolygonCallback'Unrestricted_Access;
      DBG.DrawCircleFcn := DrawCircleCallback'Unrestricted_Access;
      DBG.DrawSolidCircleFcn := DrawSolidCircleCallback'Unrestricted_Access;
      DBG.DrawSolidCapsuleFcn := DrawSolidCapsuleCallback'Unrestricted_Access;
      DBG.DrawSegmentFcn := DrawSegmentCallback'Unrestricted_Access;
      DBG.DrawTransformFcn := DrawTransformCallback'Unrestricted_Access;
      DBG.DrawPointFcn := DrawPointCallback'Unrestricted_Access;
      DBG.DrawStringFcn := DrawStringCallback'Unrestricted_Access;
   end Setup_Draw_Debug;

   ---------------------
   -- To_Raylib_Color --
   ---------------------

   function To_Raylib_Color (Color : HexColor) return Raylib.Color is
      use Interfaces;

      Hex : constant Unsigned_32 := Color'Enum_Rep;
   begin
      return (r => unsigned_char (Shift_Right (Hex, 16) and 16#FF#),
              g => unsigned_char (Shift_Right (Hex, 8) and 16#FF#),
              b => unsigned_char (Shift_Right (Hex, 0) and 16#FF#),
              a => 16#FF#);
   end To_Raylib_Color;

   ---------------
   -- Draw_Line --
   ---------------

   procedure Draw_Line (P1, P2 : Vec2; Color : Raylib.Color) is
      RP1 : constant Raylib.Vector2 := To_Raylib (P1);
      RP2 : constant Raylib.Vector2 := To_Raylib (P2);
   begin
      Raylib.DrawLine
        (startPosX => int (RP1.x),
         startPosY => int (RP1.y),
         endPosX   => int (RP2.x),
         endPosY   => int (RP2.y),
         color_p   => Color);
   end Draw_Line;

   -------------------------
   -- DrawPolygonCallback --
   -------------------------

   procedure DrawPolygonCallback (vertices    : access Vec2_Array_Indef;
                                  vertexCount : Interfaces.C.int;
                                  color       : HexColor;
                                  context     : System.Address)
   is
      pragma Unreferenced (context);
      Last : unsigned;
      Prev : Vec2;
      Next : Vec2;
   begin
      --  Put_Line ("DrawPolygonCallback vertexCount:" & vertexCount'Img);
      if vertexCount < 2 then
         return;
      end if;

      Last := unsigned (vertexCount) - 1;
      Prev := vertices (Last);
      for Idx in unsigned range 0 .. Last loop
         Next := vertices (Idx);
         Draw_Line (Prev, Next, To_Raylib_Color (color));
         Prev := Next;
      end loop;
   end DrawPolygonCallback;

   ------------------------------
   -- DrawSolidPolygonCallback --
   ------------------------------

   procedure DrawSolidPolygonCallback (transform_p : Box2D.Transform;
                                       vertices : access Vec2_Array_Indef;
                                       vertexCount : Interfaces.C.int;
                                       radius : Interfaces.C.C_float;
                                       color : HexColor;
                                       context : System.Address)
   is
      pragma Unreferenced (context);
      Last : unsigned;
      Prev : Vec2;
      Next : Vec2;
   begin
      --  Put_Line ("DrawSolidPolygonCallback vertexCount:" & vertexCount'Img &
      --           " radius:" & radius'Img);

      if vertexCount < 2 then
         return;
      end if;

      Last := unsigned (vertexCount) - 1;
      Prev := TransformPoint (transform_p, vertices (Last));
      for Idx in unsigned range 0 .. Last loop
         Next := TransformPoint (transform_p, vertices (Idx));
         Draw_Line (Prev, Next, To_Raylib_Color (color));
         Prev := Next;
      end loop;
   end DrawSolidPolygonCallback;

   ------------------------
   -- DrawCircleCallback --
   ------------------------

   procedure DrawCircleCallback (center  : Vec2;
                                 radius  : Interfaces.C.C_float;
                                 color   : HexColor;
                                 context : System.Address)
   is
      pragma Unreferenced (context);
      Dst : constant Raylib.Vector2 := To_Raylib (center);
   begin
      --  Put_Line ("DrawCircleCallback center.x:" & center.x'Img &
      --           "center.y:" & center.y'Img & " radius:" & radius'Img);
      DrawCircleLines (int (Dst.x),
                       int (Dst.y),
                       radius,
                       To_Raylib_Color (color));
   end DrawCircleCallback;

   -----------------------------
   -- DrawSolidCircleCallback --
   -----------------------------

   procedure DrawSolidCircleCallback  (transform_p : Box2D.Transform;
                                       radius : Interfaces.C.C_float;
                                       color : HexColor;
                                       context : System.Address)
   is
      pragma Unreferenced (context);

      angle : constant C_float := GetAngle (transform_p.q);
      Dst : constant Raylib.Vector2 := To_Raylib (transform_p.p);
      SX : constant int := int (Dst.x);
      SY : constant int := int (Dst.y);
      EX : constant int := int (Dst.x + Cos (-angle) * radius);
      EY : constant int := int (Dst.y + Sin (-angle) * radius);
   begin
      --  Put_Line ("DrawSolidCircleCallback center.x:" & transform_p.p.x'Img &
      --           "center.y:" & transform_p.p.y'Img & " radius:" & radius'Img);
      DrawCircle (SX, SY, radius, To_Raylib_Color (color));
      DrawLine (SX, SY, EX, EY, Raylib.BLACK);
   end DrawSolidCircleCallback;

   ------------------------------
   -- DrawSolidCapsuleCallback --
   ------------------------------

   procedure DrawSolidCapsuleCallback (p1 : Vec2; p2 : Vec2;
                                       radius : Interfaces.C.C_float;
                                       color : HexColor;
                                       context : System.Address)
   is
      pragma Unreferenced (context);
      RP1 : constant Raylib.Vector2 := To_Raylib (p1);
      RP2 : constant Raylib.Vector2 := To_Raylib (p2);
      Center : constant Raylib.Vector2 := To_Raylib ((p1 + p2) / 2.0);
      R : constant C_float := GetSegmentAngle (p1, p2);

      Height : constant C_float := radius * 2.0;
      Width : constant C_float := Length (p1 - p2);
      Rect : constant Raylib.Rectangle :=
        (Center.x, Center.y, Height, Width);
   begin
      --  Put_Line ("DrawSolidCapsuleCallback");
      DrawCircle (int (RP1.x), int (RP1.y), radius, To_Raylib_Color (color));
      DrawCircle (int (RP2.x), int (RP2.y), radius, To_Raylib_Color (color));
      DrawRectanglePro
        (rec      => Rect,
         origin   => (Height / 2.0, Width / 2.0),
         rotation => RadToDeg (R),
         color_p  => To_Raylib_Color (color));
   end DrawSolidCapsuleCallback;

   -------------------------
   -- DrawSegmentCallback --
   -------------------------

   procedure DrawSegmentCallback (p1 : Vec2; p2 : Vec2;
                                  color : HexColor;
                                  context : System.Address)
   is
      pragma Unreferenced (context);
   begin
      --  Put_Line ("DrawSegmentCallback");
      Draw_Line (p1, p2, To_Raylib_Color (color));
   end DrawSegmentCallback;

   ---------------------------
   -- DrawTransformCallback --
   ---------------------------

   procedure DrawTransformCallback (transform_p : Box2D.Transform;
                                    context : System.Address)
   is
      pragma Unreferenced (context);
      axisScale : constant := 0.2;
      P1 : constant Vec2 := transform_p.p;
      P2 : Vec2 := MulAdd (P1, axisScale, GetXAxis (transform_p.q));
   begin
      --  Put_Line ("DrawTransformCallback");
      Draw_Line (P1, P2, Raylib.RED);

      P2 := MulAdd (P1, axisScale, GetYAxis (transform_p.q));
      Draw_Line (P1, P2, Raylib.GREEN);
   end DrawTransformCallback;

   -----------------------
   -- DrawPointCallback --
   -----------------------

   procedure DrawPointCallback (p : Vec2;
                                size : Interfaces.C.C_float;
                                color : HexColor;
                                context : System.Address)
   is
      pragma Unreferenced (context);
      RP : constant Raylib.Vector2 := To_Raylib (p);
   begin
      --  Put_Line ("DrawPointCallback");
      DrawCircle (int (RP.x),
                  int (RP.y),
                  size,
                  To_Raylib_Color (color));
   end DrawPointCallback;

   ------------------------
   -- DrawStringCallback --
   ------------------------

   procedure DrawStringCallback (p : Vec2;
                                 s : Interfaces.C.Strings.chars_ptr;
                                 color : HexColor;
                                 context : System.Address)
   is
      pragma Unreferenced (context);
      RP : constant Raylib.Vector2 := To_Raylib (p);
   begin
      --  Put_Line ("DrawStringCallback");
      Raylib.DrawText
        (text     => s,
         posX     => int (RP.x),
         posY     => int (RP.y),
         fontSize => 8,
         color_p  => To_Raylib_Color (color));
   end DrawStringCallback;

end Box2D_Raylib_Debug;

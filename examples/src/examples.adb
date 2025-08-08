with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO; use Ada.Text_IO;
with Interfaces.C; use Interfaces.C;

with Box2D; use Box2D;
with Raylib;
with Box2D_Raylib_Debug;

procedure Examples is
   Width  : constant := 800;
   Height : constant := 600;

   World_Def : aliased WorldDef := DefaultWorldDef;
   World_Id : WorldId;

   Ground_Body_Def : aliased BodyDef := DefaultBodyDef;
   Ground_Id : BodyId;
   Ground_Box : aliased Polygon;

   Ground_Shape_Def : aliased ShapeDef := DefaultShapeDef;

   Body_Def : aliased BodyDef := DefaultBodyDef;
   Body_Id : BodyId;
   Dynamic_Box : aliased Polygon;

   Shape_Def : aliased ShapeDef := DefaultShapeDef;

   Debug_Draw : aliased DebugDraw := DefaultDebugDraw;

   C : aliased Circle;
   Cap : aliased Capsule;

   ---------------
   -- To_Raylib --
   ---------------

   function To_Raylib (Pos : Vec2) return Raylib.Vector2 is
   begin
      return (Pos.x, C_float (Height) - Pos.y);
   end To_Raylib;

   package Dbg_Draw is new Box2D_Raylib_Debug (To_Raylib);
begin
   Debug_Draw.drawShapes := True;
   Debug_Draw.drawBodyNames := True;
   Debug_Draw.drawBounds := True;
   Debug_Draw.drawShapes := True;
   Debug_Draw.drawJoints := True;
   Debug_Draw.drawJointExtras := True;
   Debug_Draw.drawBounds := True;
   Debug_Draw.drawMass := False;
   Debug_Draw.drawBodyNames := True;
   Debug_Draw.drawContacts := True;
   Debug_Draw.drawGraphColors := True;
   Debug_Draw.drawContactNormals := True;
   Debug_Draw.drawContactImpulses := True;
   Debug_Draw.drawContactFeatures := True;
   Debug_Draw.drawFrictionImpulses := True;
   Debug_Draw.drawIslands := True;

   Dbg_Draw.Setup_Draw_Debug (Debug_Draw);

   World_Def.gravity := (0.0, -10.0);
   World_Id := CreateWorld (World_Def'Access);

   Ground_Body_Def.position := (C_float (Width) / 2.0,
                                C_float (Height) / 2.0);
   Ground_Body_Def.rotation := MakeRot (DegToRad (20.0));
   Ground_Id := CreateBody (World_Id, Ground_Body_Def'Access);
   Ground_Box := MakeBox (230.0, 10.0);

   Ground_Shape_Def.material.restitution := 1.1;

   CreatePolygonShape (Ground_Id,
                       Ground_Shape_Def'Access,
                       Ground_Box'Access);

   Body_Def.type_K := B2_dynamicBody;
   Body_Def.position := (400.0, 400.0);
   Body_Id := CreateBody (World_Id, Body_Def'Access);
   Body_SetName (Body_Id, "Bob");

   Dynamic_Box := MakeBox (10.0, 10.0);
   Shape_Def.density := 1.0;
   Shape_Def.material.friction := 0.3;

   C.center := (0.0, 0.0);
   C.radius := 50.0;
   --  CreateCircleShape (Body_Id, Shape_Def'Access, C'Access);

   Cap.center1 := (-20.0, 0.0);
   Cap.center2 := (20.0, 0.0);
   Cap.radius := (10.0);
   CreateCapsuleShape (Body_Id, Shape_Def'Access, Cap'Access);
   --  CreatePolygonShape (Body_Id, Shape_Def'Access, Dynamic_Box'Access);

   Raylib.InitWindow (Width, Height, "Box2D Example");

   declare
      SPS : constant := 60.0;
      Period : constant Ada.Real_Time.Time_Span :=
        Ada.Real_Time.Milliseconds (1000 / Integer (SPS));

      Next_Release : Ada.Real_Time.Time;
   begin

      Next_Release := Ada.Real_Time.Clock + Period;

      while not Raylib.WindowShouldClose loop
         delay until Next_Release;
         Next_Release := Next_Release + Period;

         World_Step (World_Id, 1.0 / SPS, 4);
         Put_Line (Body_GetPosition (Body_Id).x'Img & " " &
                   Body_GetPosition (Body_Id).y'Img & " " &
                   GetAngle (Body_GetRotation (Body_Id))'Img & " ");
         Raylib.BeginDrawing;
         Raylib.ClearBackground (Raylib.BLACK);
         Raylib.DrawFPS (0, 0);

         Put_Line ("=== Start Debug Draw ===");
         World_Draw (World_Id, Debug_Draw'Access);
         Raylib.EndDrawing;

      end loop;
   end;

   Raylib.CloseWindow;
   DestroyWorld (World_Id);
end Examples;

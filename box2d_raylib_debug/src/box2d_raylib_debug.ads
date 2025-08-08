with Box2D;
with Raylib;

generic
   with function To_Raylib (Pos : Box2D.Vec2) return Raylib.Vector2;
package Box2D_Raylib_Debug is

   procedure Setup_Draw_Debug (DBG : in out Box2D.DebugDraw);
   --  This procedure will fill the drawing callbacks of the given DebugDraw struct
   --  You can then call:
   --    Box2D.World_Draw (World_Id, DBG'Access);
   --  inside a Raylib drawing section.

end Box2D_Raylib_Debug;

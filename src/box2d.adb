package body Box2D is
   pragma Linker_Options ("-lbox2d");
   pragma Linker_Options ("-lm");
   pragma Style_Checks ("M2000");
   function InternalAssertFcn (condition : String; fileName : String; lineNumber : Interfaces.C.int) return Interfaces.C.int is
      use Interfaces.C.Strings;
      C_condition : Interfaces.C.Strings.chars_ptr := New_String (condition);
      C_fileName : Interfaces.C.Strings.chars_ptr := New_String (fileName);
      Result : constant Interfaces.C.int := InternalAssertFcn (C_condition, C_fileName, lineNumber);
   begin
      Free (C_condition);
      Free (C_fileName);
      return Result;
   end InternalAssertFcn;

   procedure Body_SetName (bodyId_p : BodyId; name : String) is
      use Interfaces.C.Strings;
      C_name : Interfaces.C.Strings.chars_ptr := New_String (name);
   begin
      Body_SetName (bodyId_p, C_name);
      Free (C_name);
   end Body_SetName;


   function GetLengthAndNormalize(Length : out C_float; V : Vec2) return Vec2 is
      Inv : C_float;
   begin
      Length := Box2D.Length (V);
      if Length < C_float'Model_Epsilon then
         return (0.0, 0.0);
      else
         Inv := 1.0 / Length;
         return (Inv * V.x, Inv * V.y);
      end if;
   end GetLengthAndNormalize;

end Box2D;

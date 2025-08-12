#!/usr/bin/env python3

import json
import re
import os
import copy
import os

CRATE_ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")

ADA_KEYWORD = ["end", "type", "body", "out", "task"]

NEED_INDEF_ARRAY = [
    "Vec2",
    "ContactBeginTouchEvent",
    "SensorBeginTouchEvent",
    "SensorEndTouchEvent",
    "ContactBeginTouchEvent",
    "ContactEndTouchEvent",
    "ContactHitEvent",
    "BodyMoveEvent",
    "JointEvent",
]

JOINT_TYPES = [
    "DistanceJoint",
    "MotorJoint",
    "RevoluteJoint",
    "PrismaticJoint",
    "MouseJoint",
    "FilterJoint",
    "WeldJoint",
    "WheelJoint",
]

TYPE_CONVERSION = {
    "void": None,
    "char": "Interfaces.C.char",
    "bool": "Interfaces.C.C_bool",
    "float": "Interfaces.C.C_float",
    "double": "Interfaces.C.double",
    "long": "Interfaces.C.long",
    "float *": "access Interfaces.C.C_float",
    "float*": "access Interfaces.C.C_float",
    "int": "Interfaces.C.int",
    "int *": "access Interfaces.C.int",
    "const int *": "access constant Interfaces.C.int",
    "char *": "Interfaces.C.Strings.chars_ptr",
    "const char *": "Interfaces.C.Strings.chars_ptr",
    "unsigned int": "Interfaces.C.unsigned",
    "unsigned int *": "access Interfaces.C.unsigned",
    "unsigned char": "Interfaces.C.unsigned_char",
    "unsigned char *": "access Interfaces.C.char",
    "unsigned short": "Interfaces.C.short",
    "unsigned short *": "access Interfaces.C.short",
    "void *": "System.Address",
    "const void *": "System.Address",
    "const unsigned char *": "System.Address",
    "int64_t": "Interfaces.Integer_64",
    "int32_t": "Interfaces.Integer_32",
    "int16_t": "Interfaces.Integer_16",
    "int8_t": "Interfaces.Integer_8",
    "uint64_t": "Interfaces.Unsigned_64",
    "uint32_t": "Interfaces.Unsigned_32",
    "uint16_t": "Interfaces.Unsigned_16",
    "uint8_t": "Interfaces.Unsigned_8",
    "uint8_t[3]": "Chars_Array_3",
    "ManifoldPoint[2]": "ManifoldPoint_Array_2",
    "int[24]": "Int_Array_24",
    "int[12]": "Int_Array_12",
}

TYPE_IDENTITY = []

for typ in []:
    TYPE_CONVERSION[f"{typ}*"] = typ
    TYPE_CONVERSION[f"{typ} *"] = typ
    TYPE_CONVERSION[f"struct {typ} *"] = typ
    TYPE_CONVERSION[f"const {typ} *"] = typ


def b2strip(name):
    if name.startswith("b2"):
        return name[2:]
    else:
        return name


def to_ada_type(c_type, name=None, parent=None):

    c_type = b2strip(c_type)

    # print(c_type + " " + str(name) + " " + str(parent))

    if c_type in TYPE_IDENTITY:
        return c_type
    elif c_type in TYPE_CONVERSION:
        return TYPE_CONVERSION[c_type]
    elif name in ["vertices", "points"] and c_type in ["Vec2 *", "const b2Vec2 *"]:
        return "access Vec2_Array_Indef"
    elif c_type.startswith("const "):
        return to_ada_type(c_type[5:].strip(), name, parent)
    elif c_type.endswith(" *") and c_type[:-2] in NEED_INDEF_ARRAY:
        return f"access {to_ada_type(c_type[:-1].strip(), name, parent)}_Array_Indef"
    elif c_type.endswith("*"):
        return "access " + to_ada_type(c_type[:-1].strip(), name, parent)
    elif c_type.endswith("[B2_MAX_POLYGON_VERTICES]"):
        return c_type[:-25].strip() + "_Array_Max_Poly"
    else:
        print(TYPE_IDENTITY)
        raise Exception(f"unknown type: '{c_type}' for {name} in {parent}")


def is_type_name(name):
    for type in TYPE_IDENTITY:
        if name.lower() == type.lower():
            return True
    for type in TYPE_CONVERSION.keys():
        if name.lower() == type.lower():
            return True
    return False


def gen_struct(struct):

    print(str(struct))
    struct["name"] = b2strip(struct["name"])

    out = f"   type {struct['name']} is record\n"
    for field in struct["fields"]:
        if field["name"] == "type":
            field["name"] = "type_K"

        if is_type_name(field["name"]):
            field["name"] = field["name"] + "_f"
        desc = field["description"].strip()
        desc = f" -- {desc}" if desc != "" else ""
        out += f"      {field['name']} : {to_ada_type(field['type'], field['name'], struct['name'])};{desc}\n"
    out += "   end record\n"
    out += "      with Convention => C_Pass_By_Copy;\n"

    out += "\n"

    if struct["name"] == "Vec2":
        out += "   type Vec2_Array_Max_Poly is array (0 .. 7) of Vec2;\n"

    if struct["name"] == "ManifoldPoint":
        out += "   type ManifoldPoint_Array_2 is array (0 .. 1) of ManifoldPoint;\n\n"

    if struct["name"] in NEED_INDEF_ARRAY:
        out += f"   type {struct["name"]}_Array_Indef is array (Interfaces.C.unsigned) of aliased {struct["name"]}\n"
        out += "     with Convention => C;\n\n"

    if struct["name"] == "JointId":
        for joint_type in JOINT_TYPES:
            jtype = f"{joint_type}Id"
            out += f"   type {jtype} is new JointId;\n"
            out += f"   function AsJoint (J : {jtype}) return JointId\n"
            out += "   is (JointId(J));\n\n"
            TYPE_IDENTITY.append(jtype)
        print("\n")

    TYPE_IDENTITY.append(struct["name"])

    return out


def enum_kind(name):
    if name.endswith("Flags") or name in ["Gesture"]:
        return "unsigned_new_type"
    elif name in []:
        return "int_subtype"
    elif name in []:
        return "int_new_type"
    else:
        return "ada_enums"


def gen_enum(enum):
    out = ""
    enum["name"] = b2strip(enum["name"])

    # Remove B2_ prefix and change first letter case of value name
    for value in enum["values"]:
        value["name"] = value["name"][3].upper() + value["name"][4:]

    kind = enum_kind(enum["name"])

    enum["values"] = filter(
        lambda elt: not elt["name"].endswith("TypeCount"), enum["values"]
    )

    if kind == "unsigned_new_type":
        # The enum represents flags that can be combined, so we use a modular type
        out += f"   type {enum['name']} is new Interfaces.C.unsigned;\n"
    elif kind == "int_subtype":
        out += f"   subtype {enum['name']} is Interfaces.C.int;\n"
    elif kind == "int_new_type":
        # In these cases the enum is just used as a list of default/common
        # values for the type.
        out += f"   type {enum['name']} is new Interfaces.C.int;\n"

    if kind in ["unsigned_new_type", "int_subtype", "int_new_type"]:
        if len(enum["description"].strip()) != 0:
            out += f"   --  {enum['description']}\n"
        out += "\n"

        for value in enum["values"]:
            desc = (
                ""
                if len(value["description"].strip()) == 0
                else f" -- {value['description']}"
            )
            out += f"   {value['name']} : constant {enum['name']} := {value['value']};{desc}\n"
    else:
        # Otherwise use regular Ada enums
        out += f"   type {enum['name']} is\n"
        out += "     (\n"
        sorted_value = sorted(enum["values"], key=lambda d: d["value"])
        first = True
        for value in sorted_value:
            coma = "  " if first else ", "
            desc = (
                ""
                if len(value["description"].strip()) == 0
                else f" -- {value['description']}"
            )
            out += f"       {coma}{value['name']}{desc}\n"
            first = False
        out += "     )\n"
        out += "     with Convention => C;\n"
        if len(enum["description"].strip()) != 0:
            out += f"   --  {enum['description']}\n"
        out += "\n"

        out += f"   for {enum['name']} use\n"
        out += "     (\n"
        first = True
        for value in sorted_value:
            coma = "  " if first else ", "
            out += f"       {coma}{value['name']} => {value['value']}\n"
            first = False
        out += "     );\n"
    out += "\n"

    TYPE_IDENTITY.append(enum["name"])

    return out


def function_decl(function, spec=True, callback=False, import_fun=False):
    out = ""
    param_decls = []
    if function["params"] is not None:
        for p in function["params"]:
            param_decls += [f"{p['name']} : {p['type']}"]

    if len(param_decls) != 0:
        params_str = " (" + "; ".join(param_decls) + ")"
    else:
        params_str = ""

    if callback:
        out += f"   type {function['name']} is access "
        function["name"] = ""

    if "ada-name" in function:
        name = function["ada-name"]
    else:
        name = function["name"]

    if import_fun:
        aspects = f'\n     with Import => True, Convention => C, External_Name => "{function["name"]}"'
    else:
        aspects = ""

    term = (";" if not callback else "") if spec else " is"
    if function["returnType"] is None:
        out += f"   procedure {name}{params_str}{aspects}{term}\n"
    else:
        out += f"   function {name}{params_str} return {function['returnType']}{aspects}{term}\n"

    if spec and not callback and function["description"] != "":
        out += f"   --  {function['description']}\n"
    else:
        out += "\n"
    return out


def gen_string_function_body(function):
    out = ""
    out += function_decl(function, spec=False)
    out += "      use Interfaces.C.Strings;\n"
    params = function["params"] if function["params"] is not None else []
    ret_type = function["returnType"]

    call_params = []
    for p in params:
        if p["type"] == "String":
            out += f"      C_{p['name']} : Interfaces.C.Strings.chars_ptr := New_String ({p['name']});\n"
            call_params.append(f"C_{p['name']}")
        else:
            call_params.append(p["name"])

    if len(call_params) > 0:
        call_str = f"{function['ada-name']} ({', '.join(call_params)})"
    else:
        call_str = f"{function['ada-name']}"

    if ret_type:
        if ret_type == "String":
            call_str = f"Value ({call_str})"
        out += f"      Result : constant {ret_type} := {call_str};\n"
    out += "   begin\n"

    if not ret_type:
        out += f"      {call_str};\n"
    for p in params:
        if p["type"] == "String":
            out += f"      Free (C_{p['name']});\n"

    if ret_type:
        out += "      return Result;\n"

    out += f"   end {function['ada-name']};\n\n"

    return out


def process_params(params, function_name):
    C_STRING_TYPE = "Interfaces.C.Strings.chars_ptr"
    has_string = False
    for p in params:
        if p["name"] in ADA_KEYWORD or is_type_name(p["name"]):
            p["name"] = p["name"] + "_p"
        p["type"] = to_ada_type(p["type"], p["name"], function_name)
        if p["type"] == C_STRING_TYPE:
            has_string = True
    return params, has_string


def GUI_string_exception(param, function):
    """
    Return true is the parameter should not be converted to an Ada String.
    This is required for some GUI function that modify the string.
    """
    return function["name"] == "GuiTextInputBox" and param["name"] == "text"


def gen_function(function):
    spec = ""
    body = ""
    C_STRING_TYPE = "Interfaces.C.Strings.chars_ptr"

    function["returnType"] = to_ada_type(
        function["returnType"], "RETURNTYPE", function["name"]
    )

    has_string = function["returnType"] == C_STRING_TYPE
    if "params" in function:
        function["params"], has_string = process_params(
            function["params"], function["name"]
        )
    else:
        function["params"] = None

    if "ada-name" in function:
        name = function["ada-name"]
    else:
        name = function["name"]

    spec += function_decl(function, import_fun=True)

    # It's ok to not keep the id of a shape, so create a procedure variant of
    # the create shape functions so users don't have to use the result of the
    # function
    if function["returnType"] == "ShapeId":
        proc = function
        proc["returnType"] = None
        spec += function_decl(proc, import_fun=True)

    if has_string:
        # This sub-program either returns a string or takes a string argument.
        # We write wrapper version that handles conversions between C and Ada String.

        if function["returnType"] == C_STRING_TYPE:
            function["returnType"] = "String"

        if function["params"] is not None:
            for p in function["params"]:
                if p["type"] == C_STRING_TYPE and not GUI_string_exception(p, function):
                    p["type"] = "String"

        spec += function_decl(function) + "\n"
        body += gen_string_function_body(function)

    if (
        function["name"] == "b2Joint_GetType"
        and function["params"][0]["type"] == "JointId"
    ):
        for jtype in JOINT_TYPES:

            spec += f"   function IsValid(Id : {jtype}Id) return Boolean\n"
            spec += f"   is (IsValid (AsJoint (Id)) = True and then GetType(AsJoint (Id)) = {jtype});\n"
            spec += "    --  Check the the joint is valid and has the correct underlying type\n\n"
        spec += "\n"

    return (spec, body)


def gen_define(define):
    out = ""
    if define["type"] == "STRING":
        out += f"   {define['name']} : constant String := \"{define['value']}\";\n"
    elif define["type"] == "INT" or define["type"] == "FLOAT":
        out += f"   {define['name']} : constant := {define['value']};\n"

    return out


def gen_callback(callback):
    callback["name"] = b2strip(callback["name"])

    TYPE_IDENTITY.append(callback["name"])

    out = ""
    callback["returnType"] = to_ada_type(callback["returnType"], "RETURNTYPE")
    callback["params"], _ = process_params(callback["params"], callback["name"])
    out += function_decl(callback, spec=True, callback=True)
    out += "\n     with Convention => C;\n"

    if callback["description"]:
        out += f"   --  {callback['description']}\n"
    out += "\n"

    TYPE_IDENTITY.append(callback["name"])

    return out


def gen_binding(json_files, package_name, package_file):

    SKIP_CALLBACKS = []
    SKIP_STRUCTS = []
    SKIP_FUNCTIONS = []

    spec = ""
    body = ""
    body_required = False

    spec = "with Interfaces.C; use Interfaces.C;\n"
    spec += "with Interfaces.C.Strings;\n"
    spec += "with System;\n"
    spec += f"package {package_name}\n"
    spec += "  with Preelaborate\n"
    spec += "is\n"
    spec += '   pragma Style_Checks ("M2000");\n'
    spec += "   use type Interfaces.C.C_float;\n"
    spec += "   type Chars_Array_3 is array (0 .. 2) of Interfaces.C.char;\n"
    spec += "   type Int_Array_24 is array (0 .. 23) of Interfaces.C.int;\n"
    spec += "   type Int_Array_12 is array (0 .. 11) of Interfaces.C.int;\n"

    body += f"package body {package_name} is\n"
    body += '   pragma Linker_Options ("-lbox2d");\n'
    body += '   pragma Linker_Options ("-lm");\n'
    body += '   pragma Style_Checks ("M2000");\n'

    for json_file in json_files:
        with open(
            os.path.join(CRATE_ROOT, "scripts", json_file), encoding="utf-8"
        ) as file:
            data = json.load(file)

        for define in data["defines"]:
            spec += gen_define(define)

        for enum in data["enums"]:
            spec += gen_enum(enum)

        for callback in data["callbacks"]:
            if callback["name"] not in SKIP_CALLBACKS:
                spec += gen_callback(callback)

        for struct in data["structs"]:
            if struct["name"] not in SKIP_STRUCTS:
                spec += gen_struct(struct)

        extended_funcs = []
        for function in data["functions"]:
            short_version = copy.deepcopy(function)
            ada_name = None
            for prefix in [
                "b2World_",
                "b2Body_",
                "b2Shape_",
                "b2Chain_",
                "b2Joint_",
                "b2DynamicTree_",
                "b2",
            ]:
                if function["name"].startswith(prefix):
                    ada_name = short_version["name"].removeprefix(prefix)
                    break

            if ada_name is None:
                ada_name = function["name"]
            short_version["ada-name"] = ada_name
            extended_funcs.append(short_version)

            if (
                "params" in function
                and len(function["params"]) > 0
                and function["params"][0]["name"] == "jointId"
                and function["params"][0]["type"] == "b2JointId"
            ):
                # Create duplicates of common joint function for all joint
                # types with a proper joint type "alias"

                short_version["params"][0]["name"] = "Id"

                if function["name"].startswith("b2Joint_"):
                    for jtype in JOINT_TYPES:
                        extra_joint = copy.deepcopy(short_version)
                        extra_joint["params"][0]["type"] = jtype + "Id"
                        extra_joint["params"][0]["name"] = "Id"
                        extended_funcs.append(extra_joint)
                elif function["name"] == "b2DestroyJoint":
                    # Create destroy for all joint types
                    for jtype in JOINT_TYPES:
                        extra_joint = copy.deepcopy(short_version)
                        extra_joint["params"][0]["type"] = f"{jtype}Id"
                        extra_joint["params"][0]["name"] = "Id"
                        extended_funcs.append(extra_joint)
                else:
                    for jtype in JOINT_TYPES:
                        # Convert specific joint function to use the proper joint type "alias"
                        if function["name"].startswith(f"b2{jtype}_"):
                            # Edit in place

                            # 1st param type
                            short_version["params"][0]["type"] = f"{jtype}Id"
                            short_version["params"][0]["name"] = "Id"

                            # Remove prefix
                            short_version["ada-name"] = short_version["ada-name"][
                                len(jtype) + 1 :
                            ]

            elif function["name"].startswith("b2Create") and function["name"].endswith(
                "Joint"
            ):
                # Change the return type of joint constructors to use proper joint type "alias"
                jtype = function["name"][8:-5]
                short_version["returnType"] = (
                    f"{jtype}JointId"  # Edit the dict already in the extended_funcs
                )

        for function in extended_funcs:
            if function["name"] not in SKIP_FUNCTIONS:
                f_spec, f_body = gen_function(function)
                spec += f_spec
                if f_body != "":
                    body_required = True
                    body += f_body

    # Some of the inlines defined by hand
    spec += """
   PI : constant := 3.14159265359;

   function Dot (A, B : Vec2) return C_float
   is (A.x * B.x + A.y * B.y);
   --  Vector dot product

   function Cross (A, B : Vec2) return C_float
   is (A.x * B.y - A.y * B.x);
   --  Vector cross product. In 2D this yields a scalar.

   function CrossVS (V : Vec2; S : C_float) return Vec2
   is ((S * V.x, -S * V.x));
   --  Perform the cross product on a vector and a scalar. In 2D this produces a vector.

   function CrossSV (S : C_float; V : Vec2) return Vec2
   is ((S * V.x, -S * V.x));
   --  Perform the cross product on a scalar and a vector. In 2D this produces a vector.

   function LeftPrep (V : Vec2) return Vec2
   is ((-V.y, V.x));
   --  Get a left pointing perpendicular vector. Equivalent to b2CrossSV(1.0f, v)

   function RightPrep (V : Vec2) return Vec2
   is ((V.y, -V.x));
   --  Get a right pointing perpendicular vector. Equivalent to b2CrossSV(v, 1.0f)

   function "+" (A, B : Vec2) return Vec2
   is ((A.x + B.x, A.y + B.y));
   --  Vector addition

   function "-" (A, B : Vec2) return Vec2
   is ((A.x - B.x, A.y - B.y));
   --  Vector subtraction

   function "-" (A : Vec2) return Vec2
   is ((-A.x, -A.y));
   --  Vector negation

   function Lerp (A, B : Vec2; T : C_float) return Vec2
   is (((1.0 -T) * A.x + T * B.x, (1.0 - T) * A.y + T * B.y));
   --  Vector linear interpolation
   --  https://fgiesen.wordpress.com/2012/08/15/linear-interpolation-past-present-and-future/

   function "*" (A, B : Vec2) return Vec2
   is ((A.x * B.x, A.y * B.y));
   --  Component-wise multiplication

   function "*" (A : Vec2; S : C_float) return Vec2
   is ((A.x * S, A.y * S));
   --  Multiply a scalar and vector

   function "*" (S : C_float; A : Vec2) return Vec2
   is ((A.x * S, A.y * S));
   --  Multiply a vector and scalar

   function "/" (A : Vec2; S : C_float) return Vec2
   is ((A.x / S, A.y / S));
   --  Divide a scalar and vector

   function MulAdd (A : Vec2; S : C_float; B : Vec2) return Vec2
   is ((A.x + S * B.x, A.y + S * B.y));
   --  a + s * b

   function MulSub (A : Vec2; S : C_float; B : Vec2) return Vec2
   is ((A.x - S * B.x, A.y - S * B.y));
   --  a - s * b

   function "abs" (A : Vec2) return Vec2
   is ((abs A.x, abs A.y));
   --  Component-wise absolute vector

   function Min (A, B : Vec2) return Vec2
   is ((C_float'Min (A.x, B.x), C_float'Min (A.y, B.y)));
   --  Component-wise minimum vector

   function Max (A, B : Vec2) return Vec2
   is ((C_float'Max (A.x, B.x), C_float'Max (A.y, B.y)));
   --  Component-wise maximum vector

   function Clamp (A, Lower, Upper: C_float) return C_float
   is (C_float'Max (Lower, C_float'Min (Upper, A)));

   function Max (V, A, B : Vec2) return Vec2
   is ((Clamp (V.x, A.x, B.x), Clamp (V.y, A.y, B.y)));
   --  Component-wise clamp vector v into the range [a, b]

   function sqrtf (A : C_float) return C_float;
   pragma Import (C, sqrtf, "sqrtf");

   function Length (V : Vec2) return C_float
   is (sqrtf (V.x * V.x + V.y * V.y));
   --  Get the length of this vector (the norm)

   function Distance (A, B : Vec2) return C_float
   is (Length ((B.x - A.x, B.y - A.y)));
   --  Get the distance between two points

   function Normalize (V : Vec2) return Vec2
   is (if Length (V) < C_float'Model_Epsilon
       then (0.0, 0.0)
       else ((1.0 / Length (V)) * V.x, (1.0 / Length (V)) * V.y));
   --  Convert a vector into a unit vector if possible, otherwise returns the zero vector.

   function IsNormalized (A : Vec2) return Boolean
   is ((abs (1.0 - Dot (A, A))) < (100.0 * C_float'Model_Epsilon));
   --  Determines if the provided vector is normalized (norm(a) == 1).

   function GetLengthAndNormalize(Length : out C_float; V : Vec2) return Vec2;
   --  Convert a vector into a unit vector if possible, otherwise returns the zero vector. Also
   --  outputs the length.

   function RadToDeg (Radians : C_float) return C_float
   is (Radians * 180.0 / C_float (PI));

   function DegToRad (Degrees : C_float) return C_float
   is (Degrees * C_float (PI) / 180.0);

   function GetAngle (Q : Rot) return C_float
   is (Atan2 (Q.s, Q.c));
   --  Get the angle in radians in the range [-pi, pi]

   function GetSegmentAngle (P1, P2 : Vec2) return C_float
   is (Atan2 (P2.x - P1.x, P2.y - P1.y));
   --  Get the angle in radians in the range [-pi, pi]

   function MakeRot (Radians : C_float) return Rot
   is (ComputeCosSin (Radians).cosine, ComputeCosSin (Radians).sine);
   --  Make a rotation using an angle in radians

   function GetXAxis (Q : Rot) return Vec2
   is ((Q.c, Q.s));
   --  Get the x-axis

   function GetYAxis (Q : Rot) return Vec2
   is ((-Q.s, Q.c));
   --  Get the y-axis

   function MulRot(Q, R : Rot) return Rot
   is ((c => Q.c * R.c - Q.s * R.s,
        s => Q.s * R.c + Q.c * R.s));
   --  Multiply two rotations: q * r

   function InvMulRot(A, B : Rot) return Rot
   is ((c => A.c * B.c + A.s * B.s,
        s => A.s * B.s - A.s * B.c));
   --  Transpose multiply two rotations: inv(a) * b
   --  This rotates a vector local in frame b into a vector local in frame a

   function RelativeAngle(A, B : Rot) return C_float
   is (Atan2 (A.c * B.s- A.s * B.c, A.c * B.c + A.s *B.s));
   --  Relative angle between a and b

   function Remainderf (A, B : C_float) return C_float;
   pragma Import (C, Remainderf, "remainderf");

   function UnwindAngle (Radians : C_float) return C_float
   is (Remainderf (Radians, 2.0 * PI));
   --  Convert any angle into the range [-pi, pi]

   function RotateVector (Q : Rot; V : Vec2) return Vec2
   is ((Q.c * V.x - Q.s * V.y, Q.s * V.x + Q.c * V.y));
   --  Rotate a vector

   function InvRotateVector (Q : Rot; V : Vec2) return Vec2
   is ((Q.c * V.x + Q.s * V.y, -Q.s * V.x + Q.c * V.y));
   --  Inverse rotate a vector

   function TransformPoint(T : Transform; P : Vec2) return Vec2
   is (((T.q.c * P.x - T.q.s * P.y) + T.p.x,
        (T.q.s * P.x + T.q.c * P.y) + T.p.y));
   --  Transform a point (e.g. local space to world space)

   function InvTransformPOint(T : Transform; P : Vec2) return Vec2
   is ((T.q.c * (P.x - T.p.x) + T.q.s * (P.y - T.p.y),
        -T.q.s * (P.x - T.p.x) + T.q.c * (P.y - T.p.y)));
   --  Inverse transform a point (e.g. world space to local space)

   function MulTransforms(A, B : Transform) return Transform
   is ((q => MulRot (A.q, B.q),
        p => RotateVector (A.q, B.p) * A.p));
   --  Multiply two transforms. If the result is applied to a point p local to frame B,
   --  the transform would first convert p to a point local to frame A, then into a point
   --  in the world frame.
   --  v2 = A.q.Rot(B.q.Rot(v1) + B.p) + A.p
   --     = (A.q * B.q).Rot(v1) + A.q.Rot(B.p) + A.p

   function InvMulTransforms(A, B : Transform) return Transform
   is ((q => InvMulRot (A.q, B.q),
        p => InvRotateVector (A.q, B.p - A.p)));
   --  Creates a transform that converts a local point in frame B to a local point in frame A.
   --  v2 = A.q' * (B.q * v1 + B.p - A.p)
   --     = A.q' * B.q * v1 + A.q' * (B.p - A.p)

"""
    spec += f"end {package_name};\n"

    body += """
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

"""

    body += f"end {package_name};\n"

    spec_filename = os.path.join(CRATE_ROOT, "src", package_file + ".ads")
    body_filename = os.path.join(CRATE_ROOT, "src", package_file + ".adb")

    with open(spec_filename, "w", encoding="utf-8") as f:
        print(f"Writing {spec_filename}")
        f.write(spec)

    if body_required:
        with open(body_filename, "w", encoding="utf-8") as f:
            print(f"Writing {body_filename}")
            f.write(body)


gen_binding(
    [
        "base.h.json",
        "math_functions.h.json",
        "collision.h.json",
        "id.h.json",
        "types.h.json",
        "box2d.h.json",
    ],
    "Box2D",
    "box2d",
)

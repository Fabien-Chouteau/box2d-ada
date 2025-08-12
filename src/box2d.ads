with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with System;

package Box2D
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   use type Interfaces.C.C_float;
   type Chars_Array_3 is array (0 .. 2) of Interfaces.C.char;
   type Int_Array_24 is array (0 .. 23) of Interfaces.C.int;
   type Int_Array_12 is array (0 .. 11) of Interfaces.C.int;
   B2_HASH_INIT : constant := 5381;
   type AllocFcn is
     access function
       (size : Interfaces.C.unsigned; alignment : Interfaces.C.int)
        return System.Address


   with Convention => C;

   type FreeFcn is access procedure (mem : System.Address)


   with Convention => C;

   type AssertFcn is
     access function
       (condition  : Interfaces.C.Strings.chars_ptr;
        fileName   : Interfaces.C.Strings.chars_ptr;
        lineNumber : Interfaces.C.int) return Interfaces.C.int


   with Convention => C;

   type Version is record
      major    : Interfaces.C.int;
      minor    : Interfaces.C.int;
      revision : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   procedure SetAllocator
     (allocFcn_p : access AllocFcn; freeFcn_p : access FreeFcn)
   with Import => True, Convention => C, External_Name => "b2SetAllocator";

   function GetByteCount return Interfaces.C.int
   with Import => True, Convention => C, External_Name => "b2GetByteCount";

   procedure SetAssertFcn (assertFcn_p : access AssertFcn)
   with Import => True, Convention => C, External_Name => "b2SetAssertFcn";

   function GetVersion return Version
   with Import => True, Convention => C, External_Name => "b2GetVersion";

   function InternalAssertFcn
     (condition  : Interfaces.C.Strings.chars_ptr;
      fileName   : Interfaces.C.Strings.chars_ptr;
      lineNumber : Interfaces.C.int) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2InternalAssertFcn";

   function InternalAssertFcn
     (condition : String; fileName : String; lineNumber : Interfaces.C.int)
      return Interfaces.C.int;

   function GetTicks return Interfaces.Unsigned_64
   with Import => True, Convention => C, External_Name => "b2GetTicks";

   function GetMilliseconds
     (ticks : Interfaces.Unsigned_64) return Interfaces.C.C_float
   with Import => True, Convention => C, External_Name => "b2GetMilliseconds";

   function GetMillisecondsAndReset
     (ticks : access Interfaces.Unsigned_64) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2GetMillisecondsAndReset";

   procedure Yield
   with Import => True, Convention => C, External_Name => "b2Yield";

   function Hash
     (hash  : Interfaces.Unsigned_32;
      data  : access Interfaces.Unsigned_8;
      count : Interfaces.C.int) return Interfaces.Unsigned_32
   with Import => True, Convention => C, External_Name => "b2Hash";

   B2_PI : constant := 3.14159265359;
   type Vec2 is record
      x : Interfaces.C.C_float;
      y : Interfaces.C.C_float;
   end record
   with Convention => C_Pass_By_Copy;

   type Vec2_Array_Max_Poly is array (0 .. 7) of Vec2;
   type Vec2_Array_Indef is array (Interfaces.C.unsigned) of aliased Vec2
   with Convention => C;

   type CosSin is record
      cosine : Interfaces.C.C_float;
      sine   : Interfaces.C.C_float;
   end record
   with Convention => C_Pass_By_Copy;

   type Rot is record
      c : Interfaces.C.C_float;
      s : Interfaces.C.C_float;
   end record
   with Convention => C_Pass_By_Copy;

   type Transform is record
      p : Vec2;
      q : Rot;
   end record
   with Convention => C_Pass_By_Copy;

   type Mat22 is record
      cx : Vec2;
      cy : Vec2;
   end record
   with Convention => C_Pass_By_Copy;

   type AABB is record
      lowerBound : Vec2;
      upperBound : Vec2;
   end record
   with Convention => C_Pass_By_Copy;

   type Plane is record
      normal : Vec2;
      offset : Interfaces.C.C_float;
   end record
   with Convention => C_Pass_By_Copy;

   function IsValidFloat (a : Interfaces.C.C_float) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2IsValidFloat";

   function IsValidVec2 (v : Vec2) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2IsValidVec2";

   function IsValidRotation (q : Rot) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2IsValidRotation";

   function IsValidAABB (aabb_p : AABB) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2IsValidAABB";

   function IsValidPlane (a : Plane) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2IsValidPlane";

   function Atan2
     (y : Interfaces.C.C_float; x : Interfaces.C.C_float)
      return Interfaces.C.C_float
   with Import => True, Convention => C, External_Name => "b2Atan2";

   function ComputeCosSin (radians : Interfaces.C.C_float) return CosSin
   with Import => True, Convention => C, External_Name => "b2ComputeCosSin";

   function ComputeRotationBetweenUnitVectors (v1 : Vec2; v2 : Vec2) return Rot
   with
     Import => True,
     Convention => C,
     External_Name => "b2ComputeRotationBetweenUnitVectors";

   procedure SetLengthUnitsPerMeter (lengthUnits : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2SetLengthUnitsPerMeter";

   function GetLengthUnitsPerMeter return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2GetLengthUnitsPerMeter";

   B2_MAX_POLYGON_VERTICES : constant := 8;
   type TOIState is
     (ToiStateUnknown,
      ToiStateFailed,
      ToiStateOverlapped,
      ToiStateHit,
      ToiStateSeparated)
   with Convention => C;

   for TOIState use
     (ToiStateUnknown    => 0,
      ToiStateFailed     => 1,
      ToiStateOverlapped => 2,
      ToiStateHit        => 3,
      ToiStateSeparated  => 4);

   type RayCastInput is record
      origin      : Vec2;
      translation : Vec2;
      maxFraction : Interfaces.C.C_float;
   end record
   with Convention => C_Pass_By_Copy;

   type ShapeProxy is record
      points : Vec2_Array_Max_Poly;
      count  : Interfaces.C.int;
      radius : Interfaces.C.C_float;
   end record
   with Convention => C_Pass_By_Copy;

   type ShapeCastInput is record
      proxy       : ShapeProxy;
      translation : Vec2;
      maxFraction : Interfaces.C.C_float;
      canEncroach : Interfaces.C.C_bool;
   end record
   with Convention => C_Pass_By_Copy;

   type CastOutput is record
      normal     : Vec2;
      point      : Vec2;
      fraction   : Interfaces.C.C_float;
      iterations : Interfaces.C.int;
      hit        : Interfaces.C.C_bool;
   end record
   with Convention => C_Pass_By_Copy;

   type MassData is record
      mass              : Interfaces.C.C_float;
      center            : Vec2;
      rotationalInertia : Interfaces.C.C_float;
   end record
   with Convention => C_Pass_By_Copy;

   type Circle is record
      center : Vec2;
      radius : Interfaces.C.C_float;
   end record
   with Convention => C_Pass_By_Copy;

   type Capsule is record
      center1 : Vec2;
      center2 : Vec2;
      radius  : Interfaces.C.C_float;
   end record
   with Convention => C_Pass_By_Copy;

   type Polygon is record
      vertices : Vec2_Array_Max_Poly;
      normals  : Vec2_Array_Max_Poly;
      centroid : Vec2;
      radius   : Interfaces.C.C_float;
      count    : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type Segment is record
      point1 : Vec2;
      point2 : Vec2;
   end record
   with Convention => C_Pass_By_Copy;

   type ChainSegment is record
      ghost1    : Vec2;
      segment_f : Segment;
      ghost2    : Vec2;
      chainId   : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type Hull is record
      points : Vec2_Array_Max_Poly;
      count  : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type SegmentDistanceResult is record
      closest1        : Vec2;
      closest2        : Vec2;
      fraction1       : Interfaces.C.C_float;
      fraction2       : Interfaces.C.C_float;
      distanceSquared : Interfaces.C.C_float;
   end record
   with Convention => C_Pass_By_Copy;

   type SimplexCache is record
      count  : Interfaces.Unsigned_16;
      indexA : Chars_Array_3;
      indexB : Chars_Array_3;
   end record
   with Convention => C_Pass_By_Copy;

   type DistanceInput is record
      proxyA     : ShapeProxy;
      proxyB     : ShapeProxy;
      transformA : Transform;
      transformB : Transform;
      useRadii   : Interfaces.C.C_bool;
   end record
   with Convention => C_Pass_By_Copy;

   type DistanceOutput is record
      pointA       : Vec2; -- /< Closest point on shapeA
      pointB       : Vec2; -- /< Closest point on shapeB
      normal       :
        Vec2; -- /< Normal vector that points from A to B. Invalid if distance is zero.
      distance     :
        Interfaces.C.C_float; -- /< The final distance, zero if overlapped
      iterations   : Interfaces.C.int; -- /< Number of GJK iterations used
      simplexCount :
        Interfaces
          .C
          .int; -- /< The number of simplexes stored in the simplex array
   end record
   with Convention => C_Pass_By_Copy;

   type SimplexVertex is record
      wA     : Vec2; -- /< support point in proxyA
      wB     : Vec2; -- /< support point in proxyB
      w      : Vec2; -- /< wB - wA
      a      :
        Interfaces.C.C_float; -- /< barycentric coordinate for closest point
      indexA : Interfaces.C.int; -- /< wA index
      indexB : Interfaces.C.int; -- /< wB index
   end record
   with Convention => C_Pass_By_Copy;

   type Simplex is record
      v1    : SimplexVertex; -- /< vertices
      v2    : SimplexVertex; -- /< vertices
      v3    : SimplexVertex; -- /< vertices
      count : Interfaces.C.int; -- /< number of valid vertices
   end record
   with Convention => C_Pass_By_Copy;

   type ShapeCastPairInput is record
      proxyA       : ShapeProxy; -- /< The proxy for shape A
      proxyB       : ShapeProxy; -- /< The proxy for shape B
      transformA   : Transform; -- /< The world transform for shape A
      transformB   : Transform; -- /< The world transform for shape B
      translationB : Vec2; -- /< The translation of shape B
      maxFraction  :
        Interfaces
          .C
          .C_float; -- /< The fraction of the translation to consider, typically 1
      canEncroach  :
        Interfaces
          .C
          .C_bool; -- /< Allows shapes with a radius to move slightly closer if already touching
   end record
   with Convention => C_Pass_By_Copy;

   type Sweep is record
      localCenter : Vec2; -- /< Local center of mass position
      c1          : Vec2; -- /< Starting center of mass world position
      c2          : Vec2; -- /< Ending center of mass world position
      q1          : Rot; -- /< Starting world rotation
      q2          : Rot; -- /< Ending world rotation
   end record
   with Convention => C_Pass_By_Copy;

   type TOIInput is record
      proxyA      : ShapeProxy; -- /< The proxy for shape A
      proxyB      : ShapeProxy; -- /< The proxy for shape B
      sweepA      : Sweep; -- /< The movement of shape A
      sweepB      : Sweep; -- /< The movement of shape B
      maxFraction :
        Interfaces.C.C_float; -- /< Defines the sweep interval [0, maxFraction]
   end record
   with Convention => C_Pass_By_Copy;

   type TOIOutput is record
      state    : TOIState; -- /< The type of result
      fraction : Interfaces.C.C_float; -- /< The sweep time of the collision
   end record
   with Convention => C_Pass_By_Copy;

   type ManifoldPoint is record
      point              : Vec2;
      anchorA            : Vec2;
      anchorB            : Vec2;
      separation         : Interfaces.C.C_float;
      normalImpulse      : Interfaces.C.C_float;
      tangentImpulse     : Interfaces.C.C_float;
      totalNormalImpulse : Interfaces.C.C_float;
      normalVelocity     : Interfaces.C.C_float;
      id                 : Interfaces.Unsigned_16;
      persisted          : Interfaces.C.C_bool;
   end record
   with Convention => C_Pass_By_Copy;

   type ManifoldPoint_Array_2 is array (0 .. 1) of ManifoldPoint;

   type Manifold is record
      normal         : Vec2;
      rollingImpulse : Interfaces.C.C_float;
      points         : ManifoldPoint_Array_2;
      pointCount     : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type DynamicTree is record
      root            : Interfaces.C.int;
      nodeCount       : Interfaces.C.int;
      nodeCapacity    : Interfaces.C.int;
      freeList        : Interfaces.C.int;
      proxyCount      : Interfaces.C.int;
      leafIndices     : access Interfaces.C.int;
      leafBoxes       : access AABB;
      leafCenters     : access Vec2_Array_Indef;
      binIndices      : access Interfaces.C.int;
      rebuildCapacity : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type TreeStats is record
      nodeVisits : Interfaces.C.int;
      leafVisits : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type PlaneResult is record
      plane_f : Plane;
      point   : Vec2;
      hit     : Interfaces.C.C_bool;
   end record
   with Convention => C_Pass_By_Copy;

   type CollisionPlane is record
      plane_f      : Plane;
      pushLimit    : Interfaces.C.C_float;
      push         : Interfaces.C.C_float;
      clipVelocity : Interfaces.C.C_bool;
   end record
   with Convention => C_Pass_By_Copy;

   type PlaneSolverResult is record
      translation    : Vec2;
      iterationCount : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   function IsValidRay (input : access RayCastInput) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2IsValidRay";

   function MakePolygon
     (hull_p : access Hull; radius : Interfaces.C.C_float) return Polygon
   with Import => True, Convention => C, External_Name => "b2MakePolygon";

   function MakeOffsetPolygon
     (hull_p : access Hull; position : Vec2; rotation : Rot) return Polygon
   with
     Import => True,
     Convention => C,
     External_Name => "b2MakeOffsetPolygon";

   function MakeOffsetRoundedPolygon
     (hull_p   : access Hull;
      position : Vec2;
      rotation : Rot;
      radius   : Interfaces.C.C_float) return Polygon
   with
     Import => True,
     Convention => C,
     External_Name => "b2MakeOffsetRoundedPolygon";

   function MakeSquare (halfWidth : Interfaces.C.C_float) return Polygon
   with Import => True, Convention => C, External_Name => "b2MakeSquare";

   function MakeBox
     (halfWidth : Interfaces.C.C_float; halfHeight : Interfaces.C.C_float)
      return Polygon
   with Import => True, Convention => C, External_Name => "b2MakeBox";

   function MakeRoundedBox
     (halfWidth  : Interfaces.C.C_float;
      halfHeight : Interfaces.C.C_float;
      radius     : Interfaces.C.C_float) return Polygon
   with Import => True, Convention => C, External_Name => "b2MakeRoundedBox";

   function MakeOffsetBox
     (halfWidth  : Interfaces.C.C_float;
      halfHeight : Interfaces.C.C_float;
      center     : Vec2;
      rotation   : Rot) return Polygon
   with Import => True, Convention => C, External_Name => "b2MakeOffsetBox";

   function MakeOffsetRoundedBox
     (halfWidth  : Interfaces.C.C_float;
      halfHeight : Interfaces.C.C_float;
      center     : Vec2;
      rotation   : Rot;
      radius     : Interfaces.C.C_float) return Polygon
   with
     Import => True,
     Convention => C,
     External_Name => "b2MakeOffsetRoundedBox";

   function TransformPolygon
     (transform_p : Transform; polygon_p : access Polygon) return Polygon
   with Import => True, Convention => C, External_Name => "b2TransformPolygon";

   function ComputeCircleMass
     (shape : access Circle; density : Interfaces.C.C_float) return MassData
   with
     Import => True,
     Convention => C,
     External_Name => "b2ComputeCircleMass";

   function ComputeCapsuleMass
     (shape : access Capsule; density : Interfaces.C.C_float) return MassData
   with
     Import => True,
     Convention => C,
     External_Name => "b2ComputeCapsuleMass";

   function ComputePolygonMass
     (shape : access Polygon; density : Interfaces.C.C_float) return MassData
   with
     Import => True,
     Convention => C,
     External_Name => "b2ComputePolygonMass";

   function ComputeCircleAABB
     (shape : access Circle; transform_p : Transform) return AABB
   with
     Import => True,
     Convention => C,
     External_Name => "b2ComputeCircleAABB";

   function ComputeCapsuleAABB
     (shape : access Capsule; transform_p : Transform) return AABB
   with
     Import => True,
     Convention => C,
     External_Name => "b2ComputeCapsuleAABB";

   function ComputePolygonAABB
     (shape : access Polygon; transform_p : Transform) return AABB
   with
     Import => True,
     Convention => C,
     External_Name => "b2ComputePolygonAABB";

   function ComputeSegmentAABB
     (shape : access Segment; transform_p : Transform) return AABB
   with
     Import => True,
     Convention => C,
     External_Name => "b2ComputeSegmentAABB";

   function PointInCircle
     (point : Vec2; shape : access Circle) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2PointInCircle";

   function PointInCapsule
     (point : Vec2; shape : access Capsule) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2PointInCapsule";

   function PointInPolygon
     (point : Vec2; shape : access Polygon) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2PointInPolygon";

   function RayCastCircle
     (input : access RayCastInput; shape : access Circle) return CastOutput
   with Import => True, Convention => C, External_Name => "b2RayCastCircle";

   function RayCastCapsule
     (input : access RayCastInput; shape : access Capsule) return CastOutput
   with Import => True, Convention => C, External_Name => "b2RayCastCapsule";

   function RayCastSegment
     (input    : access RayCastInput;
      shape    : access Segment;
      oneSided : Interfaces.C.C_bool) return CastOutput
   with Import => True, Convention => C, External_Name => "b2RayCastSegment";

   function RayCastPolygon
     (input : access RayCastInput; shape : access Polygon) return CastOutput
   with Import => True, Convention => C, External_Name => "b2RayCastPolygon";

   function ShapeCastCircle
     (input : access ShapeCastInput; shape : access Circle) return CastOutput
   with Import => True, Convention => C, External_Name => "b2ShapeCastCircle";

   function ShapeCastCapsule
     (input : access ShapeCastInput; shape : access Capsule) return CastOutput
   with Import => True, Convention => C, External_Name => "b2ShapeCastCapsule";

   function ShapeCastSegment
     (input : access ShapeCastInput; shape : access Segment) return CastOutput
   with Import => True, Convention => C, External_Name => "b2ShapeCastSegment";

   function ShapeCastPolygon
     (input : access ShapeCastInput; shape : access Polygon) return CastOutput
   with Import => True, Convention => C, External_Name => "b2ShapeCastPolygon";

   function ComputeHull
     (points : access Vec2_Array_Indef; count : Interfaces.C.int) return Hull
   with Import => True, Convention => C, External_Name => "b2ComputeHull";

   function ValidateHull (hull_p : access Hull) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2ValidateHull";

   function SegmentDistance
     (p1 : Vec2; q1 : Vec2; p2 : Vec2; q2 : Vec2) return SegmentDistanceResult
   with Import => True, Convention => C, External_Name => "b2SegmentDistance";

   function ShapeDistance
     (input     : access DistanceInput;
      cache     : access SimplexCache;
      simplexes : access Simplex) return DistanceOutput
   with Import => True, Convention => C, External_Name => "b2ShapeDistance";

   function ShapeCast (input : access ShapeCastPairInput) return CastOutput
   with Import => True, Convention => C, External_Name => "b2ShapeCast";

   function MakeProxy
     (points : access Vec2_Array_Indef;
      count  : Interfaces.C.int;
      radius : Interfaces.C.C_float) return ShapeProxy
   with Import => True, Convention => C, External_Name => "b2MakeProxy";

   function MakeOffsetProxy
     (points   : access Vec2_Array_Indef;
      count    : Interfaces.C.int;
      radius   : Interfaces.C.C_float;
      position : Vec2;
      rotation : Rot) return ShapeProxy
   with Import => True, Convention => C, External_Name => "b2MakeOffsetProxy";

   function GetSweepTransform
     (sweep_p : access Sweep; time : Interfaces.C.C_float) return Transform
   with
     Import => True,
     Convention => C,
     External_Name => "b2GetSweepTransform";

   function TimeOfImpact (input : access TOIInput) return TOIOutput
   with Import => True, Convention => C, External_Name => "b2TimeOfImpact";

   function CollideCircles
     (circleA : access Circle;
      xfA     : Transform;
      circleB : access Circle;
      xfB     : Transform) return Manifold
   with Import => True, Convention => C, External_Name => "b2CollideCircles";

   function CollideCapsuleAndCircle
     (capsuleA : access Capsule; xfA : Transform; circleB : access Circle)
      return Manifold
   with
     Import => True,
     Convention => C,
     External_Name => "b2CollideCapsuleAndCircle";

   function CollideSegmentAndCircle
     (segmentA : access Segment; xfA : Transform; circleB : access Circle)
      return Manifold
   with
     Import => True,
     Convention => C,
     External_Name => "b2CollideSegmentAndCircle";

   function CollidePolygonAndCircle
     (polygonA : access Polygon; xfA : Transform; circleB : access Circle)
      return Manifold
   with
     Import => True,
     Convention => C,
     External_Name => "b2CollidePolygonAndCircle";

   function CollideCapsules
     (capsuleA : access Capsule;
      xfA      : Transform;
      capsuleB : access Capsule;
      xfB      : Transform) return Manifold
   with Import => True, Convention => C, External_Name => "b2CollideCapsules";

   function CollideSegmentAndCapsule
     (segmentA : access Segment; xfA : Transform; capsuleB : access Capsule)
      return Manifold
   with
     Import => True,
     Convention => C,
     External_Name => "b2CollideSegmentAndCapsule";

   function CollidePolygonAndCapsule
     (polygonA : access Polygon; xfA : Transform; capsuleB : access Capsule)
      return Manifold
   with
     Import => True,
     Convention => C,
     External_Name => "b2CollidePolygonAndCapsule";

   function CollidePolygons
     (polygonA : access Polygon;
      xfA      : Transform;
      polygonB : access Polygon;
      xfB      : Transform) return Manifold
   with Import => True, Convention => C, External_Name => "b2CollidePolygons";

   function CollideSegmentAndPolygon
     (segmentA : access Segment; xfA : Transform; polygonB : access Polygon)
      return Manifold
   with
     Import => True,
     Convention => C,
     External_Name => "b2CollideSegmentAndPolygon";

   function CollideChainSegmentAndCircle
     (segmentA : access ChainSegment; xfA : Transform; circleB : access Circle)
      return Manifold
   with
     Import => True,
     Convention => C,
     External_Name => "b2CollideChainSegmentAndCircle";

   function CollideChainSegmentAndCapsule
     (segmentA : access ChainSegment;
      xfA      : Transform;
      capsuleB : access Capsule) return Manifold
   with
     Import => True,
     Convention => C,
     External_Name => "b2CollideChainSegmentAndCapsule";

   function CollideChainSegmentAndPolygon
     (segmentA : access ChainSegment;
      xfA      : Transform;
      polygonB : access Polygon) return Manifold
   with
     Import => True,
     Convention => C,
     External_Name => "b2CollideChainSegmentAndPolygon";

   function Create return DynamicTree
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_Create";

   procedure Destroy (tree : access DynamicTree)
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_Destroy";

   function CreateProxy
     (tree         : access DynamicTree;
      aabb_p       : AABB;
      categoryBits : Interfaces.Unsigned_64;
      userData     : Interfaces.Unsigned_64) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_CreateProxy";

   procedure DestroyProxy
     (tree : access DynamicTree; proxyId : Interfaces.C.int)
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_DestroyProxy";

   procedure MoveProxy
     (tree : access DynamicTree; proxyId : Interfaces.C.int; aabb_p : AABB)
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_MoveProxy";

   procedure EnlargeProxy
     (tree : access DynamicTree; proxyId : Interfaces.C.int; aabb_p : AABB)
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_EnlargeProxy";

   procedure SetCategoryBits
     (tree         : access DynamicTree;
      proxyId      : Interfaces.C.int;
      categoryBits : Interfaces.Unsigned_64)
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_SetCategoryBits";

   function GetCategoryBits
     (tree : access DynamicTree; proxyId : Interfaces.C.int)
      return Interfaces.Unsigned_64
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_GetCategoryBits";

   function Query
     (tree     : access DynamicTree;
      aabb_p   : AABB;
      maskBits : Interfaces.Unsigned_64) return TreeStats
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_Query";

   function RayCast
     (tree     : access DynamicTree;
      input    : access RayCastInput;
      maskBits : Interfaces.Unsigned_64) return TreeStats
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_RayCast";

   function ShapeCast
     (tree     : access DynamicTree;
      input    : access ShapeCastInput;
      maskBits : Interfaces.Unsigned_64) return TreeStats
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_ShapeCast";

   function GetHeight (tree : access DynamicTree) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_GetHeight";

   function GetAreaRatio
     (tree : access DynamicTree) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_GetAreaRatio";

   function GetRootBounds (tree : access DynamicTree) return AABB
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_GetRootBounds";

   function GetProxyCount (tree : access DynamicTree) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_GetProxyCount";

   function Rebuild
     (tree : access DynamicTree; fullBuild : Interfaces.C.C_bool)
      return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_Rebuild";

   function GetByteCount (tree : access DynamicTree) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_GetByteCount";

   function GetUserData
     (tree : access DynamicTree; proxyId : Interfaces.C.int)
      return Interfaces.Unsigned_64
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_GetUserData";

   function GetAABB
     (tree : access DynamicTree; proxyId : Interfaces.C.int) return AABB
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_GetAABB";

   procedure Validate (tree : access DynamicTree)
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_Validate";

   procedure ValidateNoEnlarged (tree : access DynamicTree)
   with
     Import => True,
     Convention => C,
     External_Name => "b2DynamicTree_ValidateNoEnlarged";

   function SolvePlanes
     (targetDelta : Vec2;
      planes      : access CollisionPlane;
      count       : Interfaces.C.int) return PlaneSolverResult
   with Import => True, Convention => C, External_Name => "b2SolvePlanes";

   function ClipVector
     (vector : Vec2; planes : access CollisionPlane; count : Interfaces.C.int)
      return Vec2
   with Import => True, Convention => C, External_Name => "b2ClipVector";

   type WorldId is record
      index1     : Interfaces.Unsigned_16;
      generation : Interfaces.Unsigned_16;
   end record
   with Convention => C_Pass_By_Copy;

   type BodyId is record
      index1     : Interfaces.Integer_32;
      world0     : Interfaces.Unsigned_16;
      generation : Interfaces.Unsigned_16;
   end record
   with Convention => C_Pass_By_Copy;

   type ShapeId is record
      index1     : Interfaces.Integer_32;
      world0     : Interfaces.Unsigned_16;
      generation : Interfaces.Unsigned_16;
   end record
   with Convention => C_Pass_By_Copy;

   type ChainId is record
      index1     : Interfaces.Integer_32;
      world0     : Interfaces.Unsigned_16;
      generation : Interfaces.Unsigned_16;
   end record
   with Convention => C_Pass_By_Copy;

   type JointId is record
      index1     : Interfaces.Integer_32;
      world0     : Interfaces.Unsigned_16;
      generation : Interfaces.Unsigned_16;
   end record
   with Convention => C_Pass_By_Copy;

   type DistanceJointId is new JointId;
   function AsJoint (J : DistanceJointId) return JointId
   is (JointId (J));

   type MotorJointId is new JointId;
   function AsJoint (J : MotorJointId) return JointId
   is (JointId (J));

   type RevoluteJointId is new JointId;
   function AsJoint (J : RevoluteJointId) return JointId
   is (JointId (J));

   type PrismaticJointId is new JointId;
   function AsJoint (J : PrismaticJointId) return JointId
   is (JointId (J));

   type MouseJointId is new JointId;
   function AsJoint (J : MouseJointId) return JointId
   is (JointId (J));

   type FilterJointId is new JointId;
   function AsJoint (J : FilterJointId) return JointId
   is (JointId (J));

   type WeldJointId is new JointId;
   function AsJoint (J : WeldJointId) return JointId
   is (JointId (J));

   type WheelJointId is new JointId;
   function AsJoint (J : WheelJointId) return JointId
   is (JointId (J));

   B2_DEFAULT_CATEGORY_BITS : constant := 1;
   type BodyType is (StaticBody, KinematicBody, DynamicBody)
   with Convention => C;

   for BodyType use (StaticBody => 0, KinematicBody => 1, DynamicBody => 2);

   type ShapeType is
     (CircleShape, CapsuleShape, SegmentShape, PolygonShape, ChainSegmentShape)
   with Convention => C;

   for ShapeType use
     (CircleShape       => 0,
      CapsuleShape      => 1,
      SegmentShape      => 2,
      PolygonShape      => 3,
      ChainSegmentShape => 4);

   type JointType is
     (DistanceJoint,
      FilterJoint,
      MotorJoint,
      MouseJoint,
      PrismaticJoint,
      RevoluteJoint,
      WeldJoint,
      WheelJoint)
   with Convention => C;

   for JointType use
     (DistanceJoint  => 0,
      FilterJoint    => 1,
      MotorJoint     => 2,
      MouseJoint     => 3,
      PrismaticJoint => 4,
      RevoluteJoint  => 5,
      WeldJoint      => 6,
      WheelJoint     => 7);

   type HexColor is
     (ColorBlack,
      ColorNavy,
      ColorDarkBlue,
      ColorMediumBlue,
      ColorBlue,
      ColorDarkGreen,
      ColorGreen,
      ColorTeal,
      ColorDarkCyan,
      ColorDeepSkyBlue,
      ColorDarkTurquoise,
      ColorMediumSpringGreen,
      ColorLime,
      ColorSpringGreen,
      ColorAqua,
      ColorMidnightBlue,
      ColorDodgerBlue,
      ColorLightSeaGreen,
      ColorForestGreen,
      ColorSeaGreen,
      ColorDarkSlateGray,
      ColorBox2DBlue,
      ColorLimeGreen,
      ColorMediumSeaGreen,
      ColorTurquoise,
      ColorRoyalBlue,
      ColorSteelBlue,
      ColorDarkSlateBlue,
      ColorMediumTurquoise,
      ColorIndigo,
      ColorDarkOliveGreen,
      ColorCadetBlue,
      ColorCornflowerBlue,
      ColorRebeccaPurple,
      ColorMediumAquaMarine,
      ColorDimGray,
      ColorSlateBlue,
      ColorOliveDrab,
      ColorSlateGray,
      ColorLightSlateGray,
      ColorMediumSlateBlue,
      ColorLawnGreen,
      ColorChartreuse,
      ColorAquamarine,
      ColorMaroon,
      ColorPurple,
      ColorOlive,
      ColorGray,
      ColorSkyBlue,
      ColorLightSkyBlue,
      ColorBlueViolet,
      ColorDarkRed,
      ColorDarkMagenta,
      ColorSaddleBrown,
      ColorBox2DGreen,
      ColorDarkSeaGreen,
      ColorLightGreen,
      ColorMediumPurple,
      ColorDarkViolet,
      ColorPaleGreen,
      ColorDarkOrchid,
      ColorYellowGreen,
      ColorSienna,
      ColorBrown,
      ColorDarkGray,
      ColorLightBlue,
      ColorGreenYellow,
      ColorPaleTurquoise,
      ColorLightSteelBlue,
      ColorPowderBlue,
      ColorFireBrick,
      ColorDarkGoldenRod,
      ColorMediumOrchid,
      ColorRosyBrown,
      ColorDarkKhaki,
      ColorSilver,
      ColorMediumVioletRed,
      ColorIndianRed,
      ColorPeru,
      ColorChocolate,
      ColorTan,
      ColorLightGray,
      ColorThistle,
      ColorOrchid,
      ColorGoldenRod,
      ColorPaleVioletRed,
      ColorCrimson,
      ColorBox2DRed,
      ColorGainsboro,
      ColorPlum,
      ColorBurlywood,
      ColorLightCyan,
      ColorLavender,
      ColorDarkSalmon,
      ColorViolet,
      ColorPaleGoldenRod,
      ColorLightCoral,
      ColorKhaki,
      ColorAliceBlue,
      ColorHoneyDew,
      ColorAzure,
      ColorSandyBrown,
      ColorWheat,
      ColorBeige,
      ColorWhiteSmoke,
      ColorMintCream,
      ColorGhostWhite,
      ColorSalmon,
      ColorAntiqueWhite,
      ColorLinen,
      ColorLightGoldenRodYellow,
      ColorOldLace,
      ColorRed,
      ColorMagenta,
      ColorDeepPink,
      ColorOrangeRed,
      ColorTomato,
      ColorHotPink,
      ColorCoral,
      ColorDarkOrange,
      ColorLightSalmon,
      ColorOrange,
      ColorLightPink,
      ColorPink,
      ColorGold,
      ColorPeachPuff,
      ColorNavajoWhite,
      ColorMoccasin,
      ColorBisque,
      ColorMistyRose,
      ColorBlanchedAlmond,
      ColorBox2DYellow,
      ColorPapayaWhip,
      ColorLavenderBlush,
      ColorSeaShell,
      ColorCornsilk,
      ColorLemonChiffon,
      ColorFloralWhite,
      ColorSnow,
      ColorYellow,
      ColorLightYellow,
      ColorIvory,
      ColorWhite)
   with Convention => C;

   for HexColor use
     (ColorBlack                => 0,
      ColorNavy                 => 128,
      ColorDarkBlue             => 139,
      ColorMediumBlue           => 205,
      ColorBlue                 => 255,
      ColorDarkGreen            => 25600,
      ColorGreen                => 32768,
      ColorTeal                 => 32896,
      ColorDarkCyan             => 35723,
      ColorDeepSkyBlue          => 49151,
      ColorDarkTurquoise        => 52945,
      ColorMediumSpringGreen    => 64154,
      ColorLime                 => 65280,
      ColorSpringGreen          => 65407,
      ColorAqua                 => 65535,
      ColorMidnightBlue         => 1644912,
      ColorDodgerBlue           => 2003199,
      ColorLightSeaGreen        => 2142890,
      ColorForestGreen          => 2263842,
      ColorSeaGreen             => 3050327,
      ColorDarkSlateGray        => 3100495,
      ColorBox2DBlue            => 3190463,
      ColorLimeGreen            => 3329330,
      ColorMediumSeaGreen       => 3978097,
      ColorTurquoise            => 4251856,
      ColorRoyalBlue            => 4286945,
      ColorSteelBlue            => 4620980,
      ColorDarkSlateBlue        => 4734347,
      ColorMediumTurquoise      => 4772300,
      ColorIndigo               => 4915330,
      ColorDarkOliveGreen       => 5597999,
      ColorCadetBlue            => 6266528,
      ColorCornflowerBlue       => 6591981,
      ColorRebeccaPurple        => 6697881,
      ColorMediumAquaMarine     => 6737322,
      ColorDimGray              => 6908265,
      ColorSlateBlue            => 6970061,
      ColorOliveDrab            => 7048739,
      ColorSlateGray            => 7372944,
      ColorLightSlateGray       => 7833753,
      ColorMediumSlateBlue      => 8087790,
      ColorLawnGreen            => 8190976,
      ColorChartreuse           => 8388352,
      ColorAquamarine           => 8388564,
      ColorMaroon               => 8388608,
      ColorPurple               => 8388736,
      ColorOlive                => 8421376,
      ColorGray                 => 8421504,
      ColorSkyBlue              => 8900331,
      ColorLightSkyBlue         => 8900346,
      ColorBlueViolet           => 9055202,
      ColorDarkRed              => 9109504,
      ColorDarkMagenta          => 9109643,
      ColorSaddleBrown          => 9127187,
      ColorBox2DGreen           => 9226532,
      ColorDarkSeaGreen         => 9419919,
      ColorLightGreen           => 9498256,
      ColorMediumPurple         => 9662683,
      ColorDarkViolet           => 9699539,
      ColorPaleGreen            => 10025880,
      ColorDarkOrchid           => 10040012,
      ColorYellowGreen          => 10145074,
      ColorSienna               => 10506797,
      ColorBrown                => 10824234,
      ColorDarkGray             => 11119017,
      ColorLightBlue            => 11393254,
      ColorGreenYellow          => 11403055,
      ColorPaleTurquoise        => 11529966,
      ColorLightSteelBlue       => 11584734,
      ColorPowderBlue           => 11591910,
      ColorFireBrick            => 11674146,
      ColorDarkGoldenRod        => 12092939,
      ColorMediumOrchid         => 12211667,
      ColorRosyBrown            => 12357519,
      ColorDarkKhaki            => 12433259,
      ColorSilver               => 12632256,
      ColorMediumVioletRed      => 13047173,
      ColorIndianRed            => 13458524,
      ColorPeru                 => 13468991,
      ColorChocolate            => 13789470,
      ColorTan                  => 13808780,
      ColorLightGray            => 13882323,
      ColorThistle              => 14204888,
      ColorOrchid               => 14315734,
      ColorGoldenRod            => 14329120,
      ColorPaleVioletRed        => 14381203,
      ColorCrimson              => 14423100,
      ColorBox2DRed             => 14430514,
      ColorGainsboro            => 14474460,
      ColorPlum                 => 14524637,
      ColorBurlywood            => 14596231,
      ColorLightCyan            => 14745599,
      ColorLavender             => 15132410,
      ColorDarkSalmon           => 15308410,
      ColorViolet               => 15631086,
      ColorPaleGoldenRod        => 15657130,
      ColorLightCoral           => 15761536,
      ColorKhaki                => 15787660,
      ColorAliceBlue            => 15792383,
      ColorHoneyDew             => 15794160,
      ColorAzure                => 15794175,
      ColorSandyBrown           => 16032864,
      ColorWheat                => 16113331,
      ColorBeige                => 16119260,
      ColorWhiteSmoke           => 16119285,
      ColorMintCream            => 16121850,
      ColorGhostWhite           => 16316671,
      ColorSalmon               => 16416882,
      ColorAntiqueWhite         => 16444375,
      ColorLinen                => 16445670,
      ColorLightGoldenRodYellow => 16448210,
      ColorOldLace              => 16643558,
      ColorRed                  => 16711680,
      ColorMagenta              => 16711935,
      ColorDeepPink             => 16716947,
      ColorOrangeRed            => 16729344,
      ColorTomato               => 16737095,
      ColorHotPink              => 16738740,
      ColorCoral                => 16744272,
      ColorDarkOrange           => 16747520,
      ColorLightSalmon          => 16752762,
      ColorOrange               => 16753920,
      ColorLightPink            => 16758465,
      ColorPink                 => 16761035,
      ColorGold                 => 16766720,
      ColorPeachPuff            => 16767673,
      ColorNavajoWhite          => 16768685,
      ColorMoccasin             => 16770229,
      ColorBisque               => 16770244,
      ColorMistyRose            => 16770273,
      ColorBlanchedAlmond       => 16772045,
      ColorBox2DYellow          => 16772748,
      ColorPapayaWhip           => 16773077,
      ColorLavenderBlush        => 16773365,
      ColorSeaShell             => 16774638,
      ColorCornsilk             => 16775388,
      ColorLemonChiffon         => 16775885,
      ColorFloralWhite          => 16775920,
      ColorSnow                 => 16775930,
      ColorYellow               => 16776960,
      ColorLightYellow          => 16777184,
      ColorIvory                => 16777200,
      ColorWhite                => 16777215);

   type TaskCallback is
     access procedure
       (startIndex  : Interfaces.C.int;
        endIndex    : Interfaces.C.int;
        workerIndex : Interfaces.Unsigned_32;
        taskContext : System.Address)


   with Convention => C;

   type EnqueueTaskCallback is
     access function
       (task_p      : access TaskCallback;
        itemCount   : Interfaces.C.int;
        minRange    : Interfaces.C.int;
        taskContext : System.Address;
        userContext : System.Address) return System.Address


   with Convention => C;

   type FinishTaskCallback is
     access procedure (userTask : System.Address; userContext : System.Address)


   with Convention => C;

   type FrictionCallback is
     access function
       (frictionA       : Interfaces.C.C_float;
        userMaterialIdA : Interfaces.C.int;
        frictionB       : Interfaces.C.C_float;
        userMaterialIdB : Interfaces.C.int) return Interfaces.C.C_float


   with Convention => C;

   type RestitutionCallback is
     access function
       (restitutionA    : Interfaces.C.C_float;
        userMaterialIdA : Interfaces.C.int;
        restitutionB    : Interfaces.C.C_float;
        userMaterialIdB : Interfaces.C.int) return Interfaces.C.C_float


   with Convention => C;

   type CustomFilterFcn is
     access function
       (shapeIdA : ShapeId; shapeIdB : ShapeId; context : System.Address)
        return Interfaces.C.C_bool


   with Convention => C;

   type PreSolveFcn is
     access function
       (shapeIdA   : ShapeId;
        shapeIdB   : ShapeId;
        manifold_p : access Manifold;
        context    : System.Address) return Interfaces.C.C_bool


   with Convention => C;

   type OverlapResultFcn is
     access function
       (shapeId_p : ShapeId; context : System.Address)
        return Interfaces.C.C_bool


   with Convention => C;

   type CastResultFcn is
     access function
       (shapeId_p : ShapeId;
        point     : Vec2;
        normal    : Vec2;
        fraction  : Interfaces.C.C_float;
        context   : System.Address) return Interfaces.C.C_float


   with Convention => C;

   type PlaneResultFcn is
     access function
       (shapeId_p : ShapeId;
        plane_p   : access PlaneResult;
        context   : System.Address) return Interfaces.C.C_bool


   with Convention => C;

   type DrawPolygonCallback is
     access procedure
       (vertices    : access Vec2_Array_Indef;
        vertexCount : Interfaces.C.int;
        color       : HexColor;
        context     : System.Address)


   with Convention => C;

   type DrawSolidPolygonCallback is
     access procedure
       (transform_p : Transform;
        vertices    : access Vec2_Array_Indef;
        vertexCount : Interfaces.C.int;
        radius      : Interfaces.C.C_float;
        color       : HexColor;
        context     : System.Address)


   with Convention => C;

   type DrawCircleCallback is
     access procedure
       (center  : Vec2;
        radius  : Interfaces.C.C_float;
        color   : HexColor;
        context : System.Address)


   with Convention => C;

   type DrawSolidCircleCallback is
     access procedure
       (transform_p : Transform;
        radius      : Interfaces.C.C_float;
        color       : HexColor;
        context     : System.Address)


   with Convention => C;

   type DrawSolidCapsuleCallback is
     access procedure
       (p1      : Vec2;
        p2      : Vec2;
        radius  : Interfaces.C.C_float;
        color   : HexColor;
        context : System.Address)


   with Convention => C;

   type DrawSegmentCallback is
     access procedure
       (p1 : Vec2; p2 : Vec2; color : HexColor; context : System.Address)


   with Convention => C;

   type DrawTransformCallback is
     access procedure (transform_p : Transform; context : System.Address)


   with Convention => C;

   type DrawPointCallback is
     access procedure
       (p       : Vec2;
        size    : Interfaces.C.C_float;
        color   : HexColor;
        context : System.Address)


   with Convention => C;

   type DrawStringCallback is
     access procedure
       (p       : Vec2;
        s       : Interfaces.C.Strings.chars_ptr;
        color   : HexColor;
        context : System.Address)


   with Convention => C;

   type RayResult is record
      shapeId_f  : ShapeId;
      point      : Vec2;
      normal     : Vec2;
      fraction   : Interfaces.C.C_float;
      nodeVisits : Interfaces.C.int;
      leafVisits : Interfaces.C.int;
      hit        : Interfaces.C.C_bool;
   end record
   with Convention => C_Pass_By_Copy;

   type WorldDef is record
      gravity               : Vec2;
      restitutionThreshold  : Interfaces.C.C_float;
      hitEventThreshold     : Interfaces.C.C_float;
      contactHertz          : Interfaces.C.C_float;
      contactDampingRatio   : Interfaces.C.C_float;
      maxContactPushSpeed   : Interfaces.C.C_float;
      maximumLinearSpeed    : Interfaces.C.C_float;
      frictionCallback_f    : access FrictionCallback;
      restitutionCallback_f : access RestitutionCallback;
      enableSleep           : Interfaces.C.C_bool;
      enableContinuous      : Interfaces.C.C_bool;
      workerCount           : Interfaces.C.int;
      enqueueTask           : access EnqueueTaskCallback;
      finishTask            : access FinishTaskCallback;
      userTaskContext       : System.Address;
      userData              : System.Address;
      internalValue         : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type BodyDef is record
      type_K            : BodyType;
      position          : Vec2;
      rotation          : Rot;
      linearVelocity    : Vec2;
      angularVelocity   : Interfaces.C.C_float;
      linearDamping     : Interfaces.C.C_float;
      angularDamping    : Interfaces.C.C_float;
      gravityScale      : Interfaces.C.C_float;
      sleepThreshold    : Interfaces.C.C_float;
      name              : Interfaces.C.Strings.chars_ptr;
      userData          : System.Address;
      enableSleep       : Interfaces.C.C_bool;
      isAwake           : Interfaces.C.C_bool;
      fixedRotation     : Interfaces.C.C_bool;
      isBullet          : Interfaces.C.C_bool;
      isEnabled         : Interfaces.C.C_bool;
      allowFastRotation : Interfaces.C.C_bool;
      internalValue     : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type Filter is record
      categoryBits : Interfaces.Unsigned_64;
      maskBits     : Interfaces.Unsigned_64;
      groupIndex   : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type QueryFilter is record
      categoryBits : Interfaces.Unsigned_64;
      maskBits     : Interfaces.Unsigned_64;
   end record
   with Convention => C_Pass_By_Copy;

   type SurfaceMaterial is record
      friction          : Interfaces.C.C_float;
      restitution       : Interfaces.C.C_float;
      rollingResistance : Interfaces.C.C_float;
      tangentSpeed      : Interfaces.C.C_float;
      userMaterialId    : Interfaces.C.int;
      customColor       : Interfaces.Unsigned_32;
   end record
   with Convention => C_Pass_By_Copy;

   type ShapeDef is record
      userData              : System.Address;
      material              : SurfaceMaterial;
      density               : Interfaces.C.C_float;
      filter_f              : Filter;
      isSensor              : Interfaces.C.C_bool;
      enableSensorEvents    : Interfaces.C.C_bool;
      enableContactEvents   : Interfaces.C.C_bool;
      enableHitEvents       : Interfaces.C.C_bool;
      enablePreSolveEvents  : Interfaces.C.C_bool;
      invokeContactCreation : Interfaces.C.C_bool;
      updateBodyMass        : Interfaces.C.C_bool;
      internalValue         : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type ChainDef is record
      userData           : System.Address;
      points             : access Vec2_Array_Indef;
      count              : Interfaces.C.int;
      materials          : access SurfaceMaterial;
      materialCount      : Interfaces.C.int;
      filter_f           : Filter;
      isLoop             : Interfaces.C.C_bool;
      enableSensorEvents : Interfaces.C.C_bool;
      internalValue      : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type Profile is record
      step                : Interfaces.C.C_float;
      pairs               : Interfaces.C.C_float;
      collide             : Interfaces.C.C_float;
      solve               : Interfaces.C.C_float;
      mergeIslands        : Interfaces.C.C_float;
      prepareStages       : Interfaces.C.C_float;
      solveConstraints    : Interfaces.C.C_float;
      prepareConstraints  : Interfaces.C.C_float;
      integrateVelocities : Interfaces.C.C_float;
      warmStart           : Interfaces.C.C_float;
      solveImpulses       : Interfaces.C.C_float;
      integratePositions  : Interfaces.C.C_float;
      relaxImpulses       : Interfaces.C.C_float;
      applyRestitution    : Interfaces.C.C_float;
      storeImpulses       : Interfaces.C.C_float;
      splitIslands        : Interfaces.C.C_float;
      transforms          : Interfaces.C.C_float;
      hitEvents           : Interfaces.C.C_float;
      refit               : Interfaces.C.C_float;
      bullets             : Interfaces.C.C_float;
      sleepIslands        : Interfaces.C.C_float;
      sensors             : Interfaces.C.C_float;
   end record
   with Convention => C_Pass_By_Copy;

   type Counters is record
      bodyCount        : Interfaces.C.int;
      shapeCount       : Interfaces.C.int;
      contactCount     : Interfaces.C.int;
      jointCount       : Interfaces.C.int;
      islandCount      : Interfaces.C.int;
      stackUsed        : Interfaces.C.int;
      staticTreeHeight : Interfaces.C.int;
      treeHeight       : Interfaces.C.int;
      byteCount        : Interfaces.C.int;
      taskCount        : Interfaces.C.int;
      colorCounts      : Int_Array_12;
   end record
   with Convention => C_Pass_By_Copy;

   type DistanceJointDef is record
      bodyIdA          : BodyId;
      bodyIdB          : BodyId;
      localAnchorA     : Vec2;
      localAnchorB     : Vec2;
      length           : Interfaces.C.C_float;
      enableSpring     : Interfaces.C.C_bool;
      hertz            : Interfaces.C.C_float;
      dampingRatio     : Interfaces.C.C_float;
      enableLimit      : Interfaces.C.C_bool;
      minLength        : Interfaces.C.C_float;
      maxLength        : Interfaces.C.C_float;
      enableMotor      : Interfaces.C.C_bool;
      maxMotorForce    : Interfaces.C.C_float;
      motorSpeed       : Interfaces.C.C_float;
      collideConnected : Interfaces.C.C_bool;
      userData         : System.Address;
      internalValue    : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type MotorJointDef is record
      bodyIdA          : BodyId;
      bodyIdB          : BodyId;
      linearOffset     : Vec2;
      angularOffset    : Interfaces.C.C_float;
      maxForce         : Interfaces.C.C_float;
      maxTorque        : Interfaces.C.C_float;
      correctionFactor : Interfaces.C.C_float;
      collideConnected : Interfaces.C.C_bool;
      userData         : System.Address;
      internalValue    : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type MouseJointDef is record
      bodyIdA          : BodyId;
      bodyIdB          : BodyId;
      target           : Vec2;
      hertz            : Interfaces.C.C_float;
      dampingRatio     : Interfaces.C.C_float;
      maxForce         : Interfaces.C.C_float;
      collideConnected : Interfaces.C.C_bool;
      userData         : System.Address;
      internalValue    : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type FilterJointDef is record
      bodyIdA       : BodyId;
      bodyIdB       : BodyId;
      userData      : System.Address;
      internalValue : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type PrismaticJointDef is record
      bodyIdA           : BodyId;
      bodyIdB           : BodyId;
      localAnchorA      : Vec2;
      localAnchorB      : Vec2;
      localAxisA        : Vec2;
      referenceAngle    : Interfaces.C.C_float;
      targetTranslation : Interfaces.C.C_float;
      enableSpring      : Interfaces.C.C_bool;
      hertz             : Interfaces.C.C_float;
      dampingRatio      : Interfaces.C.C_float;
      enableLimit       : Interfaces.C.C_bool;
      lowerTranslation  : Interfaces.C.C_float;
      upperTranslation  : Interfaces.C.C_float;
      enableMotor       : Interfaces.C.C_bool;
      maxMotorForce     : Interfaces.C.C_float;
      motorSpeed        : Interfaces.C.C_float;
      collideConnected  : Interfaces.C.C_bool;
      userData          : System.Address;
      internalValue     : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type RevoluteJointDef is record
      bodyIdA          : BodyId;
      bodyIdB          : BodyId;
      localAnchorA     : Vec2;
      localAnchorB     : Vec2;
      referenceAngle   : Interfaces.C.C_float;
      targetAngle      : Interfaces.C.C_float;
      enableSpring     : Interfaces.C.C_bool;
      hertz            : Interfaces.C.C_float;
      dampingRatio     : Interfaces.C.C_float;
      enableLimit      : Interfaces.C.C_bool;
      lowerAngle       : Interfaces.C.C_float;
      upperAngle       : Interfaces.C.C_float;
      enableMotor      : Interfaces.C.C_bool;
      maxMotorTorque   : Interfaces.C.C_float;
      motorSpeed       : Interfaces.C.C_float;
      drawSize         : Interfaces.C.C_float;
      collideConnected : Interfaces.C.C_bool;
      userData         : System.Address;
      internalValue    : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type WeldJointDef is record
      bodyIdA             : BodyId;
      bodyIdB             : BodyId;
      localAnchorA        : Vec2;
      localAnchorB        : Vec2;
      referenceAngle      : Interfaces.C.C_float;
      linearHertz         : Interfaces.C.C_float;
      angularHertz        : Interfaces.C.C_float;
      linearDampingRatio  : Interfaces.C.C_float;
      angularDampingRatio : Interfaces.C.C_float;
      collideConnected    : Interfaces.C.C_bool;
      userData            : System.Address;
      internalValue       : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type WheelJointDef is record
      bodyIdA          : BodyId;
      bodyIdB          : BodyId;
      localAnchorA     : Vec2;
      localAnchorB     : Vec2;
      localAxisA       : Vec2;
      enableSpring     : Interfaces.C.C_bool;
      hertz            : Interfaces.C.C_float;
      dampingRatio     : Interfaces.C.C_float;
      enableLimit      : Interfaces.C.C_bool;
      lowerTranslation : Interfaces.C.C_float;
      upperTranslation : Interfaces.C.C_float;
      enableMotor      : Interfaces.C.C_bool;
      maxMotorTorque   : Interfaces.C.C_float;
      motorSpeed       : Interfaces.C.C_float;
      collideConnected : Interfaces.C.C_bool;
      userData         : System.Address;
      internalValue    : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type ExplosionDef is record
      maskBits         : Interfaces.Unsigned_64;
      position         : Vec2;
      radius           : Interfaces.C.C_float;
      falloff          : Interfaces.C.C_float;
      impulsePerLength : Interfaces.C.C_float;
   end record
   with Convention => C_Pass_By_Copy;

   type SensorBeginTouchEvent is record
      sensorShapeId  : ShapeId;
      visitorShapeId : ShapeId;
   end record
   with Convention => C_Pass_By_Copy;

   type SensorBeginTouchEvent_Array_Indef is
     array (Interfaces.C.unsigned) of aliased SensorBeginTouchEvent
   with Convention => C;

   type SensorEndTouchEvent is record
      sensorShapeId  : ShapeId;
      visitorShapeId : ShapeId;
   end record
   with Convention => C_Pass_By_Copy;

   type SensorEndTouchEvent_Array_Indef is
     array (Interfaces.C.unsigned) of aliased SensorEndTouchEvent
   with Convention => C;

   type SensorEvents is record
      beginEvents : access SensorBeginTouchEvent_Array_Indef;
      endEvents   : access SensorEndTouchEvent_Array_Indef;
      beginCount  : Interfaces.C.int;
      endCount    : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type ContactBeginTouchEvent is record
      shapeIdA   : ShapeId;
      shapeIdB   : ShapeId;
      manifold_f : Manifold;
   end record
   with Convention => C_Pass_By_Copy;

   type ContactBeginTouchEvent_Array_Indef is
     array (Interfaces.C.unsigned) of aliased ContactBeginTouchEvent
   with Convention => C;

   type ContactEndTouchEvent is record
      shapeIdA : ShapeId;
      shapeIdB : ShapeId;
   end record
   with Convention => C_Pass_By_Copy;

   type ContactEndTouchEvent_Array_Indef is
     array (Interfaces.C.unsigned) of aliased ContactEndTouchEvent
   with Convention => C;

   type ContactHitEvent is record
      shapeIdA      : ShapeId;
      shapeIdB      : ShapeId;
      point         : Vec2;
      normal        : Vec2;
      approachSpeed : Interfaces.C.C_float;
   end record
   with Convention => C_Pass_By_Copy;

   type ContactHitEvent_Array_Indef is
     array (Interfaces.C.unsigned) of aliased ContactHitEvent
   with Convention => C;

   type ContactEvents is record
      beginEvents : access ContactBeginTouchEvent_Array_Indef;
      endEvents   : access ContactEndTouchEvent_Array_Indef;
      hitEvents   : access ContactHitEvent_Array_Indef;
      beginCount  : Interfaces.C.int;
      endCount    : Interfaces.C.int;
      hitCount    : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type BodyMoveEvent is record
      transform_f : Transform;
      bodyId_f    : BodyId;
      userData    : System.Address;
      fellAsleep  : Interfaces.C.C_bool;
   end record
   with Convention => C_Pass_By_Copy;

   type BodyMoveEvent_Array_Indef is
     array (Interfaces.C.unsigned) of aliased BodyMoveEvent
   with Convention => C;

   type BodyEvents is record
      moveEvents : access BodyMoveEvent_Array_Indef;
      moveCount  : Interfaces.C.int;
   end record
   with Convention => C_Pass_By_Copy;

   type ContactData is record
      shapeIdA   : ShapeId;
      shapeIdB   : ShapeId;
      manifold_f : Manifold;
   end record
   with Convention => C_Pass_By_Copy;

   type DebugDraw is record
      DrawPolygonFcn       : DrawPolygonCallback;
      DrawSolidPolygonFcn  : DrawSolidPolygonCallback;
      DrawCircleFcn        : DrawCircleCallback;
      DrawSolidCircleFcn   : DrawSolidCircleCallback;
      DrawSolidCapsuleFcn  : DrawSolidCapsuleCallback;
      DrawSegmentFcn       : DrawSegmentCallback;
      DrawTransformFcn     : DrawTransformCallback;
      DrawPointFcn         : DrawPointCallback;
      DrawStringFcn        : DrawStringCallback;
      drawingBounds        : AABB;
      useDrawingBounds     : Interfaces.C.C_bool;
      drawShapes           : Interfaces.C.C_bool;
      drawJoints           : Interfaces.C.C_bool;
      drawJointExtras      : Interfaces.C.C_bool;
      drawBounds           : Interfaces.C.C_bool;
      drawMass             : Interfaces.C.C_bool;
      drawBodyNames        : Interfaces.C.C_bool;
      drawContacts         : Interfaces.C.C_bool;
      drawGraphColors      : Interfaces.C.C_bool;
      drawContactNormals   : Interfaces.C.C_bool;
      drawContactImpulses  : Interfaces.C.C_bool;
      drawContactFeatures  : Interfaces.C.C_bool;
      drawFrictionImpulses : Interfaces.C.C_bool;
      drawIslands          : Interfaces.C.C_bool;
      context              : System.Address;
   end record
   with Convention => C_Pass_By_Copy;

   function DefaultWorldDef return WorldDef
   with Import => True, Convention => C, External_Name => "b2DefaultWorldDef";

   function DefaultBodyDef return BodyDef
   with Import => True, Convention => C, External_Name => "b2DefaultBodyDef";

   function DefaultFilter return Filter
   with Import => True, Convention => C, External_Name => "b2DefaultFilter";

   function DefaultQueryFilter return QueryFilter
   with
     Import => True,
     Convention => C,
     External_Name => "b2DefaultQueryFilter";

   function DefaultSurfaceMaterial return SurfaceMaterial
   with
     Import => True,
     Convention => C,
     External_Name => "b2DefaultSurfaceMaterial";

   function DefaultShapeDef return ShapeDef
   with Import => True, Convention => C, External_Name => "b2DefaultShapeDef";

   function DefaultChainDef return ChainDef
   with Import => True, Convention => C, External_Name => "b2DefaultChainDef";

   function DefaultDistanceJointDef return DistanceJointDef
   with
     Import => True,
     Convention => C,
     External_Name => "b2DefaultDistanceJointDef";

   function DefaultMotorJointDef return MotorJointDef
   with
     Import => True,
     Convention => C,
     External_Name => "b2DefaultMotorJointDef";

   function DefaultMouseJointDef return MouseJointDef
   with
     Import => True,
     Convention => C,
     External_Name => "b2DefaultMouseJointDef";

   function DefaultFilterJointDef return FilterJointDef
   with
     Import => True,
     Convention => C,
     External_Name => "b2DefaultFilterJointDef";

   function DefaultPrismaticJointDef return PrismaticJointDef
   with
     Import => True,
     Convention => C,
     External_Name => "b2DefaultPrismaticJointDef";

   function DefaultRevoluteJointDef return RevoluteJointDef
   with
     Import => True,
     Convention => C,
     External_Name => "b2DefaultRevoluteJointDef";

   function DefaultWeldJointDef return WeldJointDef
   with
     Import => True,
     Convention => C,
     External_Name => "b2DefaultWeldJointDef";

   function DefaultWheelJointDef return WheelJointDef
   with
     Import => True,
     Convention => C,
     External_Name => "b2DefaultWheelJointDef";

   function DefaultExplosionDef return ExplosionDef
   with
     Import => True,
     Convention => C,
     External_Name => "b2DefaultExplosionDef";

   function DefaultDebugDraw return DebugDraw
   with Import => True, Convention => C, External_Name => "b2DefaultDebugDraw";

   function CreateWorld (def : access WorldDef) return WorldId
   with Import => True, Convention => C, External_Name => "b2CreateWorld";

   procedure DestroyWorld (worldId_p : WorldId)
   with Import => True, Convention => C, External_Name => "b2DestroyWorld";

   function IsValid (id : WorldId) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2World_IsValid";

   procedure Step
     (worldId_p    : WorldId;
      timeStep     : Interfaces.C.C_float;
      subStepCount : Interfaces.C.int)
   with Import => True, Convention => C, External_Name => "b2World_Step";

   procedure Draw (worldId_p : WorldId; draw : access DebugDraw)
   with Import => True, Convention => C, External_Name => "b2World_Draw";

   function GetBodyEvents (worldId_p : WorldId) return BodyEvents
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_GetBodyEvents";

   function GetSensorEvents (worldId_p : WorldId) return SensorEvents
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_GetSensorEvents";

   function GetContactEvents (worldId_p : WorldId) return ContactEvents
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_GetContactEvents";

   function OverlapAABB
     (worldId_p : WorldId;
      aabb_p    : AABB;
      filter_p  : QueryFilter;
      fcn       : access OverlapResultFcn) return TreeStats
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_OverlapAABB";

   function OverlapShape
     (worldId_p : WorldId; proxy : access ShapeProxy; filter_p : QueryFilter)
      return TreeStats
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_OverlapShape";

   function CastRay
     (worldId_p   : WorldId;
      origin      : Vec2;
      translation : Vec2;
      filter_p    : QueryFilter) return TreeStats
   with Import => True, Convention => C, External_Name => "b2World_CastRay";

   function CastRayClosest
     (worldId_p   : WorldId;
      origin      : Vec2;
      translation : Vec2;
      filter_p    : QueryFilter) return RayResult
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_CastRayClosest";

   function CastShape
     (worldId_p   : WorldId;
      proxy       : access ShapeProxy;
      translation : Vec2;
      filter_p    : QueryFilter) return TreeStats
   with Import => True, Convention => C, External_Name => "b2World_CastShape";

   function CastMover
     (worldId_p   : WorldId;
      mover       : access Capsule;
      translation : Vec2;
      filter_p    : QueryFilter) return Interfaces.C.C_float
   with Import => True, Convention => C, External_Name => "b2World_CastMover";

   procedure CollideMover
     (worldId_p : WorldId;
      mover     : access Capsule;
      filter_p  : QueryFilter;
      fcn       : access PlaneResultFcn)
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_CollideMover";

   procedure EnableSleeping (worldId_p : WorldId; flag : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_EnableSleeping";

   function IsSleepingEnabled (worldId_p : WorldId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_IsSleepingEnabled";

   procedure EnableContinuous (worldId_p : WorldId; flag : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_EnableContinuous";

   function IsContinuousEnabled
     (worldId_p : WorldId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_IsContinuousEnabled";

   procedure SetRestitutionThreshold
     (worldId_p : WorldId; value : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_SetRestitutionThreshold";

   function GetRestitutionThreshold
     (worldId_p : WorldId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_GetRestitutionThreshold";

   procedure SetHitEventThreshold
     (worldId_p : WorldId; value : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_SetHitEventThreshold";

   function GetHitEventThreshold
     (worldId_p : WorldId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_GetHitEventThreshold";

   procedure SetCustomFilterCallback
     (worldId_p : WorldId;
      fcn       : access CustomFilterFcn;
      context   : System.Address)
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_SetCustomFilterCallback";

   procedure SetPreSolveCallback
     (worldId_p : WorldId; fcn : access PreSolveFcn; context : System.Address)
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_SetPreSolveCallback";

   procedure SetGravity (worldId_p : WorldId; gravity : Vec2)
   with Import => True, Convention => C, External_Name => "b2World_SetGravity";

   function GetGravity (worldId_p : WorldId) return Vec2
   with Import => True, Convention => C, External_Name => "b2World_GetGravity";

   procedure Explode
     (worldId_p : WorldId; explosionDef_p : access ExplosionDef)
   with Import => True, Convention => C, External_Name => "b2World_Explode";

   procedure SetContactTuning
     (worldId_p    : WorldId;
      hertz        : Interfaces.C.C_float;
      dampingRatio : Interfaces.C.C_float;
      pushSpeed    : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_SetContactTuning";

   procedure SetMaximumLinearSpeed
     (worldId_p : WorldId; maximumLinearSpeed : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_SetMaximumLinearSpeed";

   function GetMaximumLinearSpeed
     (worldId_p : WorldId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_GetMaximumLinearSpeed";

   procedure EnableWarmStarting
     (worldId_p : WorldId; flag : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_EnableWarmStarting";

   function IsWarmStartingEnabled
     (worldId_p : WorldId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_IsWarmStartingEnabled";

   function GetAwakeBodyCount (worldId_p : WorldId) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_GetAwakeBodyCount";

   function GetProfile (worldId_p : WorldId) return Profile
   with Import => True, Convention => C, External_Name => "b2World_GetProfile";

   function GetCounters (worldId_p : WorldId) return Counters
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_GetCounters";

   procedure SetUserData (worldId_p : WorldId; userData : System.Address)
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_SetUserData";

   function GetUserData (worldId_p : WorldId) return System.Address
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_GetUserData";

   procedure SetFrictionCallback
     (worldId_p : WorldId; callback : access FrictionCallback)
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_SetFrictionCallback";

   procedure SetRestitutionCallback
     (worldId_p : WorldId; callback : access RestitutionCallback)
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_SetRestitutionCallback";

   procedure DumpMemoryStats (worldId_p : WorldId)
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_DumpMemoryStats";

   procedure RebuildStaticTree (worldId_p : WorldId)
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_RebuildStaticTree";

   procedure EnableSpeculative
     (worldId_p : WorldId; flag : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2World_EnableSpeculative";

   function CreateBody
     (worldId_p : WorldId; def : access BodyDef) return BodyId
   with Import => True, Convention => C, External_Name => "b2CreateBody";

   procedure DestroyBody (bodyId_p : BodyId)
   with Import => True, Convention => C, External_Name => "b2DestroyBody";

   function IsValid (id : BodyId) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2Body_IsValid";

   function GetType (bodyId_p : BodyId) return BodyType
   with Import => True, Convention => C, External_Name => "b2Body_GetType";

   procedure SetType (bodyId_p : BodyId; type_p : BodyType)
   with Import => True, Convention => C, External_Name => "b2Body_SetType";

   procedure SetName (bodyId_p : BodyId; name : Interfaces.C.Strings.chars_ptr)
   with Import => True, Convention => C, External_Name => "b2Body_SetName";

   procedure SetName (bodyId_p : BodyId; name : String);

   function GetName (bodyId_p : BodyId) return Interfaces.C.Strings.chars_ptr
   with Import => True, Convention => C, External_Name => "b2Body_GetName";

   procedure SetUserData (bodyId_p : BodyId; userData : System.Address)
   with Import => True, Convention => C, External_Name => "b2Body_SetUserData";

   function GetUserData (bodyId_p : BodyId) return System.Address
   with Import => True, Convention => C, External_Name => "b2Body_GetUserData";

   function GetPosition (bodyId_p : BodyId) return Vec2
   with Import => True, Convention => C, External_Name => "b2Body_GetPosition";

   function GetRotation (bodyId_p : BodyId) return Rot
   with Import => True, Convention => C, External_Name => "b2Body_GetRotation";

   function GetTransform (bodyId_p : BodyId) return Transform
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetTransform";

   procedure SetTransform (bodyId_p : BodyId; position : Vec2; rotation : Rot)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_SetTransform";

   function GetLocalPoint (bodyId_p : BodyId; worldPoint : Vec2) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetLocalPoint";

   function GetWorldPoint (bodyId_p : BodyId; localPoint : Vec2) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetWorldPoint";

   function GetLocalVector (bodyId_p : BodyId; worldVector : Vec2) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetLocalVector";

   function GetWorldVector (bodyId_p : BodyId; localVector : Vec2) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetWorldVector";

   function GetLinearVelocity (bodyId_p : BodyId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetLinearVelocity";

   function GetAngularVelocity (bodyId_p : BodyId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetAngularVelocity";

   procedure SetLinearVelocity (bodyId_p : BodyId; linearVelocity : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_SetLinearVelocity";

   procedure SetAngularVelocity
     (bodyId_p : BodyId; angularVelocity : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_SetAngularVelocity";

   procedure SetTargetTransform
     (bodyId_p : BodyId; target : Transform; timeStep : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_SetTargetTransform";

   function GetLocalPointVelocity
     (bodyId_p : BodyId; localPoint : Vec2) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetLocalPointVelocity";

   function GetWorldPointVelocity
     (bodyId_p : BodyId; worldPoint : Vec2) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetWorldPointVelocity";

   procedure ApplyForce
     (bodyId_p : BodyId;
      force    : Vec2;
      point    : Vec2;
      wake     : Interfaces.C.C_bool)
   with Import => True, Convention => C, External_Name => "b2Body_ApplyForce";

   procedure ApplyForceToCenter
     (bodyId_p : BodyId; force : Vec2; wake : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_ApplyForceToCenter";

   procedure ApplyTorque
     (bodyId_p : BodyId;
      torque   : Interfaces.C.C_float;
      wake     : Interfaces.C.C_bool)
   with Import => True, Convention => C, External_Name => "b2Body_ApplyTorque";

   procedure ApplyLinearImpulse
     (bodyId_p : BodyId;
      impulse  : Vec2;
      point    : Vec2;
      wake     : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_ApplyLinearImpulse";

   procedure ApplyLinearImpulseToCenter
     (bodyId_p : BodyId; impulse : Vec2; wake : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_ApplyLinearImpulseToCenter";

   procedure ApplyAngularImpulse
     (bodyId_p : BodyId;
      impulse  : Interfaces.C.C_float;
      wake     : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_ApplyAngularImpulse";

   function GetMass (bodyId_p : BodyId) return Interfaces.C.C_float
   with Import => True, Convention => C, External_Name => "b2Body_GetMass";

   function GetRotationalInertia
     (bodyId_p : BodyId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetRotationalInertia";

   function GetLocalCenterOfMass (bodyId_p : BodyId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetLocalCenterOfMass";

   function GetWorldCenterOfMass (bodyId_p : BodyId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetWorldCenterOfMass";

   procedure SetMassData (bodyId_p : BodyId; massData_p : MassData)
   with Import => True, Convention => C, External_Name => "b2Body_SetMassData";

   function GetMassData (bodyId_p : BodyId) return MassData
   with Import => True, Convention => C, External_Name => "b2Body_GetMassData";

   procedure ApplyMassFromShapes (bodyId_p : BodyId)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_ApplyMassFromShapes";

   procedure SetLinearDamping
     (bodyId_p : BodyId; linearDamping : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_SetLinearDamping";

   function GetLinearDamping (bodyId_p : BodyId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetLinearDamping";

   procedure SetAngularDamping
     (bodyId_p : BodyId; angularDamping : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_SetAngularDamping";

   function GetAngularDamping (bodyId_p : BodyId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetAngularDamping";

   procedure SetGravityScale
     (bodyId_p : BodyId; gravityScale : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_SetGravityScale";

   function GetGravityScale (bodyId_p : BodyId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetGravityScale";

   function IsAwake (bodyId_p : BodyId) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2Body_IsAwake";

   procedure SetAwake (bodyId_p : BodyId; awake : Interfaces.C.C_bool)
   with Import => True, Convention => C, External_Name => "b2Body_SetAwake";

   procedure EnableSleep (bodyId_p : BodyId; enableSleep : Interfaces.C.C_bool)
   with Import => True, Convention => C, External_Name => "b2Body_EnableSleep";

   function IsSleepEnabled (bodyId_p : BodyId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_IsSleepEnabled";

   procedure SetSleepThreshold
     (bodyId_p : BodyId; sleepThreshold : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_SetSleepThreshold";

   function GetSleepThreshold (bodyId_p : BodyId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetSleepThreshold";

   function IsEnabled (bodyId_p : BodyId) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2Body_IsEnabled";

   procedure Disable (bodyId_p : BodyId)
   with Import => True, Convention => C, External_Name => "b2Body_Disable";

   procedure Enable (bodyId_p : BodyId)
   with Import => True, Convention => C, External_Name => "b2Body_Enable";

   procedure SetFixedRotation (bodyId_p : BodyId; flag : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_SetFixedRotation";

   function IsFixedRotation (bodyId_p : BodyId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_IsFixedRotation";

   procedure SetBullet (bodyId_p : BodyId; flag : Interfaces.C.C_bool)
   with Import => True, Convention => C, External_Name => "b2Body_SetBullet";

   function IsBullet (bodyId_p : BodyId) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2Body_IsBullet";

   procedure EnableContactEvents
     (bodyId_p : BodyId; flag : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_EnableContactEvents";

   procedure EnableHitEvents (bodyId_p : BodyId; flag : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_EnableHitEvents";

   function GetWorld (bodyId_p : BodyId) return WorldId
   with Import => True, Convention => C, External_Name => "b2Body_GetWorld";

   function GetShapeCount (bodyId_p : BodyId) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetShapeCount";

   function GetShapes
     (bodyId_p   : BodyId;
      shapeArray : access ShapeId;
      capacity   : Interfaces.C.int) return Interfaces.C.int
   with Import => True, Convention => C, External_Name => "b2Body_GetShapes";

   function GetJointCount (bodyId_p : BodyId) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetJointCount";

   function GetJoints
     (bodyId_p   : BodyId;
      jointArray : access JointId;
      capacity   : Interfaces.C.int) return Interfaces.C.int
   with Import => True, Convention => C, External_Name => "b2Body_GetJoints";

   function GetContactCapacity (bodyId_p : BodyId) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetContactCapacity";

   function GetContactData
     (bodyId_p      : BodyId;
      contactData_p : access ContactData;
      capacity      : Interfaces.C.int) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2Body_GetContactData";

   function ComputeAABB (bodyId_p : BodyId) return AABB
   with Import => True, Convention => C, External_Name => "b2Body_ComputeAABB";

   function CreateCircleShape
     (bodyId_p : BodyId; def : access ShapeDef; circle_p : access Circle)
      return ShapeId
   with
     Import => True,
     Convention => C,
     External_Name => "b2CreateCircleShape";

   procedure CreateCircleShape
     (bodyId_p : BodyId; def : access ShapeDef; circle_p : access Circle)
   with
     Import => True,
     Convention => C,
     External_Name => "b2CreateCircleShape";

   function CreateSegmentShape
     (bodyId_p : BodyId; def : access ShapeDef; segment_p : access Segment)
      return ShapeId
   with
     Import => True,
     Convention => C,
     External_Name => "b2CreateSegmentShape";

   procedure CreateSegmentShape
     (bodyId_p : BodyId; def : access ShapeDef; segment_p : access Segment)
   with
     Import => True,
     Convention => C,
     External_Name => "b2CreateSegmentShape";

   function CreateCapsuleShape
     (bodyId_p : BodyId; def : access ShapeDef; capsule_p : access Capsule)
      return ShapeId
   with
     Import => True,
     Convention => C,
     External_Name => "b2CreateCapsuleShape";

   procedure CreateCapsuleShape
     (bodyId_p : BodyId; def : access ShapeDef; capsule_p : access Capsule)
   with
     Import => True,
     Convention => C,
     External_Name => "b2CreateCapsuleShape";

   function CreatePolygonShape
     (bodyId_p : BodyId; def : access ShapeDef; polygon_p : access Polygon)
      return ShapeId
   with
     Import => True,
     Convention => C,
     External_Name => "b2CreatePolygonShape";

   procedure CreatePolygonShape
     (bodyId_p : BodyId; def : access ShapeDef; polygon_p : access Polygon)
   with
     Import => True,
     Convention => C,
     External_Name => "b2CreatePolygonShape";

   procedure DestroyShape
     (shapeId_p : ShapeId; updateBodyMass : Interfaces.C.C_bool)
   with Import => True, Convention => C, External_Name => "b2DestroyShape";

   function IsValid (id : ShapeId) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2Shape_IsValid";

   function GetType (shapeId_p : ShapeId) return ShapeType
   with Import => True, Convention => C, External_Name => "b2Shape_GetType";

   function GetBody (shapeId_p : ShapeId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Shape_GetBody";

   function GetWorld (shapeId_p : ShapeId) return WorldId
   with Import => True, Convention => C, External_Name => "b2Shape_GetWorld";

   function IsSensor (shapeId_p : ShapeId) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2Shape_IsSensor";

   procedure SetUserData (shapeId_p : ShapeId; userData : System.Address)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_SetUserData";

   function GetUserData (shapeId_p : ShapeId) return System.Address
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_GetUserData";

   procedure SetDensity
     (shapeId_p      : ShapeId;
      density        : Interfaces.C.C_float;
      updateBodyMass : Interfaces.C.C_bool)
   with Import => True, Convention => C, External_Name => "b2Shape_SetDensity";

   function GetDensity (shapeId_p : ShapeId) return Interfaces.C.C_float
   with Import => True, Convention => C, External_Name => "b2Shape_GetDensity";

   procedure SetFriction (shapeId_p : ShapeId; friction : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_SetFriction";

   function GetFriction (shapeId_p : ShapeId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_GetFriction";

   procedure SetRestitution
     (shapeId_p : ShapeId; restitution : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_SetRestitution";

   function GetRestitution (shapeId_p : ShapeId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_GetRestitution";

   procedure SetMaterial (shapeId_p : ShapeId; material : Interfaces.C.int)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_SetMaterial";

   function GetMaterial (shapeId_p : ShapeId) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_GetMaterial";

   procedure SetSurfaceMaterial
     (shapeId_p : ShapeId; surfaceMaterial_p : SurfaceMaterial)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_SetSurfaceMaterial";

   function GetSurfaceMaterial (shapeId_p : ShapeId) return SurfaceMaterial
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_GetSurfaceMaterial";

   function GetFilter (shapeId_p : ShapeId) return Filter
   with Import => True, Convention => C, External_Name => "b2Shape_GetFilter";

   procedure SetFilter (shapeId_p : ShapeId; filter_p : Filter)
   with Import => True, Convention => C, External_Name => "b2Shape_SetFilter";

   procedure EnableSensorEvents
     (shapeId_p : ShapeId; flag : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_EnableSensorEvents";

   function AreSensorEventsEnabled
     (shapeId_p : ShapeId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_AreSensorEventsEnabled";

   procedure EnableContactEvents
     (shapeId_p : ShapeId; flag : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_EnableContactEvents";

   function AreContactEventsEnabled
     (shapeId_p : ShapeId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_AreContactEventsEnabled";

   procedure EnablePreSolveEvents
     (shapeId_p : ShapeId; flag : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_EnablePreSolveEvents";

   function ArePreSolveEventsEnabled
     (shapeId_p : ShapeId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_ArePreSolveEventsEnabled";

   procedure EnableHitEvents (shapeId_p : ShapeId; flag : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_EnableHitEvents";

   function AreHitEventsEnabled
     (shapeId_p : ShapeId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_AreHitEventsEnabled";

   function TestPoint
     (shapeId_p : ShapeId; point : Vec2) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2Shape_TestPoint";

   function RayCast
     (shapeId_p : ShapeId; input : access RayCastInput) return CastOutput
   with Import => True, Convention => C, External_Name => "b2Shape_RayCast";

   function GetCircle (shapeId_p : ShapeId) return Circle
   with Import => True, Convention => C, External_Name => "b2Shape_GetCircle";

   function GetSegment (shapeId_p : ShapeId) return Segment
   with Import => True, Convention => C, External_Name => "b2Shape_GetSegment";

   function GetChainSegment (shapeId_p : ShapeId) return ChainSegment
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_GetChainSegment";

   function GetCapsule (shapeId_p : ShapeId) return Capsule
   with Import => True, Convention => C, External_Name => "b2Shape_GetCapsule";

   function GetPolygon (shapeId_p : ShapeId) return Polygon
   with Import => True, Convention => C, External_Name => "b2Shape_GetPolygon";

   procedure SetCircle (shapeId_p : ShapeId; circle_p : access Circle)
   with Import => True, Convention => C, External_Name => "b2Shape_SetCircle";

   procedure SetCapsule (shapeId_p : ShapeId; capsule_p : access Capsule)
   with Import => True, Convention => C, External_Name => "b2Shape_SetCapsule";

   procedure SetSegment (shapeId_p : ShapeId; segment_p : access Segment)
   with Import => True, Convention => C, External_Name => "b2Shape_SetSegment";

   procedure SetPolygon (shapeId_p : ShapeId; polygon_p : access Polygon)
   with Import => True, Convention => C, External_Name => "b2Shape_SetPolygon";

   function GetParentChain (shapeId_p : ShapeId) return ChainId
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_GetParentChain";

   function GetContactCapacity (shapeId_p : ShapeId) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_GetContactCapacity";

   function GetContactData
     (shapeId_p     : ShapeId;
      contactData_p : access ContactData;
      capacity      : Interfaces.C.int) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_GetContactData";

   function GetSensorCapacity (shapeId_p : ShapeId) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_GetSensorCapacity";

   function GetSensorOverlaps
     (shapeId_p : ShapeId;
      overlaps  : access ShapeId;
      capacity  : Interfaces.C.int) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_GetSensorOverlaps";

   function GetAABB (shapeId_p : ShapeId) return AABB
   with Import => True, Convention => C, External_Name => "b2Shape_GetAABB";

   function GetMassData (shapeId_p : ShapeId) return MassData
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_GetMassData";

   function GetClosestPoint (shapeId_p : ShapeId; target : Vec2) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Shape_GetClosestPoint";

   function CreateChain
     (bodyId_p : BodyId; def : access ChainDef) return ChainId
   with Import => True, Convention => C, External_Name => "b2CreateChain";

   procedure DestroyChain (chainId_p : ChainId)
   with Import => True, Convention => C, External_Name => "b2DestroyChain";

   function GetWorld (chainId_p : ChainId) return WorldId
   with Import => True, Convention => C, External_Name => "b2Chain_GetWorld";

   function GetSegmentCount (chainId_p : ChainId) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2Chain_GetSegmentCount";

   function GetSegments
     (chainId_p    : ChainId;
      segmentArray : access ShapeId;
      capacity     : Interfaces.C.int) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2Chain_GetSegments";

   procedure SetFriction (chainId_p : ChainId; friction : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Chain_SetFriction";

   function GetFriction (chainId_p : ChainId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Chain_GetFriction";

   procedure SetRestitution
     (chainId_p : ChainId; restitution : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Chain_SetRestitution";

   function GetRestitution (chainId_p : ChainId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Chain_GetRestitution";

   procedure SetMaterial (chainId_p : ChainId; material : Interfaces.C.int)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Chain_SetMaterial";

   function GetMaterial (chainId_p : ChainId) return Interfaces.C.int
   with
     Import => True,
     Convention => C,
     External_Name => "b2Chain_GetMaterial";

   function IsValid (id : ChainId) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2Chain_IsValid";

   procedure DestroyJoint (Id : JointId)
   with Import => True, Convention => C, External_Name => "b2DestroyJoint";

   procedure DestroyJoint (Id : DistanceJointId)
   with Import => True, Convention => C, External_Name => "b2DestroyJoint";

   procedure DestroyJoint (Id : MotorJointId)
   with Import => True, Convention => C, External_Name => "b2DestroyJoint";

   procedure DestroyJoint (Id : RevoluteJointId)
   with Import => True, Convention => C, External_Name => "b2DestroyJoint";

   procedure DestroyJoint (Id : PrismaticJointId)
   with Import => True, Convention => C, External_Name => "b2DestroyJoint";

   procedure DestroyJoint (Id : MouseJointId)
   with Import => True, Convention => C, External_Name => "b2DestroyJoint";

   procedure DestroyJoint (Id : FilterJointId)
   with Import => True, Convention => C, External_Name => "b2DestroyJoint";

   procedure DestroyJoint (Id : WeldJointId)
   with Import => True, Convention => C, External_Name => "b2DestroyJoint";

   procedure DestroyJoint (Id : WheelJointId)
   with Import => True, Convention => C, External_Name => "b2DestroyJoint";

   function IsValid (id : JointId) return Interfaces.C.C_bool
   with Import => True, Convention => C, External_Name => "b2Joint_IsValid";

   function GetType (Id : JointId) return JointType
   with Import => True, Convention => C, External_Name => "b2Joint_GetType";

   function IsValid (Id : DistanceJointId) return Boolean
   is (IsValid (AsJoint (Id)) = True
       and then GetType (AsJoint (Id)) = DistanceJoint);
   --  Check the the joint is valid and has the correct underlying type

   function IsValid (Id : MotorJointId) return Boolean
   is (IsValid (AsJoint (Id)) = True
       and then GetType (AsJoint (Id)) = MotorJoint);
   --  Check the the joint is valid and has the correct underlying type

   function IsValid (Id : RevoluteJointId) return Boolean
   is (IsValid (AsJoint (Id)) = True
       and then GetType (AsJoint (Id)) = RevoluteJoint);
   --  Check the the joint is valid and has the correct underlying type

   function IsValid (Id : PrismaticJointId) return Boolean
   is (IsValid (AsJoint (Id)) = True
       and then GetType (AsJoint (Id)) = PrismaticJoint);
   --  Check the the joint is valid and has the correct underlying type

   function IsValid (Id : MouseJointId) return Boolean
   is (IsValid (AsJoint (Id)) = True
       and then GetType (AsJoint (Id)) = MouseJoint);
   --  Check the the joint is valid and has the correct underlying type

   function IsValid (Id : FilterJointId) return Boolean
   is (IsValid (AsJoint (Id)) = True
       and then GetType (AsJoint (Id)) = FilterJoint);
   --  Check the the joint is valid and has the correct underlying type

   function IsValid (Id : WeldJointId) return Boolean
   is (IsValid (AsJoint (Id)) = True
       and then GetType (AsJoint (Id)) = WeldJoint);
   --  Check the the joint is valid and has the correct underlying type

   function IsValid (Id : WheelJointId) return Boolean
   is (IsValid (AsJoint (Id)) = True
       and then GetType (AsJoint (Id)) = WheelJoint);
   --  Check the the joint is valid and has the correct underlying type

   function GetType (Id : DistanceJointId) return JointType
   with Import => True, Convention => C, External_Name => "b2Joint_GetType";

   function GetType (Id : MotorJointId) return JointType
   with Import => True, Convention => C, External_Name => "b2Joint_GetType";

   function GetType (Id : RevoluteJointId) return JointType
   with Import => True, Convention => C, External_Name => "b2Joint_GetType";

   function GetType (Id : PrismaticJointId) return JointType
   with Import => True, Convention => C, External_Name => "b2Joint_GetType";

   function GetType (Id : MouseJointId) return JointType
   with Import => True, Convention => C, External_Name => "b2Joint_GetType";

   function GetType (Id : FilterJointId) return JointType
   with Import => True, Convention => C, External_Name => "b2Joint_GetType";

   function GetType (Id : WeldJointId) return JointType
   with Import => True, Convention => C, External_Name => "b2Joint_GetType";

   function GetType (Id : WheelJointId) return JointType
   with Import => True, Convention => C, External_Name => "b2Joint_GetType";

   function GetBodyA (Id : JointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyA";

   function GetBodyA (Id : DistanceJointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyA";

   function GetBodyA (Id : MotorJointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyA";

   function GetBodyA (Id : RevoluteJointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyA";

   function GetBodyA (Id : PrismaticJointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyA";

   function GetBodyA (Id : MouseJointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyA";

   function GetBodyA (Id : FilterJointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyA";

   function GetBodyA (Id : WeldJointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyA";

   function GetBodyA (Id : WheelJointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyA";

   function GetBodyB (Id : JointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyB";

   function GetBodyB (Id : DistanceJointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyB";

   function GetBodyB (Id : MotorJointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyB";

   function GetBodyB (Id : RevoluteJointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyB";

   function GetBodyB (Id : PrismaticJointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyB";

   function GetBodyB (Id : MouseJointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyB";

   function GetBodyB (Id : FilterJointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyB";

   function GetBodyB (Id : WeldJointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyB";

   function GetBodyB (Id : WheelJointId) return BodyId
   with Import => True, Convention => C, External_Name => "b2Joint_GetBodyB";

   function GetWorld (Id : JointId) return WorldId
   with Import => True, Convention => C, External_Name => "b2Joint_GetWorld";

   function GetWorld (Id : DistanceJointId) return WorldId
   with Import => True, Convention => C, External_Name => "b2Joint_GetWorld";

   function GetWorld (Id : MotorJointId) return WorldId
   with Import => True, Convention => C, External_Name => "b2Joint_GetWorld";

   function GetWorld (Id : RevoluteJointId) return WorldId
   with Import => True, Convention => C, External_Name => "b2Joint_GetWorld";

   function GetWorld (Id : PrismaticJointId) return WorldId
   with Import => True, Convention => C, External_Name => "b2Joint_GetWorld";

   function GetWorld (Id : MouseJointId) return WorldId
   with Import => True, Convention => C, External_Name => "b2Joint_GetWorld";

   function GetWorld (Id : FilterJointId) return WorldId
   with Import => True, Convention => C, External_Name => "b2Joint_GetWorld";

   function GetWorld (Id : WeldJointId) return WorldId
   with Import => True, Convention => C, External_Name => "b2Joint_GetWorld";

   function GetWorld (Id : WheelJointId) return WorldId
   with Import => True, Convention => C, External_Name => "b2Joint_GetWorld";

   procedure SetLocalAnchorA (Id : JointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorA";

   procedure SetLocalAnchorA (Id : DistanceJointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorA";

   procedure SetLocalAnchorA (Id : MotorJointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorA";

   procedure SetLocalAnchorA (Id : RevoluteJointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorA";

   procedure SetLocalAnchorA (Id : PrismaticJointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorA";

   procedure SetLocalAnchorA (Id : MouseJointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorA";

   procedure SetLocalAnchorA (Id : FilterJointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorA";

   procedure SetLocalAnchorA (Id : WeldJointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorA";

   procedure SetLocalAnchorA (Id : WheelJointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorA";

   function GetLocalAnchorA (Id : JointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorA";

   function GetLocalAnchorA (Id : DistanceJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorA";

   function GetLocalAnchorA (Id : MotorJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorA";

   function GetLocalAnchorA (Id : RevoluteJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorA";

   function GetLocalAnchorA (Id : PrismaticJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorA";

   function GetLocalAnchorA (Id : MouseJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorA";

   function GetLocalAnchorA (Id : FilterJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorA";

   function GetLocalAnchorA (Id : WeldJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorA";

   function GetLocalAnchorA (Id : WheelJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorA";

   procedure SetLocalAnchorB (Id : JointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorB";

   procedure SetLocalAnchorB (Id : DistanceJointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorB";

   procedure SetLocalAnchorB (Id : MotorJointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorB";

   procedure SetLocalAnchorB (Id : RevoluteJointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorB";

   procedure SetLocalAnchorB (Id : PrismaticJointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorB";

   procedure SetLocalAnchorB (Id : MouseJointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorB";

   procedure SetLocalAnchorB (Id : FilterJointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorB";

   procedure SetLocalAnchorB (Id : WeldJointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorB";

   procedure SetLocalAnchorB (Id : WheelJointId; localAnchor : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAnchorB";

   function GetLocalAnchorB (Id : JointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorB";

   function GetLocalAnchorB (Id : DistanceJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorB";

   function GetLocalAnchorB (Id : MotorJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorB";

   function GetLocalAnchorB (Id : RevoluteJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorB";

   function GetLocalAnchorB (Id : PrismaticJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorB";

   function GetLocalAnchorB (Id : MouseJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorB";

   function GetLocalAnchorB (Id : FilterJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorB";

   function GetLocalAnchorB (Id : WeldJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorB";

   function GetLocalAnchorB (Id : WheelJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAnchorB";

   function GetReferenceAngle (Id : JointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetReferenceAngle";

   function GetReferenceAngle
     (Id : DistanceJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetReferenceAngle";

   function GetReferenceAngle (Id : MotorJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetReferenceAngle";

   function GetReferenceAngle
     (Id : RevoluteJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetReferenceAngle";

   function GetReferenceAngle
     (Id : PrismaticJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetReferenceAngle";

   function GetReferenceAngle (Id : MouseJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetReferenceAngle";

   function GetReferenceAngle (Id : FilterJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetReferenceAngle";

   function GetReferenceAngle (Id : WeldJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetReferenceAngle";

   function GetReferenceAngle (Id : WheelJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetReferenceAngle";

   procedure SetReferenceAngle
     (Id : JointId; angleInRadians : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetReferenceAngle";

   procedure SetReferenceAngle
     (Id : DistanceJointId; angleInRadians : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetReferenceAngle";

   procedure SetReferenceAngle
     (Id : MotorJointId; angleInRadians : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetReferenceAngle";

   procedure SetReferenceAngle
     (Id : RevoluteJointId; angleInRadians : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetReferenceAngle";

   procedure SetReferenceAngle
     (Id : PrismaticJointId; angleInRadians : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetReferenceAngle";

   procedure SetReferenceAngle
     (Id : MouseJointId; angleInRadians : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetReferenceAngle";

   procedure SetReferenceAngle
     (Id : FilterJointId; angleInRadians : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetReferenceAngle";

   procedure SetReferenceAngle
     (Id : WeldJointId; angleInRadians : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetReferenceAngle";

   procedure SetReferenceAngle
     (Id : WheelJointId; angleInRadians : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetReferenceAngle";

   procedure SetLocalAxisA (Id : JointId; localAxis : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAxisA";

   procedure SetLocalAxisA (Id : DistanceJointId; localAxis : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAxisA";

   procedure SetLocalAxisA (Id : MotorJointId; localAxis : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAxisA";

   procedure SetLocalAxisA (Id : RevoluteJointId; localAxis : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAxisA";

   procedure SetLocalAxisA (Id : PrismaticJointId; localAxis : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAxisA";

   procedure SetLocalAxisA (Id : MouseJointId; localAxis : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAxisA";

   procedure SetLocalAxisA (Id : FilterJointId; localAxis : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAxisA";

   procedure SetLocalAxisA (Id : WeldJointId; localAxis : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAxisA";

   procedure SetLocalAxisA (Id : WheelJointId; localAxis : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetLocalAxisA";

   function GetLocalAxisA (Id : JointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAxisA";

   function GetLocalAxisA (Id : DistanceJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAxisA";

   function GetLocalAxisA (Id : MotorJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAxisA";

   function GetLocalAxisA (Id : RevoluteJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAxisA";

   function GetLocalAxisA (Id : PrismaticJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAxisA";

   function GetLocalAxisA (Id : MouseJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAxisA";

   function GetLocalAxisA (Id : FilterJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAxisA";

   function GetLocalAxisA (Id : WeldJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAxisA";

   function GetLocalAxisA (Id : WheelJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLocalAxisA";

   procedure SetCollideConnected
     (Id : JointId; shouldCollide : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetCollideConnected";

   procedure SetCollideConnected
     (Id : DistanceJointId; shouldCollide : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetCollideConnected";

   procedure SetCollideConnected
     (Id : MotorJointId; shouldCollide : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetCollideConnected";

   procedure SetCollideConnected
     (Id : RevoluteJointId; shouldCollide : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetCollideConnected";

   procedure SetCollideConnected
     (Id : PrismaticJointId; shouldCollide : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetCollideConnected";

   procedure SetCollideConnected
     (Id : MouseJointId; shouldCollide : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetCollideConnected";

   procedure SetCollideConnected
     (Id : FilterJointId; shouldCollide : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetCollideConnected";

   procedure SetCollideConnected
     (Id : WeldJointId; shouldCollide : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetCollideConnected";

   procedure SetCollideConnected
     (Id : WheelJointId; shouldCollide : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetCollideConnected";

   function GetCollideConnected (Id : JointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetCollideConnected";

   function GetCollideConnected
     (Id : DistanceJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetCollideConnected";

   function GetCollideConnected (Id : MotorJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetCollideConnected";

   function GetCollideConnected
     (Id : RevoluteJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetCollideConnected";

   function GetCollideConnected
     (Id : PrismaticJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetCollideConnected";

   function GetCollideConnected (Id : MouseJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetCollideConnected";

   function GetCollideConnected (Id : FilterJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetCollideConnected";

   function GetCollideConnected (Id : WeldJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetCollideConnected";

   function GetCollideConnected (Id : WheelJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetCollideConnected";

   procedure SetUserData (Id : JointId; userData : System.Address)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetUserData";

   procedure SetUserData (Id : DistanceJointId; userData : System.Address)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetUserData";

   procedure SetUserData (Id : MotorJointId; userData : System.Address)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetUserData";

   procedure SetUserData (Id : RevoluteJointId; userData : System.Address)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetUserData";

   procedure SetUserData (Id : PrismaticJointId; userData : System.Address)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetUserData";

   procedure SetUserData (Id : MouseJointId; userData : System.Address)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetUserData";

   procedure SetUserData (Id : FilterJointId; userData : System.Address)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetUserData";

   procedure SetUserData (Id : WeldJointId; userData : System.Address)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetUserData";

   procedure SetUserData (Id : WheelJointId; userData : System.Address)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetUserData";

   function GetUserData (Id : JointId) return System.Address
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetUserData";

   function GetUserData (Id : DistanceJointId) return System.Address
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetUserData";

   function GetUserData (Id : MotorJointId) return System.Address
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetUserData";

   function GetUserData (Id : RevoluteJointId) return System.Address
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetUserData";

   function GetUserData (Id : PrismaticJointId) return System.Address
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetUserData";

   function GetUserData (Id : MouseJointId) return System.Address
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetUserData";

   function GetUserData (Id : FilterJointId) return System.Address
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetUserData";

   function GetUserData (Id : WeldJointId) return System.Address
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetUserData";

   function GetUserData (Id : WheelJointId) return System.Address
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetUserData";

   procedure WakeBodies (Id : JointId)
   with Import => True, Convention => C, External_Name => "b2Joint_WakeBodies";

   procedure WakeBodies (Id : DistanceJointId)
   with Import => True, Convention => C, External_Name => "b2Joint_WakeBodies";

   procedure WakeBodies (Id : MotorJointId)
   with Import => True, Convention => C, External_Name => "b2Joint_WakeBodies";

   procedure WakeBodies (Id : RevoluteJointId)
   with Import => True, Convention => C, External_Name => "b2Joint_WakeBodies";

   procedure WakeBodies (Id : PrismaticJointId)
   with Import => True, Convention => C, External_Name => "b2Joint_WakeBodies";

   procedure WakeBodies (Id : MouseJointId)
   with Import => True, Convention => C, External_Name => "b2Joint_WakeBodies";

   procedure WakeBodies (Id : FilterJointId)
   with Import => True, Convention => C, External_Name => "b2Joint_WakeBodies";

   procedure WakeBodies (Id : WeldJointId)
   with Import => True, Convention => C, External_Name => "b2Joint_WakeBodies";

   procedure WakeBodies (Id : WheelJointId)
   with Import => True, Convention => C, External_Name => "b2Joint_WakeBodies";

   function GetConstraintForce (Id : JointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintForce";

   function GetConstraintForce (Id : DistanceJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintForce";

   function GetConstraintForce (Id : MotorJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintForce";

   function GetConstraintForce (Id : RevoluteJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintForce";

   function GetConstraintForce (Id : PrismaticJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintForce";

   function GetConstraintForce (Id : MouseJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintForce";

   function GetConstraintForce (Id : FilterJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintForce";

   function GetConstraintForce (Id : WeldJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintForce";

   function GetConstraintForce (Id : WheelJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintForce";

   function GetConstraintTorque (Id : JointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTorque";

   function GetConstraintTorque
     (Id : DistanceJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTorque";

   function GetConstraintTorque (Id : MotorJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTorque";

   function GetConstraintTorque
     (Id : RevoluteJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTorque";

   function GetConstraintTorque
     (Id : PrismaticJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTorque";

   function GetConstraintTorque (Id : MouseJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTorque";

   function GetConstraintTorque
     (Id : FilterJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTorque";

   function GetConstraintTorque (Id : WeldJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTorque";

   function GetConstraintTorque (Id : WheelJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTorque";

   function GetLinearSeparation (Id : JointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLinearSeparation";

   function GetLinearSeparation
     (Id : DistanceJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLinearSeparation";

   function GetLinearSeparation (Id : MotorJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLinearSeparation";

   function GetLinearSeparation
     (Id : RevoluteJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLinearSeparation";

   function GetLinearSeparation
     (Id : PrismaticJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLinearSeparation";

   function GetLinearSeparation (Id : MouseJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLinearSeparation";

   function GetLinearSeparation
     (Id : FilterJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLinearSeparation";

   function GetLinearSeparation (Id : WeldJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLinearSeparation";

   function GetLinearSeparation (Id : WheelJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetLinearSeparation";

   function GetAngularSeparation (Id : JointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetAngularSeparation";

   function GetAngularSeparation
     (Id : DistanceJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetAngularSeparation";

   function GetAngularSeparation
     (Id : MotorJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetAngularSeparation";

   function GetAngularSeparation
     (Id : RevoluteJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetAngularSeparation";

   function GetAngularSeparation
     (Id : PrismaticJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetAngularSeparation";

   function GetAngularSeparation
     (Id : MouseJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetAngularSeparation";

   function GetAngularSeparation
     (Id : FilterJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetAngularSeparation";

   function GetAngularSeparation (Id : WeldJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetAngularSeparation";

   function GetAngularSeparation
     (Id : WheelJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetAngularSeparation";

   procedure GetConstraintTuning
     (Id           : JointId;
      hertz        : access Interfaces.C.C_float;
      dampingRatio : access Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTuning";

   procedure GetConstraintTuning
     (Id           : DistanceJointId;
      hertz        : access Interfaces.C.C_float;
      dampingRatio : access Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTuning";

   procedure GetConstraintTuning
     (Id           : MotorJointId;
      hertz        : access Interfaces.C.C_float;
      dampingRatio : access Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTuning";

   procedure GetConstraintTuning
     (Id           : RevoluteJointId;
      hertz        : access Interfaces.C.C_float;
      dampingRatio : access Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTuning";

   procedure GetConstraintTuning
     (Id           : PrismaticJointId;
      hertz        : access Interfaces.C.C_float;
      dampingRatio : access Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTuning";

   procedure GetConstraintTuning
     (Id           : MouseJointId;
      hertz        : access Interfaces.C.C_float;
      dampingRatio : access Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTuning";

   procedure GetConstraintTuning
     (Id           : FilterJointId;
      hertz        : access Interfaces.C.C_float;
      dampingRatio : access Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTuning";

   procedure GetConstraintTuning
     (Id           : WeldJointId;
      hertz        : access Interfaces.C.C_float;
      dampingRatio : access Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTuning";

   procedure GetConstraintTuning
     (Id           : WheelJointId;
      hertz        : access Interfaces.C.C_float;
      dampingRatio : access Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_GetConstraintTuning";

   procedure SetConstraintTuning
     (Id           : JointId;
      hertz        : Interfaces.C.C_float;
      dampingRatio : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetConstraintTuning";

   procedure SetConstraintTuning
     (Id           : DistanceJointId;
      hertz        : Interfaces.C.C_float;
      dampingRatio : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetConstraintTuning";

   procedure SetConstraintTuning
     (Id           : MotorJointId;
      hertz        : Interfaces.C.C_float;
      dampingRatio : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetConstraintTuning";

   procedure SetConstraintTuning
     (Id           : RevoluteJointId;
      hertz        : Interfaces.C.C_float;
      dampingRatio : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetConstraintTuning";

   procedure SetConstraintTuning
     (Id           : PrismaticJointId;
      hertz        : Interfaces.C.C_float;
      dampingRatio : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetConstraintTuning";

   procedure SetConstraintTuning
     (Id           : MouseJointId;
      hertz        : Interfaces.C.C_float;
      dampingRatio : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetConstraintTuning";

   procedure SetConstraintTuning
     (Id           : FilterJointId;
      hertz        : Interfaces.C.C_float;
      dampingRatio : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetConstraintTuning";

   procedure SetConstraintTuning
     (Id           : WeldJointId;
      hertz        : Interfaces.C.C_float;
      dampingRatio : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetConstraintTuning";

   procedure SetConstraintTuning
     (Id           : WheelJointId;
      hertz        : Interfaces.C.C_float;
      dampingRatio : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2Joint_SetConstraintTuning";

   function CreateDistanceJoint
     (worldId_p : WorldId; def : access DistanceJointDef)
      return DistanceJointId
   with
     Import => True,
     Convention => C,
     External_Name => "b2CreateDistanceJoint";

   procedure SetLength (Id : DistanceJointId; length : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_SetLength";

   function GetLength (Id : DistanceJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_GetLength";

   procedure EnableSpring
     (Id : DistanceJointId; enableSpring : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_EnableSpring";

   function IsSpringEnabled (Id : DistanceJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_IsSpringEnabled";

   procedure SetSpringHertz
     (Id : DistanceJointId; hertz : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_SetSpringHertz";

   procedure SetSpringDampingRatio
     (Id : DistanceJointId; dampingRatio : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_SetSpringDampingRatio";

   function GetSpringHertz (Id : DistanceJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_GetSpringHertz";

   function GetSpringDampingRatio
     (Id : DistanceJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_GetSpringDampingRatio";

   procedure EnableLimit
     (Id : DistanceJointId; enableLimit : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_EnableLimit";

   function IsLimitEnabled (Id : DistanceJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_IsLimitEnabled";

   procedure SetLengthRange
     (Id        : DistanceJointId;
      minLength : Interfaces.C.C_float;
      maxLength : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_SetLengthRange";

   function GetMinLength (Id : DistanceJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_GetMinLength";

   function GetMaxLength (Id : DistanceJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_GetMaxLength";

   function GetCurrentLength (Id : DistanceJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_GetCurrentLength";

   procedure EnableMotor
     (Id : DistanceJointId; enableMotor : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_EnableMotor";

   function IsMotorEnabled (Id : DistanceJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_IsMotorEnabled";

   procedure SetMotorSpeed
     (Id : DistanceJointId; motorSpeed : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_SetMotorSpeed";

   function GetMotorSpeed (Id : DistanceJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_GetMotorSpeed";

   procedure SetMaxMotorForce
     (Id : DistanceJointId; force : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_SetMaxMotorForce";

   function GetMaxMotorForce (Id : DistanceJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_GetMaxMotorForce";

   function GetMotorForce (Id : DistanceJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2DistanceJoint_GetMotorForce";

   function CreateMotorJoint
     (worldId_p : WorldId; def : access MotorJointDef) return MotorJointId
   with Import => True, Convention => C, External_Name => "b2CreateMotorJoint";

   procedure SetLinearOffset (Id : MotorJointId; linearOffset : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2MotorJoint_SetLinearOffset";

   function GetLinearOffset (Id : MotorJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2MotorJoint_GetLinearOffset";

   procedure SetAngularOffset
     (Id : MotorJointId; angularOffset : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2MotorJoint_SetAngularOffset";

   function GetAngularOffset (Id : MotorJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2MotorJoint_GetAngularOffset";

   procedure SetMaxForce (Id : MotorJointId; maxForce : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2MotorJoint_SetMaxForce";

   function GetMaxForce (Id : MotorJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2MotorJoint_GetMaxForce";

   procedure SetMaxTorque (Id : MotorJointId; maxTorque : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2MotorJoint_SetMaxTorque";

   function GetMaxTorque (Id : MotorJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2MotorJoint_GetMaxTorque";

   procedure SetCorrectionFactor
     (Id : MotorJointId; correctionFactor : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2MotorJoint_SetCorrectionFactor";

   function GetCorrectionFactor (Id : MotorJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2MotorJoint_GetCorrectionFactor";

   function CreateMouseJoint
     (worldId_p : WorldId; def : access MouseJointDef) return MouseJointId
   with Import => True, Convention => C, External_Name => "b2CreateMouseJoint";

   procedure SetTarget (Id : MouseJointId; target : Vec2)
   with
     Import => True,
     Convention => C,
     External_Name => "b2MouseJoint_SetTarget";

   function GetTarget (Id : MouseJointId) return Vec2
   with
     Import => True,
     Convention => C,
     External_Name => "b2MouseJoint_GetTarget";

   procedure SetSpringHertz (Id : MouseJointId; hertz : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2MouseJoint_SetSpringHertz";

   function GetSpringHertz (Id : MouseJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2MouseJoint_GetSpringHertz";

   procedure SetSpringDampingRatio
     (Id : MouseJointId; dampingRatio : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2MouseJoint_SetSpringDampingRatio";

   function GetSpringDampingRatio
     (Id : MouseJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2MouseJoint_GetSpringDampingRatio";

   procedure SetMaxForce (Id : MouseJointId; maxForce : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2MouseJoint_SetMaxForce";

   function GetMaxForce (Id : MouseJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2MouseJoint_GetMaxForce";

   function CreateFilterJoint
     (worldId_p : WorldId; def : access FilterJointDef) return FilterJointId
   with
     Import => True,
     Convention => C,
     External_Name => "b2CreateFilterJoint";

   function CreatePrismaticJoint
     (worldId_p : WorldId; def : access PrismaticJointDef)
      return PrismaticJointId
   with
     Import => True,
     Convention => C,
     External_Name => "b2CreatePrismaticJoint";

   procedure EnableSpring
     (Id : PrismaticJointId; enableSpring : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_EnableSpring";

   function IsSpringEnabled (Id : PrismaticJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_IsSpringEnabled";

   procedure SetSpringHertz
     (Id : PrismaticJointId; hertz : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_SetSpringHertz";

   function GetSpringHertz (Id : PrismaticJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_GetSpringHertz";

   procedure SetSpringDampingRatio
     (Id : PrismaticJointId; dampingRatio : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_SetSpringDampingRatio";

   function GetSpringDampingRatio
     (Id : PrismaticJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_GetSpringDampingRatio";

   procedure SetTargetTranslation
     (Id : PrismaticJointId; translation : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_SetTargetTranslation";

   function GetTargetTranslation
     (Id : PrismaticJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_GetTargetTranslation";

   procedure EnableLimit
     (Id : PrismaticJointId; enableLimit : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_EnableLimit";

   function IsLimitEnabled (Id : PrismaticJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_IsLimitEnabled";

   function GetLowerLimit (Id : PrismaticJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_GetLowerLimit";

   function GetUpperLimit (Id : PrismaticJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_GetUpperLimit";

   procedure SetLimits
     (Id    : PrismaticJointId;
      lower : Interfaces.C.C_float;
      upper : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_SetLimits";

   procedure EnableMotor
     (Id : PrismaticJointId; enableMotor : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_EnableMotor";

   function IsMotorEnabled (Id : PrismaticJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_IsMotorEnabled";

   procedure SetMotorSpeed
     (Id : PrismaticJointId; motorSpeed : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_SetMotorSpeed";

   function GetMotorSpeed (Id : PrismaticJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_GetMotorSpeed";

   procedure SetMaxMotorForce
     (Id : PrismaticJointId; force : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_SetMaxMotorForce";

   function GetMaxMotorForce
     (Id : PrismaticJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_GetMaxMotorForce";

   function GetMotorForce (Id : PrismaticJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_GetMotorForce";

   function GetTranslation (Id : PrismaticJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_GetTranslation";

   function GetSpeed (Id : PrismaticJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2PrismaticJoint_GetSpeed";

   function CreateRevoluteJoint
     (worldId_p : WorldId; def : access RevoluteJointDef)
      return RevoluteJointId
   with
     Import => True,
     Convention => C,
     External_Name => "b2CreateRevoluteJoint";

   procedure EnableSpring
     (Id : RevoluteJointId; enableSpring : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_EnableSpring";

   function IsSpringEnabled (Id : RevoluteJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_IsSpringEnabled";

   procedure SetSpringHertz
     (Id : RevoluteJointId; hertz : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_SetSpringHertz";

   function GetSpringHertz (Id : RevoluteJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_GetSpringHertz";

   procedure SetSpringDampingRatio
     (Id : RevoluteJointId; dampingRatio : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_SetSpringDampingRatio";

   function GetSpringDampingRatio
     (Id : RevoluteJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_GetSpringDampingRatio";

   procedure SetTargetAngle
     (Id : RevoluteJointId; angle : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_SetTargetAngle";

   function GetTargetAngle (Id : RevoluteJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_GetTargetAngle";

   function GetAngle (Id : RevoluteJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_GetAngle";

   procedure EnableLimit
     (Id : RevoluteJointId; enableLimit : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_EnableLimit";

   function IsLimitEnabled (Id : RevoluteJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_IsLimitEnabled";

   function GetLowerLimit (Id : RevoluteJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_GetLowerLimit";

   function GetUpperLimit (Id : RevoluteJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_GetUpperLimit";

   procedure SetLimits
     (Id    : RevoluteJointId;
      lower : Interfaces.C.C_float;
      upper : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_SetLimits";

   procedure EnableMotor
     (Id : RevoluteJointId; enableMotor : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_EnableMotor";

   function IsMotorEnabled (Id : RevoluteJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_IsMotorEnabled";

   procedure SetMotorSpeed
     (Id : RevoluteJointId; motorSpeed : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_SetMotorSpeed";

   function GetMotorSpeed (Id : RevoluteJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_GetMotorSpeed";

   function GetMotorTorque (Id : RevoluteJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_GetMotorTorque";

   procedure SetMaxMotorTorque
     (Id : RevoluteJointId; torque : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_SetMaxMotorTorque";

   function GetMaxMotorTorque
     (Id : RevoluteJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2RevoluteJoint_GetMaxMotorTorque";

   function CreateWeldJoint
     (worldId_p : WorldId; def : access WeldJointDef) return WeldJointId
   with Import => True, Convention => C, External_Name => "b2CreateWeldJoint";

   procedure SetLinearHertz (Id : WeldJointId; hertz : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2WeldJoint_SetLinearHertz";

   function GetLinearHertz (Id : WeldJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2WeldJoint_GetLinearHertz";

   procedure SetLinearDampingRatio
     (Id : WeldJointId; dampingRatio : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2WeldJoint_SetLinearDampingRatio";

   function GetLinearDampingRatio
     (Id : WeldJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2WeldJoint_GetLinearDampingRatio";

   procedure SetAngularHertz (Id : WeldJointId; hertz : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2WeldJoint_SetAngularHertz";

   function GetAngularHertz (Id : WeldJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2WeldJoint_GetAngularHertz";

   procedure SetAngularDampingRatio
     (Id : WeldJointId; dampingRatio : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2WeldJoint_SetAngularDampingRatio";

   function GetAngularDampingRatio
     (Id : WeldJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2WeldJoint_GetAngularDampingRatio";

   function CreateWheelJoint
     (worldId_p : WorldId; def : access WheelJointDef) return WheelJointId
   with Import => True, Convention => C, External_Name => "b2CreateWheelJoint";

   procedure EnableSpring
     (Id : WheelJointId; enableSpring : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_EnableSpring";

   function IsSpringEnabled (Id : WheelJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_IsSpringEnabled";

   procedure SetSpringHertz (Id : WheelJointId; hertz : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_SetSpringHertz";

   function GetSpringHertz (Id : WheelJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_GetSpringHertz";

   procedure SetSpringDampingRatio
     (Id : WheelJointId; dampingRatio : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_SetSpringDampingRatio";

   function GetSpringDampingRatio
     (Id : WheelJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_GetSpringDampingRatio";

   procedure EnableLimit (Id : WheelJointId; enableLimit : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_EnableLimit";

   function IsLimitEnabled (Id : WheelJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_IsLimitEnabled";

   function GetLowerLimit (Id : WheelJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_GetLowerLimit";

   function GetUpperLimit (Id : WheelJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_GetUpperLimit";

   procedure SetLimits
     (Id    : WheelJointId;
      lower : Interfaces.C.C_float;
      upper : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_SetLimits";

   procedure EnableMotor (Id : WheelJointId; enableMotor : Interfaces.C.C_bool)
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_EnableMotor";

   function IsMotorEnabled (Id : WheelJointId) return Interfaces.C.C_bool
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_IsMotorEnabled";

   procedure SetMotorSpeed
     (Id : WheelJointId; motorSpeed : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_SetMotorSpeed";

   function GetMotorSpeed (Id : WheelJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_GetMotorSpeed";

   procedure SetMaxMotorTorque
     (Id : WheelJointId; torque : Interfaces.C.C_float)
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_SetMaxMotorTorque";

   function GetMaxMotorTorque (Id : WheelJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_GetMaxMotorTorque";

   function GetMotorTorque (Id : WheelJointId) return Interfaces.C.C_float
   with
     Import => True,
     Convention => C,
     External_Name => "b2WheelJoint_GetMotorTorque";

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
   is (((1.0 - T) * A.x + T * B.x, (1.0 - T) * A.y + T * B.y));
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

   function Clamp (A, Lower, Upper : C_float) return C_float
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
   is (if Length (V) < C_float'Model_Epsilon then (0.0, 0.0)
       else ((1.0 / Length (V)) * V.x, (1.0 / Length (V)) * V.y));
   --  Convert a vector into a unit vector if possible, otherwise returns the zero vector.

   function IsNormalized (A : Vec2) return Boolean
   is ((abs (1.0 - Dot (A, A))) < (100.0 * C_float'Model_Epsilon));
   --  Determines if the provided vector is normalized (norm(a) == 1).

   function GetLengthAndNormalize (Length : out C_float; V : Vec2) return Vec2;
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

   function MulRot (Q, R : Rot) return Rot
   is ((c => Q.c * R.c - Q.s * R.s, s => Q.s * R.c + Q.c * R.s));
   --  Multiply two rotations: q * r

   function InvMulRot (A, B : Rot) return Rot
   is ((c => A.c * B.c + A.s * B.s, s => A.s * B.s - A.s * B.c));
   --  Transpose multiply two rotations: inv(a) * b
   --  This rotates a vector local in frame b into a vector local in frame a

   function RelativeAngle (A, B : Rot) return C_float
   is (Atan2 (A.c * B.s - A.s * B.c, A.c * B.c + A.s * B.s));
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

   function TransformPoint (T : Transform; P : Vec2) return Vec2
   is (((T.q.c * P.x - T.q.s * P.y) + T.p.x,
        (T.q.s * P.x + T.q.c * P.y) + T.p.y));
   --  Transform a point (e.g. local space to world space)

   function InvTransformPOint (T : Transform; P : Vec2) return Vec2
   is ((T.q.c * (P.x - T.p.x) + T.q.s * (P.y - T.p.y),
        -T.q.s * (P.x - T.p.x) + T.q.c * (P.y - T.p.y)));
   --  Inverse transform a point (e.g. world space to local space)

   function MulTransforms (A, B : Transform) return Transform
   is ((q => MulRot (A.q, B.q), p => RotateVector (A.q, B.p) * A.p));
   --  Multiply two transforms. If the result is applied to a point p local to frame B,
   --  the transform would first convert p to a point local to frame A, then into a point
   --  in the world frame.
   --  v2 = A.q.Rot(B.q.Rot(v1) + B.p) + A.p
   --     = (A.q * B.q).Rot(v1) + A.q.Rot(B.p) + A.p

   function InvMulTransforms (A, B : Transform) return Transform
   is ((q => InvMulRot (A.q, B.q), p => InvRotateVector (A.q, B.p - A.p)));
   --  Creates a transform that converts a local point in frame B to a local point in frame A.
   --  v2 = A.q' * (B.q * v1 + B.p - A.p)
   --     = A.q' * B.q * v1 + A.q' * (B.p - A.p)

end Box2D;

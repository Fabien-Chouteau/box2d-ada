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
   B2_HASH_INIT : constant := 5381;
   type AllocFcn is access    function  (size : Interfaces.C.unsigned; alignment : Interfaces.C.int) return System.Address

     with Convention => C;

   type FreeFcn is access    procedure  (mem : System.Address)

     with Convention => C;

   type AssertFcn is access    function  (condition : Interfaces.C.Strings.chars_ptr; fileName : Interfaces.C.Strings.chars_ptr; lineNumber : Interfaces.C.int) return Interfaces.C.int

     with Convention => C;

   type Version is record
      major : Interfaces.C.int;
      minor : Interfaces.C.int;
      revision : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   procedure SetAllocator (allocFcn_p : access AllocFcn; freeFcn_p : access FreeFcn);
   --  
   pragma Import (C, SetAllocator, "b2SetAllocator");

   function GetByteCount return Interfaces.C.int;
   --  
   pragma Import (C, GetByteCount, "b2GetByteCount");

   procedure SetAssertFcn (assertFcn_p : access AssertFcn);
   --  
   pragma Import (C, SetAssertFcn, "b2SetAssertFcn");

   function GetVersion return Version;
   --  
   pragma Import (C, GetVersion, "b2GetVersion");

   function InternalAssertFcn (condition : Interfaces.C.Strings.chars_ptr; fileName : Interfaces.C.Strings.chars_ptr; lineNumber : Interfaces.C.int) return Interfaces.C.int;
   --  
   pragma Import (C, InternalAssertFcn, "b2InternalAssertFcn");

   function InternalAssertFcn (condition : String; fileName : String; lineNumber : Interfaces.C.int) return Interfaces.C.int;
   --  

   function GetTicks return Interfaces.Unsigned_64;
   --  
   pragma Import (C, GetTicks, "b2GetTicks");

   function GetMilliseconds (ticks : Interfaces.Unsigned_64) return Interfaces.C.C_float;
   --  
   pragma Import (C, GetMilliseconds, "b2GetMilliseconds");

   function GetMillisecondsAndReset (ticks : access Interfaces.Unsigned_64) return Interfaces.C.C_float;
   --  
   pragma Import (C, GetMillisecondsAndReset, "b2GetMillisecondsAndReset");

   procedure Yield;
   --  
   pragma Import (C, Yield, "b2Yield");

   function Hash (hash : Interfaces.Unsigned_32; data : access Interfaces.Unsigned_8; count : Interfaces.C.int) return Interfaces.Unsigned_32;
   --  
   pragma Import (C, Hash, "b2Hash");

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
      sine : Interfaces.C.C_float;
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

   function IsValidFloat (a : Interfaces.C.C_float) return Interfaces.C.C_bool;
   --  
   pragma Import (C, IsValidFloat, "b2IsValidFloat");

   function IsValidVec2 (v : Vec2) return Interfaces.C.C_bool;
   --  
   pragma Import (C, IsValidVec2, "b2IsValidVec2");

   function IsValidRotation (q : Rot) return Interfaces.C.C_bool;
   --  
   pragma Import (C, IsValidRotation, "b2IsValidRotation");

   function IsValidTransform (t : Transform) return Interfaces.C.C_bool;
   --  
   pragma Import (C, IsValidTransform, "b2IsValidTransform");

   function IsValidAABB (aabb_p : AABB) return Interfaces.C.C_bool;
   --  
   pragma Import (C, IsValidAABB, "b2IsValidAABB");

   function IsValidPlane (a : Plane) return Interfaces.C.C_bool;
   --  
   pragma Import (C, IsValidPlane, "b2IsValidPlane");

   function Atan2 (y : Interfaces.C.C_float; x : Interfaces.C.C_float) return Interfaces.C.C_float;
   --  
   pragma Import (C, Atan2, "b2Atan2");

   function ComputeCosSin (radians : Interfaces.C.C_float) return CosSin;
   --  
   pragma Import (C, ComputeCosSin, "b2ComputeCosSin");

   function ComputeRotationBetweenUnitVectors (v1 : Vec2; v2 : Vec2) return Rot;
   --  
   pragma Import (C, ComputeRotationBetweenUnitVectors, "b2ComputeRotationBetweenUnitVectors");

   procedure SetLengthUnitsPerMeter (lengthUnits : Interfaces.C.C_float);
   --  
   pragma Import (C, SetLengthUnitsPerMeter, "b2SetLengthUnitsPerMeter");

   function GetLengthUnitsPerMeter return Interfaces.C.C_float;
   --  
   pragma Import (C, GetLengthUnitsPerMeter, "b2GetLengthUnitsPerMeter");

   B2_MAX_POLYGON_VERTICES : constant := 8;
   type TOIState is
     (
         B2_toiStateUnknown
       , B2_toiStateFailed
       , B2_toiStateOverlapped
       , B2_toiStateHit
       , B2_toiStateSeparated
     )
     with Convention => C;

   for TOIState use
     (
         B2_toiStateUnknown => 0
       , B2_toiStateFailed => 1
       , B2_toiStateOverlapped => 2
       , B2_toiStateHit => 3
       , B2_toiStateSeparated => 4
     );

   type RayCastInput is record
      origin : Vec2;
      translation : Vec2;
      maxFraction : Interfaces.C.C_float;
   end record
      with Convention => C_Pass_By_Copy;

   type ShapeProxy is record
      points : Vec2_Array_Max_Poly;
      count : Interfaces.C.int;
      radius : Interfaces.C.C_float;
   end record
      with Convention => C_Pass_By_Copy;

   type ShapeCastInput is record
      proxy : ShapeProxy;
      translation : Vec2;
      maxFraction : Interfaces.C.C_float;
      canEncroach : Interfaces.C.C_bool;
   end record
      with Convention => C_Pass_By_Copy;

   type CastOutput is record
      normal : Vec2;
      point : Vec2;
      fraction : Interfaces.C.C_float;
      iterations : Interfaces.C.int;
      hit : Interfaces.C.C_bool;
   end record
      with Convention => C_Pass_By_Copy;

   type MassData is record
      mass : Interfaces.C.C_float;
      center : Vec2;
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
      radius : Interfaces.C.C_float;
   end record
      with Convention => C_Pass_By_Copy;

   type Polygon is record
      vertices : Vec2_Array_Max_Poly;
      normals : Vec2_Array_Max_Poly;
      centroid : Vec2;
      radius : Interfaces.C.C_float;
      count : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type Segment is record
      point1 : Vec2;
      point2 : Vec2;
   end record
      with Convention => C_Pass_By_Copy;

   type ChainSegment is record
      ghost1 : Vec2;
      segment_f : Segment;
      ghost2 : Vec2;
      chainId : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type Hull is record
      points : Vec2_Array_Max_Poly;
      count : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type SegmentDistanceResult is record
      closest1 : Vec2;
      closest2 : Vec2;
      fraction1 : Interfaces.C.C_float;
      fraction2 : Interfaces.C.C_float;
      distanceSquared : Interfaces.C.C_float;
   end record
      with Convention => C_Pass_By_Copy;

   type SimplexCache is record
      count : Interfaces.Unsigned_16;
      indexA : Chars_Array_3;
      indexB : Chars_Array_3;
   end record
      with Convention => C_Pass_By_Copy;

   type DistanceInput is record
      proxyA : ShapeProxy;
      proxyB : ShapeProxy;
      transformA : Transform;
      transformB : Transform;
      useRadii : Interfaces.C.C_bool;
   end record
      with Convention => C_Pass_By_Copy;

   type DistanceOutput is record
      pointA : Vec2; -- /< Closest point on shapeA
      pointB : Vec2; -- /< Closest point on shapeB
      normal : Vec2; -- /< Normal vector that points from A to B. Invalid if distance is zero.
      distance : Interfaces.C.C_float; -- /< The final distance, zero if overlapped
      iterations : Interfaces.C.int; -- /< Number of GJK iterations used
      simplexCount : Interfaces.C.int; -- /< The number of simplexes stored in the simplex array
   end record
      with Convention => C_Pass_By_Copy;

   type SimplexVertex is record
      wA : Vec2; -- /< support point in proxyA
      wB : Vec2; -- /< support point in proxyB
      w : Vec2; -- /< wB - wA
      a : Interfaces.C.C_float; -- /< barycentric coordinate for closest point
      indexA : Interfaces.C.int; -- /< wA index
      indexB : Interfaces.C.int; -- /< wB index
   end record
      with Convention => C_Pass_By_Copy;

   type Simplex is record
      v1 : SimplexVertex; -- /< vertices
      v2 : SimplexVertex; -- /< vertices
      v3 : SimplexVertex; -- /< vertices
      count : Interfaces.C.int; -- /< number of valid vertices
   end record
      with Convention => C_Pass_By_Copy;

   type ShapeCastPairInput is record
      proxyA : ShapeProxy; -- /< The proxy for shape A
      proxyB : ShapeProxy; -- /< The proxy for shape B
      transformA : Transform; -- /< The world transform for shape A
      transformB : Transform; -- /< The world transform for shape B
      translationB : Vec2; -- /< The translation of shape B
      maxFraction : Interfaces.C.C_float; -- /< The fraction of the translation to consider, typically 1
      canEncroach : Interfaces.C.C_bool; -- /< Allows shapes with a radius to move slightly closer if already touching
   end record
      with Convention => C_Pass_By_Copy;

   type Sweep is record
      localCenter : Vec2; -- /< Local center of mass position
      c1 : Vec2; -- /< Starting center of mass world position
      c2 : Vec2; -- /< Ending center of mass world position
      q1 : Rot; -- /< Starting world rotation
      q2 : Rot; -- /< Ending world rotation
   end record
      with Convention => C_Pass_By_Copy;

   type TOIInput is record
      proxyA : ShapeProxy; -- /< The proxy for shape A
      proxyB : ShapeProxy; -- /< The proxy for shape B
      sweepA : Sweep; -- /< The movement of shape A
      sweepB : Sweep; -- /< The movement of shape B
      maxFraction : Interfaces.C.C_float; -- /< Defines the sweep interval [0, maxFraction]
   end record
      with Convention => C_Pass_By_Copy;

   type TOIOutput is record
      state : TOIState;
      point : Vec2;
      normal : Vec2;
      fraction : Interfaces.C.C_float;
   end record
      with Convention => C_Pass_By_Copy;

   type ManifoldPoint is record
      point : Vec2;
      anchorA : Vec2;
      anchorB : Vec2;
      separation : Interfaces.C.C_float;
      normalImpulse : Interfaces.C.C_float;
      tangentImpulse : Interfaces.C.C_float;
      totalNormalImpulse : Interfaces.C.C_float;
      normalVelocity : Interfaces.C.C_float;
      id : Interfaces.Unsigned_16;
      persisted : Interfaces.C.C_bool;
   end record
      with Convention => C_Pass_By_Copy;

   type ManifoldPoint_Array_2 is array (0 .. 1) of ManifoldPoint;

   type Manifold is record
      normal : Vec2;
      rollingImpulse : Interfaces.C.C_float;
      points : ManifoldPoint_Array_2;
      pointCount : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type DynamicTree is record
      root : Interfaces.C.int;
      nodeCount : Interfaces.C.int;
      nodeCapacity : Interfaces.C.int;
      freeList : Interfaces.C.int;
      proxyCount : Interfaces.C.int;
      leafIndices : access Interfaces.C.int;
      leafBoxes : access AABB;
      leafCenters : access Vec2_Array_Indef;
      binIndices : access Interfaces.C.int;
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
      point : Vec2;
      hit : Interfaces.C.C_bool;
   end record
      with Convention => C_Pass_By_Copy;

   type CollisionPlane is record
      plane_f : Plane;
      pushLimit : Interfaces.C.C_float;
      push : Interfaces.C.C_float;
      clipVelocity : Interfaces.C.C_bool;
   end record
      with Convention => C_Pass_By_Copy;

   type PlaneSolverResult is record
      translation : Vec2;
      iterationCount : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   function IsValidRay (input : access RayCastInput) return Interfaces.C.C_bool;
   --  
   pragma Import (C, IsValidRay, "b2IsValidRay");

   function MakePolygon (hull_p : access Hull; radius : Interfaces.C.C_float) return Polygon;
   --  
   pragma Import (C, MakePolygon, "b2MakePolygon");

   function MakeOffsetPolygon (hull_p : access Hull; position : Vec2; rotation : Rot) return Polygon;
   --  
   pragma Import (C, MakeOffsetPolygon, "b2MakeOffsetPolygon");

   function MakeOffsetRoundedPolygon (hull_p : access Hull; position : Vec2; rotation : Rot; radius : Interfaces.C.C_float) return Polygon;
   --  
   pragma Import (C, MakeOffsetRoundedPolygon, "b2MakeOffsetRoundedPolygon");

   function MakeSquare (halfWidth : Interfaces.C.C_float) return Polygon;
   --  
   pragma Import (C, MakeSquare, "b2MakeSquare");

   function MakeBox (halfWidth : Interfaces.C.C_float; halfHeight : Interfaces.C.C_float) return Polygon;
   --  
   pragma Import (C, MakeBox, "b2MakeBox");

   function MakeRoundedBox (halfWidth : Interfaces.C.C_float; halfHeight : Interfaces.C.C_float; radius : Interfaces.C.C_float) return Polygon;
   --  
   pragma Import (C, MakeRoundedBox, "b2MakeRoundedBox");

   function MakeOffsetBox (halfWidth : Interfaces.C.C_float; halfHeight : Interfaces.C.C_float; center : Vec2; rotation : Rot) return Polygon;
   --  
   pragma Import (C, MakeOffsetBox, "b2MakeOffsetBox");

   function MakeOffsetRoundedBox (halfWidth : Interfaces.C.C_float; halfHeight : Interfaces.C.C_float; center : Vec2; rotation : Rot; radius : Interfaces.C.C_float) return Polygon;
   --  
   pragma Import (C, MakeOffsetRoundedBox, "b2MakeOffsetRoundedBox");

   function TransformPolygon (transform_p : Transform; polygon_p : access Polygon) return Polygon;
   --  
   pragma Import (C, TransformPolygon, "b2TransformPolygon");

   function ComputeCircleMass (shape : access Circle; density : Interfaces.C.C_float) return MassData;
   --  
   pragma Import (C, ComputeCircleMass, "b2ComputeCircleMass");

   function ComputeCapsuleMass (shape : access Capsule; density : Interfaces.C.C_float) return MassData;
   --  
   pragma Import (C, ComputeCapsuleMass, "b2ComputeCapsuleMass");

   function ComputePolygonMass (shape : access Polygon; density : Interfaces.C.C_float) return MassData;
   --  
   pragma Import (C, ComputePolygonMass, "b2ComputePolygonMass");

   function ComputeCircleAABB (shape : access Circle; transform_p : Transform) return AABB;
   --  
   pragma Import (C, ComputeCircleAABB, "b2ComputeCircleAABB");

   function ComputeCapsuleAABB (shape : access Capsule; transform_p : Transform) return AABB;
   --  
   pragma Import (C, ComputeCapsuleAABB, "b2ComputeCapsuleAABB");

   function ComputePolygonAABB (shape : access Polygon; transform_p : Transform) return AABB;
   --  
   pragma Import (C, ComputePolygonAABB, "b2ComputePolygonAABB");

   function ComputeSegmentAABB (shape : access Segment; transform_p : Transform) return AABB;
   --  
   pragma Import (C, ComputeSegmentAABB, "b2ComputeSegmentAABB");

   function PointInCircle (shape : access Circle; point : Vec2) return Interfaces.C.C_bool;
   --  
   pragma Import (C, PointInCircle, "b2PointInCircle");

   function PointInCapsule (shape : access Capsule; point : Vec2) return Interfaces.C.C_bool;
   --  
   pragma Import (C, PointInCapsule, "b2PointInCapsule");

   function PointInPolygon (shape : access Polygon; point : Vec2) return Interfaces.C.C_bool;
   --  
   pragma Import (C, PointInPolygon, "b2PointInPolygon");

   function RayCastCircle (shape : access Circle; input : access RayCastInput) return CastOutput;
   --  
   pragma Import (C, RayCastCircle, "b2RayCastCircle");

   function RayCastCapsule (shape : access Capsule; input : access RayCastInput) return CastOutput;
   --  
   pragma Import (C, RayCastCapsule, "b2RayCastCapsule");

   function RayCastSegment (shape : access Segment; input : access RayCastInput; oneSided : Interfaces.C.C_bool) return CastOutput;
   --  
   pragma Import (C, RayCastSegment, "b2RayCastSegment");

   function RayCastPolygon (shape : access Polygon; input : access RayCastInput) return CastOutput;
   --  
   pragma Import (C, RayCastPolygon, "b2RayCastPolygon");

   function ShapeCastCircle (shape : access Circle; input : access ShapeCastInput) return CastOutput;
   --  
   pragma Import (C, ShapeCastCircle, "b2ShapeCastCircle");

   function ShapeCastCapsule (shape : access Capsule; input : access ShapeCastInput) return CastOutput;
   --  
   pragma Import (C, ShapeCastCapsule, "b2ShapeCastCapsule");

   function ShapeCastSegment (shape : access Segment; input : access ShapeCastInput) return CastOutput;
   --  
   pragma Import (C, ShapeCastSegment, "b2ShapeCastSegment");

   function ShapeCastPolygon (shape : access Polygon; input : access ShapeCastInput) return CastOutput;
   --  
   pragma Import (C, ShapeCastPolygon, "b2ShapeCastPolygon");

   function ComputeHull (points : access Vec2_Array_Indef; count : Interfaces.C.int) return Hull;
   --  
   pragma Import (C, ComputeHull, "b2ComputeHull");

   function ValidateHull (hull_p : access Hull) return Interfaces.C.C_bool;
   --  
   pragma Import (C, ValidateHull, "b2ValidateHull");

   function SegmentDistance (p1 : Vec2; q1 : Vec2; p2 : Vec2; q2 : Vec2) return SegmentDistanceResult;
   --  
   pragma Import (C, SegmentDistance, "b2SegmentDistance");

   function ShapeDistance (input : access DistanceInput; cache : access SimplexCache; simplexes : access Simplex) return DistanceOutput;
   --  
   pragma Import (C, ShapeDistance, "b2ShapeDistance");

   function ShapeCast (input : access ShapeCastPairInput) return CastOutput;
   --  
   pragma Import (C, ShapeCast, "b2ShapeCast");

   function MakeProxy (points : access Vec2_Array_Indef; count : Interfaces.C.int; radius : Interfaces.C.C_float) return ShapeProxy;
   --  
   pragma Import (C, MakeProxy, "b2MakeProxy");

   function MakeOffsetProxy (points : access Vec2_Array_Indef; count : Interfaces.C.int; radius : Interfaces.C.C_float; position : Vec2; rotation : Rot) return ShapeProxy;
   --  
   pragma Import (C, MakeOffsetProxy, "b2MakeOffsetProxy");

   function GetSweepTransform (sweep_p : access Sweep; time : Interfaces.C.C_float) return Transform;
   --  
   pragma Import (C, GetSweepTransform, "b2GetSweepTransform");

   function TimeOfImpact (input : access TOIInput) return TOIOutput;
   --  
   pragma Import (C, TimeOfImpact, "b2TimeOfImpact");

   function CollideCircles (circleA : access Circle; xfA : Transform; circleB : access Circle; xfB : Transform) return Manifold;
   --  
   pragma Import (C, CollideCircles, "b2CollideCircles");

   function CollideCapsuleAndCircle (capsuleA : access Capsule; xfA : Transform; circleB : access Circle) return Manifold;
   --  
   pragma Import (C, CollideCapsuleAndCircle, "b2CollideCapsuleAndCircle");

   function CollideSegmentAndCircle (segmentA : access Segment; xfA : Transform; circleB : access Circle) return Manifold;
   --  
   pragma Import (C, CollideSegmentAndCircle, "b2CollideSegmentAndCircle");

   function CollidePolygonAndCircle (polygonA : access Polygon; xfA : Transform; circleB : access Circle) return Manifold;
   --  
   pragma Import (C, CollidePolygonAndCircle, "b2CollidePolygonAndCircle");

   function CollideCapsules (capsuleA : access Capsule; xfA : Transform; capsuleB : access Capsule; xfB : Transform) return Manifold;
   --  
   pragma Import (C, CollideCapsules, "b2CollideCapsules");

   function CollideSegmentAndCapsule (segmentA : access Segment; xfA : Transform; capsuleB : access Capsule) return Manifold;
   --  
   pragma Import (C, CollideSegmentAndCapsule, "b2CollideSegmentAndCapsule");

   function CollidePolygonAndCapsule (polygonA : access Polygon; xfA : Transform; capsuleB : access Capsule) return Manifold;
   --  
   pragma Import (C, CollidePolygonAndCapsule, "b2CollidePolygonAndCapsule");

   function CollidePolygons (polygonA : access Polygon; xfA : Transform; polygonB : access Polygon; xfB : Transform) return Manifold;
   --  
   pragma Import (C, CollidePolygons, "b2CollidePolygons");

   function CollideSegmentAndPolygon (segmentA : access Segment; xfA : Transform; polygonB : access Polygon) return Manifold;
   --  
   pragma Import (C, CollideSegmentAndPolygon, "b2CollideSegmentAndPolygon");

   function CollideChainSegmentAndCircle (segmentA : access ChainSegment; xfA : Transform; circleB : access Circle) return Manifold;
   --  
   pragma Import (C, CollideChainSegmentAndCircle, "b2CollideChainSegmentAndCircle");

   function CollideChainSegmentAndCapsule (segmentA : access ChainSegment; xfA : Transform; capsuleB : access Capsule) return Manifold;
   --  
   pragma Import (C, CollideChainSegmentAndCapsule, "b2CollideChainSegmentAndCapsule");

   function CollideChainSegmentAndPolygon (segmentA : access ChainSegment; xfA : Transform; polygonB : access Polygon) return Manifold;
   --  
   pragma Import (C, CollideChainSegmentAndPolygon, "b2CollideChainSegmentAndPolygon");

   function DynamicTree_Create return DynamicTree;
   --  
   pragma Import (C, DynamicTree_Create, "b2DynamicTree_Create");

   procedure DynamicTree_Destroy (tree : access DynamicTree);
   --  
   pragma Import (C, DynamicTree_Destroy, "b2DynamicTree_Destroy");

   function DynamicTree_CreateProxy (tree : access DynamicTree; aabb_p : AABB; categoryBits : Interfaces.Unsigned_64; userData : Interfaces.Unsigned_64) return Interfaces.C.int;
   --  
   pragma Import (C, DynamicTree_CreateProxy, "b2DynamicTree_CreateProxy");

   procedure DynamicTree_DestroyProxy (tree : access DynamicTree; proxyId : Interfaces.C.int);
   --  
   pragma Import (C, DynamicTree_DestroyProxy, "b2DynamicTree_DestroyProxy");

   procedure DynamicTree_MoveProxy (tree : access DynamicTree; proxyId : Interfaces.C.int; aabb_p : AABB);
   --  
   pragma Import (C, DynamicTree_MoveProxy, "b2DynamicTree_MoveProxy");

   procedure DynamicTree_EnlargeProxy (tree : access DynamicTree; proxyId : Interfaces.C.int; aabb_p : AABB);
   --  
   pragma Import (C, DynamicTree_EnlargeProxy, "b2DynamicTree_EnlargeProxy");

   procedure DynamicTree_SetCategoryBits (tree : access DynamicTree; proxyId : Interfaces.C.int; categoryBits : Interfaces.Unsigned_64);
   --  
   pragma Import (C, DynamicTree_SetCategoryBits, "b2DynamicTree_SetCategoryBits");

   function DynamicTree_GetCategoryBits (tree : access DynamicTree; proxyId : Interfaces.C.int) return Interfaces.Unsigned_64;
   --  
   pragma Import (C, DynamicTree_GetCategoryBits, "b2DynamicTree_GetCategoryBits");

   function DynamicTree_Query (tree : access DynamicTree; aabb_p : AABB; maskBits : Interfaces.Unsigned_64) return TreeStats;
   --  
   pragma Import (C, DynamicTree_Query, "b2DynamicTree_Query");

   function DynamicTree_RayCast (tree : access DynamicTree; input : access RayCastInput; maskBits : Interfaces.Unsigned_64) return TreeStats;
   --  
   pragma Import (C, DynamicTree_RayCast, "b2DynamicTree_RayCast");

   function DynamicTree_ShapeCast (tree : access DynamicTree; input : access ShapeCastInput; maskBits : Interfaces.Unsigned_64) return TreeStats;
   --  
   pragma Import (C, DynamicTree_ShapeCast, "b2DynamicTree_ShapeCast");

   function DynamicTree_GetHeight (tree : access DynamicTree) return Interfaces.C.int;
   --  
   pragma Import (C, DynamicTree_GetHeight, "b2DynamicTree_GetHeight");

   function DynamicTree_GetAreaRatio (tree : access DynamicTree) return Interfaces.C.C_float;
   --  
   pragma Import (C, DynamicTree_GetAreaRatio, "b2DynamicTree_GetAreaRatio");

   function DynamicTree_GetRootBounds (tree : access DynamicTree) return AABB;
   --  
   pragma Import (C, DynamicTree_GetRootBounds, "b2DynamicTree_GetRootBounds");

   function DynamicTree_GetProxyCount (tree : access DynamicTree) return Interfaces.C.int;
   --  
   pragma Import (C, DynamicTree_GetProxyCount, "b2DynamicTree_GetProxyCount");

   function DynamicTree_Rebuild (tree : access DynamicTree; fullBuild : Interfaces.C.C_bool) return Interfaces.C.int;
   --  
   pragma Import (C, DynamicTree_Rebuild, "b2DynamicTree_Rebuild");

   function DynamicTree_GetByteCount (tree : access DynamicTree) return Interfaces.C.int;
   --  
   pragma Import (C, DynamicTree_GetByteCount, "b2DynamicTree_GetByteCount");

   function DynamicTree_GetUserData (tree : access DynamicTree; proxyId : Interfaces.C.int) return Interfaces.Unsigned_64;
   --  
   pragma Import (C, DynamicTree_GetUserData, "b2DynamicTree_GetUserData");

   function DynamicTree_GetAABB (tree : access DynamicTree; proxyId : Interfaces.C.int) return AABB;
   --  
   pragma Import (C, DynamicTree_GetAABB, "b2DynamicTree_GetAABB");

   procedure DynamicTree_Validate (tree : access DynamicTree);
   --  
   pragma Import (C, DynamicTree_Validate, "b2DynamicTree_Validate");

   procedure DynamicTree_ValidateNoEnlarged (tree : access DynamicTree);
   --  
   pragma Import (C, DynamicTree_ValidateNoEnlarged, "b2DynamicTree_ValidateNoEnlarged");

   function SolvePlanes (targetDelta : Vec2; planes : access CollisionPlane; count : Interfaces.C.int) return PlaneSolverResult;
   --  
   pragma Import (C, SolvePlanes, "b2SolvePlanes");

   function ClipVector (vector : Vec2; planes : access CollisionPlane; count : Interfaces.C.int) return Vec2;
   --  
   pragma Import (C, ClipVector, "b2ClipVector");

   type WorldId is record
      index1 : Interfaces.Unsigned_16;
      generation : Interfaces.Unsigned_16;
   end record
      with Convention => C_Pass_By_Copy;

   type BodyId is record
      index1 : Interfaces.Integer_32;
      world0 : Interfaces.Unsigned_16;
      generation : Interfaces.Unsigned_16;
   end record
      with Convention => C_Pass_By_Copy;

   type ShapeId is record
      index1 : Interfaces.Integer_32;
      world0 : Interfaces.Unsigned_16;
      generation : Interfaces.Unsigned_16;
   end record
      with Convention => C_Pass_By_Copy;

   type ChainId is record
      index1 : Interfaces.Integer_32;
      world0 : Interfaces.Unsigned_16;
      generation : Interfaces.Unsigned_16;
   end record
      with Convention => C_Pass_By_Copy;

   type JointId is record
      index1 : Interfaces.Integer_32;
      world0 : Interfaces.Unsigned_16;
      generation : Interfaces.Unsigned_16;
   end record
      with Convention => C_Pass_By_Copy;

   type ContactId is record
      index1 : Interfaces.Integer_32;
      world0 : Interfaces.Unsigned_16;
      padding : Interfaces.Integer_16;
      generation : Interfaces.Unsigned_32;
   end record
      with Convention => C_Pass_By_Copy;

   B2_DEFAULT_CATEGORY_BITS : constant := 1;
   type BodyType is
     (
         B2_staticBody
       , B2_kinematicBody
       , B2_dynamicBody
     )
     with Convention => C;

   for BodyType use
     (
         B2_staticBody => 0
       , B2_kinematicBody => 1
       , B2_dynamicBody => 2
     );

   type ShapeType is
     (
         B2_circleShape
       , B2_capsuleShape
       , B2_segmentShape
       , B2_polygonShape
       , B2_chainSegmentShape
     )
     with Convention => C;

   for ShapeType use
     (
         B2_circleShape => 0
       , B2_capsuleShape => 1
       , B2_segmentShape => 2
       , B2_polygonShape => 3
       , B2_chainSegmentShape => 4
     );

   type JointType is
     (
         B2_distanceJoint
       , B2_filterJoint
       , B2_motorJoint
       , B2_mouseJoint
       , B2_prismaticJoint
       , B2_revoluteJoint
       , B2_weldJoint
       , B2_wheelJoint
     )
     with Convention => C;

   for JointType use
     (
         B2_distanceJoint => 0
       , B2_filterJoint => 1
       , B2_motorJoint => 2
       , B2_mouseJoint => 3
       , B2_prismaticJoint => 4
       , B2_revoluteJoint => 5
       , B2_weldJoint => 6
       , B2_wheelJoint => 7
     );

   type HexColor is
     (
         B2_colorBlack
       , B2_colorNavy
       , B2_colorDarkBlue
       , B2_colorMediumBlue
       , B2_colorBlue
       , B2_colorDarkGreen
       , B2_colorGreen
       , B2_colorTeal
       , B2_colorDarkCyan
       , B2_colorDeepSkyBlue
       , B2_colorDarkTurquoise
       , B2_colorMediumSpringGreen
       , B2_colorLime
       , B2_colorSpringGreen
       , B2_colorAqua
       , B2_colorMidnightBlue
       , B2_colorDodgerBlue
       , B2_colorLightSeaGreen
       , B2_colorForestGreen
       , B2_colorSeaGreen
       , B2_colorDarkSlateGray
       , B2_colorBox2DBlue
       , B2_colorLimeGreen
       , B2_colorMediumSeaGreen
       , B2_colorTurquoise
       , B2_colorRoyalBlue
       , B2_colorSteelBlue
       , B2_colorDarkSlateBlue
       , B2_colorMediumTurquoise
       , B2_colorIndigo
       , B2_colorDarkOliveGreen
       , B2_colorCadetBlue
       , B2_colorCornflowerBlue
       , B2_colorRebeccaPurple
       , B2_colorMediumAquaMarine
       , B2_colorDimGray
       , B2_colorSlateBlue
       , B2_colorOliveDrab
       , B2_colorSlateGray
       , B2_colorLightSlateGray
       , B2_colorMediumSlateBlue
       , B2_colorLawnGreen
       , B2_colorChartreuse
       , B2_colorAquamarine
       , B2_colorMaroon
       , B2_colorPurple
       , B2_colorOlive
       , B2_colorGray
       , B2_colorSkyBlue
       , B2_colorLightSkyBlue
       , B2_colorBlueViolet
       , B2_colorDarkRed
       , B2_colorDarkMagenta
       , B2_colorSaddleBrown
       , B2_colorBox2DGreen
       , B2_colorDarkSeaGreen
       , B2_colorLightGreen
       , B2_colorMediumPurple
       , B2_colorDarkViolet
       , B2_colorPaleGreen
       , B2_colorDarkOrchid
       , B2_colorYellowGreen
       , B2_colorSienna
       , B2_colorBrown
       , B2_colorDarkGray
       , B2_colorLightBlue
       , B2_colorGreenYellow
       , B2_colorPaleTurquoise
       , B2_colorLightSteelBlue
       , B2_colorPowderBlue
       , B2_colorFireBrick
       , B2_colorDarkGoldenRod
       , B2_colorMediumOrchid
       , B2_colorRosyBrown
       , B2_colorDarkKhaki
       , B2_colorSilver
       , B2_colorMediumVioletRed
       , B2_colorIndianRed
       , B2_colorPeru
       , B2_colorChocolate
       , B2_colorTan
       , B2_colorLightGray
       , B2_colorThistle
       , B2_colorOrchid
       , B2_colorGoldenRod
       , B2_colorPaleVioletRed
       , B2_colorCrimson
       , B2_colorBox2DRed
       , B2_colorGainsboro
       , B2_colorPlum
       , B2_colorBurlywood
       , B2_colorLightCyan
       , B2_colorLavender
       , B2_colorDarkSalmon
       , B2_colorViolet
       , B2_colorPaleGoldenRod
       , B2_colorLightCoral
       , B2_colorKhaki
       , B2_colorAliceBlue
       , B2_colorHoneyDew
       , B2_colorAzure
       , B2_colorSandyBrown
       , B2_colorWheat
       , B2_colorBeige
       , B2_colorWhiteSmoke
       , B2_colorMintCream
       , B2_colorGhostWhite
       , B2_colorSalmon
       , B2_colorAntiqueWhite
       , B2_colorLinen
       , B2_colorLightGoldenRodYellow
       , B2_colorOldLace
       , B2_colorRed
       , B2_colorMagenta
       , B2_colorDeepPink
       , B2_colorOrangeRed
       , B2_colorTomato
       , B2_colorHotPink
       , B2_colorCoral
       , B2_colorDarkOrange
       , B2_colorLightSalmon
       , B2_colorOrange
       , B2_colorLightPink
       , B2_colorPink
       , B2_colorGold
       , B2_colorPeachPuff
       , B2_colorNavajoWhite
       , B2_colorMoccasin
       , B2_colorBisque
       , B2_colorMistyRose
       , B2_colorBlanchedAlmond
       , B2_colorBox2DYellow
       , B2_colorPapayaWhip
       , B2_colorLavenderBlush
       , B2_colorSeaShell
       , B2_colorCornsilk
       , B2_colorLemonChiffon
       , B2_colorFloralWhite
       , B2_colorSnow
       , B2_colorYellow
       , B2_colorLightYellow
       , B2_colorIvory
       , B2_colorWhite
     )
     with Convention => C;

   for HexColor use
     (
         B2_colorBlack => 0
       , B2_colorNavy => 128
       , B2_colorDarkBlue => 139
       , B2_colorMediumBlue => 205
       , B2_colorBlue => 255
       , B2_colorDarkGreen => 25600
       , B2_colorGreen => 32768
       , B2_colorTeal => 32896
       , B2_colorDarkCyan => 35723
       , B2_colorDeepSkyBlue => 49151
       , B2_colorDarkTurquoise => 52945
       , B2_colorMediumSpringGreen => 64154
       , B2_colorLime => 65280
       , B2_colorSpringGreen => 65407
       , B2_colorAqua => 65535
       , B2_colorMidnightBlue => 1644912
       , B2_colorDodgerBlue => 2003199
       , B2_colorLightSeaGreen => 2142890
       , B2_colorForestGreen => 2263842
       , B2_colorSeaGreen => 3050327
       , B2_colorDarkSlateGray => 3100495
       , B2_colorBox2DBlue => 3190463
       , B2_colorLimeGreen => 3329330
       , B2_colorMediumSeaGreen => 3978097
       , B2_colorTurquoise => 4251856
       , B2_colorRoyalBlue => 4286945
       , B2_colorSteelBlue => 4620980
       , B2_colorDarkSlateBlue => 4734347
       , B2_colorMediumTurquoise => 4772300
       , B2_colorIndigo => 4915330
       , B2_colorDarkOliveGreen => 5597999
       , B2_colorCadetBlue => 6266528
       , B2_colorCornflowerBlue => 6591981
       , B2_colorRebeccaPurple => 6697881
       , B2_colorMediumAquaMarine => 6737322
       , B2_colorDimGray => 6908265
       , B2_colorSlateBlue => 6970061
       , B2_colorOliveDrab => 7048739
       , B2_colorSlateGray => 7372944
       , B2_colorLightSlateGray => 7833753
       , B2_colorMediumSlateBlue => 8087790
       , B2_colorLawnGreen => 8190976
       , B2_colorChartreuse => 8388352
       , B2_colorAquamarine => 8388564
       , B2_colorMaroon => 8388608
       , B2_colorPurple => 8388736
       , B2_colorOlive => 8421376
       , B2_colorGray => 8421504
       , B2_colorSkyBlue => 8900331
       , B2_colorLightSkyBlue => 8900346
       , B2_colorBlueViolet => 9055202
       , B2_colorDarkRed => 9109504
       , B2_colorDarkMagenta => 9109643
       , B2_colorSaddleBrown => 9127187
       , B2_colorBox2DGreen => 9226532
       , B2_colorDarkSeaGreen => 9419919
       , B2_colorLightGreen => 9498256
       , B2_colorMediumPurple => 9662683
       , B2_colorDarkViolet => 9699539
       , B2_colorPaleGreen => 10025880
       , B2_colorDarkOrchid => 10040012
       , B2_colorYellowGreen => 10145074
       , B2_colorSienna => 10506797
       , B2_colorBrown => 10824234
       , B2_colorDarkGray => 11119017
       , B2_colorLightBlue => 11393254
       , B2_colorGreenYellow => 11403055
       , B2_colorPaleTurquoise => 11529966
       , B2_colorLightSteelBlue => 11584734
       , B2_colorPowderBlue => 11591910
       , B2_colorFireBrick => 11674146
       , B2_colorDarkGoldenRod => 12092939
       , B2_colorMediumOrchid => 12211667
       , B2_colorRosyBrown => 12357519
       , B2_colorDarkKhaki => 12433259
       , B2_colorSilver => 12632256
       , B2_colorMediumVioletRed => 13047173
       , B2_colorIndianRed => 13458524
       , B2_colorPeru => 13468991
       , B2_colorChocolate => 13789470
       , B2_colorTan => 13808780
       , B2_colorLightGray => 13882323
       , B2_colorThistle => 14204888
       , B2_colorOrchid => 14315734
       , B2_colorGoldenRod => 14329120
       , B2_colorPaleVioletRed => 14381203
       , B2_colorCrimson => 14423100
       , B2_colorBox2DRed => 14430514
       , B2_colorGainsboro => 14474460
       , B2_colorPlum => 14524637
       , B2_colorBurlywood => 14596231
       , B2_colorLightCyan => 14745599
       , B2_colorLavender => 15132410
       , B2_colorDarkSalmon => 15308410
       , B2_colorViolet => 15631086
       , B2_colorPaleGoldenRod => 15657130
       , B2_colorLightCoral => 15761536
       , B2_colorKhaki => 15787660
       , B2_colorAliceBlue => 15792383
       , B2_colorHoneyDew => 15794160
       , B2_colorAzure => 15794175
       , B2_colorSandyBrown => 16032864
       , B2_colorWheat => 16113331
       , B2_colorBeige => 16119260
       , B2_colorWhiteSmoke => 16119285
       , B2_colorMintCream => 16121850
       , B2_colorGhostWhite => 16316671
       , B2_colorSalmon => 16416882
       , B2_colorAntiqueWhite => 16444375
       , B2_colorLinen => 16445670
       , B2_colorLightGoldenRodYellow => 16448210
       , B2_colorOldLace => 16643558
       , B2_colorRed => 16711680
       , B2_colorMagenta => 16711935
       , B2_colorDeepPink => 16716947
       , B2_colorOrangeRed => 16729344
       , B2_colorTomato => 16737095
       , B2_colorHotPink => 16738740
       , B2_colorCoral => 16744272
       , B2_colorDarkOrange => 16747520
       , B2_colorLightSalmon => 16752762
       , B2_colorOrange => 16753920
       , B2_colorLightPink => 16758465
       , B2_colorPink => 16761035
       , B2_colorGold => 16766720
       , B2_colorPeachPuff => 16767673
       , B2_colorNavajoWhite => 16768685
       , B2_colorMoccasin => 16770229
       , B2_colorBisque => 16770244
       , B2_colorMistyRose => 16770273
       , B2_colorBlanchedAlmond => 16772045
       , B2_colorBox2DYellow => 16772748
       , B2_colorPapayaWhip => 16773077
       , B2_colorLavenderBlush => 16773365
       , B2_colorSeaShell => 16774638
       , B2_colorCornsilk => 16775388
       , B2_colorLemonChiffon => 16775885
       , B2_colorFloralWhite => 16775920
       , B2_colorSnow => 16775930
       , B2_colorYellow => 16776960
       , B2_colorLightYellow => 16777184
       , B2_colorIvory => 16777200
       , B2_colorWhite => 16777215
     );

   type TaskCallback is access    procedure  (startIndex : Interfaces.C.int; endIndex : Interfaces.C.int; workerIndex : Interfaces.Unsigned_32; taskContext : System.Address)

     with Convention => C;

   type EnqueueTaskCallback is access    function  (task_p : access TaskCallback; itemCount : Interfaces.C.int; minRange : Interfaces.C.int; taskContext : System.Address; userContext : System.Address) return System.Address

     with Convention => C;

   type FinishTaskCallback is access    procedure  (userTask : System.Address; userContext : System.Address)

     with Convention => C;

   type FrictionCallback is access    function  (frictionA : Interfaces.C.C_float; userMaterialIdA : Interfaces.C.int; frictionB : Interfaces.C.C_float; userMaterialIdB : Interfaces.C.int) return Interfaces.C.C_float

     with Convention => C;

   type RestitutionCallback is access    function  (restitutionA : Interfaces.C.C_float; userMaterialIdA : Interfaces.C.int; restitutionB : Interfaces.C.C_float; userMaterialIdB : Interfaces.C.int) return Interfaces.C.C_float

     with Convention => C;

   type CustomFilterFcn is access    function  (shapeIdA : ShapeId; shapeIdB : ShapeId; context : System.Address) return Interfaces.C.C_bool

     with Convention => C;

   type PreSolveFcn is access    function  (shapeIdA : ShapeId; shapeIdB : ShapeId; point : Vec2; normal : Vec2; context : System.Address) return Interfaces.C.C_bool

     with Convention => C;

   type OverlapResultFcn is access    function  (shapeId_p : ShapeId; context : System.Address) return Interfaces.C.C_bool

     with Convention => C;

   type CastResultFcn is access    function  (shapeId_p : ShapeId; point : Vec2; normal : Vec2; fraction : Interfaces.C.C_float; context : System.Address) return Interfaces.C.C_float

     with Convention => C;

   type PlaneResultFcn is access    function  (shapeId_p : ShapeId; plane_p : access PlaneResult; context : System.Address) return Interfaces.C.C_bool

     with Convention => C;

   type DrawPolygonCallback is access    procedure  (vertices : access Vec2_Array_Indef; vertexCount : Interfaces.C.int; color : HexColor; context : System.Address)

     with Convention => C;

   type DrawSolidPolygonCallback is access    procedure  (transform_p : Transform; vertices : access Vec2_Array_Indef; vertexCount : Interfaces.C.int; radius : Interfaces.C.C_float; color : HexColor; context : System.Address)

     with Convention => C;

   type DrawCircleCallback is access    procedure  (center : Vec2; radius : Interfaces.C.C_float; color : HexColor; context : System.Address)

     with Convention => C;

   type DrawSolidCircleCallback is access    procedure  (transform_p : Transform; radius : Interfaces.C.C_float; color : HexColor; context : System.Address)

     with Convention => C;

   type DrawSolidCapsuleCallback is access    procedure  (p1 : Vec2; p2 : Vec2; radius : Interfaces.C.C_float; color : HexColor; context : System.Address)

     with Convention => C;

   type DrawSegmentCallback is access    procedure  (p1 : Vec2; p2 : Vec2; color : HexColor; context : System.Address)

     with Convention => C;

   type DrawTransformCallback is access    procedure  (transform_p : Transform; context : System.Address)

     with Convention => C;

   type DrawPointCallback is access    procedure  (p : Vec2; size : Interfaces.C.C_float; color : HexColor; context : System.Address)

     with Convention => C;

   type DrawStringCallback is access    procedure  (p : Vec2; s : Interfaces.C.Strings.chars_ptr; color : HexColor; context : System.Address)

     with Convention => C;

   type RayResult is record
      shapeId_f : ShapeId;
      point : Vec2;
      normal : Vec2;
      fraction : Interfaces.C.C_float;
      nodeVisits : Interfaces.C.int;
      leafVisits : Interfaces.C.int;
      hit : Interfaces.C.C_bool;
   end record
      with Convention => C_Pass_By_Copy;

   type WorldDef is record
      gravity : Vec2;
      restitutionThreshold : Interfaces.C.C_float;
      hitEventThreshold : Interfaces.C.C_float;
      contactHertz : Interfaces.C.C_float;
      contactDampingRatio : Interfaces.C.C_float;
      contactSpeed : Interfaces.C.C_float;
      maximumLinearSpeed : Interfaces.C.C_float;
      frictionCallback_f : access FrictionCallback;
      restitutionCallback_f : access RestitutionCallback;
      enableSleep : Interfaces.C.C_bool;
      enableContinuous : Interfaces.C.C_bool;
      workerCount : Interfaces.C.int;
      enqueueTask : access EnqueueTaskCallback;
      finishTask : access FinishTaskCallback;
      userTaskContext : System.Address;
      userData : System.Address;
      internalValue : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type MotionLocks is record
      linearX : Interfaces.C.C_bool;
      linearY : Interfaces.C.C_bool;
      angularZ : Interfaces.C.C_bool;
   end record
      with Convention => C_Pass_By_Copy;

   type BodyDef is record
      type_K : BodyType;
      position : Vec2;
      rotation : Rot;
      linearVelocity : Vec2;
      angularVelocity : Interfaces.C.C_float;
      linearDamping : Interfaces.C.C_float;
      angularDamping : Interfaces.C.C_float;
      gravityScale : Interfaces.C.C_float;
      sleepThreshold : Interfaces.C.C_float;
      name : Interfaces.C.Strings.chars_ptr;
      userData : System.Address;
      motionLocks_f : MotionLocks;
      enableSleep : Interfaces.C.C_bool;
      isAwake : Interfaces.C.C_bool;
      isBullet : Interfaces.C.C_bool;
      isEnabled : Interfaces.C.C_bool;
      allowFastRotation : Interfaces.C.C_bool;
      internalValue : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type Filter is record
      categoryBits : Interfaces.Unsigned_64;
      maskBits : Interfaces.Unsigned_64;
      groupIndex : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type QueryFilter is record
      categoryBits : Interfaces.Unsigned_64;
      maskBits : Interfaces.Unsigned_64;
   end record
      with Convention => C_Pass_By_Copy;

   type SurfaceMaterial is record
      friction : Interfaces.C.C_float;
      restitution : Interfaces.C.C_float;
      rollingResistance : Interfaces.C.C_float;
      tangentSpeed : Interfaces.C.C_float;
      userMaterialId : Interfaces.C.int;
      customColor : Interfaces.Unsigned_32;
   end record
      with Convention => C_Pass_By_Copy;

   type ShapeDef is record
      userData : System.Address;
      material : SurfaceMaterial;
      density : Interfaces.C.C_float;
      filter_f : Filter;
      enableCustomFiltering : Interfaces.C.C_bool;
      isSensor : Interfaces.C.C_bool;
      enableSensorEvents : Interfaces.C.C_bool;
      enableContactEvents : Interfaces.C.C_bool;
      enableHitEvents : Interfaces.C.C_bool;
      enablePreSolveEvents : Interfaces.C.C_bool;
      invokeContactCreation : Interfaces.C.C_bool;
      updateBodyMass : Interfaces.C.C_bool;
      internalValue : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type ChainDef is record
      userData : System.Address;
      points : access Vec2_Array_Indef;
      count : Interfaces.C.int;
      materials : access SurfaceMaterial;
      materialCount : Interfaces.C.int;
      filter_f : Filter;
      isLoop : Interfaces.C.C_bool;
      enableSensorEvents : Interfaces.C.C_bool;
      internalValue : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type Profile is record
      step : Interfaces.C.C_float;
      pairs : Interfaces.C.C_float;
      collide : Interfaces.C.C_float;
      solve : Interfaces.C.C_float;
      prepareStages : Interfaces.C.C_float;
      solveConstraints : Interfaces.C.C_float;
      prepareConstraints : Interfaces.C.C_float;
      integrateVelocities : Interfaces.C.C_float;
      warmStart : Interfaces.C.C_float;
      solveImpulses : Interfaces.C.C_float;
      integratePositions : Interfaces.C.C_float;
      relaxImpulses : Interfaces.C.C_float;
      applyRestitution : Interfaces.C.C_float;
      storeImpulses : Interfaces.C.C_float;
      splitIslands : Interfaces.C.C_float;
      transforms : Interfaces.C.C_float;
      sensorHits : Interfaces.C.C_float;
      jointEvents : Interfaces.C.C_float;
      hitEvents : Interfaces.C.C_float;
      refit : Interfaces.C.C_float;
      bullets : Interfaces.C.C_float;
      sleepIslands : Interfaces.C.C_float;
      sensors : Interfaces.C.C_float;
   end record
      with Convention => C_Pass_By_Copy;

   type Counters is record
      bodyCount : Interfaces.C.int;
      shapeCount : Interfaces.C.int;
      contactCount : Interfaces.C.int;
      jointCount : Interfaces.C.int;
      islandCount : Interfaces.C.int;
      stackUsed : Interfaces.C.int;
      staticTreeHeight : Interfaces.C.int;
      treeHeight : Interfaces.C.int;
      byteCount : Interfaces.C.int;
      taskCount : Interfaces.C.int;
      colorCounts : Int_Array_24;
   end record
      with Convention => C_Pass_By_Copy;

   type JointDef is record
      userData : System.Address;
      bodyIdA : BodyId;
      bodyIdB : BodyId;
      localFrameA : Transform;
      localFrameB : Transform;
      forceThreshold : Interfaces.C.C_float;
      torqueThreshold : Interfaces.C.C_float;
      constraintHertz : Interfaces.C.C_float;
      constraintDampingRatio : Interfaces.C.C_float;
      drawScale : Interfaces.C.C_float;
      collideConnected : Interfaces.C.C_bool;
   end record
      with Convention => C_Pass_By_Copy;

   type DistanceJointDef is record
      base : JointDef;
      length : Interfaces.C.C_float;
      enableSpring : Interfaces.C.C_bool;
      lowerSpringForce : Interfaces.C.C_float;
      upperSpringForce : Interfaces.C.C_float;
      hertz : Interfaces.C.C_float;
      dampingRatio : Interfaces.C.C_float;
      enableLimit : Interfaces.C.C_bool;
      minLength : Interfaces.C.C_float;
      maxLength : Interfaces.C.C_float;
      enableMotor : Interfaces.C.C_bool;
      maxMotorForce : Interfaces.C.C_float;
      motorSpeed : Interfaces.C.C_float;
      internalValue : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type MotorJointDef is record
      base : JointDef;
      linearVelocity : Vec2;
      maxVelocityForce : Interfaces.C.C_float;
      angularVelocity : Interfaces.C.C_float;
      maxVelocityTorque : Interfaces.C.C_float;
      linearHertz : Interfaces.C.C_float;
      linearDampingRatio : Interfaces.C.C_float;
      maxSpringForce : Interfaces.C.C_float;
      angularHertz : Interfaces.C.C_float;
      angularDampingRatio : Interfaces.C.C_float;
      maxSpringTorque : Interfaces.C.C_float;
      relativeTransform : Transform;
      internalValue : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type MouseJointDef is record
      base : JointDef;
      hertz : Interfaces.C.C_float;
      dampingRatio : Interfaces.C.C_float;
      maxForce : Interfaces.C.C_float;
      internalValue : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type FilterJointDef is record
      base : JointDef;
      internalValue : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type PrismaticJointDef is record
      base : JointDef;
      enableSpring : Interfaces.C.C_bool;
      hertz : Interfaces.C.C_float;
      dampingRatio : Interfaces.C.C_float;
      targetTranslation : Interfaces.C.C_float;
      enableLimit : Interfaces.C.C_bool;
      lowerTranslation : Interfaces.C.C_float;
      upperTranslation : Interfaces.C.C_float;
      enableMotor : Interfaces.C.C_bool;
      maxMotorForce : Interfaces.C.C_float;
      motorSpeed : Interfaces.C.C_float;
      internalValue : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type RevoluteJointDef is record
      base : JointDef;
      targetAngle : Interfaces.C.C_float;
      enableSpring : Interfaces.C.C_bool;
      hertz : Interfaces.C.C_float;
      dampingRatio : Interfaces.C.C_float;
      enableLimit : Interfaces.C.C_bool;
      lowerAngle : Interfaces.C.C_float;
      upperAngle : Interfaces.C.C_float;
      enableMotor : Interfaces.C.C_bool;
      maxMotorTorque : Interfaces.C.C_float;
      motorSpeed : Interfaces.C.C_float;
      internalValue : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type WeldJointDef is record
      base : JointDef;
      linearHertz : Interfaces.C.C_float;
      angularHertz : Interfaces.C.C_float;
      linearDampingRatio : Interfaces.C.C_float;
      angularDampingRatio : Interfaces.C.C_float;
      internalValue : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type WheelJointDef is record
      base : JointDef;
      enableSpring : Interfaces.C.C_bool;
      hertz : Interfaces.C.C_float;
      dampingRatio : Interfaces.C.C_float;
      enableLimit : Interfaces.C.C_bool;
      lowerTranslation : Interfaces.C.C_float;
      upperTranslation : Interfaces.C.C_float;
      enableMotor : Interfaces.C.C_bool;
      maxMotorTorque : Interfaces.C.C_float;
      motorSpeed : Interfaces.C.C_float;
      internalValue : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type ExplosionDef is record
      maskBits : Interfaces.Unsigned_64;
      position : Vec2;
      radius : Interfaces.C.C_float;
      falloff : Interfaces.C.C_float;
      impulsePerLength : Interfaces.C.C_float;
   end record
      with Convention => C_Pass_By_Copy;

   type SensorBeginTouchEvent is record
      sensorShapeId : ShapeId;
      visitorShapeId : ShapeId;
   end record
      with Convention => C_Pass_By_Copy;

   type SensorBeginTouchEvent_Array_Indef is array (Interfaces.C.unsigned) of aliased SensorBeginTouchEvent
     with Convention => C;

   type SensorEndTouchEvent is record
      sensorShapeId : ShapeId;
      visitorShapeId : ShapeId;
   end record
      with Convention => C_Pass_By_Copy;

   type SensorEndTouchEvent_Array_Indef is array (Interfaces.C.unsigned) of aliased SensorEndTouchEvent
     with Convention => C;

   type SensorEvents is record
      beginEvents : access SensorBeginTouchEvent;
      endEvents : access SensorEndTouchEvent;
      beginCount : Interfaces.C.int;
      endCount : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type ContactBeginTouchEvent is record
      shapeIdA : ShapeId;
      shapeIdB : ShapeId;
      contactId_f : ContactId;
   end record
      with Convention => C_Pass_By_Copy;

   type ContactBeginTouchEvent_Array_Indef is array (Interfaces.C.unsigned) of aliased ContactBeginTouchEvent
     with Convention => C;

   type ContactEndTouchEvent is record
      shapeIdA : ShapeId;
      shapeIdB : ShapeId;
      contactId_f : ContactId;
   end record
      with Convention => C_Pass_By_Copy;

   type ContactEndTouchEvent_Array_Indef is array (Interfaces.C.unsigned) of aliased ContactEndTouchEvent
     with Convention => C;

   type ContactHitEvent is record
      shapeIdA : ShapeId;
      shapeIdB : ShapeId;
      point : Vec2;
      normal : Vec2;
      approachSpeed : Interfaces.C.C_float;
   end record
      with Convention => C_Pass_By_Copy;

   type ContactHitEvent_Array_Indef is array (Interfaces.C.unsigned) of aliased ContactHitEvent
     with Convention => C;

   type ContactEvents is record
      beginEvents : access ContactBeginTouchEvent_Array_Indef;
      endEvents : access ContactEndTouchEvent_Array_Indef;
      hitEvents : access ContactHitEvent_Array_Indef;
      beginCount : Interfaces.C.int;
      endCount : Interfaces.C.int;
      hitCount : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type BodyMoveEvent is record
      userData : System.Address;
      transform_f : Transform;
      bodyId_f : BodyId;
      fellAsleep : Interfaces.C.C_bool;
   end record
      with Convention => C_Pass_By_Copy;

   type BodyMoveEvent_Array_Indef is array (Interfaces.C.unsigned) of aliased BodyMoveEvent
     with Convention => C;

   type BodyEvents is record
      moveEvents : access BodyMoveEvent_Array_Indef;
      moveCount : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type JointEvent is record
      jointId_f : JointId;
      userData : System.Address;
   end record
      with Convention => C_Pass_By_Copy;

   type JointEvent_Array_Indef is array (Interfaces.C.unsigned) of aliased JointEvent
     with Convention => C;

   type JointEvents is record
      jointEvents : access JointEvent_Array_Indef;
      count : Interfaces.C.int;
   end record
      with Convention => C_Pass_By_Copy;

   type ContactData is record
      contactId_f : ContactId;
      shapeIdA : ShapeId;
      shapeIdB : ShapeId;
      manifold_f : Manifold;
   end record
      with Convention => C_Pass_By_Copy;

   type DebugDraw is record
      DrawPolygonFcn : DrawPolygonCallback;
      DrawSolidPolygonFcn : DrawSolidPolygonCallback;
      DrawCircleFcn : DrawCircleCallback;
      DrawSolidCircleFcn : DrawSolidCircleCallback;
      DrawSolidCapsuleFcn : DrawSolidCapsuleCallback;
      DrawSegmentFcn : DrawSegmentCallback;
      DrawTransformFcn : DrawTransformCallback;
      DrawPointFcn : DrawPointCallback;
      DrawStringFcn : DrawStringCallback;
      drawingBounds : AABB;
      drawShapes : Interfaces.C.C_bool;
      drawJoints : Interfaces.C.C_bool;
      drawJointExtras : Interfaces.C.C_bool;
      drawBounds : Interfaces.C.C_bool;
      drawMass : Interfaces.C.C_bool;
      drawBodyNames : Interfaces.C.C_bool;
      drawContacts : Interfaces.C.C_bool;
      drawGraphColors : Interfaces.C.C_bool;
      drawContactNormals : Interfaces.C.C_bool;
      drawContactImpulses : Interfaces.C.C_bool;
      drawContactFeatures : Interfaces.C.C_bool;
      drawFrictionImpulses : Interfaces.C.C_bool;
      drawIslands : Interfaces.C.C_bool;
      context : System.Address;
   end record
      with Convention => C_Pass_By_Copy;

   function DefaultWorldDef return WorldDef;
   --  
   pragma Import (C, DefaultWorldDef, "b2DefaultWorldDef");

   function DefaultBodyDef return BodyDef;
   --  
   pragma Import (C, DefaultBodyDef, "b2DefaultBodyDef");

   function DefaultFilter return Filter;
   --  
   pragma Import (C, DefaultFilter, "b2DefaultFilter");

   function DefaultQueryFilter return QueryFilter;
   --  
   pragma Import (C, DefaultQueryFilter, "b2DefaultQueryFilter");

   function DefaultSurfaceMaterial return SurfaceMaterial;
   --  
   pragma Import (C, DefaultSurfaceMaterial, "b2DefaultSurfaceMaterial");

   function DefaultShapeDef return ShapeDef;
   --  
   pragma Import (C, DefaultShapeDef, "b2DefaultShapeDef");

   function DefaultChainDef return ChainDef;
   --  
   pragma Import (C, DefaultChainDef, "b2DefaultChainDef");

   function DefaultDistanceJointDef return DistanceJointDef;
   --  
   pragma Import (C, DefaultDistanceJointDef, "b2DefaultDistanceJointDef");

   function DefaultMotorJointDef return MotorJointDef;
   --  
   pragma Import (C, DefaultMotorJointDef, "b2DefaultMotorJointDef");

   function DefaultMouseJointDef return MouseJointDef;
   --  
   pragma Import (C, DefaultMouseJointDef, "b2DefaultMouseJointDef");

   function DefaultFilterJointDef return FilterJointDef;
   --  
   pragma Import (C, DefaultFilterJointDef, "b2DefaultFilterJointDef");

   function DefaultPrismaticJointDef return PrismaticJointDef;
   --  
   pragma Import (C, DefaultPrismaticJointDef, "b2DefaultPrismaticJointDef");

   function DefaultRevoluteJointDef return RevoluteJointDef;
   --  
   pragma Import (C, DefaultRevoluteJointDef, "b2DefaultRevoluteJointDef");

   function DefaultWeldJointDef return WeldJointDef;
   --  
   pragma Import (C, DefaultWeldJointDef, "b2DefaultWeldJointDef");

   function DefaultWheelJointDef return WheelJointDef;
   --  
   pragma Import (C, DefaultWheelJointDef, "b2DefaultWheelJointDef");

   function DefaultExplosionDef return ExplosionDef;
   --  
   pragma Import (C, DefaultExplosionDef, "b2DefaultExplosionDef");

   function DefaultDebugDraw return DebugDraw;
   --  
   pragma Import (C, DefaultDebugDraw, "b2DefaultDebugDraw");

   function CreateWorld (def : access WorldDef) return WorldId;
   --  
   pragma Import (C, CreateWorld, "b2CreateWorld");

   procedure DestroyWorld (worldId_p : WorldId);
   --  
   pragma Import (C, DestroyWorld, "b2DestroyWorld");

   function World_IsValid (id : WorldId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, World_IsValid, "b2World_IsValid");

   procedure World_Step (worldId_p : WorldId; timeStep : Interfaces.C.C_float; subStepCount : Interfaces.C.int);
   --  
   pragma Import (C, World_Step, "b2World_Step");

   procedure World_Draw (worldId_p : WorldId; draw : access DebugDraw);
   --  
   pragma Import (C, World_Draw, "b2World_Draw");

   function World_GetBodyEvents (worldId_p : WorldId) return BodyEvents;
   --  
   pragma Import (C, World_GetBodyEvents, "b2World_GetBodyEvents");

   function World_GetSensorEvents (worldId_p : WorldId) return SensorEvents;
   --  
   pragma Import (C, World_GetSensorEvents, "b2World_GetSensorEvents");

   function World_GetContactEvents (worldId_p : WorldId) return ContactEvents;
   --  
   pragma Import (C, World_GetContactEvents, "b2World_GetContactEvents");

   function World_GetJointEvents (worldId_p : WorldId) return JointEvents;
   --  
   pragma Import (C, World_GetJointEvents, "b2World_GetJointEvents");

   function World_OverlapAABB (worldId_p : WorldId; aabb_p : AABB; filter_p : QueryFilter; fcn : access OverlapResultFcn) return TreeStats;
   --  
   pragma Import (C, World_OverlapAABB, "b2World_OverlapAABB");

   function World_OverlapShape (worldId_p : WorldId; proxy : access ShapeProxy; filter_p : QueryFilter) return TreeStats;
   --  
   pragma Import (C, World_OverlapShape, "b2World_OverlapShape");

   function World_CastRay (worldId_p : WorldId; origin : Vec2; translation : Vec2; filter_p : QueryFilter) return TreeStats;
   --  
   pragma Import (C, World_CastRay, "b2World_CastRay");

   function World_CastRayClosest (worldId_p : WorldId; origin : Vec2; translation : Vec2; filter_p : QueryFilter) return RayResult;
   --  
   pragma Import (C, World_CastRayClosest, "b2World_CastRayClosest");

   function World_CastShape (worldId_p : WorldId; proxy : access ShapeProxy; translation : Vec2; filter_p : QueryFilter) return TreeStats;
   --  
   pragma Import (C, World_CastShape, "b2World_CastShape");

   function World_CastMover (worldId_p : WorldId; mover : access Capsule; translation : Vec2; filter_p : QueryFilter) return Interfaces.C.C_float;
   --  
   pragma Import (C, World_CastMover, "b2World_CastMover");

   procedure World_CollideMover (worldId_p : WorldId; mover : access Capsule; filter_p : QueryFilter; fcn : access PlaneResultFcn);
   --  
   pragma Import (C, World_CollideMover, "b2World_CollideMover");

   procedure World_EnableSleeping (worldId_p : WorldId; flag : Interfaces.C.C_bool);
   --  
   pragma Import (C, World_EnableSleeping, "b2World_EnableSleeping");

   function World_IsSleepingEnabled (worldId_p : WorldId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, World_IsSleepingEnabled, "b2World_IsSleepingEnabled");

   procedure World_EnableContinuous (worldId_p : WorldId; flag : Interfaces.C.C_bool);
   --  
   pragma Import (C, World_EnableContinuous, "b2World_EnableContinuous");

   function World_IsContinuousEnabled (worldId_p : WorldId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, World_IsContinuousEnabled, "b2World_IsContinuousEnabled");

   procedure World_SetRestitutionThreshold (worldId_p : WorldId; value : Interfaces.C.C_float);
   --  
   pragma Import (C, World_SetRestitutionThreshold, "b2World_SetRestitutionThreshold");

   function World_GetRestitutionThreshold (worldId_p : WorldId) return Interfaces.C.C_float;
   --  
   pragma Import (C, World_GetRestitutionThreshold, "b2World_GetRestitutionThreshold");

   procedure World_SetHitEventThreshold (worldId_p : WorldId; value : Interfaces.C.C_float);
   --  
   pragma Import (C, World_SetHitEventThreshold, "b2World_SetHitEventThreshold");

   function World_GetHitEventThreshold (worldId_p : WorldId) return Interfaces.C.C_float;
   --  
   pragma Import (C, World_GetHitEventThreshold, "b2World_GetHitEventThreshold");

   procedure World_SetCustomFilterCallback (worldId_p : WorldId; fcn : access CustomFilterFcn; context : System.Address);
   --  
   pragma Import (C, World_SetCustomFilterCallback, "b2World_SetCustomFilterCallback");

   procedure World_SetPreSolveCallback (worldId_p : WorldId; fcn : access PreSolveFcn; context : System.Address);
   --  
   pragma Import (C, World_SetPreSolveCallback, "b2World_SetPreSolveCallback");

   procedure World_SetGravity (worldId_p : WorldId; gravity : Vec2);
   --  
   pragma Import (C, World_SetGravity, "b2World_SetGravity");

   function World_GetGravity (worldId_p : WorldId) return Vec2;
   --  
   pragma Import (C, World_GetGravity, "b2World_GetGravity");

   procedure World_Explode (worldId_p : WorldId; explosionDef_p : access ExplosionDef);
   --  
   pragma Import (C, World_Explode, "b2World_Explode");

   procedure World_SetContactTuning (worldId_p : WorldId; hertz : Interfaces.C.C_float; dampingRatio : Interfaces.C.C_float; pushSpeed : Interfaces.C.C_float);
   --  
   pragma Import (C, World_SetContactTuning, "b2World_SetContactTuning");

   procedure World_SetMaximumLinearSpeed (worldId_p : WorldId; maximumLinearSpeed : Interfaces.C.C_float);
   --  
   pragma Import (C, World_SetMaximumLinearSpeed, "b2World_SetMaximumLinearSpeed");

   function World_GetMaximumLinearSpeed (worldId_p : WorldId) return Interfaces.C.C_float;
   --  
   pragma Import (C, World_GetMaximumLinearSpeed, "b2World_GetMaximumLinearSpeed");

   procedure World_EnableWarmStarting (worldId_p : WorldId; flag : Interfaces.C.C_bool);
   --  
   pragma Import (C, World_EnableWarmStarting, "b2World_EnableWarmStarting");

   function World_IsWarmStartingEnabled (worldId_p : WorldId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, World_IsWarmStartingEnabled, "b2World_IsWarmStartingEnabled");

   function World_GetAwakeBodyCount (worldId_p : WorldId) return Interfaces.C.int;
   --  
   pragma Import (C, World_GetAwakeBodyCount, "b2World_GetAwakeBodyCount");

   function World_GetProfile (worldId_p : WorldId) return Profile;
   --  
   pragma Import (C, World_GetProfile, "b2World_GetProfile");

   function World_GetCounters (worldId_p : WorldId) return Counters;
   --  
   pragma Import (C, World_GetCounters, "b2World_GetCounters");

   procedure World_SetUserData (worldId_p : WorldId; userData : System.Address);
   --  
   pragma Import (C, World_SetUserData, "b2World_SetUserData");

   function World_GetUserData (worldId_p : WorldId) return System.Address;
   --  
   pragma Import (C, World_GetUserData, "b2World_GetUserData");

   procedure World_SetFrictionCallback (worldId_p : WorldId; callback : access FrictionCallback);
   --  
   pragma Import (C, World_SetFrictionCallback, "b2World_SetFrictionCallback");

   procedure World_SetRestitutionCallback (worldId_p : WorldId; callback : access RestitutionCallback);
   --  
   pragma Import (C, World_SetRestitutionCallback, "b2World_SetRestitutionCallback");

   procedure World_DumpMemoryStats (worldId_p : WorldId);
   --  
   pragma Import (C, World_DumpMemoryStats, "b2World_DumpMemoryStats");

   procedure World_RebuildStaticTree (worldId_p : WorldId);
   --  
   pragma Import (C, World_RebuildStaticTree, "b2World_RebuildStaticTree");

   procedure World_EnableSpeculative (worldId_p : WorldId; flag : Interfaces.C.C_bool);
   --  
   pragma Import (C, World_EnableSpeculative, "b2World_EnableSpeculative");

   function CreateBody (worldId_p : WorldId; def : access BodyDef) return BodyId;
   --  
   pragma Import (C, CreateBody, "b2CreateBody");

   procedure DestroyBody (bodyId_p : BodyId);
   --  
   pragma Import (C, DestroyBody, "b2DestroyBody");

   function Body_IsValid (id : BodyId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, Body_IsValid, "b2Body_IsValid");

   function Body_GetType (bodyId_p : BodyId) return BodyType;
   --  
   pragma Import (C, Body_GetType, "b2Body_GetType");

   procedure Body_SetType (bodyId_p : BodyId; type_p : BodyType);
   --  
   pragma Import (C, Body_SetType, "b2Body_SetType");

   procedure Body_SetName (bodyId_p : BodyId; name : Interfaces.C.Strings.chars_ptr);
   --  
   pragma Import (C, Body_SetName, "b2Body_SetName");

   procedure Body_SetName (bodyId_p : BodyId; name : String);
   --  

   function Body_GetName (bodyId_p : BodyId) return Interfaces.C.Strings.chars_ptr;
   --  
   pragma Import (C, Body_GetName, "b2Body_GetName");

   procedure Body_SetUserData (bodyId_p : BodyId; userData : System.Address);
   --  
   pragma Import (C, Body_SetUserData, "b2Body_SetUserData");

   function Body_GetUserData (bodyId_p : BodyId) return System.Address;
   --  
   pragma Import (C, Body_GetUserData, "b2Body_GetUserData");

   function Body_GetPosition (bodyId_p : BodyId) return Vec2;
   --  
   pragma Import (C, Body_GetPosition, "b2Body_GetPosition");

   function Body_GetRotation (bodyId_p : BodyId) return Rot;
   --  
   pragma Import (C, Body_GetRotation, "b2Body_GetRotation");

   function Body_GetTransform (bodyId_p : BodyId) return Transform;
   --  
   pragma Import (C, Body_GetTransform, "b2Body_GetTransform");

   procedure Body_SetTransform (bodyId_p : BodyId; position : Vec2; rotation : Rot);
   --  
   pragma Import (C, Body_SetTransform, "b2Body_SetTransform");

   function Body_GetLocalPoint (bodyId_p : BodyId; worldPoint : Vec2) return Vec2;
   --  
   pragma Import (C, Body_GetLocalPoint, "b2Body_GetLocalPoint");

   function Body_GetWorldPoint (bodyId_p : BodyId; localPoint : Vec2) return Vec2;
   --  
   pragma Import (C, Body_GetWorldPoint, "b2Body_GetWorldPoint");

   function Body_GetLocalVector (bodyId_p : BodyId; worldVector : Vec2) return Vec2;
   --  
   pragma Import (C, Body_GetLocalVector, "b2Body_GetLocalVector");

   function Body_GetWorldVector (bodyId_p : BodyId; localVector : Vec2) return Vec2;
   --  
   pragma Import (C, Body_GetWorldVector, "b2Body_GetWorldVector");

   function Body_GetLinearVelocity (bodyId_p : BodyId) return Vec2;
   --  
   pragma Import (C, Body_GetLinearVelocity, "b2Body_GetLinearVelocity");

   function Body_GetAngularVelocity (bodyId_p : BodyId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Body_GetAngularVelocity, "b2Body_GetAngularVelocity");

   procedure Body_SetLinearVelocity (bodyId_p : BodyId; linearVelocity : Vec2);
   --  
   pragma Import (C, Body_SetLinearVelocity, "b2Body_SetLinearVelocity");

   procedure Body_SetAngularVelocity (bodyId_p : BodyId; angularVelocity : Interfaces.C.C_float);
   --  
   pragma Import (C, Body_SetAngularVelocity, "b2Body_SetAngularVelocity");

   procedure Body_SetTargetTransform (bodyId_p : BodyId; target : Transform; timeStep : Interfaces.C.C_float);
   --  
   pragma Import (C, Body_SetTargetTransform, "b2Body_SetTargetTransform");

   function Body_GetLocalPointVelocity (bodyId_p : BodyId; localPoint : Vec2) return Vec2;
   --  
   pragma Import (C, Body_GetLocalPointVelocity, "b2Body_GetLocalPointVelocity");

   function Body_GetWorldPointVelocity (bodyId_p : BodyId; worldPoint : Vec2) return Vec2;
   --  
   pragma Import (C, Body_GetWorldPointVelocity, "b2Body_GetWorldPointVelocity");

   procedure Body_ApplyForce (bodyId_p : BodyId; force : Vec2; point : Vec2; wake : Interfaces.C.C_bool);
   --  
   pragma Import (C, Body_ApplyForce, "b2Body_ApplyForce");

   procedure Body_ApplyForceToCenter (bodyId_p : BodyId; force : Vec2; wake : Interfaces.C.C_bool);
   --  
   pragma Import (C, Body_ApplyForceToCenter, "b2Body_ApplyForceToCenter");

   procedure Body_ApplyTorque (bodyId_p : BodyId; torque : Interfaces.C.C_float; wake : Interfaces.C.C_bool);
   --  
   pragma Import (C, Body_ApplyTorque, "b2Body_ApplyTorque");

   procedure Body_ApplyLinearImpulse (bodyId_p : BodyId; impulse : Vec2; point : Vec2; wake : Interfaces.C.C_bool);
   --  
   pragma Import (C, Body_ApplyLinearImpulse, "b2Body_ApplyLinearImpulse");

   procedure Body_ApplyLinearImpulseToCenter (bodyId_p : BodyId; impulse : Vec2; wake : Interfaces.C.C_bool);
   --  
   pragma Import (C, Body_ApplyLinearImpulseToCenter, "b2Body_ApplyLinearImpulseToCenter");

   procedure Body_ApplyAngularImpulse (bodyId_p : BodyId; impulse : Interfaces.C.C_float; wake : Interfaces.C.C_bool);
   --  
   pragma Import (C, Body_ApplyAngularImpulse, "b2Body_ApplyAngularImpulse");

   function Body_GetMass (bodyId_p : BodyId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Body_GetMass, "b2Body_GetMass");

   function Body_GetRotationalInertia (bodyId_p : BodyId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Body_GetRotationalInertia, "b2Body_GetRotationalInertia");

   function Body_GetLocalCenterOfMass (bodyId_p : BodyId) return Vec2;
   --  
   pragma Import (C, Body_GetLocalCenterOfMass, "b2Body_GetLocalCenterOfMass");

   function Body_GetWorldCenterOfMass (bodyId_p : BodyId) return Vec2;
   --  
   pragma Import (C, Body_GetWorldCenterOfMass, "b2Body_GetWorldCenterOfMass");

   procedure Body_SetMassData (bodyId_p : BodyId; massData_p : MassData);
   --  
   pragma Import (C, Body_SetMassData, "b2Body_SetMassData");

   function Body_GetMassData (bodyId_p : BodyId) return MassData;
   --  
   pragma Import (C, Body_GetMassData, "b2Body_GetMassData");

   procedure Body_ApplyMassFromShapes (bodyId_p : BodyId);
   --  
   pragma Import (C, Body_ApplyMassFromShapes, "b2Body_ApplyMassFromShapes");

   procedure Body_SetLinearDamping (bodyId_p : BodyId; linearDamping : Interfaces.C.C_float);
   --  
   pragma Import (C, Body_SetLinearDamping, "b2Body_SetLinearDamping");

   function Body_GetLinearDamping (bodyId_p : BodyId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Body_GetLinearDamping, "b2Body_GetLinearDamping");

   procedure Body_SetAngularDamping (bodyId_p : BodyId; angularDamping : Interfaces.C.C_float);
   --  
   pragma Import (C, Body_SetAngularDamping, "b2Body_SetAngularDamping");

   function Body_GetAngularDamping (bodyId_p : BodyId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Body_GetAngularDamping, "b2Body_GetAngularDamping");

   procedure Body_SetGravityScale (bodyId_p : BodyId; gravityScale : Interfaces.C.C_float);
   --  
   pragma Import (C, Body_SetGravityScale, "b2Body_SetGravityScale");

   function Body_GetGravityScale (bodyId_p : BodyId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Body_GetGravityScale, "b2Body_GetGravityScale");

   function Body_IsAwake (bodyId_p : BodyId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, Body_IsAwake, "b2Body_IsAwake");

   procedure Body_SetAwake (bodyId_p : BodyId; awake : Interfaces.C.C_bool);
   --  
   pragma Import (C, Body_SetAwake, "b2Body_SetAwake");

   procedure Body_EnableSleep (bodyId_p : BodyId; enableSleep : Interfaces.C.C_bool);
   --  
   pragma Import (C, Body_EnableSleep, "b2Body_EnableSleep");

   function Body_IsSleepEnabled (bodyId_p : BodyId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, Body_IsSleepEnabled, "b2Body_IsSleepEnabled");

   procedure Body_SetSleepThreshold (bodyId_p : BodyId; sleepThreshold : Interfaces.C.C_float);
   --  
   pragma Import (C, Body_SetSleepThreshold, "b2Body_SetSleepThreshold");

   function Body_GetSleepThreshold (bodyId_p : BodyId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Body_GetSleepThreshold, "b2Body_GetSleepThreshold");

   function Body_IsEnabled (bodyId_p : BodyId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, Body_IsEnabled, "b2Body_IsEnabled");

   procedure Body_Disable (bodyId_p : BodyId);
   --  
   pragma Import (C, Body_Disable, "b2Body_Disable");

   procedure Body_Enable (bodyId_p : BodyId);
   --  
   pragma Import (C, Body_Enable, "b2Body_Enable");

   procedure Body_SetMotionLocks (bodyId_p : BodyId; locks : MotionLocks);
   --  
   pragma Import (C, Body_SetMotionLocks, "b2Body_SetMotionLocks");

   function Body_GetMotionLocks (bodyId_p : BodyId) return MotionLocks;
   --  
   pragma Import (C, Body_GetMotionLocks, "b2Body_GetMotionLocks");

   procedure Body_SetBullet (bodyId_p : BodyId; flag : Interfaces.C.C_bool);
   --  
   pragma Import (C, Body_SetBullet, "b2Body_SetBullet");

   function Body_IsBullet (bodyId_p : BodyId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, Body_IsBullet, "b2Body_IsBullet");

   procedure Body_EnableContactEvents (bodyId_p : BodyId; flag : Interfaces.C.C_bool);
   --  
   pragma Import (C, Body_EnableContactEvents, "b2Body_EnableContactEvents");

   procedure Body_EnableHitEvents (bodyId_p : BodyId; flag : Interfaces.C.C_bool);
   --  
   pragma Import (C, Body_EnableHitEvents, "b2Body_EnableHitEvents");

   function Body_GetWorld (bodyId_p : BodyId) return WorldId;
   --  
   pragma Import (C, Body_GetWorld, "b2Body_GetWorld");

   function Body_GetShapeCount (bodyId_p : BodyId) return Interfaces.C.int;
   --  
   pragma Import (C, Body_GetShapeCount, "b2Body_GetShapeCount");

   function Body_GetShapes (bodyId_p : BodyId; shapeArray : access ShapeId; capacity : Interfaces.C.int) return Interfaces.C.int;
   --  
   pragma Import (C, Body_GetShapes, "b2Body_GetShapes");

   function Body_GetJointCount (bodyId_p : BodyId) return Interfaces.C.int;
   --  
   pragma Import (C, Body_GetJointCount, "b2Body_GetJointCount");

   function Body_GetJoints (bodyId_p : BodyId; jointArray : access JointId; capacity : Interfaces.C.int) return Interfaces.C.int;
   --  
   pragma Import (C, Body_GetJoints, "b2Body_GetJoints");

   function Body_GetContactCapacity (bodyId_p : BodyId) return Interfaces.C.int;
   --  
   pragma Import (C, Body_GetContactCapacity, "b2Body_GetContactCapacity");

   function Body_GetContactData (bodyId_p : BodyId; contactData_p : access ContactData; capacity : Interfaces.C.int) return Interfaces.C.int;
   --  
   pragma Import (C, Body_GetContactData, "b2Body_GetContactData");

   function Body_ComputeAABB (bodyId_p : BodyId) return AABB;
   --  
   pragma Import (C, Body_ComputeAABB, "b2Body_ComputeAABB");

   function CreateCircleShape (bodyId_p : BodyId; def : access ShapeDef; circle_p : access Circle) return ShapeId;
   --  
   procedure CreateCircleShape (bodyId_p : BodyId; def : access ShapeDef; circle_p : access Circle);
   --  
   pragma Import (C, CreateCircleShape, "b2CreateCircleShape");

   function CreateSegmentShape (bodyId_p : BodyId; def : access ShapeDef; segment_p : access Segment) return ShapeId;
   --  
   procedure CreateSegmentShape (bodyId_p : BodyId; def : access ShapeDef; segment_p : access Segment);
   --  
   pragma Import (C, CreateSegmentShape, "b2CreateSegmentShape");

   function CreateCapsuleShape (bodyId_p : BodyId; def : access ShapeDef; capsule_p : access Capsule) return ShapeId;
   --  
   procedure CreateCapsuleShape (bodyId_p : BodyId; def : access ShapeDef; capsule_p : access Capsule);
   --  
   pragma Import (C, CreateCapsuleShape, "b2CreateCapsuleShape");

   function CreatePolygonShape (bodyId_p : BodyId; def : access ShapeDef; polygon_p : access Polygon) return ShapeId;
   --  
   procedure CreatePolygonShape (bodyId_p : BodyId; def : access ShapeDef; polygon_p : access Polygon);
   --  
   pragma Import (C, CreatePolygonShape, "b2CreatePolygonShape");

   procedure DestroyShape (shapeId_p : ShapeId; updateBodyMass : Interfaces.C.C_bool);
   --  
   pragma Import (C, DestroyShape, "b2DestroyShape");

   function Shape_IsValid (id : ShapeId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, Shape_IsValid, "b2Shape_IsValid");

   function Shape_GetType (shapeId_p : ShapeId) return ShapeType;
   --  
   pragma Import (C, Shape_GetType, "b2Shape_GetType");

   function Shape_GetBody (shapeId_p : ShapeId) return BodyId;
   --  
   pragma Import (C, Shape_GetBody, "b2Shape_GetBody");

   function Shape_GetWorld (shapeId_p : ShapeId) return WorldId;
   --  
   pragma Import (C, Shape_GetWorld, "b2Shape_GetWorld");

   function Shape_IsSensor (shapeId_p : ShapeId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, Shape_IsSensor, "b2Shape_IsSensor");

   procedure Shape_SetUserData (shapeId_p : ShapeId; userData : System.Address);
   --  
   pragma Import (C, Shape_SetUserData, "b2Shape_SetUserData");

   function Shape_GetUserData (shapeId_p : ShapeId) return System.Address;
   --  
   pragma Import (C, Shape_GetUserData, "b2Shape_GetUserData");

   procedure Shape_SetDensity (shapeId_p : ShapeId; density : Interfaces.C.C_float; updateBodyMass : Interfaces.C.C_bool);
   --  
   pragma Import (C, Shape_SetDensity, "b2Shape_SetDensity");

   function Shape_GetDensity (shapeId_p : ShapeId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Shape_GetDensity, "b2Shape_GetDensity");

   procedure Shape_SetFriction (shapeId_p : ShapeId; friction : Interfaces.C.C_float);
   --  
   pragma Import (C, Shape_SetFriction, "b2Shape_SetFriction");

   function Shape_GetFriction (shapeId_p : ShapeId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Shape_GetFriction, "b2Shape_GetFriction");

   procedure Shape_SetRestitution (shapeId_p : ShapeId; restitution : Interfaces.C.C_float);
   --  
   pragma Import (C, Shape_SetRestitution, "b2Shape_SetRestitution");

   function Shape_GetRestitution (shapeId_p : ShapeId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Shape_GetRestitution, "b2Shape_GetRestitution");

   procedure Shape_SetMaterial (shapeId_p : ShapeId; material : Interfaces.C.int);
   --  
   pragma Import (C, Shape_SetMaterial, "b2Shape_SetMaterial");

   function Shape_GetMaterial (shapeId_p : ShapeId) return Interfaces.C.int;
   --  
   pragma Import (C, Shape_GetMaterial, "b2Shape_GetMaterial");

   procedure Shape_SetSurfaceMaterial (shapeId_p : ShapeId; surfaceMaterial_p : SurfaceMaterial);
   --  
   pragma Import (C, Shape_SetSurfaceMaterial, "b2Shape_SetSurfaceMaterial");

   function Shape_GetSurfaceMaterial (shapeId_p : ShapeId) return SurfaceMaterial;
   --  
   pragma Import (C, Shape_GetSurfaceMaterial, "b2Shape_GetSurfaceMaterial");

   function Shape_GetFilter (shapeId_p : ShapeId) return Filter;
   --  
   pragma Import (C, Shape_GetFilter, "b2Shape_GetFilter");

   procedure Shape_SetFilter (shapeId_p : ShapeId; filter_p : Filter);
   --  
   pragma Import (C, Shape_SetFilter, "b2Shape_SetFilter");

   procedure Shape_EnableSensorEvents (shapeId_p : ShapeId; flag : Interfaces.C.C_bool);
   --  
   pragma Import (C, Shape_EnableSensorEvents, "b2Shape_EnableSensorEvents");

   function Shape_AreSensorEventsEnabled (shapeId_p : ShapeId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, Shape_AreSensorEventsEnabled, "b2Shape_AreSensorEventsEnabled");

   procedure Shape_EnableContactEvents (shapeId_p : ShapeId; flag : Interfaces.C.C_bool);
   --  
   pragma Import (C, Shape_EnableContactEvents, "b2Shape_EnableContactEvents");

   function Shape_AreContactEventsEnabled (shapeId_p : ShapeId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, Shape_AreContactEventsEnabled, "b2Shape_AreContactEventsEnabled");

   procedure Shape_EnablePreSolveEvents (shapeId_p : ShapeId; flag : Interfaces.C.C_bool);
   --  
   pragma Import (C, Shape_EnablePreSolveEvents, "b2Shape_EnablePreSolveEvents");

   function Shape_ArePreSolveEventsEnabled (shapeId_p : ShapeId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, Shape_ArePreSolveEventsEnabled, "b2Shape_ArePreSolveEventsEnabled");

   procedure Shape_EnableHitEvents (shapeId_p : ShapeId; flag : Interfaces.C.C_bool);
   --  
   pragma Import (C, Shape_EnableHitEvents, "b2Shape_EnableHitEvents");

   function Shape_AreHitEventsEnabled (shapeId_p : ShapeId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, Shape_AreHitEventsEnabled, "b2Shape_AreHitEventsEnabled");

   function Shape_TestPoint (shapeId_p : ShapeId; point : Vec2) return Interfaces.C.C_bool;
   --  
   pragma Import (C, Shape_TestPoint, "b2Shape_TestPoint");

   function Shape_RayCast (shapeId_p : ShapeId; input : access RayCastInput) return CastOutput;
   --  
   pragma Import (C, Shape_RayCast, "b2Shape_RayCast");

   function Shape_GetCircle (shapeId_p : ShapeId) return Circle;
   --  
   pragma Import (C, Shape_GetCircle, "b2Shape_GetCircle");

   function Shape_GetSegment (shapeId_p : ShapeId) return Segment;
   --  
   pragma Import (C, Shape_GetSegment, "b2Shape_GetSegment");

   function Shape_GetChainSegment (shapeId_p : ShapeId) return ChainSegment;
   --  
   pragma Import (C, Shape_GetChainSegment, "b2Shape_GetChainSegment");

   function Shape_GetCapsule (shapeId_p : ShapeId) return Capsule;
   --  
   pragma Import (C, Shape_GetCapsule, "b2Shape_GetCapsule");

   function Shape_GetPolygon (shapeId_p : ShapeId) return Polygon;
   --  
   pragma Import (C, Shape_GetPolygon, "b2Shape_GetPolygon");

   procedure Shape_SetCircle (shapeId_p : ShapeId; circle_p : access Circle);
   --  
   pragma Import (C, Shape_SetCircle, "b2Shape_SetCircle");

   procedure Shape_SetCapsule (shapeId_p : ShapeId; capsule_p : access Capsule);
   --  
   pragma Import (C, Shape_SetCapsule, "b2Shape_SetCapsule");

   procedure Shape_SetSegment (shapeId_p : ShapeId; segment_p : access Segment);
   --  
   pragma Import (C, Shape_SetSegment, "b2Shape_SetSegment");

   procedure Shape_SetPolygon (shapeId_p : ShapeId; polygon_p : access Polygon);
   --  
   pragma Import (C, Shape_SetPolygon, "b2Shape_SetPolygon");

   function Shape_GetParentChain (shapeId_p : ShapeId) return ChainId;
   --  
   pragma Import (C, Shape_GetParentChain, "b2Shape_GetParentChain");

   function Shape_GetContactCapacity (shapeId_p : ShapeId) return Interfaces.C.int;
   --  
   pragma Import (C, Shape_GetContactCapacity, "b2Shape_GetContactCapacity");

   function Shape_GetContactData (shapeId_p : ShapeId; contactData_p : access ContactData; capacity : Interfaces.C.int) return Interfaces.C.int;
   --  
   pragma Import (C, Shape_GetContactData, "b2Shape_GetContactData");

   function Shape_GetSensorCapacity (shapeId_p : ShapeId) return Interfaces.C.int;
   --  
   pragma Import (C, Shape_GetSensorCapacity, "b2Shape_GetSensorCapacity");

   function Shape_GetSensorData (shapeId_p : ShapeId; visitorIds : access ShapeId; capacity : Interfaces.C.int) return Interfaces.C.int;
   --  
   pragma Import (C, Shape_GetSensorData, "b2Shape_GetSensorData");

   function Shape_GetAABB (shapeId_p : ShapeId) return AABB;
   --  
   pragma Import (C, Shape_GetAABB, "b2Shape_GetAABB");

   function Shape_ComputeMassData (shapeId_p : ShapeId) return MassData;
   --  
   pragma Import (C, Shape_ComputeMassData, "b2Shape_ComputeMassData");

   function Shape_GetClosestPoint (shapeId_p : ShapeId; target : Vec2) return Vec2;
   --  
   pragma Import (C, Shape_GetClosestPoint, "b2Shape_GetClosestPoint");

   function CreateChain (bodyId_p : BodyId; def : access ChainDef) return ChainId;
   --  
   pragma Import (C, CreateChain, "b2CreateChain");

   procedure DestroyChain (chainId_p : ChainId);
   --  
   pragma Import (C, DestroyChain, "b2DestroyChain");

   function Chain_GetWorld (chainId_p : ChainId) return WorldId;
   --  
   pragma Import (C, Chain_GetWorld, "b2Chain_GetWorld");

   function Chain_GetSegmentCount (chainId_p : ChainId) return Interfaces.C.int;
   --  
   pragma Import (C, Chain_GetSegmentCount, "b2Chain_GetSegmentCount");

   function Chain_GetSegments (chainId_p : ChainId; segmentArray : access ShapeId; capacity : Interfaces.C.int) return Interfaces.C.int;
   --  
   pragma Import (C, Chain_GetSegments, "b2Chain_GetSegments");

   procedure Chain_SetFriction (chainId_p : ChainId; friction : Interfaces.C.C_float);
   --  
   pragma Import (C, Chain_SetFriction, "b2Chain_SetFriction");

   function Chain_GetFriction (chainId_p : ChainId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Chain_GetFriction, "b2Chain_GetFriction");

   procedure Chain_SetRestitution (chainId_p : ChainId; restitution : Interfaces.C.C_float);
   --  
   pragma Import (C, Chain_SetRestitution, "b2Chain_SetRestitution");

   function Chain_GetRestitution (chainId_p : ChainId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Chain_GetRestitution, "b2Chain_GetRestitution");

   procedure Chain_SetMaterial (chainId_p : ChainId; material : Interfaces.C.int);
   --  
   pragma Import (C, Chain_SetMaterial, "b2Chain_SetMaterial");

   function Chain_GetMaterial (chainId_p : ChainId) return Interfaces.C.int;
   --  
   pragma Import (C, Chain_GetMaterial, "b2Chain_GetMaterial");

   function Chain_IsValid (id : ChainId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, Chain_IsValid, "b2Chain_IsValid");

   procedure DestroyJoint (jointId_p : JointId);
   --  
   pragma Import (C, DestroyJoint, "b2DestroyJoint");

   function Joint_IsValid (id : JointId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, Joint_IsValid, "b2Joint_IsValid");

   function Joint_GetType (jointId_p : JointId) return JointType;
   --  
   pragma Import (C, Joint_GetType, "b2Joint_GetType");

   function Joint_GetBodyA (jointId_p : JointId) return BodyId;
   --  
   pragma Import (C, Joint_GetBodyA, "b2Joint_GetBodyA");

   function Joint_GetBodyB (jointId_p : JointId) return BodyId;
   --  
   pragma Import (C, Joint_GetBodyB, "b2Joint_GetBodyB");

   function Joint_GetWorld (jointId_p : JointId) return WorldId;
   --  
   pragma Import (C, Joint_GetWorld, "b2Joint_GetWorld");

   procedure Joint_SetLocalFrameA (jointId_p : JointId; localFrame : Transform);
   --  
   pragma Import (C, Joint_SetLocalFrameA, "b2Joint_SetLocalFrameA");

   function Joint_GetLocalFrameA (jointId_p : JointId) return Transform;
   --  
   pragma Import (C, Joint_GetLocalFrameA, "b2Joint_GetLocalFrameA");

   procedure Joint_SetLocalFrameB (jointId_p : JointId; localFrame : Transform);
   --  
   pragma Import (C, Joint_SetLocalFrameB, "b2Joint_SetLocalFrameB");

   function Joint_GetLocalFrameB (jointId_p : JointId) return Transform;
   --  
   pragma Import (C, Joint_GetLocalFrameB, "b2Joint_GetLocalFrameB");

   procedure Joint_SetCollideConnected (jointId_p : JointId; shouldCollide : Interfaces.C.C_bool);
   --  
   pragma Import (C, Joint_SetCollideConnected, "b2Joint_SetCollideConnected");

   function Joint_GetCollideConnected (jointId_p : JointId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, Joint_GetCollideConnected, "b2Joint_GetCollideConnected");

   procedure Joint_SetUserData (jointId_p : JointId; userData : System.Address);
   --  
   pragma Import (C, Joint_SetUserData, "b2Joint_SetUserData");

   function Joint_GetUserData (jointId_p : JointId) return System.Address;
   --  
   pragma Import (C, Joint_GetUserData, "b2Joint_GetUserData");

   procedure Joint_WakeBodies (jointId_p : JointId);
   --  
   pragma Import (C, Joint_WakeBodies, "b2Joint_WakeBodies");

   function Joint_GetConstraintForce (jointId_p : JointId) return Vec2;
   --  
   pragma Import (C, Joint_GetConstraintForce, "b2Joint_GetConstraintForce");

   function Joint_GetConstraintTorque (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Joint_GetConstraintTorque, "b2Joint_GetConstraintTorque");

   function Joint_GetLinearSeparation (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Joint_GetLinearSeparation, "b2Joint_GetLinearSeparation");

   function Joint_GetAngularSeparation (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Joint_GetAngularSeparation, "b2Joint_GetAngularSeparation");

   procedure Joint_SetConstraintTuning (jointId_p : JointId; hertz : Interfaces.C.C_float; dampingRatio : Interfaces.C.C_float);
   --  
   pragma Import (C, Joint_SetConstraintTuning, "b2Joint_SetConstraintTuning");

   procedure Joint_GetConstraintTuning (jointId_p : JointId; hertz : access Interfaces.C.C_float; dampingRatio : access Interfaces.C.C_float);
   --  
   pragma Import (C, Joint_GetConstraintTuning, "b2Joint_GetConstraintTuning");

   procedure Joint_SetForceThreshold (jointId_p : JointId; threshold : Interfaces.C.C_float);
   --  
   pragma Import (C, Joint_SetForceThreshold, "b2Joint_SetForceThreshold");

   function Joint_GetForceThreshold (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Joint_GetForceThreshold, "b2Joint_GetForceThreshold");

   procedure Joint_SetTorqueThreshold (jointId_p : JointId; threshold : Interfaces.C.C_float);
   --  
   pragma Import (C, Joint_SetTorqueThreshold, "b2Joint_SetTorqueThreshold");

   function Joint_GetTorqueThreshold (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, Joint_GetTorqueThreshold, "b2Joint_GetTorqueThreshold");

   function CreateDistanceJoint (worldId_p : WorldId; def : access DistanceJointDef) return JointId;
   --  
   pragma Import (C, CreateDistanceJoint, "b2CreateDistanceJoint");

   procedure DistanceJoint_SetLength (jointId_p : JointId; length : Interfaces.C.C_float)
     with Pre => Joint_GetType (jointId_p) = B2_distanceJoint;
   --  
   pragma Import (C, DistanceJoint_SetLength, "b2DistanceJoint_SetLength");

   function DistanceJoint_GetLength (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, DistanceJoint_GetLength, "b2DistanceJoint_GetLength");

   procedure DistanceJoint_EnableSpring (jointId_p : JointId; enableSpring : Interfaces.C.C_bool)
     with Pre => Joint_GetType (jointId_p) = B2_distanceJoint;
   --  
   pragma Import (C, DistanceJoint_EnableSpring, "b2DistanceJoint_EnableSpring");

   function DistanceJoint_IsSpringEnabled (jointId_p : JointId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, DistanceJoint_IsSpringEnabled, "b2DistanceJoint_IsSpringEnabled");

   procedure DistanceJoint_SetSpringForceRange (jointId_p : JointId; lowerForce : Interfaces.C.C_float; upperForce : Interfaces.C.C_float)
     with Pre => Joint_GetType (jointId_p) = B2_distanceJoint;
   --  
   pragma Import (C, DistanceJoint_SetSpringForceRange, "b2DistanceJoint_SetSpringForceRange");

   procedure DistanceJoint_GetSpringForceRange (jointId_p : JointId; lowerForce : access Interfaces.C.C_float; upperForce : access Interfaces.C.C_float)
     with Pre => Joint_GetType (jointId_p) = B2_distanceJoint;
   --  
   pragma Import (C, DistanceJoint_GetSpringForceRange, "b2DistanceJoint_GetSpringForceRange");

   function DistanceJoint_IsCompressionEnabled (jointId_p : JointId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, DistanceJoint_IsCompressionEnabled, "b2DistanceJoint_IsCompressionEnabled");

   procedure DistanceJoint_SetSpringHertz (jointId_p : JointId; hertz : Interfaces.C.C_float)
     with Pre => Joint_GetType (jointId_p) = B2_distanceJoint;
   --  
   pragma Import (C, DistanceJoint_SetSpringHertz, "b2DistanceJoint_SetSpringHertz");

   procedure DistanceJoint_SetSpringDampingRatio (jointId_p : JointId; dampingRatio : Interfaces.C.C_float)
     with Pre => Joint_GetType (jointId_p) = B2_distanceJoint;
   --  
   pragma Import (C, DistanceJoint_SetSpringDampingRatio, "b2DistanceJoint_SetSpringDampingRatio");

   function DistanceJoint_GetSpringHertz (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, DistanceJoint_GetSpringHertz, "b2DistanceJoint_GetSpringHertz");

   function DistanceJoint_GetSpringDampingRatio (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, DistanceJoint_GetSpringDampingRatio, "b2DistanceJoint_GetSpringDampingRatio");

   procedure DistanceJoint_EnableLimit (jointId_p : JointId; enableLimit : Interfaces.C.C_bool)
     with Pre => Joint_GetType (jointId_p) = B2_distanceJoint;
   --  
   pragma Import (C, DistanceJoint_EnableLimit, "b2DistanceJoint_EnableLimit");

   function DistanceJoint_IsLimitEnabled (jointId_p : JointId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, DistanceJoint_IsLimitEnabled, "b2DistanceJoint_IsLimitEnabled");

   procedure DistanceJoint_SetLengthRange (jointId_p : JointId; minLength : Interfaces.C.C_float; maxLength : Interfaces.C.C_float)
     with Pre => Joint_GetType (jointId_p) = B2_distanceJoint;
   --  
   pragma Import (C, DistanceJoint_SetLengthRange, "b2DistanceJoint_SetLengthRange");

   function DistanceJoint_GetMinLength (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, DistanceJoint_GetMinLength, "b2DistanceJoint_GetMinLength");

   function DistanceJoint_GetMaxLength (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, DistanceJoint_GetMaxLength, "b2DistanceJoint_GetMaxLength");

   function DistanceJoint_GetCurrentLength (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, DistanceJoint_GetCurrentLength, "b2DistanceJoint_GetCurrentLength");

   procedure DistanceJoint_EnableMotor (jointId_p : JointId; enableMotor : Interfaces.C.C_bool)
     with Pre => Joint_GetType (jointId_p) = B2_distanceJoint;
   --  
   pragma Import (C, DistanceJoint_EnableMotor, "b2DistanceJoint_EnableMotor");

   function DistanceJoint_IsMotorEnabled (jointId_p : JointId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, DistanceJoint_IsMotorEnabled, "b2DistanceJoint_IsMotorEnabled");

   procedure DistanceJoint_SetMotorSpeed (jointId_p : JointId; motorSpeed : Interfaces.C.C_float)
     with Pre => Joint_GetType (jointId_p) = B2_distanceJoint;
   --  
   pragma Import (C, DistanceJoint_SetMotorSpeed, "b2DistanceJoint_SetMotorSpeed");

   function DistanceJoint_GetMotorSpeed (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, DistanceJoint_GetMotorSpeed, "b2DistanceJoint_GetMotorSpeed");

   procedure DistanceJoint_SetMaxMotorForce (jointId_p : JointId; force : Interfaces.C.C_float)
     with Pre => Joint_GetType (jointId_p) = B2_distanceJoint;
   --  
   pragma Import (C, DistanceJoint_SetMaxMotorForce, "b2DistanceJoint_SetMaxMotorForce");

   function DistanceJoint_GetMaxMotorForce (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, DistanceJoint_GetMaxMotorForce, "b2DistanceJoint_GetMaxMotorForce");

   function DistanceJoint_GetMotorForce (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, DistanceJoint_GetMotorForce, "b2DistanceJoint_GetMotorForce");

   function CreateMotorJoint (worldId_p : WorldId; def : access MotorJointDef) return JointId;
   --  
   pragma Import (C, CreateMotorJoint, "b2CreateMotorJoint");

   procedure MotorJoint_SetLinearVelocity (jointId_p : JointId; velocity : Vec2);
   --  
   pragma Import (C, MotorJoint_SetLinearVelocity, "b2MotorJoint_SetLinearVelocity");

   function MotorJoint_GetLinearVelocity (jointId_p : JointId) return Vec2;
   --  
   pragma Import (C, MotorJoint_GetLinearVelocity, "b2MotorJoint_GetLinearVelocity");

   procedure MotorJoint_SetAngularVelocity (jointId_p : JointId; velocity : Interfaces.C.C_float);
   --  
   pragma Import (C, MotorJoint_SetAngularVelocity, "b2MotorJoint_SetAngularVelocity");

   function MotorJoint_GetAngularVelocity (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, MotorJoint_GetAngularVelocity, "b2MotorJoint_GetAngularVelocity");

   procedure MotorJoint_SetMaxVelocityForce (jointId_p : JointId; maxForce : Interfaces.C.C_float);
   --  
   pragma Import (C, MotorJoint_SetMaxVelocityForce, "b2MotorJoint_SetMaxVelocityForce");

   function MotorJoint_GetMaxVelocityForce (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, MotorJoint_GetMaxVelocityForce, "b2MotorJoint_GetMaxVelocityForce");

   procedure MotorJoint_SetMaxVelocityTorque (jointId_p : JointId; maxTorque : Interfaces.C.C_float);
   --  
   pragma Import (C, MotorJoint_SetMaxVelocityTorque, "b2MotorJoint_SetMaxVelocityTorque");

   function MotorJoint_GetMaxVelocityTorque (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, MotorJoint_GetMaxVelocityTorque, "b2MotorJoint_GetMaxVelocityTorque");

   procedure MotorJoint_SetLinearHertz (jointId_p : JointId; hertz : Interfaces.C.C_float);
   --  
   pragma Import (C, MotorJoint_SetLinearHertz, "b2MotorJoint_SetLinearHertz");

   function MotorJoint_GetLinearHertz (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, MotorJoint_GetLinearHertz, "b2MotorJoint_GetLinearHertz");

   procedure MotorJoint_SetLinearDampingRatio (jointId_p : JointId; damping : Interfaces.C.C_float);
   --  
   pragma Import (C, MotorJoint_SetLinearDampingRatio, "b2MotorJoint_SetLinearDampingRatio");

   function MotorJoint_GetLinearDampingRatio (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, MotorJoint_GetLinearDampingRatio, "b2MotorJoint_GetLinearDampingRatio");

   procedure MotorJoint_SetAngularHertz (jointId_p : JointId; hertz : Interfaces.C.C_float);
   --  
   pragma Import (C, MotorJoint_SetAngularHertz, "b2MotorJoint_SetAngularHertz");

   function MotorJoint_GetAngularHertz (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, MotorJoint_GetAngularHertz, "b2MotorJoint_GetAngularHertz");

   procedure MotorJoint_SetAngularDampingRatio (jointId_p : JointId; damping : Interfaces.C.C_float);
   --  
   pragma Import (C, MotorJoint_SetAngularDampingRatio, "b2MotorJoint_SetAngularDampingRatio");

   function MotorJoint_GetAngularDampingRatio (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, MotorJoint_GetAngularDampingRatio, "b2MotorJoint_GetAngularDampingRatio");

   procedure MotorJoint_SetMaxSpringForce (jointId_p : JointId; maxForce : Interfaces.C.C_float);
   --  
   pragma Import (C, MotorJoint_SetMaxSpringForce, "b2MotorJoint_SetMaxSpringForce");

   function MotorJoint_GetMaxSpringForce (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, MotorJoint_GetMaxSpringForce, "b2MotorJoint_GetMaxSpringForce");

   procedure MotorJoint_SetMaxSpringTorque (jointId_p : JointId; maxTorque : Interfaces.C.C_float);
   --  
   pragma Import (C, MotorJoint_SetMaxSpringTorque, "b2MotorJoint_SetMaxSpringTorque");

   function MotorJoint_GetMaxSpringTorque (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, MotorJoint_GetMaxSpringTorque, "b2MotorJoint_GetMaxSpringTorque");

   function CreateMouseJoint (worldId_p : WorldId; def : access MouseJointDef) return JointId;
   --  
   pragma Import (C, CreateMouseJoint, "b2CreateMouseJoint");

   procedure MouseJoint_SetSpringHertz (jointId_p : JointId; hertz : Interfaces.C.C_float);
   --  
   pragma Import (C, MouseJoint_SetSpringHertz, "b2MouseJoint_SetSpringHertz");

   function MouseJoint_GetSpringHertz (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, MouseJoint_GetSpringHertz, "b2MouseJoint_GetSpringHertz");

   procedure MouseJoint_SetSpringDampingRatio (jointId_p : JointId; dampingRatio : Interfaces.C.C_float);
   --  
   pragma Import (C, MouseJoint_SetSpringDampingRatio, "b2MouseJoint_SetSpringDampingRatio");

   function MouseJoint_GetSpringDampingRatio (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, MouseJoint_GetSpringDampingRatio, "b2MouseJoint_GetSpringDampingRatio");

   procedure MouseJoint_SetMaxForce (jointId_p : JointId; maxForce : Interfaces.C.C_float);
   --  
   pragma Import (C, MouseJoint_SetMaxForce, "b2MouseJoint_SetMaxForce");

   function MouseJoint_GetMaxForce (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, MouseJoint_GetMaxForce, "b2MouseJoint_GetMaxForce");

   function CreateFilterJoint (worldId_p : WorldId; def : access FilterJointDef) return JointId;
   --  
   pragma Import (C, CreateFilterJoint, "b2CreateFilterJoint");

   function CreatePrismaticJoint (worldId_p : WorldId; def : access PrismaticJointDef) return JointId;
   --  
   pragma Import (C, CreatePrismaticJoint, "b2CreatePrismaticJoint");

   procedure PrismaticJoint_EnableSpring (jointId_p : JointId; enableSpring : Interfaces.C.C_bool);
   --  
   pragma Import (C, PrismaticJoint_EnableSpring, "b2PrismaticJoint_EnableSpring");

   function PrismaticJoint_IsSpringEnabled (jointId_p : JointId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, PrismaticJoint_IsSpringEnabled, "b2PrismaticJoint_IsSpringEnabled");

   procedure PrismaticJoint_SetSpringHertz (jointId_p : JointId; hertz : Interfaces.C.C_float);
   --  
   pragma Import (C, PrismaticJoint_SetSpringHertz, "b2PrismaticJoint_SetSpringHertz");

   function PrismaticJoint_GetSpringHertz (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, PrismaticJoint_GetSpringHertz, "b2PrismaticJoint_GetSpringHertz");

   procedure PrismaticJoint_SetSpringDampingRatio (jointId_p : JointId; dampingRatio : Interfaces.C.C_float);
   --  
   pragma Import (C, PrismaticJoint_SetSpringDampingRatio, "b2PrismaticJoint_SetSpringDampingRatio");

   function PrismaticJoint_GetSpringDampingRatio (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, PrismaticJoint_GetSpringDampingRatio, "b2PrismaticJoint_GetSpringDampingRatio");

   procedure PrismaticJoint_SetTargetTranslation (jointId_p : JointId; translation : Interfaces.C.C_float);
   --  
   pragma Import (C, PrismaticJoint_SetTargetTranslation, "b2PrismaticJoint_SetTargetTranslation");

   function PrismaticJoint_GetTargetTranslation (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, PrismaticJoint_GetTargetTranslation, "b2PrismaticJoint_GetTargetTranslation");

   procedure PrismaticJoint_EnableLimit (jointId_p : JointId; enableLimit : Interfaces.C.C_bool);
   --  
   pragma Import (C, PrismaticJoint_EnableLimit, "b2PrismaticJoint_EnableLimit");

   function PrismaticJoint_IsLimitEnabled (jointId_p : JointId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, PrismaticJoint_IsLimitEnabled, "b2PrismaticJoint_IsLimitEnabled");

   function PrismaticJoint_GetLowerLimit (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, PrismaticJoint_GetLowerLimit, "b2PrismaticJoint_GetLowerLimit");

   function PrismaticJoint_GetUpperLimit (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, PrismaticJoint_GetUpperLimit, "b2PrismaticJoint_GetUpperLimit");

   procedure PrismaticJoint_SetLimits (jointId_p : JointId; lower : Interfaces.C.C_float; upper : Interfaces.C.C_float);
   --  
   pragma Import (C, PrismaticJoint_SetLimits, "b2PrismaticJoint_SetLimits");

   procedure PrismaticJoint_EnableMotor (jointId_p : JointId; enableMotor : Interfaces.C.C_bool);
   --  
   pragma Import (C, PrismaticJoint_EnableMotor, "b2PrismaticJoint_EnableMotor");

   function PrismaticJoint_IsMotorEnabled (jointId_p : JointId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, PrismaticJoint_IsMotorEnabled, "b2PrismaticJoint_IsMotorEnabled");

   procedure PrismaticJoint_SetMotorSpeed (jointId_p : JointId; motorSpeed : Interfaces.C.C_float);
   --  
   pragma Import (C, PrismaticJoint_SetMotorSpeed, "b2PrismaticJoint_SetMotorSpeed");

   function PrismaticJoint_GetMotorSpeed (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, PrismaticJoint_GetMotorSpeed, "b2PrismaticJoint_GetMotorSpeed");

   procedure PrismaticJoint_SetMaxMotorForce (jointId_p : JointId; force : Interfaces.C.C_float);
   --  
   pragma Import (C, PrismaticJoint_SetMaxMotorForce, "b2PrismaticJoint_SetMaxMotorForce");

   function PrismaticJoint_GetMaxMotorForce (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, PrismaticJoint_GetMaxMotorForce, "b2PrismaticJoint_GetMaxMotorForce");

   function PrismaticJoint_GetMotorForce (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, PrismaticJoint_GetMotorForce, "b2PrismaticJoint_GetMotorForce");

   function PrismaticJoint_GetTranslation (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, PrismaticJoint_GetTranslation, "b2PrismaticJoint_GetTranslation");

   function PrismaticJoint_GetSpeed (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, PrismaticJoint_GetSpeed, "b2PrismaticJoint_GetSpeed");

   function CreateRevoluteJoint (worldId_p : WorldId; def : access RevoluteJointDef) return JointId;
   --  
   pragma Import (C, CreateRevoluteJoint, "b2CreateRevoluteJoint");

   procedure RevoluteJoint_EnableSpring (jointId_p : JointId; enableSpring : Interfaces.C.C_bool);
   --  
   pragma Import (C, RevoluteJoint_EnableSpring, "b2RevoluteJoint_EnableSpring");

   function RevoluteJoint_IsSpringEnabled (jointId_p : JointId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, RevoluteJoint_IsSpringEnabled, "b2RevoluteJoint_IsSpringEnabled");

   procedure RevoluteJoint_SetSpringHertz (jointId_p : JointId; hertz : Interfaces.C.C_float);
   --  
   pragma Import (C, RevoluteJoint_SetSpringHertz, "b2RevoluteJoint_SetSpringHertz");

   function RevoluteJoint_GetSpringHertz (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, RevoluteJoint_GetSpringHertz, "b2RevoluteJoint_GetSpringHertz");

   procedure RevoluteJoint_SetSpringDampingRatio (jointId_p : JointId; dampingRatio : Interfaces.C.C_float);
   --  
   pragma Import (C, RevoluteJoint_SetSpringDampingRatio, "b2RevoluteJoint_SetSpringDampingRatio");

   function RevoluteJoint_GetSpringDampingRatio (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, RevoluteJoint_GetSpringDampingRatio, "b2RevoluteJoint_GetSpringDampingRatio");

   procedure RevoluteJoint_SetTargetAngle (jointId_p : JointId; angle : Interfaces.C.C_float);
   --  
   pragma Import (C, RevoluteJoint_SetTargetAngle, "b2RevoluteJoint_SetTargetAngle");

   function RevoluteJoint_GetTargetAngle (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, RevoluteJoint_GetTargetAngle, "b2RevoluteJoint_GetTargetAngle");

   function RevoluteJoint_GetAngle (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, RevoluteJoint_GetAngle, "b2RevoluteJoint_GetAngle");

   procedure RevoluteJoint_EnableLimit (jointId_p : JointId; enableLimit : Interfaces.C.C_bool);
   --  
   pragma Import (C, RevoluteJoint_EnableLimit, "b2RevoluteJoint_EnableLimit");

   function RevoluteJoint_IsLimitEnabled (jointId_p : JointId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, RevoluteJoint_IsLimitEnabled, "b2RevoluteJoint_IsLimitEnabled");

   function RevoluteJoint_GetLowerLimit (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, RevoluteJoint_GetLowerLimit, "b2RevoluteJoint_GetLowerLimit");

   function RevoluteJoint_GetUpperLimit (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, RevoluteJoint_GetUpperLimit, "b2RevoluteJoint_GetUpperLimit");

   procedure RevoluteJoint_SetLimits (jointId_p : JointId; lower : Interfaces.C.C_float; upper : Interfaces.C.C_float);
   --  
   pragma Import (C, RevoluteJoint_SetLimits, "b2RevoluteJoint_SetLimits");

   procedure RevoluteJoint_EnableMotor (jointId_p : JointId; enableMotor : Interfaces.C.C_bool);
   --  
   pragma Import (C, RevoluteJoint_EnableMotor, "b2RevoluteJoint_EnableMotor");

   function RevoluteJoint_IsMotorEnabled (jointId_p : JointId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, RevoluteJoint_IsMotorEnabled, "b2RevoluteJoint_IsMotorEnabled");

   procedure RevoluteJoint_SetMotorSpeed (jointId_p : JointId; motorSpeed : Interfaces.C.C_float);
   --  
   pragma Import (C, RevoluteJoint_SetMotorSpeed, "b2RevoluteJoint_SetMotorSpeed");

   function RevoluteJoint_GetMotorSpeed (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, RevoluteJoint_GetMotorSpeed, "b2RevoluteJoint_GetMotorSpeed");

   function RevoluteJoint_GetMotorTorque (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, RevoluteJoint_GetMotorTorque, "b2RevoluteJoint_GetMotorTorque");

   procedure RevoluteJoint_SetMaxMotorTorque (jointId_p : JointId; torque : Interfaces.C.C_float);
   --  
   pragma Import (C, RevoluteJoint_SetMaxMotorTorque, "b2RevoluteJoint_SetMaxMotorTorque");

   function RevoluteJoint_GetMaxMotorTorque (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, RevoluteJoint_GetMaxMotorTorque, "b2RevoluteJoint_GetMaxMotorTorque");

   function CreateWeldJoint (worldId_p : WorldId; def : access WeldJointDef) return JointId;
   --  
   pragma Import (C, CreateWeldJoint, "b2CreateWeldJoint");

   procedure WeldJoint_SetLinearHertz (jointId_p : JointId; hertz : Interfaces.C.C_float);
   --  
   pragma Import (C, WeldJoint_SetLinearHertz, "b2WeldJoint_SetLinearHertz");

   function WeldJoint_GetLinearHertz (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, WeldJoint_GetLinearHertz, "b2WeldJoint_GetLinearHertz");

   procedure WeldJoint_SetLinearDampingRatio (jointId_p : JointId; dampingRatio : Interfaces.C.C_float);
   --  
   pragma Import (C, WeldJoint_SetLinearDampingRatio, "b2WeldJoint_SetLinearDampingRatio");

   function WeldJoint_GetLinearDampingRatio (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, WeldJoint_GetLinearDampingRatio, "b2WeldJoint_GetLinearDampingRatio");

   procedure WeldJoint_SetAngularHertz (jointId_p : JointId; hertz : Interfaces.C.C_float);
   --  
   pragma Import (C, WeldJoint_SetAngularHertz, "b2WeldJoint_SetAngularHertz");

   function WeldJoint_GetAngularHertz (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, WeldJoint_GetAngularHertz, "b2WeldJoint_GetAngularHertz");

   procedure WeldJoint_SetAngularDampingRatio (jointId_p : JointId; dampingRatio : Interfaces.C.C_float);
   --  
   pragma Import (C, WeldJoint_SetAngularDampingRatio, "b2WeldJoint_SetAngularDampingRatio");

   function WeldJoint_GetAngularDampingRatio (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, WeldJoint_GetAngularDampingRatio, "b2WeldJoint_GetAngularDampingRatio");

   function CreateWheelJoint (worldId_p : WorldId; def : access WheelJointDef) return JointId;
   --  
   pragma Import (C, CreateWheelJoint, "b2CreateWheelJoint");

   procedure WheelJoint_EnableSpring (jointId_p : JointId; enableSpring : Interfaces.C.C_bool);
   --  
   pragma Import (C, WheelJoint_EnableSpring, "b2WheelJoint_EnableSpring");

   function WheelJoint_IsSpringEnabled (jointId_p : JointId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, WheelJoint_IsSpringEnabled, "b2WheelJoint_IsSpringEnabled");

   procedure WheelJoint_SetSpringHertz (jointId_p : JointId; hertz : Interfaces.C.C_float);
   --  
   pragma Import (C, WheelJoint_SetSpringHertz, "b2WheelJoint_SetSpringHertz");

   function WheelJoint_GetSpringHertz (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, WheelJoint_GetSpringHertz, "b2WheelJoint_GetSpringHertz");

   procedure WheelJoint_SetSpringDampingRatio (jointId_p : JointId; dampingRatio : Interfaces.C.C_float);
   --  
   pragma Import (C, WheelJoint_SetSpringDampingRatio, "b2WheelJoint_SetSpringDampingRatio");

   function WheelJoint_GetSpringDampingRatio (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, WheelJoint_GetSpringDampingRatio, "b2WheelJoint_GetSpringDampingRatio");

   procedure WheelJoint_EnableLimit (jointId_p : JointId; enableLimit : Interfaces.C.C_bool);
   --  
   pragma Import (C, WheelJoint_EnableLimit, "b2WheelJoint_EnableLimit");

   function WheelJoint_IsLimitEnabled (jointId_p : JointId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, WheelJoint_IsLimitEnabled, "b2WheelJoint_IsLimitEnabled");

   function WheelJoint_GetLowerLimit (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, WheelJoint_GetLowerLimit, "b2WheelJoint_GetLowerLimit");

   function WheelJoint_GetUpperLimit (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, WheelJoint_GetUpperLimit, "b2WheelJoint_GetUpperLimit");

   procedure WheelJoint_SetLimits (jointId_p : JointId; lower : Interfaces.C.C_float; upper : Interfaces.C.C_float);
   --  
   pragma Import (C, WheelJoint_SetLimits, "b2WheelJoint_SetLimits");

   procedure WheelJoint_EnableMotor (jointId_p : JointId; enableMotor : Interfaces.C.C_bool);
   --  
   pragma Import (C, WheelJoint_EnableMotor, "b2WheelJoint_EnableMotor");

   function WheelJoint_IsMotorEnabled (jointId_p : JointId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, WheelJoint_IsMotorEnabled, "b2WheelJoint_IsMotorEnabled");

   procedure WheelJoint_SetMotorSpeed (jointId_p : JointId; motorSpeed : Interfaces.C.C_float);
   --  
   pragma Import (C, WheelJoint_SetMotorSpeed, "b2WheelJoint_SetMotorSpeed");

   function WheelJoint_GetMotorSpeed (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, WheelJoint_GetMotorSpeed, "b2WheelJoint_GetMotorSpeed");

   procedure WheelJoint_SetMaxMotorTorque (jointId_p : JointId; torque : Interfaces.C.C_float);
   --  
   pragma Import (C, WheelJoint_SetMaxMotorTorque, "b2WheelJoint_SetMaxMotorTorque");

   function WheelJoint_GetMaxMotorTorque (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, WheelJoint_GetMaxMotorTorque, "b2WheelJoint_GetMaxMotorTorque");

   function WheelJoint_GetMotorTorque (jointId_p : JointId) return Interfaces.C.C_float;
   --  
   pragma Import (C, WheelJoint_GetMotorTorque, "b2WheelJoint_GetMotorTorque");

   function Contact_IsValid (id : ContactId) return Interfaces.C.C_bool;
   --  
   pragma Import (C, Contact_IsValid, "b2Contact_IsValid");

   function Contact_GetData (contactId_p : ContactId) return ContactData;
   --  
   pragma Import (C, Contact_GetData, "b2Contact_GetData");


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

end Box2D;

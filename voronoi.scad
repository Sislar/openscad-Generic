$fn = 20;

function center_of_three_points(A, B, C) =
let (
  yD_b = C.y - B.y,  xD_b = C.x - B.x,  yD_a = B.y - A.y,
  xD_a = B.x - A.x,  aS = yD_a / xD_a,  bS = yD_b / xD_b,
  cex = (aS * bS * (A.y - C.y) + 
  bS * (A.x + B.x) -    aS * (B.x + C.x)) / (2 * (bS - aS)),
  cey = -1 * (cex - (A.x + B.x) / 2) / aS + (A.y + B.y) / 2
)
[cex, cey];

function len3(v) = sqrt(pow(v.x, 2) + pow(v.y, 2));

function PtInCircumCircle(pt, triangle) = 
   let (center = center_of_three_points(triangle[0],triangle[1],triangle[2]),
        radius = len3(triangle[0] - center), 
        distance = len3(pt - center))
   distance < radius;

/*
function BowyerWatson (pointList) { 
  let(
  
  )
      // pointList is a set of coordinates defining the points to be triangulated
      triangulation := empty triangle mesh data structure
      add super-triangle to triangulation // must be large enough to completely contain all the points in pointList
      for each point in pointList do // add all the points one at a time to the triangulation
         badTriangles := empty set
         for each triangle in triangulation do // first find all the triangles that are no longer valid due to the insertion
            if point is inside circumcircle of triangle
               add triangle to badTriangles
         polygon := empty set
         for each triangle in badTriangles do // find the boundary of the polygonal hole
            for each edge in triangle do
               if edge is not shared by any other triangles in badTriangles
                  add edge to polygon
         for each triangle in badTriangles do // remove them from the data structure
            remove triangle from triangulation
         for each edge in polygon do // re-triangulate the polygonal hole
            newTri := form a triangle from edge to point
            add newTri to triangulation
      for each triangle in triangulation // done inserting points, now clean up
         if triangle contains a vertex from original super-triangle
            remove triangle from triangulation
      return triangulation
*/

GSeed = 20;

// NEED to figure out how the array works here
function rnd(a = 1, b = 0, s = []) =s == [] ?
  (rands(min(a, b), max(a, b), 1 )[0]) :
  (rands(min(a, b), max(a, b), 1, s)[0]);

//MAIN
seeds =  [for(i=[0:20])[rnd(0,20), rnd(0,20,i)]];

//unit testing

center = center_of_three_points(seeds[0], seeds[1], seeds[2]);
radius = len3(seeds[2] - center);

translate(seeds[0]) circle(1);
translate(seeds[1]) circle(1);
translate(seeds[2]) circle(1);
translate(seeds[3]) circle(1);

difference() {
    translate(center) circle(radius);
    translate(center) circle(radius-0.1);
}

echo("test1" , PtInCircumCircle(seeds[3], [seeds[0],seeds[1],seeds[2]]));


echo("seeds", seeds);
echo("Center:", center);






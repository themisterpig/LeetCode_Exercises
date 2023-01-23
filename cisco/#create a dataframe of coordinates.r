#create a dataframe of coordinates
df <- data.frame(x = c(1,2,3,4,5,6,7,8,9,10), y = c(1,2,3,4,5,6,7,8,9,10))

quickhull = function(v){
  #calculate the convex hull of a set of vertices v that
  
  if (length(v) <= 2){
    return(v)
  }
  
  convex_hull = c()
  
  #find the maximum and minimum points on the x-axis
  #sort the points by x-axis
  v = v[order(v[,1]),]
  p1 = v[1,]
  p2 = v[length(v),]
  
  convex_hull = convex_hull + p1 + p2
  
  #remove from the dataset as they are now part of the convex hull
  v = v[-c(1,length(v)),]
  
  #determine points above and below the line
  above = create_segment(p1, p2, v)
  below = create_segment(p1, p2, v)
  convex_hull == convex_hull + quickhull2(p1,p2,above, "above")
  convex_hull == convex_hull + quickhull2(p1,p2,below, "below")
  
  return(convex_hull)
}

quickhull2 = function(p1,p2,segment,flag){
  
  #Exit case for recursion
  if (length(segment) == 0){
    return(c())
  }
  
  convex_hull = c()
  
  #calculate the distance of every point from the line to find the farthest point
  farthest_distance = -1
  farthest_point = 0
  for(point in segment){
    distance = find_distance(p1,p2,point)
    if(distance > farthest_distance){
      farthest_distance = distance
      farthest_point = point
    }
  }
  
  convex_hull = convex_hull + farthest_point
  
  #point is now in the convex hull so remove it from the segment
  segment.remove(farthest_point)
  
  point1above = create_segment(p1,farthest_point,segment)
  point1below = create_segment(p1,farthest_point,segment)
  point2above= create_segment(farthest_point,p2,segment)
  point2below = create_segment(farthest_point,p2,segment)
  
  if(flag == "above"){
    convex_hull = convex_hull + quickhull2(p1,farthest_point,point1above,"above")
    convex_hull = convex_hull + quickhull2(farthest_point,p2,point2above,"above")
  } else{
    convex_hull = convex_hull + quickhull2(p1,farthest_point,point1below,"below")
    convex_hull = convex_hull + quickhull2(farthest_point,p2,point2below,"below")
  }
  return(convex_hull)
}

create_segment = function(p1,p2,v){
  #p1 and p2 are the points that define the line
  #v is the set of points that we are checking
  #returns two lists, one for points above the line and one for points below the line
  
  above = c()
  below = c()
  
  if( p2[1,]-p1[1,] ==0){
    return(above,below)
  }
  
  m = (p2[2,]-p1[2,])/(p2[1,]-p1[1,])
  c = -m*p1[1,] + p1[2,]
  
  for(coordinate in v){
    if(coordinate[2,] > m*coordinate[1,] + c){
      above = above + coordinate
    } else{
      below = below + coordinate
    }
  }
  return(above,below)
}


find_distance = function(p1,p2,p3){
  #p1 and p2 are the points that define the line
  #p3 is the point that we are checking
  #returns the distance of p3 from the line defined by p1 and p2
  
  a = p1[2,]-p2[2,]
  b = p2[1,]-p1[1,]
  c = p1[1,]*p2[2,]-p2[1,]*p1[2,]
  
  return(abs(a*p3[1,]+b*p3[2,]+c)/sqrt(a^2+b^2))
}

quickhull(df)

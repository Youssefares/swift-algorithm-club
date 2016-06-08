//
//  main.swift
//  Graham Scan
//
//  Created by Youssef Fres on 5/17/16.
//  Copyright © 2016 Youssef Fares. All rights reserved.
//

import Foundation

public func GrahamScan(inout Points: [Point])->[Point]?{
    var ConvexHull: [Point] = []
    if Points.count < 3{
        return nil
    }
    let Lowest = Points.minElement(Point.orderWithY)
    for var i in 0..<Points.count{
        Points[i].setPolar(Lowest!)
        Points[i].setDistance(Lowest!)
    }
    var sortedPoints = Points.sort(Point.orderWithPolar)

    var i = 1
    var m = sortedPoints.count
    while(i < m-1){
        if(sortedPoints[i].polarangle! - sortedPoints[i+1].polarangle! < 0.001){
            sortedPoints.removeAtIndex(i)
        }
        i = i + 1
        m = m - 1
    }
    
    if(m < 3){
        return nil
    }
    
    
    ConvexHull.append(sortedPoints[0])
    ConvexHull.append(sortedPoints[1])
    ConvexHull.append(sortedPoints[2])
    
    for var i in 3..<sortedPoints.count{
        var top = ConvexHull.removeLast()
        while(Point.orientation(ConvexHull.last!, b: top, c: sortedPoints[i]) != -1){
            top = ConvexHull.removeLast()
        }
        ConvexHull.append(top)
        ConvexHull.append(sortedPoints[i])
    }
    return ConvexHull
}
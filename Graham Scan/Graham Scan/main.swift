//
//  main.swift
//  Graham Scan
//
//  Created by Youssef Fres on 5/17/16.
//  Copyright © 2016 Youssef Fares. All rights reserved.
//

import Foundation

struct Point{
    var x: Double
    var y: Double
    var polarangle: Double?
    var distance: Double?
    
    init(x: Double, y:Double){
        self.x = x
        self.y = y
    }
    
    static func orderWithY(a: Point, b: Point)->Bool{
        return a.y < b.y || (a.y == b.y && a.x < b.x)
    }
    
    mutating func setPolar(lowest: Point)->Void{
        let x = self.x - lowest.x
        let y = self.y - lowest.y
        
        if(x == 0 && y == 0){
            self.polarangle = 0
        }
        else if(x > 0){
            self.polarangle = atan(y/x)*180/3.14
        }
        else if(x == 0){
            self.polarangle = 90
        }
        else{
            self.polarangle = 180 + atan(y/x)*180/3.14
        }
    }
    
    mutating func setDistance(lowest: Point){
        self.distance = sqrt(pow(self.x - lowest.x, 2) + pow(self.y - lowest.y,2))
    }
    
    static func orderWithPolar(a: Point, b: Point)->Bool{
        return a.polarangle! < b.polarangle! || (a.polarangle! - b.polarangle! < 0.001 && a.distance! < b.distance!)
    }
}


func counterClockWise(a: Point, b: Point, c: Point)->Int{
    let area = 0.5*((b.x-a.x)*(c.y-a.y) - (b.y-a.y)*(c.x-a.x))
    if (area < 0){
        return 1 //clockwise
    }
    else if (area > 0){
        return  -1 //counterclockwise
    }
    else{
        return  0 // linear
    }
}

var p = Point(x: 2.3,y: 2.3)
var p2 = Point(x: 1, y: 1)
var p3 = Point(x: 0, y: 0)
var p4 = Point(x: 1.9, y: 4.5)
var p5 = Point(x: 1.9, y: 4.5)

var points: [Point] = [p2,p,p3,p4,p5]


func GrahamScan(inout Points: [Point])->[Point]?{
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
        while(counterClockWise(ConvexHull.last!, b: top, c: sortedPoints[i]) != -1){
            top = ConvexHull.removeLast()
        }
        ConvexHull.append(top)
        ConvexHull.append(sortedPoints[i])
    }
    return ConvexHull
}

points = GrahamScan(&points)!
print(points)

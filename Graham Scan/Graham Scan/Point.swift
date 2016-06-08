//
//  Point.swift
//  Graham Scan
//
//  Created by Youssef Fres on 6/8/16.
//  Copyright © 2016 Youssef Fares. All rights reserved.
//

import Foundation

public struct Point : CustomStringConvertible {
    var x: Double
    var y: Double
    var polarangle: Double?
    var distance: Double?
    
    public var description: String {
        return "(\(x), \(y))"
    }
    
    public init(x: Double, y:Double){
        self.x = x
        self.y = y
    }
    
    public static func orderWithY(a: Point, b: Point)->Bool{
        return a.y < b.y || (a.y == b.y && a.x < b.x)
    }
    
    public mutating func setPolar(lowest: Point)->Void{
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
    
    public mutating func setDistance(lowest: Point){
        self.distance = sqrt(pow(self.x - lowest.x, 2) + pow(self.y - lowest.y,2))
    }
    
    public static func orderWithPolar(a: Point, b: Point)->Bool{
        return a.polarangle! < b.polarangle! || (a.polarangle! - b.polarangle! < 0.001 && a.distance! < b.distance!)
    }
    
    public static func orientation(a: Point, b: Point, c: Point)->Int{
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
}



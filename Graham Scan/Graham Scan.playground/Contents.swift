//: Playground - noun: a place where people can play

import Cocoa


var p = Point(x: 2.3,y: 2.3)
var p2 = Point(x: 1, y: 1)
var p3 = Point(x: 0, y: 0)
var p4 = Point(x: 1.9, y: 4.5)
var p5 = Point(x: 1.234, y: 4.5)

var points: [Point] = [p2,p,p3,p4,p5]

points = GrahamScan(&points)!
print(points)

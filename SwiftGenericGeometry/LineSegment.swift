//
//  LineSegment.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

public protocol LineSegmentType: Equatable {
    associatedtype Point: PointType

    var first: Point { get }
    var second: Point { get }

    init(first: Point, second: Point)
}

public extension LineSegmentType {

    func containsPoint(point: Point) -> Bool {
        if first.x != second.x {    // self is not vertical
            if first.x <= point.x && point.x <= second.x {
                return true
            }
            else if first.x >= point.x && point.x >= second.x {
                return true
            }
        }
        else {    // self is vertical, so test y coordinate
            if first.y <= point.y && point.y <= second.y {
                return true
            }
            else if first.y >= point.y && point.y >= second.y {
                return true
            }
        }
        return false
    }

}

// MARK: -

public enum LineSegmentIntersection <LineSegment: LineSegmentType> {
    case None
    case Disjoint
    case Intersect(LineSegment.Point)
    case Overlap(LineSegment)
}

public extension LineSegmentType where Point.Scalar: FloatingPointType {

    public func intersection(other: Self) -> Point? {
        if case .Intersect(let intersection) = advancedIntersection(other) {
            return intersection
        }
        else {
            return nil
        }
    }

    // Adapted from: http://geomalgorithms.com/a05-_intersect-1.html
    func advancedIntersection(other: Self) -> LineSegmentIntersection <Self> {

        let SMALL_NUM = Point.Scalar(0.00000001)

        let S1 = self
        let S2 = other

        let u = S1.second - S1.first
        let v = S2.second - S2.first
        let w = S1.first - S2.first
        let D = perp(u,v)

        // test if they are parallel (includes either being a point)
        if abs(D) < SMALL_NUM {           // S1 and S2 are parallel
            if perp(u, w) != 0 || perp(v, w) != 0 {
                return .None                    // they are NOT collinear
            }
            // they are collinear or degenerate
            // check if they are degenerate points
            let du = dotProduct(u, u)
            let dv = dotProduct(v, v)
            if du == 0 && dv == 0 {            // both segments are points
                if S1.first != S2.first {         // they are distinct  points
                    return .Disjoint
                }
                return .Intersect(S1.first)
            }
            if du == 0 {                     // S1 is a single point
                if S2.containsPoint(S1.first) == false { // but is not in S2
                    return .None
                }
                return .Intersect(S1.first)
            }
            if dv == 0 {                     // S2 a single point
                if S1.containsPoint(S2.first) == false { // but is not in S1
                    return .None
                }
            return .Intersect(S2.first)
            }
            // they are collinear segments - get overlap (or not)

            // endpoints of S1 in eqn for S2
            var t0: Point.Scalar, t1: Point.Scalar

            let w2 = S1.second - S2.first
            if v.x != 0 {
                t0 = w.x / v.x
                t1 = w2.x / v.x
            }
            else {
                t0 = w.y / v.y
                t1 = w2.y / v.y
            }
            if t0 > t1 {                   // must have t0 smaller than t1
                swap(&t0, &t1)
            }
            // NO overlap
            if t0 > 1 || t1 < 0 {
                return .None
            }
            t0 = t0 < 0 ? 0 : t0               // clip to min 0
            t1 = t1 > 1 ? 1 : t1               // clip to max 1
            if t0 == t1 {                  // intersect is a point
                return .Intersect(S2.first + v * t0)
            }

            // they overlap in a valid subsegment
            return .Overlap(Self(first: S2.first + v * t0, second: S2.first + v * t1))
        }

        // the segments are skew and may intersect in a point
        // get the intersect parameter for S1
        let sI = perp(v, w) / D
        if sI < 0 || sI > 1 {               // no intersect with S1
            return .None
        }

        // get the intersect parameter for S2
        let tI = perp(u, w) / D
        if tI < 0 || tI > 1 {               // no intersect with S2
            return .None
        }

        return .Intersect(S1.first + u * sI)
    }


}


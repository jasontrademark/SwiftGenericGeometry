//
//  LineString.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

public protocol LineStringType {
    associatedtype Point: PointType
    var points: [Point] { get }
}


public extension LineStringType where Point == CGPoint {
    func boundingBox() -> CGRect {
        return points.boundingBox()
    }
}


public extension LineStringType {
    func boundingBox <Rect: RectType where Rect.Point == Point, Rect.Point.Scalar == Rect.Size.Scalar> () -> Rect {
//        return points.boundingBox()
        fatalError()
    }
}

public extension LineStringType {
    func toLineSegments <LineSegment: LineSegmentType where LineSegment.Point == Point>() -> [LineSegment] {
        precondition(points.count % 2 == 0)
        return 0.stride(to: points.count, by: 2)
            .map() { points[$0 ..< (min($0 + 2, points.count))] }
            .map() { ($0[0], $0[1]) }
            .map() { LineSegment(first: $0, second: $1) }
    }

}
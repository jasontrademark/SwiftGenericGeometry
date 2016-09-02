//
//  Polygon.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

public protocol PolygonType {
    associatedtype Point: PointType

    var points: [Point] { get }

    init(points: [Point])
}

public extension PolygonType where Point.Scalar: FloatingPoint {
    func boundingBox <Rect: RectType> () -> Rect where Rect.Point.Scalar: FloatingPoint, Rect.Point.Scalar == Rect.Size.Scalar, Point == Rect.Point {
        return points.boundingBox()
    }
}

public extension PolygonType {

    init <LineSegment: LineSegmentType> (segments: [LineSegment]) where LineSegment.Point == Point {
        let points = segments.flatMap() {
            return [ $0.first, $0.second ]
        }
        self.init(points: points)
    }

    func toLineSegments <LineSegment: LineSegmentType>() -> [LineSegment] where LineSegment.Point == Point {
        precondition(points.count >= 3)
        let segments = stride(from: 0, to: points.count - 1, by: 1)
            .map() { Array(points[$0 ..< $0 + 2]) }
            .map() { ($0[0], $0[1]) }
            .map() { LineSegment(first: $0, second: $1) }
        return segments + [ LineSegment(first:points.last!, second: points.first!)]
    }
}

public extension PolygonType where Point.Scalar: FloatingPoint {

    func intersections <LineSegment: LineSegmentType> (_ segment: LineSegment) -> [Point] where LineSegment.Point == Point {
        let segments: [LineSegment] = toLineSegments()
        return segments.flatMap() {
            return $0.intersection(segment)
        }
    }

}

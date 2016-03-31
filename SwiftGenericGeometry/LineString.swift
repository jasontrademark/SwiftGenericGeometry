//
//  LineString.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

// TODO: Rename to Polyline?
public protocol LineStringType {
    associatedtype Point: PointType

    var points: [Point] { get }

    init(points: [Point])
}

public extension LineStringType where Point.Scalar: FloatingPointType {
    @warn_unused_result
    func boundingBox <Rect: RectType where Rect.Point.Scalar: FloatingPointType, Rect.Point.Scalar == Rect.Size.Scalar, Point == Rect.Point> () -> Rect {
        return points.boundingBox()
    }
}

public extension LineStringType {

    init <LineSegment: LineSegmentType where LineSegment.Point == Point> (segments: [LineSegment]) {
        let points = segments.flatMap() {
            return [ $0.first, $0.second ]
        }
        self.init(points: points)
    }

    @warn_unused_result
    func toLineSegments <LineSegment: LineSegmentType where LineSegment.Point == Point>() -> [LineSegment] {
        precondition(points.count >= 2)
        return 0.stride(to: points.count - 1, by: 1)
            .map() { Array(points[$0 ..< $0 + 2]) }
            .map() { ($0[0], $0[1]) }
            .map() { LineSegment(first: $0, second: $1) }
    }
}

public extension LineStringType where Point.Scalar: FloatingPointType {

    func intersections <LineSegment: LineSegmentType where LineSegment.Point == Point> (segment: LineSegment) -> [Point] {
        let segments: [LineSegment] = toLineSegments()
        return segments.flatMap() {
            return $0.intersection(segment)
        }
    }

}

//
//  LineString.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

// TODO: Rename to Polyline?
public protocol LineStringType {
    associatedtype LineSegment: LineSegmentType
    var segments: [LineSegment] { get }

    init(segments: [LineSegment])
}

public extension LineStringType {

    init(points: [LineSegment.Point]) {
        precondition(points.count >= 2)
        let segments = 0.stride(to: points.count - 1, by: 1)
            .map() { Array(points[$0 ..< $0 + 2]) }
            .map() { ($0[0], $0[1]) }
            .map() { LineSegment(first: $0, second: $1) }
        self.init(segments: segments)
    }

    var points: [LineSegment.Point] {
        return segments.flatMap() {
            return [$0.first, $0.second]
        }
    }

}

public extension LineStringType where LineSegment.Point.Scalar: FloatingPointType {
    @warn_unused_result
    func boundingBox <Rect: RectType where Rect.Point.Scalar: FloatingPointType, Rect.Point.Scalar == Rect.Size.Scalar, LineSegment.Point == Rect.Point> () -> Rect {
        return points.boundingBox()
    }
}

//
//  CoreGraphics.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

import CoreGraphics

extension CGFloat: ScalarType {
}

extension CGPoint: PointType {
}

extension CGSize: SizeType {
}

extension CGRect: RectType {
}

// MARK: -

public struct Polygon: PolygonType {
    public var points: [CGPoint] = []
}


public struct LineSegment: LineSegmentType {
    public var first: CGPoint
    public var second: CGPoint

    // TODO: KILL
    public var start: CGPoint {
        return first
    }
    // TODO: KILL
    public var end: CGPoint {
        return second
    }

    public init(first: CGPoint, second: CGPoint) {
        self.first = first
        self.second = second
    }
}

public func == (lhs: LineSegment, rhs: LineSegment) -> Bool {
    return lhs.first == rhs.first && lhs.second == rhs.second
}

extension LineSegment {
    func transform(transform: CGAffineTransform) -> LineSegment {
        return LineSegment(first: start * transform, second: end * transform)
    }
}






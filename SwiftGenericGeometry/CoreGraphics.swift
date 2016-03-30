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

extension CGFloat: MathType {
    public static func sqrt(x: CGFloat) -> CGFloat {
        return CoreGraphics.sqrt(x)
    }
}

extension CGPoint: PointType {
}

extension CGSize: SizeType {
}

extension CGRect: RectType {
}

// MARK: -

public struct Polygon: PolygonType {
    public let points: [CGPoint]

    public init(points: [CGPoint]) {
        self.points = points
    }
}


public struct LineSegment: LineSegmentType {
    public let first: CGPoint
    public let second: CGPoint

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

public extension LineSegment {
    func transform(transform: CGAffineTransform) -> LineSegment {
        return LineSegment(first: start * transform, second: end * transform)
    }
}






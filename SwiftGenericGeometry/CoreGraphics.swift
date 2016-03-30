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

struct Polygon: PolygonType {
    var points: [CGPoint] = []
}


struct LineSegment: LineSegmentType {
    var first: CGPoint
    var second: CGPoint

    var start: CGPoint {
        return first
    }
    var end: CGPoint {
        return second
    }

    init(first: CGPoint, second: CGPoint) {
        self.first = first
        self.second = second
    }
}

func == (lhs: LineSegment, rhs: LineSegment) -> Bool {
    return lhs.first == rhs.first && lhs.second == rhs.second
}

//extension LineSegment {
//    func transform(transform: CGAffineTransform) -> LineSegment {
//        return LineSegment(first: start * transform, second: end * transform)
//    }
//}






//
//  IntegerTypes.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

import Foundation

public struct IntPoint: PointType {
    public var x: Int
    public var y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

public func == (lhs: IntPoint, rhs: IntPoint) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

// MARK: -

public struct IntSize: SizeType {
    public var width: Int
    public var height: Int

    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

public func == (lhs: IntSize, rhs: IntSize) -> Bool {
    return lhs.width == rhs.width && lhs.height == rhs.height
}

// MARK: -

public struct IntRect: RectType {
    public var origin: IntPoint
    public var size: IntSize

    public init(origin: IntPoint, size: IntSize) {
        self.origin = origin
        self.size = size
    }
}

public func == (lhs: IntRect, rhs: IntRect) -> Bool {
    return lhs.origin == rhs.origin && lhs.size == rhs.size
}

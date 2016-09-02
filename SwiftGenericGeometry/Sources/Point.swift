//
//  Point.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

public protocol PointType: Equatable {
    associatedtype Scalar: ScalarType

    var x: Scalar { get set }
    var y: Scalar { get set }

    init(x: Scalar, y: Scalar)
}

// MARK: -

public extension PointType {
    static var zero: Self {
        return self.init(x: Scalar(0), y: Scalar(0))
    }
}

// MARK: -

public prefix func - <Point: PointType> (other: Point) -> Point {
    return Point(x: -other.x, y: -other.y)
}

// MARK: -

public func + <Point: PointType> (lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func - <Point: PointType> (lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func * <Point: PointType> (lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
}

public func / <Point: PointType> (lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
}

// MARK: -

public func * <Point: PointType> (lhs: Point, rhs: Point.Scalar) -> Point {
    return Point(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func * <Point: PointType> (lhs: Point.Scalar, rhs: Point) -> Point {
    return Point(x: lhs * rhs.x, y: lhs * rhs.y)
}

public func / <Point: PointType> (lhs: Point, rhs: Point.Scalar) -> Point {
    return Point(x: lhs.x / rhs, y: lhs.y / rhs)
}

// MARK: -

public func + <Point: PointType, Size: SizeType> (lhs: Point, rhs: Size) -> Point where Point.Scalar == Size.Scalar {
    return Point(x: lhs.x + rhs.width, y: lhs.y + rhs.height)
}

public func - <Point: PointType, Size: SizeType> (lhs: Point, rhs: Size) -> Point where Point.Scalar == Size.Scalar {
    return Point(x: lhs.x - rhs.width, y: lhs.y - rhs.height)
}

// MARK: -

public func min <Point: PointType> (_ lhs: Point, _ rhs: Point) -> Point where Point.Scalar: Comparable {
    return Point(x: min(lhs.x, rhs.x), y: min(lhs.y, rhs.y))
}

public func max <Point: PointType> (_ lhs: Point, _ rhs: Point) -> Point where Point.Scalar: Comparable {
    return Point(x: max(lhs.x, rhs.x), y: max(lhs.y, rhs.y))
}

// MARK: -

public func dotProduct <Point: PointType> (_ lhs: Point, _ rhs: Point) -> Point.Scalar {
    return lhs.x * rhs.x + lhs.y * rhs.y
}

public func crossProduct <Point: PointType> (_ lhs: Point, _ rhs: Point) -> Point.Scalar {
    return lhs.x * rhs.y - lhs.y * rhs.x
}

// TODO: Rename perpProduct?
public func perp <Point: PointType> (_ lhs: Point, _ rhs: Point) -> Point.Scalar {
    return lhs.x * rhs.y - lhs.y * rhs.x
}

public extension PointType where Scalar: MathType {

    // TODO: Convert to func
    var magnitude: Scalar {
        return sqrt(x * x + y * y)
    }

    func distanceTo(_ other: Self) -> Scalar {
        return (self - other).magnitude
    }

}


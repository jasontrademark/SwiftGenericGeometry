//
//  Point.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

public protocol PointType: Equatable {
    associatedtype Scalar: ScalarType

    var x: Scalar { get }
    var y: Scalar { get }

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

public func * <Point: PointType> (lhs: Point, rhs: Point.Scalar) -> Point {
    return Point(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func / <Point: PointType> (lhs: Point, rhs: Point.Scalar) -> Point {
    return Point(x: lhs.x / rhs, y: lhs.y / rhs)
}

// MARK: -

public func + <Point: PointType, Size: SizeType where Point.Scalar == Size.Scalar> (lhs: Point, rhs: Size) -> Point {
    return Point(x: lhs.x + rhs.width, y: lhs.y + rhs.height)
}

public func - <Point: PointType, Size: SizeType where Point.Scalar == Size.Scalar> (lhs: Point, rhs: Size) -> Point {
    return Point(x: lhs.x - rhs.width, y: lhs.y - rhs.height)
}

// MARK: -

public func min <Point: PointType where Point.Scalar: Comparable> (lhs: Point, _ rhs: Point) -> Point {
    return Point(x: min(lhs.x, rhs.x), y: min(lhs.y, rhs.y))
}

public func max <Point: PointType where Point.Scalar: Comparable> (lhs: Point, _ rhs: Point) -> Point {
    return Point(x: max(lhs.x, rhs.x), y: max(lhs.y, rhs.y))
}

// MARK: -

public func dotProduct <Point: PointType> (lhs: Point, _ rhs: Point) -> Point.Scalar {
    return lhs.x * rhs.x + lhs.y * rhs.y
}

public func crossProduct <Point: PointType> (lhs: Point, _ rhs: Point) -> Point.Scalar {
    return lhs.x * rhs.y - lhs.y * rhs.x
}

// TODO: Rename perpProduct?
public func perp <Point: PointType> (lhs: Point, _ rhs: Point) -> Point.Scalar {
    return lhs.x * rhs.y - lhs.y * rhs.x
}

extension PointType where Scalar: MathType {

    var magnitude: Scalar {
        return sqrt(x * x + y * y)
    }

    func distanceTo(other: Self) -> Scalar {
        return (self - other).magnitude
    }

}


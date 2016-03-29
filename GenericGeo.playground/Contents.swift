//: Playground - noun: a place where people can play

import Foundation
import MapKit
import Cocoa

public protocol ScalarType: Equatable {
    func + (lhs: Self, rhs: Self) -> Self
    func - (lhs: Self, rhs: Self) -> Self
    func * (lhs: Self, rhs: Self) -> Self
    func / (lhs: Self, rhs: Self) -> Self

    init(_ value: Int)
    init(_ value: Double)
}

extension Int: ScalarType {
}

extension Float: ScalarType {
}

extension Double: ScalarType {
}

extension CGFloat: ScalarType {
}

// MARK: -

public protocol PointType: Equatable {
    associatedtype Scalar: ScalarType

    var x: Scalar { get }
    var y: Scalar { get }

    init(x: Scalar, y: Scalar)
}

// MARK: -

public protocol SizeType: Equatable {
    associatedtype Scalar: ScalarType

    var width: Scalar { get }
    var height: Scalar { get }

    init(width: Scalar, height: Scalar)
}

// MARK: -

public protocol RectType: Equatable {
    associatedtype Point: PointType
    associatedtype Size: SizeType

    var origin: Point { get }
    var size: Size { get }

    init(origin: Point, size: Size)
}

// MARK: -

public extension PointType {
    static var zero: Self {
        return self.init(x: Scalar(0), y: Scalar(0))
    }
}

// MARK: -

public extension SizeType {
    static var zero: Self {
        return self.init(width: Scalar(0), height: Scalar(0))
    }
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

public func + <Size: SizeType> (lhs: Size, rhs: Size) -> Size {
    return Size(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func - <Size: SizeType> (lhs: Size, rhs: Size) -> Size {
    return Size(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

public func * <Size: SizeType> (lhs: Size, rhs: Size) -> Size {
    return Size(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
}

public func / <Size: SizeType> (lhs: Size, rhs: Size) -> Size {
    return Size(width: lhs.width / rhs.width, height: lhs.height / rhs.height)
}

public func * <Size: SizeType> (lhs: Size, rhs: Size.Scalar) -> Size {
    return Size(width: lhs.width * rhs, height: lhs.height * rhs)
}

public func / <Size: SizeType> (lhs: Size, rhs: Size.Scalar) -> Size {
    return Size(width: lhs.width / rhs, height: lhs.height / rhs)
}

// MARK: -

public func + <Point: PointType, Size: SizeType where Point.Scalar == Size.Scalar> (lhs: Point, rhs: Size) -> Point {
    return Point(x: lhs.x + rhs.width, y: lhs.y + rhs.height)
}

public func - <Point: PointType, Size: SizeType where Point.Scalar == Size.Scalar> (lhs: Point, rhs: Size) -> Point {
    return Point(x: lhs.x - rhs.width, y: lhs.y - rhs.height)
}


// MARK: -

public extension RectType {
    var x: Point.Scalar {
        return origin.x
    }

    var y: Point.Scalar {
        return origin.y
    }

    var width: Size.Scalar {
        return size.width
    }

    var height: Size.Scalar {
        return size.height
    }

    init(x: Point.Scalar, y: Point.Scalar, width: Size.Scalar, height: Size.Scalar) {
        self.init(origin: Point(x: x, y: y), size: Size(width: width, height: height))
    }

    init(width: Size.Scalar, height: Size.Scalar) {
        self.init(origin: Point.zero, size: Size(width: width, height: height))
    }
}

public extension RectType where Point.Scalar == Size.Scalar, Size.Scalar: FloatingPointType {
    init(center: Point, size: Size) {
        self.init(origin: center - size * Size.Scalar(0.5), size: size)
    }

    init(center: Point, diameter: Size.Scalar) {
        let size = Size(width: diameter, height: diameter)
        self.init(origin: center - size * Size.Scalar(0.5), size: size)
    }

    init(center: Point, radius: Size.Scalar) {
        let size = Size(width: radius * Size.Scalar(2), height: radius * Size.Scalar(2))
        self.init(origin: center - size * Size.Scalar(0.5), size: size)
    }
}

public extension RectType {
    static var zero: Self {
        return self.init(origin: Point.zero, size: Size.zero)
    }
}

public extension RectType where Point.Scalar: FloatingPointType {
    static var null: Self {
        return self.init(origin: Point(x: Point.Scalar.infinity, y: Point.Scalar.infinity), size: Size.zero)
    }
    var isNull: Bool {
        return origin == Point(x: Point.Scalar.infinity, y: Point.Scalar.infinity)
    }
}

public extension RectType where Point.Scalar == Size.Scalar {

    var minX: Point.Scalar {
        return x
    }

    var minY: Point.Scalar {
        return y
    }

    var maxX: Point.Scalar {
        return x + width
    }

    var maxY: Point.Scalar {
        return y + height
    }

    init(minX: Point.Scalar, minY: Point.Scalar, maxX: Point.Scalar, maxY: Point.Scalar) {
        self.init(origin: Point(x: minX, y: minY), size: Size(width: maxX - minX, height: maxY - minY))
    }

    var minXminY: Point {
        return Point(x: minX, y: minY)
    }

    var minXmaxY: Point {
        return Point(x: minX, y: maxY)
    }

    var maxXminY: Point {
        return Point(x: maxX, y: minY)
    }

    var maxXmaxY: Point {
        return Point(x: maxX, y: maxY)
    }
}

public extension RectType where Point.Scalar == Size.Scalar, Point.Scalar: Comparable {
    init(points: (Point, Point)) {
        let minX = min(points.0.x, points.1.x)
        let minY = min(points.0.y, points.1.y)
        let maxX = max(points.0.x, points.1.x)
        let maxY = max(points.0.y, points.1.y)
        self.init(minX: minX, minY: minY, maxX: maxX, maxY: maxY)
    }
}


public extension RectType where Point.Scalar == Size.Scalar, Point.Scalar: FloatingPointType {

    var midX: Point.Scalar {
        return x + width * Point.Scalar(0.5)
    }

    var midY: Point.Scalar {
        return y + height * Point.Scalar(0.5)
    }

    var mid: Point {
        return Point(x: midX, y: midY)
    }
}

public extension RectType where Point.Scalar == Size.Scalar, Point.Scalar: FloatingPointType {
    @warn_unused_result
    func union(point: Point) -> Self {
        if isNull {
            return Self(origin: point, size: Size.zero)
        }
        else {
//            let p1 = min(minXminY, point)
//            let p2 = max(maxXmaxY, point)
//            return Self(points: (p1, p2))

            let minX = min(self.minX, point.x)
            let minY = min(self.minY, point.y)
            let maxX = max(self.maxX, point.x)
            let maxY = max(self.maxY, point.y)
            return Self(minX: minX, minY: minY, maxX: maxX, maxY: maxY)
        }
    }

    @warn_unused_result
    func union(rect: Self) -> Self {
        if isNull {
            return rect
        }
        else {
            let minX = min(self.minX, rect.minX)
            let minY = min(self.minY, rect.minY)
            let maxX = max(self.maxX, rect.maxX)
            let maxY = max(self.maxY, rect.maxY)
            return Self(minX: minX, minY: minY, maxX: maxX, maxY: maxY)
        }
    }
}

public extension RectType where Point.Scalar == Size.Scalar, Point.Scalar: Comparable {
    @warn_unused_result
    func contains(point: Point) -> Bool {
        let xInterval = minX ..< maxX
        let yInterval = minY ..< maxY
        return xInterval.contains(point.x) && yInterval.contains(point.y)
    }
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

//

public protocol LineSegment: Equatable {
    associatedtype Point: PointType

    var first: Point { get }
    var second: Point { get }
}


// MARK: -

extension MKMapPoint: Equatable {
}

public func == (lhs: MKMapPoint, rhs: MKMapPoint) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

extension MKMapSize: Equatable {
}

public func == (lhs: MKMapSize, rhs: MKMapSize) -> Bool {
    return lhs.width == rhs.width && lhs.height == rhs.height
}

extension MKMapRect: Equatable {
}

public func == (lhs: MKMapRect, rhs: MKMapRect) -> Bool {
    return lhs.origin == rhs.origin && lhs.size == rhs.size
}

// MARK: -

extension MKMapPoint: CustomStringConvertible {
    public var description: String {
        return "\(x), \(y)"
    }
}

extension MKMapSize: CustomStringConvertible {
    public var description: String {
        return "\(width), \(height)"
    }
}

//extension MKMapPoint: CustomStringConvertible {
//    public var description: String {
//        return "\(x), \(y)"
//    }
//}


extension CGPoint: PointType {
}

//

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

// MARK: -

extension MKMapPoint: PointType {
}

extension MKMapSize: SizeType {
}

extension MKMapRect: RectType {
}


print(IntRect.zero)
print(MKMapRect.null)
print(MKMapRect.null.isNull)
print(IntRect(points: (IntPoint(x: -100, y: -100), IntPoint(x: 100, y: 100))))

print(MKMapRect.null.union(MKMapPoint(x: 10, y: 10)).union(MKMapPoint(x: 100, y: 100)))








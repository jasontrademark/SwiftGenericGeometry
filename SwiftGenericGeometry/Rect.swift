//
//  Rect.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

public protocol RectType: Equatable {
    associatedtype Point: PointType
    associatedtype Size: SizeType

    var origin: Point { get }
    var size: Size { get }

    init(origin: Point, size: Size)
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

// MARK: -

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

// MARK: -

public extension RectType {
    static var zero: Self {
        return self.init(origin: Point.zero, size: Size.zero)
    }
}

// MARK: -

public extension RectType where Point.Scalar: FloatingPointType {
    static var null: Self {
        return self.init(origin: Point(x: Point.Scalar.infinity, y: Point.Scalar.infinity), size: Size.zero)
    }
    var isNull: Bool {
        return origin == Point(x: Point.Scalar.infinity, y: Point.Scalar.infinity)
    }
}

// MARK: -

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

    var minXMinY: Point {
        return Point(x: minX, y: minY)
    }

    var minXMaxY: Point {
        return Point(x: minX, y: maxY)
    }

    var maxXMinY: Point {
        return Point(x: maxX, y: minY)
    }

    var maxXMaxY: Point {
        return Point(x: maxX, y: maxY)
    }
}

// MARK: -

public extension RectType where Point.Scalar == Size.Scalar, Point.Scalar: Comparable {
    init(points: (Point, Point)) {
        let minX = min(points.0.x, points.1.x)
        let minY = min(points.0.y, points.1.y)
        let maxX = max(points.0.x, points.1.x)
        let maxY = max(points.0.y, points.1.y)
        self.init(minX: minX, minY: minY, maxX: maxX, maxY: maxY)
    }
}

// MARK: -

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

// MARK: -

public extension RectType where Point.Scalar == Size.Scalar {
    @warn_unused_result
    func union(point: Point) -> Self {
//            let p1 = min(minXminY, point)
//            let p2 = max(maxXmaxY, point)
//            return Self(points: (p1, p2))

        let minX = min(self.minX, point.x)
        let minY = min(self.minY, point.y)
        let maxX = max(self.maxX, point.x)
        let maxY = max(self.maxY, point.y)
        return Self(minX: minX, minY: minY, maxX: maxX, maxY: maxY)
    }

    @warn_unused_result
    func union(rect: Self) -> Self {
        let minX = min(self.minX, rect.minX)
        let minY = min(self.minY, rect.minY)
        let maxX = max(self.maxX, rect.maxX)
        let maxY = max(self.maxY, rect.maxY)
        return Self(minX: minX, minY: minY, maxX: maxX, maxY: maxY)
    }
}

// MARK: -

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

// MARK: -

public extension RectType where Point.Scalar == Size.Scalar, Point.Scalar: Comparable {
    @warn_unused_result
    func contains(point: Point) -> Bool {
        let xInterval = minX ..< maxX
        let yInterval = minY ..< maxY
        return xInterval.contains(point.x) && yInterval.contains(point.y)
    }
}

// MARK: -

public extension SequenceType where Generator.Element: PointType, Generator.Element.Scalar: FloatingPointType {
    @warn_unused_result
    func boundingBox <Rect: RectType where Rect.Point == Generator.Element, Rect.Point.Scalar == Rect.Size.Scalar>() -> Rect {
        return reduce(Rect.null) {
            (accumulator, element) in
            return accumulator.union(element)
        }
    }
}




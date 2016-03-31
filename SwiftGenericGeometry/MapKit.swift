//
//  MapKit.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

import MapKit

extension MKMapPoint: Equatable {
}

public func == (lhs: MKMapPoint, rhs: MKMapPoint) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

extension MKMapPoint: PointType {
}

extension MKMapPoint: CustomStringConvertible {
    public var description: String {
        return "\(x), \(y)"
    }
}

// MARK: -

extension MKMapSize: Equatable {
}

public func == (lhs: MKMapSize, rhs: MKMapSize) -> Bool {
    return lhs.width == rhs.width && lhs.height == rhs.height
}

extension MKMapSize: SizeType {
}

extension MKMapSize: CustomStringConvertible {
    public var description: String {
        return "\(width), \(height)"
    }
}

// MARK: -

extension MKMapRect: Equatable {
}

public func == (lhs: MKMapRect, rhs: MKMapRect) -> Bool {
    return lhs.origin == rhs.origin && lhs.size == rhs.size
}

extension MKMapRect: RectType {
}

// MARK: -


public struct MapLineString: LineStringType {
    public let points: [MKMapPoint]

    public init(points: [MKMapPoint]) {
        self.points = points
    }
}



public struct MapPolygon: PolygonType {
    public let points: [MKMapPoint]

    public init(points: [MKMapPoint]) {
        self.points = points
    }
}


public struct MapLineSegment: LineSegmentType {
    public let first: MKMapPoint
    public let second: MKMapPoint

    public init(first: MKMapPoint, second: MKMapPoint) {
        self.first = first
        self.second = second
    }
}

public func == (lhs: MapLineSegment, rhs: MapLineSegment) -> Bool {
    return lhs.first == rhs.first && lhs.second == rhs.second
}




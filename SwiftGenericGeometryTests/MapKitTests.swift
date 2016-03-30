//
//  SwiftGenericGeometryTests.swift
//  SwiftGenericGeometryTests
//
//  Created by Jonathan Wight on 3/30/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

import XCTest

import SwiftGenericGeometry
import MapKit

class MapKitTests: XCTestCase {
    
    func testSimpleIntRects() {
        let rect = MKMapRect(x: -100, y: 100, width: 100, height: 200)
        XCTAssert(rect.origin.x == -100)
        XCTAssert(rect.x == -100)
        XCTAssert(rect.minX == -100)
        XCTAssert(rect.origin == MKMapPoint(x: -100, y: 100))
        XCTAssert(rect.minXMinY == rect.origin)
        XCTAssert(rect.minXMaxY == MKMapPoint(x: -100, y: 300))
        XCTAssert(rect.maxXMinY == MKMapPoint(x: 0, y: 100))
        XCTAssert(rect.maxXMaxY == MKMapPoint(x: 0, y: 300))
        XCTAssert(rect == MKMapRect(minX: -100, minY: 100, maxX: 0, maxY: 300))
        XCTAssert(MKMapRect(width: 100, height: 200) == MKMapRect(minX: 0, minY: 0, maxX: 100, maxY: 200))
    }

    func testInits() {
        XCTAssert(MKMapRect(center: MKMapPoint(x: 0, y: -100), size: MKMapSize(width: 100, height: 50)) == MKMapRect(x: -50, y: -125, width: 100, height: 50))
        XCTAssert(MKMapRect(center: MKMapPoint(x: 0, y: -100), diameter: 100) == MKMapRect(x: -50, y: -150, width: 100, height: 100))
        XCTAssert(MKMapRect(center: MKMapPoint(x: 0, y: -100), radius: 50) == MKMapRect(x: -50, y: -150, width: 100, height: 100))
    }

    func testToLineSegments() {

        let polygon = MapPolygon(points: [
            MKMapPoint(x: 0, y: 0),
            MKMapPoint(x: 100, y: 0),
            MKMapPoint(x: 100, y: 100),
            MKMapPoint(x: 0, y: 100),
        ])

        let segments:[MapLineSegment] = polygon.toLineSegments()

        XCTAssert(segments[0] == MapLineSegment(first: MKMapPoint(x: 0, y: 0), second: MKMapPoint(x: 100, y: 0)))
        XCTAssert(segments[1] == MapLineSegment(first: MKMapPoint(x: 100, y: 0), second: MKMapPoint(x: 100, y: 100)))
    }

    func testBoundingBoxes() {
        let points = [
            MKMapPoint(x: 0, y: 0),
            MKMapPoint(x: 100, y: 0),
            MKMapPoint(x: 100, y: 100),
            MKMapPoint(x: 0, y: 100),
        ]
        XCTAssert(points.boundingBox() == MKMapRect(x: 0, y:0, width: 100, height: 100))

        let polygon = MapPolygon(points: [
            MKMapPoint(x: 0, y: 0),
            MKMapPoint(x: 100, y: 0),
            MKMapPoint(x: 100, y: 100),
            MKMapPoint(x: 0, y: 100),
        ])
        XCTAssert(polygon.boundingBox() == MKMapRect(x: 0, y:0, width: 100, height: 100))
    }

}

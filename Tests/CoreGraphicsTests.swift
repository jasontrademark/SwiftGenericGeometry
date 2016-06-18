//
//  SwiftGenericGeometryTests.swift
//  SwiftGenericGeometryTests
//
//  Created by Jonathan Wight on 3/30/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

import XCTest

import SwiftGenericGeometry

class CoreGraphicsTests: XCTestCase {
    
    func testSimpleRects() {
        let rect = CGRect(x: -100, y: 100, width: 100, height: 200)
        XCTAssert(rect.origin.x == -100)
        XCTAssert(rect.x == -100)
        XCTAssert(rect.minX == -100)
        XCTAssert(rect.origin == CGPoint(x: -100, y: 100))
        XCTAssert(rect.minXMinY == rect.origin)
        XCTAssert(rect.minXMaxY == CGPoint(x: -100, y: 300))
        XCTAssert(rect.maxXMinY == CGPoint(x: 0, y: 100))
        XCTAssert(rect.maxXMaxY == CGPoint(x: 0, y: 300))
        XCTAssert(rect == CGRect(minX: -100, minY: 100, maxX: 0, maxY: 300))
        XCTAssert(CGRect(width: 100, height: 200) == CGRect(minX: 0, minY: 0, maxX: 100, maxY: 200))
    }

    func testCGRectsInits() {
        XCTAssert(CGRect(center: CGPoint(x: 0, y: -100), size: CGSize(width: 100, height: 50)) == CGRect(x: -50, y: -125, width: 100, height: 50))
        XCTAssert(CGRect(center: CGPoint(x: 0, y: -100), diameter: 100) == CGRect(x: -50, y: -150, width: 100, height: 100))
        XCTAssert(CGRect(center: CGPoint(x: 0, y: -100), radius: 50) == CGRect(x: -50, y: -150, width: 100, height: 100))
    }

//    func testToLineSegments() {
//
//        let polygon = Polygon(points: [
//            CGPoint(x: 0, y: 0),
//            CGPoint(x: 100, y: 0),
//            CGPoint(x: 100, y: 100),
//            CGPoint(x: 0, y: 100),
//        ])
//
//        let segments:[LineSegment] = polygon.toLineSegments()
//
//        XCTAssert(segments[0] == LineSegment(first: CGPoint(x: 0, y: 0), second: CGPoint(x: 100, y: 0)))
//        XCTAssert(segments[1] == LineSegment(first: CGPoint(x: 100, y: 0), second: CGPoint(x: 100, y: 100)))
//    }

    func testBoundingBoxes() {
        let points = [
            CGPoint(x: 0, y: 0),
            CGPoint(x: 100, y: 0),
            CGPoint(x: 100, y: 100),
            CGPoint(x: 0, y: 100),
        ]
        XCTAssert(points.boundingBox() == CGRect(x: 0, y:0, width: 100, height: 100))

//        let polygon = Polygon(points: [
//            CGPoint(x: 0, y: 0),
//            CGPoint(x: 100, y: 0),
//            CGPoint(x: 100, y: 100),
//            CGPoint(x: 0, y: 100),
//        ])
//        XCTAssert(polygon.boundingBox() == CGRect(x: 0, y:0, width: 100, height: 100))
    }

}

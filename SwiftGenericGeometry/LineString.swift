//
//  LineString.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

protocol LineStringType {
    associatedtype Point: PointType
    var points: [Point] { get }
}

extension LineStringType where Point == CGPoint {
    func boundingBox() -> CGRect {
        return points.boundingBox()
    }
}

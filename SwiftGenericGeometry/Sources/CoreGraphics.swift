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

extension CGFloat: MathType {
    public static func sqrt(_ x: CGFloat) -> CGFloat {
        return CoreGraphics.sqrt(x)
    }
}

extension CGPoint: PointType {
}

extension CGSize: SizeType {
}

extension CGRect: RectType {
}


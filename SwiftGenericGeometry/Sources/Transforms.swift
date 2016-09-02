//
//  Transforms.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/30/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

import CoreGraphics

public func * (lhs: CGPoint, rhs: CGAffineTransform) -> CGPoint {
    return lhs.applying(rhs)
}

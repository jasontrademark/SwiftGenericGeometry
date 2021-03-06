//
//  Math.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/30/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

import Darwin

public protocol MathType: AbsoluteValuable {
    static func sqrt(x: Self) -> Self
}

public func sqrt <T: MathType> (x: T) -> T {
    return T.sqrt(x)
}

extension Double: MathType {
    public static func sqrt(x: Double) -> Double {
        return Darwin.sqrt(x)
    }
}

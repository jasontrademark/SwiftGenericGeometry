//
//  Math.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/30/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

protocol MathType: AbsoluteValuable {
    static func sqrt(x: Self) -> Self
}

func sqrt <T: MathType> (x: T) -> T {
    return T.sqrt(x)
}

extension Double: MathType {
    static func sqrt(x: Double) -> Double {
        return Darwin.sqrt(x)
    }
}

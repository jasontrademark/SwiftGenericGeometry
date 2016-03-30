//
//  Size.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

public protocol SizeType: Equatable {
    associatedtype Scalar: ScalarType

    var width: Scalar { get set }
    var height: Scalar { get set }

    init(width: Scalar, height: Scalar)
}

// MARK: -

public extension SizeType {
    static var zero: Self {
        return self.init(width: Scalar(0), height: Scalar(0))
    }
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

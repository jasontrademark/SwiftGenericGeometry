//: Playground - noun: a place where people can play

import CoreGraphics

let items = [ "A", "B", "C", "D" ]

let slices = 0.stride(to: items.count - 1, by: 1)
    .map() { items[$0 ..< $0 + 2] }

dump(slices)


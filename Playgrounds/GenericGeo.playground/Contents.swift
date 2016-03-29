//: Playground - noun: a place where people can play

import Foundation
import MapKit
import Cocoa
import SwiftGenericGeometry

//


print(IntRect.zero)
print(MKMapRect.null)
print(MKMapRect.null.isNull)
print(IntRect(points: (IntPoint(x: -100, y: -100), IntPoint(x: 100, y: 100))))
print(MKMapRect.null.union(MKMapPoint(x: 10, y: 10)).union(MKMapPoint(x: 100, y: 100)))

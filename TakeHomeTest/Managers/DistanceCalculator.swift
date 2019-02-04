//
//  DistanceCalculator.swift
//  TakeHomeTest
//
//  Created by Abhishek Srivastava on 03/02/19.
//  Copyright © 2019 Abhishek Srivastava. All rights reserved.
//

import UIKit

class DistanceCalculator: NSObject {
    
    class func haversineDinstanceInMeters(lat1: Double, long1: Double, lat2: Double, long2: Double) -> Double {
        
        let haversin = { (angle: Double) -> Double in
            return (1 - cos(angle))/2
        }
        
        let ahaversin = { (angle: Double) -> Double in
            return 2 * asin(sqrt(angle))
        }
        
        // Converts from degrees to radians
        let degreesToRadians = { (angle: Double) -> Double in
            return (angle / 360) * 2 * .pi
        }
        
        let lat1 = degreesToRadians(lat1)
        let lon1 = degreesToRadians(long1)
        let lat2 = degreesToRadians(lat2)
        let lon2 = degreesToRadians(long2)
        
        let distanceInMeters = kRadiusOfEarth * ahaversin(haversin(lat2 - lat1) + cos(lat1) * cos(lat2) * haversin(lon2 - lon1))
        return distanceInMeters
    }
    
    class func haversineDinstanceInKiloMeters(lat1: Double, long1: Double, lat2: Double, long2: Double) -> Double {
        let distanceInKm: Double = haversineDinstanceInMeters(lat1: lat1, long1: long1, lat2: lat2, long2: long2) / 1000.00
        return distanceInKm
    }
}

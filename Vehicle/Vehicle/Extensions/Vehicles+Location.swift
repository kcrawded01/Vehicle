//
//  Vehicles+Location.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 24/01/2022.
//

import Foundation

extension Array where Element == Vehicle {
    func updateLocation() {
        for vehicle in self {
            let obj = SmartCache.shared.getObject(forkey: Int(vehicle.vehicleId))
            if(obj != nil) {
                vehicle.lat = obj!.lat
                vehicle.long = obj!.lon
            }
        }
    }
}

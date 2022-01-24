//
//  VehicleLocationDTO.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 20/01/2022.
//

import Foundation

class VehicleLocation : Codable {
    var vehicleid: Int
    var lat: Double
    var lon: Double

    init(with vehicleid: Int, lat: Double, lon: Double) {
        self.vehicleid = vehicleid
        self.lat = lat
        self.lon = lon
    }
}

class VehicleLocationEx : VehicleLocation {
    var expirationDate: Date
    
    override init(with vehicleid: Int, lat: Double, lon: Double) {
        expirationDate = Date()
        super.init(with: vehicleid, lat: lat, lon: lon)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

//
//  OwnerVechicleDTO.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 19/01/2022.
//

import Foundation

struct User : Codable {
    var userid: Int?
    var owner: Owner1?
    var vehicles: [Vehicle2]?
}

struct Owner1 : Codable {
    var name: String?
    var surname: String?
    var foto: String?
}

struct Vehicle2 : Codable {
    var vehicleid: Int?
    var make: String?
    var model: String?
    var year: String?
    var color: String?
    var vin: String?
    var foto: String?
}

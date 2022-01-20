//
//  Vehicle.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 19/01/2022.
//

import Foundation
import MapKit

class Vehicle : NSObject, MKAnnotation {
    var uid: Int
    var name: String
    var model: String
    var year: String
    var color: String
    var vin: String
    var pic: String
    var lat: Double
    var long: Double
    
    private var _coordinate: CLLocationCoordinate2D
    dynamic var coordinate: CLLocationCoordinate2D {
        get {
            _coordinate
        } set {
            _coordinate = newValue
        }
    }
    
    var title: String? {
        name + " " + model + ", " + year
    }
    
    init(dic: Dictionary<String, String>, tag: Bool) {
        self.uid = 0
        self.name = tag ? "Toyota" : "Saab"
        self.model = tag ? "RAV4" : "93"
        self.year = tag ? "2007" : "2008"
        self.color = tag ? "#c2b280" : "#ffffff"
        self.vin = "5TFEM5F18EX043734"
        self.pic = tag ? "https://s-media-cache-ak0.pinimg.com/736x/a0/68/0d/a0680da9e0730971bf817ae7da78d2d5.jpg" : "https://upload.wikimedia.org/wikipedia/lv/7/79/Mercedes_Benz_O530.jpg"
        self.lat = tag ? 56.952590 : 56.949660
        self.long = tag ? 24.143230 : 24.141730
        _coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}

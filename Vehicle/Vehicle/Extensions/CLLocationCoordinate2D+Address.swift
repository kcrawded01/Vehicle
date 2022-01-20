//
//  CLLocationCoordinate2D+Address.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 19/01/2022.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {
    func findAddress(completion: @escaping (String) -> Void) {
        CLGeocoder.init().reverseGeocodeLocation(CLLocation(latitude: self.latitude, longitude: self.longitude)) { placemarks, error in
            if (error == nil && placemarks != nil && placemarks!.count > 0){
                completion(placemarks![0].name ?? "")
            }
        }
    }
}

//
//  LocationTracker.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 20/01/2022.
//

import Foundation

//save data in the cache with expiration time

class LocationTracker {
    weak var delegate: FetchDelegate?
    var userId: Int32!
    
    static let shared = LocationTracker()
    
    func fetchData(userId: Int32) {
        self.userId = userId
        let url = Defines.vechicleURL + "\(userId)"
        NetworkManager().retrieveData(url: url) { failed, data in
            if (!failed && data != nil) {
                self.decodeData(data)
            }else {
                print("failed: \(failed) or data is nil: \(data == nil)")
                self.delegate?.fetchFailed()
            }
        }
    }
    
    func cacheData(_ vehicle: VehicleLocation) {
        SmartCache.shared.setObject(
            VehicleLocationEx(with: vehicle.vehicleid, lat: vehicle.lat, lon: vehicle.lon),
            forKey: vehicle.vehicleid)
    }
    
    func decodeData(_ data: Data?) {
        let decoder = JSONDecoder()
        do {
            let vechicleData = try decoder.decode([String:[VehicleLocation]].self, from: data!)
            let vehicles = vechicleData["data"] ?? []
            for vehicle in vehicles {
                self.cacheData(vehicle)
            }
            self.delegate?.updateSucceeded()
        } catch {
            print("Error info: \(error)")
            self.delegate?.fetchFailed()
        }
    }
}

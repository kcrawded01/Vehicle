//
//  LocationTracker.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 20/01/2022.
//

import Foundation

class LocationTracker {
    //save data in the cache with expiration time
    
    func fetchData(userId: Int) {
        let url = Defines.vechicleURL + "\(userId)"
        NetworkManager().retrieveData(url: url) { failed, data in
            if (!failed && data != nil) {
                self.decodeData(data)
            }else {
                print("failed: \(failed) or data is nil: \(data == nil)")
            }
        }
    }
    
    func cacheData(_ vehicle: VehicleLocation) {
        
    }
    
    func decodeData(_ data: Data?) {
        let decoder = JSONDecoder()
        do {
            let vechicleData = try decoder.decode([String:[VehicleLocation]].self, from: data!)
            let vehicles = vechicleData["data"] ?? []
            for vehicle in vehicles {
                self.cacheData(vehicle)
            }
        } catch {
            print("Error info: \(error)")
        }
    }
}

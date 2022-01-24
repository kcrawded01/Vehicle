//
//  SmartCache.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 23/01/2022.
//

import Foundation

class SmartCache {
    
    private var cache: NSCache<NSString, VehicleLocationEx>
    private let cacheExpiration: TimeInterval = 30
    
    static let shared = SmartCache()
    
    private init () {
        cache = NSCache<NSString, VehicleLocationEx>()
    }
    
    func setObject(_ vehicleLocation: VehicleLocationEx, forKey key: Int) {
        cache.setObject(vehicleLocation, forKey: nsKey(key))
    }
    
    func getObject(forkey key: Int) -> VehicleLocationEx? {
        let object = cache.object(forKey: nsKey(key))
        if(object != nil) {
            if (cacheExpiration < fabs(object!.expirationDate.timeIntervalSinceNow)) {
                cache.removeObject(forKey: nsKey(key))
            }
        }
        return object
    }
    
    func nsKey(_ key: Int) -> NSString {
        return String(key) as NSString
    }
}

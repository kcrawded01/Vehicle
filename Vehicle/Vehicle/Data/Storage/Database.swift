//
//  Database.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 24/01/2022.
//

import Foundation
import CoreData
import UIKit

class Database {
    static let shared = Database()
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    func saveOwner(with userId: Int, _ ownerDTO: OwnerDTO) {
        if let context = container?.viewContext {
            if let foundOwner = try? Owner.findOwner(userid: Int32(userId), in: context) {
                Owner.updateOwnerData(owner: foundOwner, ownerDTO: ownerDTO, in: context)
            }else {
                _ = Owner.createOwner(Int32(userId), ownerDTO, in: context)
            }
        }
    }
    
    func saveVehicles(_ userId: Int, _ vehicles: [VehicleDTO]) {
        if let context = container?.viewContext {
            if (vehicles.count > 0) {
                Vehicle.clearUserVehicles(userId: Int32(userId), in: context)
            }
            
            for vehicle in vehicles {
               _ = try? Vehicle.createVehicle(Int32(userId), vehicle, in: context)
            }
        }
    }
    
    func findOwners () -> [Owner] {
        if let context = container?.viewContext {
            let request: NSFetchRequest<Owner> = Owner.fetchRequest()
            if let owners = (try? context.fetch(request)) {
                return owners
            }
        }
        return [Owner]()
    }
    
    func findUserVehicles(userId: Int32) -> [Vehicle] {
        if let context = container?.viewContext {
            if let vehicles = try? Vehicle.findUserVehicles(userId: Int32(userId), in: context) {
                return vehicles
            }
        }
        return [Vehicle]()
    }
    
    func findVehicles() -> [Vehicle] {
        if let context = container?.viewContext {
            let request: NSFetchRequest<Vehicle> = Vehicle.fetchRequest()
            if let owners = (try? context.fetch(request)) {
                return owners
            }
        }
        return [Vehicle]()
    }
}

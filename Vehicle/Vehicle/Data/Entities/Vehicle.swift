//
//  Vehicle.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 24/01/2022.
//

import UIKit
import CoreData
import MapKit

class Vehicle: NSManagedObject, MKAnnotation {
    var lat: Double?
    var long: Double?
    
    class func clearUserVehicles(userId: Int32, in context: NSManagedObjectContext) {
        if let vehicles = try? findUserVehicles(userId: userId, in: context) {
            for vehicle in vehicles {
                context.delete(vehicle)
            }
        }
    }
    
    class func findUserVehicles(userId: Int32, in context: NSManagedObjectContext) throws -> [Vehicle] {
        let request: NSFetchRequest<Vehicle> = Vehicle.fetchRequest()
        request.predicate = NSPredicate(format: "userId == %lld", userId)
        
        do {
            let matches = try context.fetch(request)
            if (matches.count > 0) {
                return matches
            }
        }catch {
            throw error
        }
        
        return [Vehicle]()
    }

    class func createVehicle(_ userId: Int32, _ vehicleDTO: VehicleDTO, in context: NSManagedObjectContext) throws -> Vehicle? {
        do {
            let vehicle = Vehicle(context: context)
            vehicle.year = vehicleDTO.year
            vehicle.model = vehicleDTO.model
            vehicle.foto = vehicleDTO.foto
            vehicle.vin = vehicleDTO.vin
            vehicle.color = vehicleDTO.color
            vehicle.make = vehicleDTO.make
            vehicle.vehicleId = Int32(vehicleDTO.vehicleid!)
            vehicle.userId = userId
            let owner = try Owner.findOwner(userid: userId, in: context)
            if (owner != nil) {
                vehicle.owner_ = owner
                try? context.save()
                return vehicle
            }
        }catch {
            throw error
        }
        return nil
    }
    
    //MARK: MKAnnotation
    private var _coordinate: CLLocationCoordinate2D!
    dynamic var coordinate: CLLocationCoordinate2D {
        get {
            _coordinate = CLLocationCoordinate2D(latitude: lat ?? 0, longitude: long ?? 0)
            return _coordinate
        } set {
            _coordinate = newValue
        }
    }
    
    var title: String? {
        String("\(make ?? "") \(model ?? ""), \(year ?? "")")
    }
    
}

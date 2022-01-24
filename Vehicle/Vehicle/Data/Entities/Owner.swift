//
//  Owner.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 24/01/2022.
//

import UIKit
import CoreData

class Owner: NSManagedObject {
    
    class func findOwner(userid: Int32, in context: NSManagedObjectContext) throws -> Owner? {
        let request: NSFetchRequest<Owner> = Owner.fetchRequest()
        request.predicate = NSPredicate(format: "userId == %lld", userid)
        
        do {
            let matches = try context.fetch(request)
            if (matches.count > 0) {
                return matches[0]
            }
        }catch {
            throw error
        }
        
        return nil
    }
    
    class func updateOwnerData(owner: Owner, ownerDTO: OwnerDTO, in context: NSManagedObjectContext) {
        owner.name = ownerDTO.name
        owner.surname = ownerDTO.surname
        owner.foto = ownerDTO.foto
        try? context.save()
    }
    
    class func createOwner(_ userId: Int32, _ ownerDTO: OwnerDTO, in context: NSManagedObjectContext) -> Owner {
        let owner = Owner(context: context)
        owner.name = ownerDTO.name
        owner.surname = ownerDTO.surname
        owner.foto = ownerDTO.foto
        owner.userId = Int32(userId)
        try? context.save()
        return owner
    }
}

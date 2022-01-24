//
//  OwnerFetcher.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 20/01/2022.
//

import Foundation
import UIKit

class OwnerFetcher {
    weak var delegate: FetchDelegate?
    
    func fetchData() {
        NetworkManager().retrieveData(url: Defines.listURL) { failed, data in
            if (failed || data == nil) {
                self.dataLoadingFailed()
            }else {
                self.decodeData(data)
            }
        }
    }
    
    func dataLoadingFailed() {
        delegate?.fetchFailed()
    }
    
    func decodeData(_ data: Data?) {
        let decoder = JSONDecoder()
        do {
            let ownerVehicle = try decoder.decode([String:[User]].self, from: data!)
            let users = ownerVehicle["data"] ?? []
            for user in users {
                DispatchQueue.main.async {
                    self.saveData(user)
                }
            }
            delegate?.updateSucceeded()
            
        } catch {
            print("Error info: \(error)")
            dataLoadingFailed()
        }
    }
    
    func saveData( _ user: User) {
        if (user.owner != nil && user.userid != nil) {
            Database.shared.saveOwner(with: user.userid!, user.owner!)
            if (user.vehicles != nil) {
                Database.shared.saveVehicles(user.userid!, user.vehicles!)
            }
        }
    }
}

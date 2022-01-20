//
//  OwnerFetcher.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 20/01/2022.
//

import Foundation

class OwnerFetcher {
    weak var delegate: OwnerFetcherDelegate?
    
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
        delegate?.showError()
    }
    
    func decodeData(_ data: Data?) {
        let decoder = JSONDecoder()
        do {
            let ownerVehicle = try decoder.decode([String:[User]].self, from: data!)
            let users = ownerVehicle["data"] ?? []
            for user in users {
                self.saveData(user)
            }
            delegate?.updateList()
            
        } catch {
            print("Error info: \(error)")
            dataLoadingFailed()
        }
    }
    
    func saveData(_ user: User) {
        
    }
}

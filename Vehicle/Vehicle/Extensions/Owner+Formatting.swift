//
//  Owner+Formatting.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 24/01/2022.
//

import Foundation

extension Owner {
    func fullName() -> String {
        return String("\(self.name ?? "") \(self.surname ?? "")")
    }
}

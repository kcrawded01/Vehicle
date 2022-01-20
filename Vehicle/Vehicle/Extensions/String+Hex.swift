//
//  String+Hex.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 19/01/2022.
//

extension String {
    func clear() -> String {
        return self.replacingOccurrences(of: "#", with: "")
    }
}

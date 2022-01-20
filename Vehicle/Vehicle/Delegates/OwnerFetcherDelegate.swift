//
//  OwnerFetcherDelegate.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 20/01/2022.
//

import Foundation

protocol OwnerFetcherDelegate : AnyObject {
    func showError()
    func updateList()
}

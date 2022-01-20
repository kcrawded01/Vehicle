//
//  LoadingViewController.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 18/01/2022.
//

import UIKit

class LoadingViewController: UIViewController, ReloadDelegate, OwnerFetcherDelegate  {

    @IBOutlet weak var errorView: ErrorView!
    @IBOutlet weak var loadingVew: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorView.delegate = self
        fetchData()
    }

    func openList() {
        performSegue(withIdentifier: "openListId", sender: nil)
    }
    
    func reloadData() {
        hideError(true)
        fetchData()
    }
    
    func fetchData() {
        let ownerFetcher = OwnerFetcher()
        ownerFetcher.delegate = self
        ownerFetcher.fetchData()
    }
    
    func hideError(_ hide: Bool) {
        showLoading(hide)
        errorView.isHidden = !loadingVew.isHidden
    }
    
    func showLoading(_ hide: Bool) {
        loadingVew.isHidden = !hide
    }
    
    func showError() {
        DispatchQueue.main.async {
            self.hideError(false)
        }
    }
    
    func updateList() {
        DispatchQueue.main.async {
            self.openList()
        }
    }
}

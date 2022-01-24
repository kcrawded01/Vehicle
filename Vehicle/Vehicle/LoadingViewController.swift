//
//  LoadingViewController.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 18/01/2022.
//

import UIKit

class LoadingViewController: UIViewController, ReloadDelegate, FetchDelegate  {

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
    
    func fetchData() {
        let ownerFetcher = OwnerFetcher()
        ownerFetcher.delegate = self
        ownerFetcher.fetchData()
    }
    
    func hideError(_ hide: Bool) {
        showLoading(hide)
        errorView.isHidden = !loadingVew.isHidden
        errorView.hideListButton(noData)
    }
    
    func showLoading(_ hide: Bool) {
        loadingVew.isHidden = !hide
    }
    
    var noData: Bool {
        Database.shared.findOwners().count == 0
    }
    
    //MARK: FetchDelegate
    func fetchFailed() {
        DispatchQueue.main.async {
            self.hideError(false)
        }
    }
    
    func updateSucceeded() {
        DispatchQueue.main.async {
            self.openList()
        }
    }
    
    //MARK: ReloadDelegate
    func reloadData() {
        hideError(true)
        fetchData()
    }
    
    func showList() {
        openList()
    }
}

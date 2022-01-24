//
//  OwnerListViewController.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 18/01/2022.
//

import UIKit

class OwnerListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let kUserCellIdentifier = "kUserCellIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    var imageLoader: ImageLoader = ImageLoader()
    var owners: [Owner]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: kUserCellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
        owners = Database.shared.findOwners()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kUserCellIdentifier, for: indexPath) as! UserCell
        let owner = owners[indexPath.row]
        cell.setupName(owner.fullName())
        imageLoader.loadImage(owner.foto) { image in
            cell.setupProfile(image)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userInfoViewController = storyboard.instantiateViewController(withIdentifier: "VehicleInfoViewController")
        (userInfoViewController as! VehicleInfoViewController).owner = owners[indexPath.row]
        self.present(userInfoViewController, animated: true)
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return owners.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}

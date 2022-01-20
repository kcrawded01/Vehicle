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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: kUserCellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    let img =  "https://akns-images.eonline.com/eol_images/Entire_Site/2019414/rs_634x1024-190514063109-634-George-Clooney-Batman-LT-051419-GettyImages-607408286.jpg"
    let name = "Aigars Mūrnieks ++++++jfhsjkhf jksdhfjk ashf kjhsad jkfsadhf jkhsa jkfadhf"
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kUserCellIdentifier, for: indexPath) as! UserCell
        cell.setupData(self.name, img)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userInfoViewController = storyboard.instantiateViewController(withIdentifier: "VehicleInfoViewController")
        (userInfoViewController as! VehicleInfoViewController).screenTitle = name
        self.present(userInfoViewController, animated: true)
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

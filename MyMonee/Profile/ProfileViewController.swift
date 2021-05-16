//
//  ProfileViewController.swift
//  MyMonee
//
//  Created by Macbook on 14/05/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var customerName: UILabel!
    
    @IBOutlet weak var customerStatus: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var profilePicture: UIImageView!
    var imageUpdated : UIImage?
    var editedName: String?
    @IBAction func editProfile(_ sender: Any) {
        let updateProfileController = UpdateProfileViewController(nibName: "UpdateProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(updateProfileController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if(editedName != nil){
            customerName.text = editedName!
        } else{
            customerName.text = customer.userName}
        customerStatus.text = customer.userStatus
        
        if(imageUpdated != nil){
            print("Updated")
            profilePicture.image = imageUpdated!
            self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
            self.profilePicture.clipsToBounds = true;
            
        }
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }


}

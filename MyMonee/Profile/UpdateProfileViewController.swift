//
//  UpdateProfileViewController.swift
//  MyMonee
//
//  Created by Macbook on 15/05/21.
//

import UIKit
protocol ProfileDelegate {
    func passData(profileImage: UIImage)
}

class UpdateProfileViewController: UIViewController {
    

    @IBOutlet weak var buttonFinish: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var editTextName: UITextField!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var editButton: UIImageView!
    var delegate: ProfileDelegate?
    @IBAction func finish(_ sender: Any) {
      
        let profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        
        customer.userName = self.editTextName.text
       
        profileViewController.imageUpdated = self.profilePicture.image
        navigationController?.setViewControllers([profileViewController], animated: true)
//        self.navigationController!.pushViewController(profileViewController, animated: true)
    }
 
    
    @IBAction func didChanged(_ sender: Any) {
        print("edit")
        editButton.image = .none
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        editTextName.text = customer.userName
        editTextName.frame.size.width = editTextName.intrinsicContentSize.width
        status.text = customer.userStatus
        editButton.leadingAnchor.constraint(equalTo: self.editTextName.leadingAnchor, constant: (editTextName.frame.size.width+40)).isActive = true
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.imageTapped(_:)))
        profilePicture.isUserInteractionEnabled = true
        profilePicture.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func imageTapped(_ sender: UITapGestureRecognizer)
        {
            
        ImagePickerManager().pickImage(self){ image in
            self.profilePicture.image = image
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewControllerID")as! ProfileViewController
//        if segue.identifier == "ProfileViewControllerID" {
//                    let destination = segue.profileViewController as! ProfileViewController
//                    destination.imageUpdated = self.profilePicture.image
//                }
//    }

}

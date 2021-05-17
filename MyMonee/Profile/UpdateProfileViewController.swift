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
    var imageUpdated : UIImage?
    
    @IBAction func finish(_ sender: Any) {
      
        let profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        
        customer.userName = self.editTextName.text
       
        profileViewController.imageUpdated = self.profilePicture.image
        saveImage(imageName: "profile", image: profilePicture.image!)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(customer) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "Customer")
        }
        navigationController?.setViewControllers([profileViewController], animated: true)

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
        
        if(imageUpdated != nil){
            print("Updated")
            profilePicture.image = imageUpdated!
            self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
            self.profilePicture.clipsToBounds = true;
            
        }
        
        editButton.leadingAnchor.constraint(equalTo: self.editTextName.leadingAnchor, constant: (editTextName.frame.size.width+40)).isActive = true
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.imageTapped(_:)))
        profilePicture.isUserInteractionEnabled = true
        profilePicture.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func saveImage(imageName: String, image: UIImage) {


     guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }

        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }

        }

        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }

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

  
}

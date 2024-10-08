import UIKit
import Kingfisher

class ProfileViewController: UIViewController {

    @IBOutlet weak var customerName: UILabel!
    
    @IBOutlet weak var customerStatus: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var profilePicture: UIImageView!
    var imageUpdated : UIImage?
    var editedName: String?
    
    @IBAction func editProfile(_ sender: Any) {
        let updateProfileController = UpdateProfileViewController(nibName: "UpdateProfileViewController", bundle: nil)
        let profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        updateProfileController.imageUpdated =  self.profilePicture.image
        navigationController?.setViewControllers([profileViewController, updateProfileController], animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if let savedPerson = defaults.object(forKey: "Customer") as? Data {
            let decoder = JSONDecoder()
            
            if let loadedPerson = try? decoder.decode(Customer.self, from: savedPerson) {
                customer = loadedPerson
                
            }
           
        }
        if(editedName != nil){
            customerName.text = editedName!
        } else{
            customerName.text = customer.userName}
        customerStatus.text = customer.userStatus
//        self.LoadingStart()
//        let urlString = URL(string: "https://static.wikia.nocookie.net/naruto/images/1/13/Sasuke_Part_2.png")
//
//
//        DispatchQueue.main.async{ [self] in
//            profilePicture.kf.setImage(with: urlString)
//            self.profilePicture.contentMode = UIView.ContentMode.scaleAspectFill
//            self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
//            self.profilePicture.clipsToBounds = true
//            self.LoadingStop()
//        }
        if(imageUpdated != nil){
            print("Updated")
            profilePicture.image = imageUpdated!
            self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
            self.profilePicture.clipsToBounds = true;
        }

        if(loadImageFromDiskWith(fileName: "profile") != nil){
            profilePicture.image =  loadImageFromDiskWith(fileName: "profile")
            self.profilePicture.contentMode = UIView.ContentMode.scaleAspectFill
            self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
            self.profilePicture.clipsToBounds = true;
        }
        
       
    }
   
    func loadImageFromDiskWith(fileName: String) -> UIImage? {

      let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image

        }

        return nil
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

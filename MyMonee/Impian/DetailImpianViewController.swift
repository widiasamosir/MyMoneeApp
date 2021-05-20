import UIKit

protocol ButtonConfirmImpian {
    func buttonChanger()
    func setProgress(target: Int, reached: Int) -> Float
}

class DetailImpianViewController: UIViewController, ButtonConfirmImpian {
   
    @IBOutlet weak var judul: UILabel!
    
    @IBOutlet weak var target: UILabel!
    
    @IBOutlet weak var persentage: UILabel!
    @IBOutlet weak var targetPerImpian: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var viewImpian: UIView!
    @IBOutlet weak var buttonConfirm: UIButton!
    var wish: Impian!
    var indexPath : Int?
   
    @IBOutlet weak var buttonBack: UIButton!
    
    @IBAction func edit(_ sender: Any) {
        
        let updateImpianController = UpdateImpianViewController(nibName: "UpdateImpianViewController", bundle: nil)
        updateImpianController.indexPath = self.indexPath
        updateImpianController.wish = wish!
        self.navigationController?.pushViewController(updateImpianController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if let savedWish = defaults.object(forKey: "Impian") as? Data {
            let decoder = JSONDecoder()
            
            if let loadedWish = try? decoder.decode([Impian].self, from: savedWish) {
                wishLists = loadedWish
               
            }
           
        }
        
       
        judul.text = wish.name
        target.text = "Rp. \(getStringPrice(price: wish.target!))"
        persentage.text = "\(setProgress(target: wish.target!, reached: wish.reachedTarget!)*100) %"
        targetPerImpian.text = "IDR \(getStringPrice(price: wish.reachedTarget!)) / \(getStringPrice(price: wish.target!)) "
        progressBar.progress = setProgress(target: wish.target!, reached: wish.reachedTarget!)
        viewImpian.layer.cornerRadius = 8
        viewImpian.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        viewImpian.layer.shadowOpacity = 1
        viewImpian.layer.shadowRadius = 8
        buttonConfirm.layer.cornerRadius = 20
        buttonBack.layer.cornerRadius = 20
        buttonBack.layer.borderWidth = 3
        buttonBack.layer.borderColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(self.back(_:)))
        buttonBack.addGestureRecognizer(backGesture)
        backGesture.numberOfTapsRequired = 1
        buttonBack.isUserInteractionEnabled = true
        buttonChanger()
      
    }
    
    @objc func back(_ sender: UITapGestureRecognizer){
        
        let impianViewController = ImpianViewController(nibName: "ImpianViewController", bundle: nil)
        wishLists[indexPath!] = wish
        navigationController?.setViewControllers([impianViewController], animated: true)
    }
    
    func buttonChanger() {
        if (setProgress(target: wish.target!, reached: wish.reachedTarget!)) == 1{
            buttonConfirm.layer.backgroundColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
            let confirmGesture = UITapGestureRecognizer(target: self, action: #selector(self.setTercapai(_:)))
            confirmGesture.numberOfTapsRequired = 1
            buttonConfirm.addGestureRecognizer(confirmGesture)
            buttonConfirm.isUserInteractionEnabled = true

        } else {
            buttonConfirm.layer.backgroundColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 0.5).cgColor
        }
    }
    
    @objc func setTercapai(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Konfirmasi Ketercapaian", message: "Target telah tercapai. Konfirmasi ketercapaian impian anda.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Konfirmasi", style: .default, handler: { [self]action in
            let impianViewController = ImpianViewController(nibName: "ImpianViewController", bundle: nil)
            wish.name?.append(" [Tercapai]")
            wishLists[indexPath!] = wish
            
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(wishLists) {
                let defaults = UserDefaults.standard

                defaults.set(encoded, forKey: "Impian")
                
            }
            
            navigationController?.setViewControllers([impianViewController], animated: true)
            
          
        }))
        alert.addAction(UIAlertAction(title:"Batal", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
     
        self.viewDidLoad()
    }
    
    func setProgress(target: Int, reached: Int) -> Float {
        var progress : Float!
        
        
        progress = Float(Float(reached)/Float(target))
        
        return progress
    }
    
    func getStringPrice(price: Int) -> String {
        let number = String(price)
        let array = number.utf8.map{Int(($0 as UInt8)) - 48}
        var priceString: String = ""

        var newArray : [String] = []
        for i in 0...array.count-1 {
            let n = array.count-1 - i
            newArray.append(String(array[n]))
            if((i+1)%3 == 0) && ((i+1) != array.count){
                newArray.append(".")
            }
        }
        for num in newArray.reversed() {
            priceString.append(String(num))
        }
        return "\(priceString)"
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

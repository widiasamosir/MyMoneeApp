//
//  UpdateImpianViewController.swift
//  MyMonee
//
//  Created by Macbook on 15/05/21.
//

import UIKit

class UpdateImpianViewController: UIViewController {

    @IBOutlet weak var textJudul: UITextField!
    @IBOutlet weak var textTargetCapaian: UITextField!
    @IBOutlet weak var buttonBack: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var textTambahCapaian: UITextField!
    
    var wish : Impian!
    var indexPath: Int?
    var temporaryTarget : String = ""
    var temporaryAddCapaian : String = ""
    var pengeluaran : [Pengeluaran] = []
    
    @IBOutlet weak var buttonSimpan: UIButton!
    
    
    @IBAction func changedTarget(_ sender: Any) {
        temporaryTarget = parseDot(price: textTargetCapaian.text!)
        textTargetCapaian.text = getStringPrice(price: temporaryTarget)
    }
    
    @IBAction func changedAddTarget(_ sender: Any) {
        temporaryAddCapaian = parseDot(price: textTambahCapaian.text!)
        textTambahCapaian.text = getStringPrice(price: temporaryAddCapaian)
    }
    
    @IBAction func save(_ sender: Any) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id_ID_POSIX")
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        let result = formatter.string(from: date)
        
        if(textJudul.hasText){
            wish.name = textJudul.text!
        }
        if(textTargetCapaian.hasText){
            wish.target = Int(parseDot(price: textTargetCapaian.text!))
        }
        if(textTambahCapaian.hasText){
            wish.reachedTarget = wish.reachedTarget! + Int(parseDot(price: textTambahCapaian.text!))!
        }
        pengeluaran.append(Pengeluaran(id: "dasdhs", pengeluaranName: "Pay WishList \(wish.name!)", pengeluaranPrice: Int(parseDot(price: textTambahCapaian.text!))!, status: true, date: result))
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(pengeluaran) {
            let defaults = UserDefaults.standard

            defaults.set(encoded, forKey: "Pengeluaran")
            
        }
        
        let detailController = DetailImpianViewController(nibName: "DetailImpianViewController", bundle: nil)
        detailController.wish = self.wish!
        detailController.indexPath = self.indexPath
        wishLists[indexPath!] = wish ?? Impian(name: "", target: 0, reachedTarget: 0, status: false)
        
     
        if let encoded = try? encoder.encode(wishLists) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "Impian")
        }
        
        navigationController?.setViewControllers([detailController], animated: true)
    }
    
    @IBAction func deleteWish(_ sender: Any) {
        let impianController = ImpianViewController(nibName: "ImpianViewController", bundle: nil)
        let alert = UIAlertController(title: "Menghapus wishlist", message: "Apakah Anda mau menghapus wishlist ini?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Hapus", style: .destructive, handler: { [self]action in
            let encoder = JSONEncoder()
            wishLists.remove(at: self.indexPath!)
            if let encoded = try? encoder.encode(wishLists) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "Impian")
                
            }
          
            
            navigationController?.setViewControllers([impianController], animated: true)
           
        }))
        alert.addAction(UIAlertAction(title:"Batal", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    
       
        
    }
    
    @IBAction func back(_ sender: Any) {
        let detailController = DetailImpianViewController(nibName: "DetailImpianViewController", bundle: nil)
        detailController.wish = self.wish!
        detailController.indexPath = self.indexPath

        navigationController?.setViewControllers([detailController], animated: true)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let impianController = ImpianViewController(nibName: "ImpianViewController", bundle: nil)
        impianController.isAvailable(wish: wish)
        textJudul.text = wishLists[indexPath!].name
        textTargetCapaian.text
            = getStringPrice(price: String(wishLists[indexPath!].target!))
        
        buttonSimpan.layer.cornerRadius = 20
        deleteButton.layer.cornerRadius = 20
        deleteButton.layer.borderWidth = 3
        deleteButton.layer.borderColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1).cgColor
    }

    func getStringPrice(price: String) -> String {
        let number = String(price)
        let array = Array(number)
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
    
    func parseDot(price: String)-> String{
        let array = price.components(separatedBy: ".")
        var string = ""
        for item in array {
            string.append(item)
        }
        return string
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

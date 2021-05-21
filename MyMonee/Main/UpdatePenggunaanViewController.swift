//
//  FormPenggunaanViewController.swift
//  MyMonee
//
//  Created by Macbook on 14/05/21.
//

import UIKit

class UpdatePenggunaanViewController: UIViewController {
   
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var textJudul: UITextField!
    @IBOutlet weak var textJumlah: UITextField!
    @IBOutlet weak var buttonSimpan: UIButton!
    @IBOutlet weak var buttonPickPemasukan: UIView!
    @IBOutlet weak var buttonPickPengeluaran: UIView!
    @IBOutlet var deleteButton: UIButton!
    
    var penggunaan : Pengeluaran!
    var indexPath : Int?
    var temporaryTarget : String = ""
    var pengeluaran : [Pengeluaran] = []
    var service: DeletePenggunaanService = DeletePenggunaanService()
    var serviceUpdate: UpdatePenggunaanService = UpdatePenggunaanService()
    @IBAction func editedTarget(_ sender: Any) {
        temporaryTarget = parseDot(price: textJumlah.text!)
        textJumlah.text = getStringPrice(price: temporaryTarget)
       
    }
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textJudul.text = penggunaan.pengeluaranName
        textJumlah.text = getStringPrice(price: String(penggunaan.pengeluaranPrice ?? 0))
        buttonPickPemasukan.layer.cornerRadius = 8
       setShadowCategory(button: buttonPickPemasukan)
        setShadowCategory(button: buttonPickPengeluaran)
        buttonPickPengeluaran.layer.cornerRadius = 8
        buttonSimpan.layer.cornerRadius = 20
        
        deleteButton.layer.cornerRadius = 20
        deleteButton.layer.borderWidth = 3
        deleteButton.layer.borderColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1).cgColor
        let tapPemasukan = UITapGestureRecognizer(target: self, action: #selector(self.clickedPemasukan(_:)))
        let tapPengeluaran = UITapGestureRecognizer(target: self, action: #selector(self.clickedPengeluaran(_:)))
        let saveGesture = UITapGestureRecognizer(target: self, action: #selector(self.simpan(_:)))
        buttonSimpan.addGestureRecognizer(saveGesture)
        saveGesture.numberOfTapsRequired = 1
        tapPemasukan.numberOfTapsRequired = 1
        tapPengeluaran.numberOfTapsRequired = 1
        buttonPickPengeluaran.addGestureRecognizer(tapPengeluaran)
        buttonPickPemasukan.addGestureRecognizer(tapPemasukan)
        buttonPickPengeluaran.isUserInteractionEnabled = true
        buttonPickPemasukan.isUserInteractionEnabled = true
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(self.back(_:)))
        backButton.addGestureRecognizer(backGesture)
        backGesture.numberOfTapsRequired = 1
    }
    
    func setShadowCategory(button : UIView!) {
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.3
        button.layer.shadowColor = UIColor.gray.cgColor
    }
    
    
    
    
    @objc func clickedPemasukan(_ sender: UITapGestureRecognizer) {
        let button = sender.view!
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.3
        button.layer.shadowColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
        buttonPickPengeluaran.layer.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        penggunaan.status = false
    }
    @objc func clickedPengeluaran(_ sender: UITapGestureRecognizer) {
        let button = sender.view!
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.3
        button.layer.shadowColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
        buttonPickPemasukan.layer.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        penggunaan.status = true
    }
    @objc func back(_ sender: UITapGestureRecognizer){
        
        let riwayatController = RiwayatPenggunaanViewController(nibName: "RiwayatPenggunaanViewController", bundle: nil)
        let mainView = MainViewController(nibName: "MainViewController", bundle: nil)
        riwayatController.penggunaan = self.penggunaan
        navigationController?.setViewControllers([mainView,riwayatController], animated: true)
        
    }
    @objc func simpan(_ sender: UITapGestureRecognizer) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        let result = formatter.string(from: date)
        
        let riwayatController = RiwayatPenggunaanViewController(nibName: "RiwayatPenggunaanViewController", bundle: nil)
        let mainView = MainViewController(nibName: "MainViewController", bundle: nil)
        if(textJudul.text == nil || textJumlah.text == nil){
            riwayatController.penggunaan = self.penggunaan
        } else {
            if(textJudul.text != ""){
                penggunaan.pengeluaranName = textJudul.text
            }
            if(textJumlah.text != ""){
                penggunaan.pengeluaranPrice = Int(parseDot(price: textJumlah.text ?? "0"))
            }
            penggunaan.date = result
            
//            pengeluaran[indexPath!] = self.penggunaan
            serviceUpdate.savePengeluaran(parameters: penggunaan){ response in
            DispatchQueue.main.async {
                
                
                }
            }
            riwayatController.indexPath = self.indexPath
            riwayatController.penggunaan = self.penggunaan
            
        }
        
        
        navigationController?.setViewControllers([mainView,riwayatController], animated: true)
        
        
    }
    
    @IBAction func deletePenggunaan(_ sender: Any) {
        let mainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
        let alert = UIAlertController(title: "Menghapus penggunaan", message: "Apakah Anda mau menghapus penggunaan ini?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Hapus", style: .destructive, handler: { [self]action in
            
           
            service.deletePenggunaan(id: penggunaan.id!){ response in
            DispatchQueue.main.async {
                mainViewController.tableView.reloadData()
                
                }
            }

            navigationController?.setViewControllers([mainViewController], animated: true)
          
        }))
        alert.addAction(UIAlertAction(title:"Batal", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    
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

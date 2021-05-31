//
//  FormPenggunaanViewController.swift
//  MyMonee
//
//  Created by Macbook on 14/05/21.
//

import UIKit
protocol ButtonSave {
    func activateButtonSave()
    func handlingMinus()
}
class FormPenggunaanViewController: UIViewController, ButtonSave {


    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var textJudul: UITextField!
    @IBOutlet weak var textJumlah: UITextField!
    @IBOutlet weak var buttonSimpan: UIButton!
    @IBOutlet weak var buttonPickPemasukan: UIView!
    @IBOutlet weak var buttonPickPengeluaran: UIView!
    var status : Bool?
    var penggunaan : Pengeluaran!
    var isJudulEmpty : Bool? = true
    var isJumlahEmpty : Bool? = true
    var temporaryTarget : String = ""
    var balance : Int?
    var pengeluaran : [Pengeluaran] = []
    var service: PostPenggunaanService = PostPenggunaanService()
    @IBAction func judulDidChange(_ sender: Any) {
        self.isJudulEmpty = false
        self.viewDidLoad()
    }

    @IBAction func jumlahDidChange(_ sender: Any) {
        self.isJumlahEmpty = false
        self.viewDidLoad()
    }
    
    @IBAction func editedTarget(_ sender: Any) {
        temporaryTarget =  parseDot(price: textJumlah.text!)
        textJumlah.text = getStringPrice(price: temporaryTarget)
        
        print(textJumlah.text!)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id_ID_POSIX")
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        let result = formatter.string(from: date)
        
        
        
        penggunaan = Pengeluaran(id: "USDSJDHJ", pengeluaranName: "", pengeluaranPrice: 0, status: false, date: result)
     
        buttonPickPemasukan.layer.cornerRadius = 8
    
        buttonPickPengeluaran.layer.cornerRadius = 8
        buttonSimpan.layer.cornerRadius = 20
        let tapPemasukan = UITapGestureRecognizer(target: self, action: #selector(self.clickedPemasukan(_:)))
        let tapPengeluaran = UITapGestureRecognizer(target: self, action: #selector(self.clickedPengeluaran(_:)))
        tapPemasukan.numberOfTapsRequired = 1
        tapPengeluaran.numberOfTapsRequired = 1
        buttonPickPengeluaran.addGestureRecognizer(tapPengeluaran)
        buttonPickPemasukan.addGestureRecognizer(tapPemasukan)
        buttonPickPengeluaran.isUserInteractionEnabled = true
        buttonPickPemasukan.isUserInteractionEnabled = true
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(self.back(_:)))
        backButton.addGestureRecognizer(backGesture)
        backGesture.numberOfTapsRequired = 1

        print(isJumlahEmpty!)
        print(isJudulEmpty!)
        if status != nil {
            print("status: ",status!)
        }
        if isJumlahEmpty == false && isJudulEmpty == false && (status != nil)
        {
            
            let saveGesture = UITapGestureRecognizer(target: self, action: #selector(self.simpan(_:)))
            buttonSimpan.addGestureRecognizer(saveGesture)
            saveGesture.numberOfTapsRequired = 1
            buttonSimpan.isUserInteractionEnabled = true
             
            activateButtonSave()
        }
        else{
            
            buttonSimpan.layer.backgroundColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1).cgColor
            
            
            
        }
    }
    
 
   

    
    func activateButtonSave(){
        let saveGesture = UITapGestureRecognizer(target: self, action: #selector(self.simpan(_:)))
        buttonSimpan.addGestureRecognizer(saveGesture)
        saveGesture.numberOfTapsRequired = 1
        buttonSimpan.isUserInteractionEnabled = true
        buttonSimpan.layer.backgroundColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
    }
    
    func handlingMinus() {
      
        if(getInt(string: temporaryTarget) > balance!) && status == true{
            let alert = UIAlertController(title: "Saldo anda tidak cukup", message: "Saldo anda sebesar \(customer.balance!), tidak cukup untuk melakukan transaksi sebesar Rp  \(textJumlah.text ?? "").", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Edit", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title:"Batal", style: .cancel, handler: {[self]action in
                navigationController?.popViewController(animated: true)
                
            }))
            self.present(alert, animated: true, completion: nil)
        
        } else {
            let mainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
            service.savePengeluaran(parameters: penggunaan){ [self] response in
                self.showToast(message: "Penggunaan \(penggunaan.pengeluaranName ?? "") anda sudah berhasil diupdate", font: .systemFont(ofSize: 12.0))
                DispatchQueue.main.asyncAfter(deadline: .now()+1){
                    self.navigationController?.setViewControllers([mainViewController], animated: true)
                }
            }
        }
    }
    
    func validateAll(textFields:[UITextField]) -> Bool {
           // Check each field for nil and not empty.
           for field in textFields {
               // Remove space and new lines while unwrapping.
               guard let fieldText = field.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                   return false
               }
               // Are there no other charaters?
               if (fieldText.isEmpty) {
                   return false
               }
            if (field.text == "") {
                return false
            }


           }
           // All fields passed.
           return true
       }


    
    @objc func clickedPemasukan(_ sender: UITapGestureRecognizer) {
        let button = sender.view!
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.3
        button.layer.shadowColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
        buttonPickPengeluaran.layer.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.status = false
        self.viewDidLoad()
      
    }
    @objc func clickedPengeluaran(_ sender: UITapGestureRecognizer) {
        let button = sender.view!
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.3
        button.layer.shadowColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
        buttonPickPemasukan.layer.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.status = true
        self.viewDidLoad()
      
    }
    @objc func back(_ sender: UITapGestureRecognizer){
       
        let mainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
        navigationController?.setViewControllers([mainViewController], animated: true)
        
    }
    
    @objc func simpan(_ sender: UITapGestureRecognizer) {
        penggunaan.pengeluaranName = self.textJudul.text
        penggunaan.pengeluaranPrice = Int(parseDot(price:  self.textJumlah.text!))
        penggunaan.status = self.status!
       
        handlingMinus()
        
       
        
        
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


extension FormPenggunaanViewController{
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
}

extension FormPenggunaanViewController {
    func getInt(string : String) -> Int {
        Int(string) ?? 0
    }
}

extension FormPenggunaanViewController: MainDelegate{
 
    func sendBalance(price: Int) {
        self.balance = price
    }
    
}

extension FormPenggunaanViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: 30, y: self.view.frame.size.height/2, width: self.view.frame.size.width-60, height: 60))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.numberOfLines = 2
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 5, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }

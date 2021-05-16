//
//  FormPenggunaanViewController.swift
//  MyMonee
//
//  Created by Macbook on 14/05/21.
//

import UIKit

class FormPenggunaanViewController: UIViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        let result = formatter.string(from: date)
        penggunaan = Pengeluaran(id: pengeluaran.count+1, pengeluaranName: "", pengeluaranPrice: 0, status: false, date: result)
     
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
       
        if status != nil
        {
            print("masuk")
            let saveGesture = UITapGestureRecognizer(target: self, action: #selector(self.simpan(_:)))
            buttonSimpan.addGestureRecognizer(saveGesture)
            saveGesture.numberOfTapsRequired = 1
            buttonSimpan.isUserInteractionEnabled = true
            buttonSimpan.layer.backgroundColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
        }
        else{
            print("status nil")
            buttonSimpan.layer.backgroundColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1).cgColor
            
            
            
        }
    }
    
 
    @IBAction func judulDidChange(_ sender: Any) {
        self.isJudulEmpty = false
    }

    @IBAction func jumlahDidChange(_ sender: Any) {
        self.isJumlahEmpty = false
    }
    
    func activateButtonSave(){
        let saveGesture = UITapGestureRecognizer(target: self, action: #selector(self.simpan(_:)))
        buttonSimpan.addGestureRecognizer(saveGesture)
        saveGesture.numberOfTapsRequired = 1
        buttonSimpan.isUserInteractionEnabled = true
        buttonSimpan.layer.backgroundColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
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
        activateButtonSave()
      
    }
    @objc func clickedPengeluaran(_ sender: UITapGestureRecognizer) {
        let button = sender.view!
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.3
        button.layer.shadowColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
        buttonPickPemasukan.layer.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.status = true
        activateButtonSave()
      
    }
    @objc func back(_ sender: UITapGestureRecognizer){
       
        let mainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
        navigationController?.setViewControllers([mainViewController], animated: true)
        
    }
    @objc func simpan(_ sender: UITapGestureRecognizer) {
        penggunaan.pengeluaranName = self.textJudul.text
        penggunaan.pengeluaranPrice = Int(self.textJumlah.text!)
        penggunaan.status = self.status!
        let mainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
        pengeluaran.append(penggunaan)
        navigationController?.setViewControllers([mainViewController], animated: true)
        
        print("save")
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

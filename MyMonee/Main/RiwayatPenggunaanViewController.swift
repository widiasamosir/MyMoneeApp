//
//  RiwayatPenggunaanViewController.swift
//  MyMonee
//
//  Created by Macbook on 14/05/21.
//

import UIKit

class RiwayatPenggunaanViewController: UIViewController {

    @IBOutlet weak var viewLogo: UIView!
    @IBOutlet weak var layer0: UIView!
    @IBOutlet weak var viewRiwayat: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var judul: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var editButton: UIImageView!
    
    @IBOutlet weak var buttonBack: UIButton!
    var penggunaan : Pengeluaran!
    var indexPath : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        judul.text = penggunaan.pengeluaranName
        price.text = " Rp. \(pengeluaran[indexPath!].pengeluaranPrice!)"
        id.text = String(penggunaan.id!)
        date.text = penggunaan.date
        viewRiwayat.layer.cornerRadius = 16
        viewLogo.layer.cornerRadius = 4
        layer0.layer.cornerRadius = 4
        let editGesture = UITapGestureRecognizer(target: self, action: #selector(editPenggunaan(_:)))
        editGesture.numberOfTapsRequired = 1
        self.editButton.addGestureRecognizer(editGesture)
        editButton.isUserInteractionEnabled = true
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(self.back(_:)))
        backGesture.numberOfTapsRequired = 1
        buttonBack.addGestureRecognizer(backGesture)
        
        
        buttonBack.layer.cornerRadius = 20
        buttonBack.layer.borderWidth = 3
        buttonBack.layer.borderColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
      
        
        
        if(penggunaan.status == true){
            status.text = "Pengeluaran"
            viewLogo.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            layer0.layer.backgroundColor  = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 0.2).cgColor
           
            logo.image = UIImage(systemName: "arrow.down")
            logo.tintColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
            price.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
        } else {
            status.text = "Pemasukan"
            viewLogo.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            layer0.layer.backgroundColor  = UIColor(red: 0.129, green: 0.588, blue: 0.325, alpha: 0.2).cgColor
           
            logo.image = UIImage(systemName: "arrow.up")
            logo.tintColor = UIColor(red: 0.129, green: 0.588, blue: 0.325, alpha: 1)
            price.textColor = UIColor(red: 0.129, green: 0.588, blue: 0.325, alpha: 1)
        }
        
    }

    @objc func back(_ sender: UITapGestureRecognizer){
        
        self.navigationController?.popToRootViewController(animated: true
        )
    }
    
    @objc func editPenggunaan(_ sender: UITapGestureRecognizer){
        print("edit")
        let updateController = UpdatePenggunaanViewController(nibName: "UpdatePenggunaanViewController", bundle: nil)
        updateController.penggunaan = self.penggunaan
        updateController.indexPath = self.indexPath
        
        self.navigationController?.pushViewController(updateController, animated: true)
        
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

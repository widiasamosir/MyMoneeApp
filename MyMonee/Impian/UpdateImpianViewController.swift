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
    var wish : Impian!
    var indexPath: Int?
    @IBOutlet weak var buttonSimpan: UIButton!
    @IBAction func save(_ sender: Any) {
        if(textJudul.hasText){
            wish.name = textJudul.text!
        }
        if(textTargetCapaian.hasText){
            wish.target = Int(textTargetCapaian.text!)
        }
        
        let detailController = DetailImpianViewController(nibName: "DetailImpianViewController", bundle: nil)
        detailController.wish = self.wish!
        detailController.indexPath = self.indexPath
        navigationController?.setViewControllers([detailController], animated: true)
    }
    @IBAction func deleteWish(_ sender: Any) {
        let impianController = ImpianViewController(nibName: "ImpianViewController", bundle: nil)
        let alert = UIAlertController(title: "Menghapus wishlist", message: "Apakah Anda mau menghapus wishlist ini?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Hapus", style: .destructive, handler: { [self]action in
            
            wishLists.remove(at: self.indexPath!)
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
        textJudul.placeholder = wishLists[indexPath!].name
        textTargetCapaian.placeholder
            = String(wishLists[indexPath!].target!)
        
        buttonSimpan.layer.cornerRadius = 20
        deleteButton.layer.cornerRadius = 20
        deleteButton.layer.borderWidth = 3
        deleteButton.layer.borderColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1).cgColor
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

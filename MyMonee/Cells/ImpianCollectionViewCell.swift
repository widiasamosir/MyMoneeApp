//
//  ImpianCollectionViewCell.swift
//  MyMonee
//
//  Created by Macbook on 15/05/21.
//

import UIKit

class ImpianCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var judulImpian: UILabel!
    @IBOutlet weak var progessImpian: UIProgressView!

    @IBOutlet weak var iconConfirmed: UIImageView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var targetImpian: UILabel!
    
    @IBAction func deleteCell(_ sender: Any) {
        
        let alert = UIAlertController(title: "Menghapus wishlist", message: "Apakah Anda mau menghapus wishlist ini?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Hapus", style: .destructive, handler: { [self]action in
            let encoder = JSONEncoder()
            wishLists.remove(at: deleteButton.tag)
            if let encoded = try? encoder.encode(wishLists) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "Impian")
                
            }
            
            window?.rootViewController?.viewWillAppear(true)
        }))
        alert.addAction(UIAlertAction(title:"Batal", style: .cancel, handler: nil))
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCell.layer.cornerRadius = 4
        
    }
    

}

//
//  EmptyHandlingCollectionViewCell.swift
//  MyMonee
//
//  Created by Macbook on 22/05/21.
//

import UIKit

class EmptyHandlingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var buttonAddImpian: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        messageLabel.text = "Data kamu kosong, Yuk buat impian baru kamu!"
        messageLabel.numberOfLines = 2
        messageLabel.textColor = UIColor.gray
        messageLabel.textAlignment = .center
        buttonAddImpian.titleLabel?.text = "Tambah Impian"
        buttonAddImpian.titleLabel?.textColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        buttonAddImpian.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)

        buttonAddImpian.titleLabel?.textAlignment = .center
        buttonAddImpian.layer.backgroundColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
        buttonAddImpian.layer.cornerRadius = 16
    }

}

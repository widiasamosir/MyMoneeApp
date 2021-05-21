//
//  EmptyHandlingTableViewCell.swift
//  MyMonee
//
//  Created by Macbook on 20/05/21.
//

import UIKit

class EmptyHandlingTableViewCell: UITableViewCell {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        message.text = "Data kamu kosong, Yuk buat catatan kamu!"
        message.numberOfLines = 2
        message.textColor = UIColor.gray
        message.textAlignment = .center
        button.titleLabel?.text = "Tambah Penggunaan"
        button.titleLabel?.textColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)

        button.titleLabel?.textAlignment = .center
        button.layer.backgroundColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
        button.layer.cornerRadius = 16
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

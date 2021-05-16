//
//  MainTableViewCell.swift
//  SampleApp
//
//  Created by Macbook on 11/05/21.
//

import UIKit

class MainTableViewCell: UITableViewCell {

 
   
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var imageBackground: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.cornerRadius = 10
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

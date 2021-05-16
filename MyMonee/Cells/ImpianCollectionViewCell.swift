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
    @IBOutlet weak var targetImpian: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCell.layer.cornerRadius = 4
    }

}

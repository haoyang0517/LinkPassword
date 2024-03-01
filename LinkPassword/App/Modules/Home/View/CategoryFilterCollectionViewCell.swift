//
//  CategoryFilterCollectionViewCell.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit

class CategoryFilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                titleContainer.backgroundColor = LinkPassword.Colors.PrimaryText
                titleLabel.textColor = .white
            } else {
                titleContainer.backgroundColor = LinkPassword.Colors.BtnBgGrey
                titleLabel.textColor = LinkPassword.Colors.SecondaryText
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        titleContainer.layer.cornerRadius = 20
        titleLabel.font = LinkPassword.Fonts.soraRegular(size: 14)
    }

    func setupView(title: String) {
        titleLabel.text = title
    }

}

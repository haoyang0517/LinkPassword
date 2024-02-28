//
//  SettingsTableViewCell.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var rightIconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = LinkPassword.Fonts.soraSemiBold(size: 15)
        titleLabel.textColor = LinkPassword.Colors.PrimaryText
        subTitleLabel.font = LinkPassword.Fonts.soraSemiBold(size: 12)
        subTitleLabel.textColor = LinkPassword.Colors.SecondaryText
        valueLabel.font = LinkPassword.Fonts.soraSemiBold(size: 12)
        valueLabel.textColor = LinkPassword.Colors.SecondaryText
        selectionStyle = .none
        backgroundColor = LinkPassword.Colors.BgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupSettingCell(setting: SettingOptionEntity){
        titleLabel.text = setting.title
        subTitleLabel.text = setting.subTitle
        subTitleLabel.isHidden = setting.subTitle.isEmpty
        valueLabel.text = setting.value
        rightIconImageView.image = setting.isShowNavigationIcon
    }
    
}

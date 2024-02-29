//
//  PasswordTableViewCell.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 29/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

class PasswordTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!

    private(set) var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        titleLabel.font = LinkPassword.Fonts.soraSemiBold(size: 16)
        titleLabel.textColor = LinkPassword.Colors.PrimaryText
        valueLabel.font = LinkPassword.Fonts.soraRegular(size: 14)
        valueLabel.textColor = LinkPassword.Colors.SecondaryText
    }

    func setupCell(pw: Password){
        titleLabel.text = pw.webname
        valueLabel.text = pw.email
    }
    
}

extension Reactive where Base : PasswordTableViewCell {
    var moreDidTap: Driver<Void> { return base.moreButton.rx.tap.asDriver() }
}

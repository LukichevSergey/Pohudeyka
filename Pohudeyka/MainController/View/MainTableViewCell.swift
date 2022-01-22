//
//  MainTableViewCell.swift
//  Pohudeyka
//
//  Created by Сергей Лукичев on 21.01.2022.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: MainTableViewCell.self)
    
    private lazy var date: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var weight: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(date)
        date.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.left.equalToSuperview().inset(16)
        }
        
        addSubview(weight)
        weight.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.right.equalToSuperview().inset(16)
        }
    }
    
    func configuration(with model: User.Result) {
        self.backgroundColor = UIColor(red:255/255.0, green:130/255.0, blue:119/255.0, alpha:1.0)
        self.date.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        self.weight.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        self.date.text = model.data
        self.weight.text = "\(model.weight) кг."
    }
}

//
//  MainSectionHeader.swift
//  Pohudeyka
//
//  Created by Сергей Лукичев on 21.01.2022.
//

import UIKit
import SnapKit

protocol MainSectionHeaderDelegate: AnyObject {
    func headerTapped(withSection section: String)
}

class MainSectionHeader: UIView {
    
    weak var delegate: MainSectionHeaderDelegate?
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "User"
        label.font = UIFont(name: "avenir", size: 20)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor(red:171/255.0, green:242/255.0, blue:227/255.0, alpha:0.4)
        self.layer.borderColor = UIColor(red:171/255.0, green:242/255.0, blue:227/255.0, alpha:0.5).cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        addSubview(userName)
        userName.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.left.equalToSuperview().inset(16)
        }
    }
    
    func configuration(section: String) {
        self.userName.text = section
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tabTapped))
        tap.delegate = self
        self.addGestureRecognizer(tap)
    }

    @objc func tabTapped() {
        delegate?.headerTapped(withSection: self.userName.text ?? "")
    }
}

extension MainSectionHeader: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

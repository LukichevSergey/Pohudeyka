//
//  PopupView.swift
//  Pohudeyka
//
//  Created by Сергей Лукичев on 21.01.2022.
//

import UIKit
import SnapKit

protocol PopupViewDelegate: AnyObject {
    func saveButtonTapped(withWeight weight: Double)
}

class PopupView: UIView {
    
    weak var delegate: PopupViewDelegate?
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Введите Ваш вес"
        label.font = UIFont(name: "avenir", size: 24)
        label.textColor = UIColor(red:11/255.0, green:132/255.0, blue:255/255.0, alpha:1.0)
        return label
    }()
    
    private lazy var weightInput: UITextField = {
        let input = UITextField(frame: CGRect(x: 0, y: 0, width: 153, height: 44))
        input.font = UIFont(name: "avenir", size: 20)
        input.borderStyle = .roundedRect
        input.keyboardType = .numbersAndPunctuation
        input.clearButtonMode = .whileEditing
        input.backgroundColor = .white
        input.textColor = UIColor(red:11/255.0, green:132/255.0, blue:255/255.0, alpha:1.0)
        input.textAlignment = .center
        input.layer.cornerRadius = 16
        input.layer.masksToBounds = true
        input.delegate = self
        return input
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red:11/255.0, green:132/255.0, blue:255/255.0, alpha:1.0)
        button.titleLabel?.font = UIFont(name: "avenir", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Ок", for: .normal)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [title, weightInput, saveButton])
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            self.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor(red:171/255.0, green:242/255.0, blue:227/255.0, alpha:1)
        self.layer.borderColor = UIColor(red:81/255.0, green:114/255.0, blue:108/255.0, alpha:0.5).cgColor
        self.layer.borderWidth = 5
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        
        if let clearButton = weightInput.value(forKey: "_clearButton") as? UIButton {
           let templateImage = clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
           clearButton.setImage(templateImage, for: .normal)
           clearButton.tintColor = UIColor(red:11/255.0, green:132/255.0, blue:255/255.0, alpha:1.0)
        }
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview().inset(8)
        }
        
        weightInput.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        saveButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        animateIn()
    }
    
    func configuration() {
        
    }
    
    private func animateIn() {
        self.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.alpha = 1
        }
    }
    
    private func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
    
    @objc private func saveButtonTapped() {
        animateOut()
        if let weight = Double(self.weightInput.text ?? "") {
            delegate?.saveButtonTapped(withWeight: weight)
        }
    }

}

extension PopupView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string != "\n" else {
            textField.endEditing(true)
            return false
        }

        let text: NSString = (textField.text ?? "") as NSString
        let resultString = text.replacingCharacters(in: range, with: string)

        if let _ = Double(resultString) {
            self.saveButton.isEnabled = true
            self.saveButton.alpha = 1
            return true
        }
        
        return false
    }
}

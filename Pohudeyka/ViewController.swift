//
//  ViewController.swift
//  Pohudeyka
//
//  Created by Сергей Лукичев on 21.01.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        // Do any additional setup after loading the view.
        
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(52)
        }
    }
    
    @objc func didTapButton() {
        let tabBarController = UITabBarController()
        let mainViewController = UINavigationController(rootViewController: MainConfigurator().configure())
        let chartViewController = UINavigationController(rootViewController: ChartConfigurator().configure())
        mainViewController.title = "Home"
        chartViewController.title = "Chart"
        tabBarController.setViewControllers([mainViewController, chartViewController], animated: false)
        
        guard let items = tabBarController.tabBar.items else { return }
        
        let images = ["house", "bell"]
        
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
        
        tabBarController.tabBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.95)
        
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }


}


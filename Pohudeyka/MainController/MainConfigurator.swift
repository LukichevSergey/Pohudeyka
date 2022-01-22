//
//  MainConfigurator.swift
//  Pohudeyka
//
//  Created by Сергей Лукичев on 21.01.2022.
//  
//

import UIKit

class MainConfigurator {
    func configure() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter()
        let router = MainRouter()
        let interactor = MainInteractor()
        
        view.presenter = presenter

        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view

        interactor.presenter = presenter
        
        router.view = view
        
        return view
    }
}
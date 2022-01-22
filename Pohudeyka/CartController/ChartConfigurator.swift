//
//  ChartConfigurator.swift
//  Pohudeyka
//
//  Created by Сергей Лукичев on 22.01.2022.
//  
//

import UIKit

class ChartConfigurator {
    func configure() -> UIViewController {
        let view = ChartViewController()
        let presenter = ChartPresenter()
        let router = ChartRouter()
        let interactor = ChartInteractor()
        
        view.presenter = presenter

        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view

        interactor.presenter = presenter
        
        router.view = view
        
        return view
    }
}
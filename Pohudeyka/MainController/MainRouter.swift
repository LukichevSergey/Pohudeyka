//
//  MainRouter.swift
//  Pohudeyka
//
//  Created by Сергей Лукичев on 21.01.2022.
//  
//

import Foundation

// MARK: Protocol - MainPresenterToRouterProtocol (Presenter -> Router)
protocol MainPresenterToRouterProtocol: AnyObject {

}

class MainRouter {

    // MARK: Properties
    weak var view: MainRouterToViewProtocol!
}

// MARK: Extension - MainPresenterToRouterProtocol
extension MainRouter: MainPresenterToRouterProtocol {
    
}
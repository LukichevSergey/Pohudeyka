//
//  ChartRouter.swift
//  Pohudeyka
//
//  Created by Сергей Лукичев on 22.01.2022.
//  
//

import Foundation

// MARK: Protocol - ChartPresenterToRouterProtocol (Presenter -> Router)
protocol ChartPresenterToRouterProtocol: AnyObject {

}

class ChartRouter {

    // MARK: Properties
    weak var view: ChartRouterToViewProtocol!
}

// MARK: Extension - ChartPresenterToRouterProtocol
extension ChartRouter: ChartPresenterToRouterProtocol {
    
}
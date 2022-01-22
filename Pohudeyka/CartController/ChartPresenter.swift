//
//  ChartPresenter.swift
//  Pohudeyka
//
//  Created by Сергей Лукичев on 22.01.2022.
//  
//

import Foundation

// MARK: Protocol - ChartViewToPresenterProtocol (View -> Presenter)
protocol ChartViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
}

// MARK: Protocol - ChartInteractorToPresenterProtocol (Interactor -> Presenter)
protocol ChartInteractorToPresenterProtocol: AnyObject {

}

class ChartPresenter {

    // MARK: Properties
    var router: ChartPresenterToRouterProtocol!
    var interactor: ChartPresenterToInteractorProtocol!
    weak var view: ChartPresenterToViewProtocol!
}

// MARK: Extension - ChartViewToPresenterProtocol
extension ChartPresenter: ChartViewToPresenterProtocol {
    func viewDidLoad() {
    
    }
}

// MARK: Extension - ChartInteractorToPresenterProtocol
extension ChartPresenter: ChartInteractorToPresenterProtocol {
    
}
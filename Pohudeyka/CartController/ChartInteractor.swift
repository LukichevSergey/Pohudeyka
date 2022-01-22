//
//  ChartInteractor.swift
//  Pohudeyka
//
//  Created by Сергей Лукичев on 22.01.2022.
//  
//

import Foundation

// MARK: Protocol - ChartPresenterToInteractorProtocol (Presenter -> Interactor)
protocol ChartPresenterToInteractorProtocol: AnyObject {

}

class ChartInteractor {

    // MARK: Properties
    weak var presenter: ChartInteractorToPresenterProtocol!

}

// MARK: Extension - ChartPresenterToInteractorProtocol
extension ChartInteractor: ChartPresenterToInteractorProtocol {
    
}
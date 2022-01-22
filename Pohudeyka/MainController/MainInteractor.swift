//
//  MainInteractor.swift
//  Pohudeyka
//
//  Created by Сергей Лукичев on 21.01.2022.
//  
//

import Foundation

// MARK: Protocol - MainPresenterToInteractorProtocol (Presenter -> Interactor)
protocol MainPresenterToInteractorProtocol: AnyObject {
    var tableViewData: [[ResultModel]] { get }
    var sections: [String] { get }
    
    func saveButtonTapped(withWeight weight: Double)
}

class MainInteractor {
    
    var sections: [String] = ["Сергей", "Андрей"]
    
    var tableViewData = [
        [ResultModel(data: "23.01.2021", weight: 123), ResultModel(data: "24.01.2021", weight: 122)],
        [ResultModel(data: "23.01.2021", weight: 98), ResultModel(data: "24.01.2021", weight: 97)],
    ]

    // MARK: Properties
    weak var presenter: MainInteractorToPresenterProtocol!

}

// MARK: Extension - MainPresenterToInteractorProtocol
extension MainInteractor: MainPresenterToInteractorProtocol {
    func saveButtonTapped(withWeight weight: Double) {
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let formatteddate = formatter.string(from: time as Date)
        
        tableViewData[0].append(ResultModel(data: formatteddate, weight: weight))
        presenter.weightSaved()
    }
}

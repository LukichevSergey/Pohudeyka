//
//  MainPresenter.swift
//  Pohudeyka
//
//  Created by Сергей Лукичев on 21.01.2022.
//  
//

import Foundation

// MARK: Protocol - MainViewToPresenterProtocol (View -> Presenter)
protocol MainViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
    func headerTapped(withSection section: String)
    func saveButtonTapped(withWeight weight: Double)
}

// MARK: Protocol - MainInteractorToPresenterProtocol (Interactor -> Presenter)
protocol MainInteractorToPresenterProtocol: AnyObject {
    func weightSaved()
    func usersDataFetched()
}

class MainPresenter {
    
    private var openSections = Set<String>()

    // MARK: Properties
    var router: MainPresenterToRouterProtocol!
    var interactor: MainPresenterToInteractorProtocol!
    weak var view: MainPresenterToViewProtocol!
}

// MARK: Extension - MainViewToPresenterProtocol
extension MainPresenter: MainViewToPresenterProtocol {
    func saveButtonTapped(withWeight weight: Double) {
        interactor.saveButtonTapped(withWeight: weight)
    }
    
    func headerTapped(withSection section: String) {
        if self.openSections.contains(section) {
            self.openSections.remove(section)
        } else {
            self.openSections.insert(section)
        }
        view.updateTable(withData: interactor.results, openSections: openSections)
    }
    
    func viewDidLoad() {
        DispatchQueue.main.async {
            self.interactor.fetchUsersData()
        }
    }
}

// MARK: Extension - MainInteractorToPresenterProtocol
extension MainPresenter: MainInteractorToPresenterProtocol {
    func usersDataFetched() {
        DispatchQueue.main.async {
            self.view.appendTableSections(sections: self.interactor.sections)
            self.view.updateTable(withData: self.interactor.results, openSections: self.openSections)
        }
    }
    
    func weightSaved() {
//        view.updateTable(withData: interactor.tableViewData, openSections: openSections)
    }
}

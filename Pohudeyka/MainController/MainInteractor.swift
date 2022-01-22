//
//  MainInteractor.swift
//  Pohudeyka
//
//  Created by Сергей Лукичев on 21.01.2022.
//  
//

import Foundation
import UIKit
import Firebase

// MARK: Protocol - MainPresenterToInteractorProtocol (Presenter -> Interactor)
protocol MainPresenterToInteractorProtocol: AnyObject {
    var sections: [String] { get }
    var dataEntity: [User] { get }
    var results: [[User.Result]] { get }
    
    func saveButtonTapped(withWeight weight: Double)
    func fetchUsersData()
}

class MainInteractor {
    
    var sections: [String] {
        var arr: [String] = []
        for user in dataEntity {
            arr.append(user.name)
        }
        return arr
    }
    
    var results: [[User.Result]] {
        var arr: [[User.Result]] = [[], []]
        for (key, user) in dataEntity.enumerated() {
            if let results = user.results {
                for result in results {
                    arr[key].append(result)
                }
            }
        }

        for i in 0..<arr.count {
            arr[i].sort(by: {$0.data > $1.data})
        }
        return arr
    }
    
    private var ref: DatabaseReference!

    var dataEntity: [User] = []

    // MARK: Properties
    weak var presenter: MainInteractorToPresenterProtocol!
    
    func fetchUsersData() {
//        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("shopList")
        ref = Database.database().reference(withPath: "users")
        ref.observeSingleEvent(of: DataEventType.value, with: { snapshot in
            if snapshot.exists() {
                let users = snapshot.value as! NSDictionary
                for (userName, userResults) in users {
                    var us = User(name: "\(userName)", results: [])
                    let userData = userResults as! NSDictionary
                    for (date,result) in userData {
                        let resultData = result as! NSDictionary
                        if let weight = resultData["weight"] {
                            us.results?.append(User.Result(data: "\(date)", weight: weight as! Double))
                        }
                    }
                    self.dataEntity.append(us)
                }
            }
            self.presenter.usersDataFetched()
        })
        
        
    }

}

// MARK: Extension - MainPresenterToInteractorProtocol
extension MainInteractor: MainPresenterToInteractorProtocol {
    
    func saveButtonTapped(withWeight weight: Double) {
//        let time = NSDate()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd.MM.YYYY"
//        formatter.timeZone = TimeZone(secondsFromGMT: 0)
//        let formatteddate = formatter.string(from: time as Date)
//        
//        tableViewData[0].append(ResultModel(data: formatteddate, weight: weight))
//        presenter.weightSaved()
    }
}

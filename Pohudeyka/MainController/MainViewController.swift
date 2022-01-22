//
//  MainViewController.swift
//  Pohudeyka
//
//  Created by Сергей Лукичев on 21.01.2022.
//  
//

import UIKit
import SnapKit

// MARK: Protocol - MainPresenterToViewProtocol (Presenter -> View)
protocol MainPresenterToViewProtocol: AnyObject {
    func updateTable(withData data: [[User.Result]], openSections: Set<String>)
    func appendTableSections(sections: [String])
}

// MARK: Protocol - MainRouterToViewProtocol (Router -> View)
protocol MainRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

class MainViewController: UIViewController {
        
    private var sections: [String] = []
    
    private lazy var homeTitle: UILabel = {
        let label = UILabel()
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let formatteddate = formatter.string(from: time as Date)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        label.backgroundColor = UIColor(red:255/255.0, green:130/255.0, blue:119/255.0, alpha:1.0)
        label.text = "График потери жира (\(formatteddate))"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = UIColor(red:255/255.0, green:130/255.0, blue:119/255.0, alpha:1.0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var dataSource = UITableViewDiffableDataSource<String, User.Result>(tableView: tableView) { tableView, indexPath, currentItem in
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell
        else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }

        cell.configuration(with: currentItem)
        
        return cell
    }
    
    // MARK: - Property
    var presenter: MainViewToPresenterProtocol!

    // MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:255/255.0, green:130/255.0, blue:119/255.0, alpha:1.0)
        
        configureUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - private func
    private func commonInit() {

    }

    private func configureUI() {
        self.title = "Home"
        configureTabBar()
        
        view.addSubview(homeTitle)
        homeTitle.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.bottom.right.left.equalToSuperview()
            make.top.equalTo(homeTitle.snp.bottom).offset(12)
        }
    }
    
    private func configureTabBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)]
    }
}

// MARK: Extension - MainPresenterToViewProtocol 
extension MainViewController: MainPresenterToViewProtocol{
    func appendTableSections(sections: [String]) {
        self.sections.append(contentsOf: sections)
    }
    
    func updateTable(withData data: [[User.Result]], openSections: Set<String>) {
        var snapshot = NSDiffableDataSourceSnapshot<String, User.Result>()
        snapshot.appendSections(self.sections)
        for section in openSections {
            if let indexOfSection = self.sections.firstIndex(of: section) {
                snapshot.appendItems(data[indexOfSection], toSection: section)
            }
        }
        dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
}

// MARK: Extension - MainRouterToViewProtocol
extension MainViewController: MainRouterToViewProtocol{
    func presentView(view: UIViewController) {
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard self.sections.count > 0  else { return UIView() }
        let header = MainSectionHeader()
        header.delegate = self
        header.configuration(section: self.sections[section])

        return header
    }
}

extension MainViewController: MainSectionHeaderDelegate {
    func addResultButtonTapped(forSection section: String) {
        let popup = PopupView()
        popup.delegate = self
        popup.layer.zPosition = 1
        self.view.addSubview(popup)
        popup.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
    }
    
    func headerTapped(withSection section: String) {
        presenter.headerTapped(withSection: section)
    }
}

extension MainViewController: PopupViewDelegate {
    func saveButtonTapped(withWeight weight: Double) {
        presenter.saveButtonTapped(withWeight: weight)
    }
}

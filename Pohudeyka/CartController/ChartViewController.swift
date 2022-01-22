//
//  ChartViewController.swift
//  Pohudeyka
//
//  Created by Сергей Лукичев on 22.01.2022.
//  
//

import UIKit
import SnapKit
import Charts

// MARK: Protocol - ChartPresenterToViewProtocol (Presenter -> View)
protocol ChartPresenterToViewProtocol: AnyObject {

}

// MARK: Protocol - ChartRouterToViewProtocol (Router -> View)
protocol ChartRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

class ChartViewController: UIViewController {
    
    private lazy var lineChart: LineChartView = {
        let lineChart = LineChartView()
        lineChart.delegate = self
        lineChart.backgroundColor = .systemBlue
        
        lineChart.rightAxis.enabled = false
        
        let yAxis = lineChart.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChart.xAxis.setLabelCount(6, force: false)
        lineChart.xAxis.labelTextColor = .white
        lineChart.xAxis.axisLineColor = .systemBlue
        
        lineChart.animate(xAxisDuration: 2.5)
        
        return lineChart
    }()
    
    private lazy var lineChart2: LineChartView = {
        let lineChart = LineChartView()
        lineChart.delegate = self
        lineChart.backgroundColor = .systemBlue
        
        lineChart.rightAxis.enabled = false
        
        let yAxis = lineChart.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChart.xAxis.setLabelCount(6, force: false)
        lineChart.xAxis.labelTextColor = .white
        lineChart.xAxis.axisLineColor = .systemBlue
        
        lineChart.animate(xAxisDuration: 2.5)
        
        return lineChart
    }()
    
    // MARK: - Property
    var presenter: ChartViewToPresenterProtocol!

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

        configureUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - private func
    private func commonInit() {
        let entries1: [ChartDataEntry] = [
            ChartDataEntry(x: 10.10, y: 126.8),
            ChartDataEntry(x: 11.10, y: 125.9),
            ChartDataEntry(x: 12.10, y: 124.9),
            ChartDataEntry(x: 13.10, y: 124.3),
            ChartDataEntry(x: 14.10, y: 123.9),
            ChartDataEntry(x: 15.10, y: 123.4),
            ChartDataEntry(x: 16.10, y: 123.4),
            ChartDataEntry(x: 17.10, y: 123.2),
            ChartDataEntry(x: 18.10, y: 122.5),
            ChartDataEntry(x: 19.10, y: 122.1),
            ChartDataEntry(x: 20.10, y: 121.9),
            ChartDataEntry(x: 21.10, y: 121.4),
            ChartDataEntry(x: 22.10, y: 121.9)
        ]
        
        let entries2: [ChartDataEntry] = [
            ChartDataEntry(x: 10.10, y: 98.0),
            ChartDataEntry(x: 11.10, y: 96.7),
            ChartDataEntry(x: 12.10, y: 96.0),
            ChartDataEntry(x: 13.10, y: 96.0),
            ChartDataEntry(x: 14.10, y: 95.5),
            ChartDataEntry(x: 15.10, y: 95.1),
            ChartDataEntry(x: 16.10, y: 95.1),
            ChartDataEntry(x: 17.10, y: 95.5),
            ChartDataEntry(x: 18.10, y: 94.8),
            ChartDataEntry(x: 19.10, y: 94.5),
            ChartDataEntry(x: 20.10, y: 94.1),
            ChartDataEntry(x: 21.10, y: 93.3),
            ChartDataEntry(x: 22.10, y: 93.5)
        ]

        let set1 = LineChartDataSet(entries: entries1, label: "Sergey")
        set1.drawCirclesEnabled = false
        set1.mode = .cubicBezier
        set1.lineWidth = 3
        set1.setColor(.white)
        
        let set2 = LineChartDataSet(entries: entries2, label: "Andrey")
        set2.drawCirclesEnabled = false
        set2.mode = .cubicBezier
        set2.lineWidth = 3
        set2.setColor(.green)
        
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChart.data = data
        
        let data2 = LineChartData(dataSet: set2)
        data2.setDrawValues(false)
        lineChart2.data = data2
    }

    private func configureUI() {
        self.title = "Chart"
        self.view.backgroundColor = UIColor(red:255/255.0, green:130/255.0, blue:119/255.0, alpha:1.0)
        
        self.view.addSubview(lineChart)
        lineChart.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(300)
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(12)
        }
        
        self.view.addSubview(lineChart2)
        lineChart2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(300)
            make.top.equalTo(lineChart.snp.bottom).offset(12)
        }
    }
}

// MARK: Extension - ChartPresenterToViewProtocol 
extension ChartViewController: ChartPresenterToViewProtocol{
    
}

// MARK: Extension - ChartRouterToViewProtocol
extension ChartViewController: ChartRouterToViewProtocol{
    func presentView(view: UIViewController) {
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}

extension ChartViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}

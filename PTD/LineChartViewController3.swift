//
//  ViewController.swift
//  PTD
//
//  Created by Karol Chojnacki on 18/10/2019.
//  Copyright © 2019 Karol Chojnacki. All rights reserved.
//

import Foundation
import Darwin
import Cocoa
import Charts

class LineChartViewController3: NSViewController
{


  @IBOutlet weak var lineChartView: LineChartView!
  
    let fc = Functions()
  
    override open func viewDidLoad()
    {
      super.viewDidLoad()
      
      let ys1 = Array(stride(from: 0.0, to: fc.T, by: fc.interval)).map {t in return fc.z(t: t)}
      let yse1 = ys1.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }

        
      let data = LineChartData()
      let ds1 = LineChartDataSet(entries: yse1)
      ds1.colors = [NSUIColor.red]
      data.addDataSet(ds1)
      ds1.circleRadius = 0
      ds1.circleHoleRadius = 0
      
      self.lineChartView.data = data
      self.lineChartView.backgroundColor = NSUIColor.white
      self.lineChartView.gridBackgroundColor = NSUIColor.white
      self.lineChartView.chartDescription?.text = "Zadanie #1"
      
    }
    
    override open func viewWillAppear()
    {
        self.lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
    }
}


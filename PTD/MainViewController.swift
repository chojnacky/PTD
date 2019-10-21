//
//  MainVC.swift
//  PTD
//
//  Created by Karol Chojnacki on 18/10/2019.
//  Copyright © 2019 Karol Chojnacki. All rights reserved.
//

import Foundation
import Cocoa
import Charts

class MainViewController : NSViewController, FunctionsDelegate {
  
  let fc = Functions()
  @IBOutlet weak var menuListOutlet: NSPopUpButton!
  
  @IBAction func menuList(_ sender: NSPopUpButton) {
    fc.delegate = self
    
    let selectedIndex = menuListOutlet.indexOfSelectedItem
    
    if (selectedIndex == 0){
      self.lineChartView.isHidden = true
    }
    else if (selectedIndex == 1) {
      fc.makeAChart(.ZAD1)
    } else if (selectedIndex == 2) {
      fc.makeAChart(.ZAD2A)
    }
    else if (selectedIndex == 3) {
      fc.makeAChart(.ZAD2B)
    }
    else if (selectedIndex == 4) {
      fc.makeAChart(.ZAD2C)
    }
    else if (selectedIndex == 5) {
      fc.makeAChart(.ZAD3)
    }
    else if (selectedIndex == 6) {
      fc.makeAChart(.ZAD4A)
    }
    else if (selectedIndex == 7) {
      fc.makeAChart(.ZAD4B)
    }
    else if (selectedIndex == 8) {
      fc.makeAChart(.ZAD4C)
    } else {
      print("Error.")
    }
  }
  
  @IBOutlet weak var lineChartView: LineChartView!
  func chartDataReady(_ data: LineChartData) {
    self.lineChartView.isHidden = false
    self.lineChartView.data = data
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.lineChartView.backgroundColor = NSUIColor.white
    self.lineChartView.gridBackgroundColor = NSUIColor.white
  }
}

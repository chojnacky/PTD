//
//  MainVC.swift
//  PTD
//
//  Created by Karol Chojnacki on 18/10/2019.
//  Copyright © 2019 Karol Chojnacki. All rights reserved.
//

import Foundation
import Cocoa

class MainViewController : NSViewController {
  
  @IBOutlet weak var ownership: NSTextField!
  
  @IBAction func PTD1(_ sender: NSButton) {
    performSegue(withIdentifier: "PTD1", sender: self)
  }
  @IBAction func PTD2A(_ sender: NSButton) {
    performSegue(withIdentifier: "PTD2A", sender: self)
  }
  @IBAction func PTD2B(_ sender: NSButton) {
    performSegue(withIdentifier: "PTD2B", sender: self)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    ownership.stringValue = "Created by Karol Chojnacki"
  }
  
}

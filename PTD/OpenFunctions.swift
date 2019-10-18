//
//  OpenFunctions.swift
//  PTD
//
//  Created by Karol Chojnacki on 18/10/2019.
//  Copyright © 2019 Karol Chojnacki. All rights reserved.
//

import Foundation
import Darwin

class Functions {
  
  let f: Double = 17
  let fs: Double = 1000
  let d: Double = Double((3*Double.pi)/1)
  let T: Double = 1.2
  let e: Double = Double(Darwin.M_E)
  var m: Double = 0
  var interval: Double = 1/1000
  
  init() {
    self.interval = 1/fs
    let xs = Array(stride(from: 0.0, to: T, by: interval))
    var ys = [Double]()
    
    for i in xs {
      ys.append(self.x(t: i))
    }
    self.m = ys.max()!
  }
  
  func x(t: Double) -> Double {
    let first: Double = (1 - t)/(3 - pow(t, 2))
    let second: Double = sin(2 * Double(Double.pi) * f * t + d)
    let third: Double = cos(4 * pow(t, 2))
    return first * second + third
  }
  
  func y(t: Double) -> Double {
    let first: Double = pow(-x(t: t), 3)
    let second: Double = x(t: t) + m
    return first/second
  }

  func z(t: Double) -> Double {
    let first: Double = y(t: t) + pow(e, x(t: t) + y(t: t))
    let second: Double = pow(abs(y(t: t)), 0.333)
    return first * second
  }
  
  func v(t: Double) -> Double {
    let first: Double = 3*(cos(13*t)) - y(t: t) + (z(t: t)/7)
    let second: Double = sin(z(t: t) + x(t: t))
    return first * second
  }
}

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
  
  var f: Double = 17
  var fs: Double = 1000
  var d: Double = Double((3*Double.pi)/1)
  var T: Double = 1.2
  var e: Double = Double(Darwin.M_E)
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
    print("OpenFunctions initialized with settings: \nf = \(f)Hz\nd = \(d)\nfs = \(fs)Hz\nT = \(T)s\ninterval = \(interval)")
  }
  
  init(T: Double, fs: Double){
    self.fs = fs
    self.T = T
    self.interval = 1/fs
    print("OpenFunctions initialized with settings: \nf = \(f)Hz\nd = \(d)\nfs = \(fs)Hz\nT = \(T)s\ninterval = \(interval)")
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
    let power: Double = x(t: t) + y(t: t)
    let second: Double = pow(e, power)

    let third: Double = abs(y(t: t))
    let fourth: Double = pow(third, 0.333)

    let comb: Double = y(t: t) + second

    return comb * fourth
  }
  
  func v(t: Double) -> Double {
    let first: Double = 3*(cos(13*t)) - y(t: t) + (z(t: t)/7)
    let second: Double = sin(z(t: t) + x(t: t))
    return first * second
  }
  
  func u(t: Double) -> Double {
    if (t >= 0 && t < 0.6) {
      let st: Double = pow(t, 2)
      let nd: Double = sin(2 * Double.pi * t)
      return st * nd
    } else if (t >= 0.6 && t < 1.5) {
      let st: Double = t * pow(e, t-0.6)
      let nd: Double = sin(10 * Double.pi * t)
      return st * 0.8 * nd
    } else if (t >= 1.5 && t < 2.4) {
      let st: Double = (1 + 0.4 * sin(2 * Double.pi * t))
      let nd: Double = sin(30 * Double.pi * t)
      return st * nd
    } else if (t >= 2.4 && t < 3) {
      let st: Double = sqrt(t + cos(14 * t))
      let nd: Double = sin(10 * Double.pi * t)
      return st * nd
    }
    return 0
  }
}

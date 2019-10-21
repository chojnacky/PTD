//
//  OpenFunctions.swift
//  PTD
//
//  Created by Karol Chojnacki on 18/10/2019.
//  Copyright © 2019 Karol Chojnacki. All rights reserved.
//

import Foundation
import Darwin
import Charts

enum Zadanie {
  case ZAD1
  case ZAD2A
  case ZAD2B
  case ZAD2C
  case ZAD3
  case ZAD4A
  case ZAD4B
  case ZAD4C
}

protocol FunctionsDelegate {
    func chartDataReady(_ data: LineChartData)
}

class Functions {
  var delegate: FunctionsDelegate?
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
  }
  
  init(T: Double, fs: Double){
    self.fs = fs
    self.T = T
    self.interval = 1/fs
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
    let first: Double = 3*cos(13 * t) - y(t: t) + z(t: t) / 7
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
  
  func b(t: Double, N: Int) -> Double {
    var sum: Double = 0
    for i in 1...N {
      let x: Double = Double(i)
      sum = sum + (sin((x * t * Double.pi) / 2) / (2 + cos(pow(x, 2) * Double.pi * t)))
    }
    return sum
  }
  
  func calculate(_ ys1: [Double]) {
    let yse1 = ys1.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
    let data = LineChartData()
    let ds1 = LineChartDataSet(entries: yse1)
    ds1.colors = [NSUIColor.red]
    ds1.circleRadius = 0
    ds1.circleHoleRadius = 0
    data.addDataSet(ds1)
    
    delegate?.chartDataReady(data)
  }
  
  func makeAChart(_ mode: Zadanie) {
    var ys1 = [Double]()
    
    switch(mode){
    case .ZAD1:
      ys1 = Array(stride(from: 0.0, to: self.T, by: self.interval)).map {t in return self.x(t: t)}
      break
    case .ZAD2A:
      ys1 = Array(stride(from: 0.0, to: self.T, by: self.interval)).map {t in return self.y(t: t)}
      break
    case .ZAD2B:
      ys1 = Array(stride(from: 0.0, to: self.T, by: self.interval)).map {t in return self.z(t: t)}
      break
    case .ZAD2C:
      ys1 = Array(stride(from: 0.0, to: self.T, by: self.interval)).map {t in return self.v(t: t)}
      break
    case .ZAD3:
      self.T = 3
      self.fs = 2000
      self.interval = 1/fs
      ys1 = Array(stride(from: 0.0, to: self.T, by: self.interval)).map {t in return self.u(t: t)}
      break
    case .ZAD4A:
      self.T = 2
      self.fs = 10000
      self.interval = 1/fs
      ys1 = Array(stride(from: 0.0, to: self.T, by: self.interval)).map {t in return self.b(t: t, N: 2)}
      break
    case .ZAD4B:
      self.T = 2
      self.fs = 10000
      self.interval = 1/fs
      ys1 = Array(stride(from: 0.0, to: self.T, by: self.interval)).map {t in return self.b(t: t, N: 6)}
      break
    case .ZAD4C:
      self.T = 2
      self.fs = 10000
      self.interval = 1/fs
      ys1 = Array(stride(from: 0.0, to: self.T, by: self.interval)).map {t in return self.b(t: t, N: 10)}
      break
    }
    calculate(ys1)
  }
}

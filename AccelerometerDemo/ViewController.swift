//
//  ViewController.swift
//  AccelerometerDemo
//
//  Created by mitsuyoshi.yamazaki on 2017/03/03.
//  Copyright © 2017年 mitsuyoshi.yamazaki. All rights reserved.
//

import UIKit
import CoreMotion

// https://www.hackingwithswift.com/example-code/system/how-to-use-core-motion-to-read-accelerometer-data
final class ViewController: UIViewController {

  @IBOutlet fileprivate weak var accelerationLabel: UILabel! {
    didSet {
      let fontSize = accelerationLabel.font.pointSize
      accelerationLabel.font = UIFont.monospacedDigitSystemFont(ofSize: fontSize, weight: UIFontWeightMedium)
    }
  }
  
  fileprivate let motionManager = CMMotionManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    motionManager.startAccelerometerUpdates(to: OperationQueue.main) { [weak self] (dataOptional, error) in
      guard
        let _self = self,
        let data = dataOptional,
        error == nil
      else {
        print("accelerometerUpdates failed")
        print(dataOptional ?? "data is nil")
        print(error ?? "error is nil ")
        return
      }
      
      let format = "%1.3f"
      let xString = data.acceleration.x.convertToStringWithSign(format: format)
      let yString = data.acceleration.y.convertToStringWithSign(format: format)
      let zString = data.acceleration.z.convertToStringWithSign(format: format)
      let formattedResult = "(x: \(xString), y : \(yString), z : \(zString))"
      
      print(formattedResult)
      
      DispatchQueue.main.async {
        _self.accelerationLabel.text = formattedResult
      }
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // TODO: tear down
  }
}

extension Double {
  func convertToStringWithSign(format: String) -> String {
    
    let rawString = String(format: format, self)
    return self < 0 ? rawString : "+" + rawString
  }
}

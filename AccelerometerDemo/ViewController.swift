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
      
      print(data.acceleration)
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // TODO: tear down
  }
}

//
//  ChainEditViewController.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/23/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import Foundation
import UIKit

class ChainEditViewController: UIViewController {
  var chainEditView: ChainEditView?

  override func loadView() {
    let v = UIView()
    v.backgroundColor = UIColor.redColor()
    self.view = v
  }
}
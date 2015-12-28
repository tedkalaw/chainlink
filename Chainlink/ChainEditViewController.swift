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
  var chain: Chain!

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  convenience init(chain: Chain) {
    self.init()
    self.chain = chain
  }

  override func loadView() {
    let v = UIView()
    v.backgroundColor = UIColor.redColor()
    self.view = v
    self.title = self.chain.name
  }
}
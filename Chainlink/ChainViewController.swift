//
//  ChainViewController.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/5/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import UIKit

class ChainViewController:UIViewController {

  var chainView: ChainView?

  override func viewDidLoad() {
    super.viewDidLoad();

    self.chainView = ChainView()
    self.view.addSubview(self.chainView!)

    self.title = "Chain"
    self.navigationController?.navigationBarHidden = false
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    self.chainView?.frame = self.view.bounds
  }

  override func viewWillDisappear(animated: Bool) {
    self.navigationController?.navigationBarHidden = true
  }
}

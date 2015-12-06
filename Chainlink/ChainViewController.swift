//
//  ChainViewController.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/5/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import UIKit

class ChainViewController:UIViewController,
  ChainViewDelegate {

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
    self.chainView?.frame = CGRectMake(
      self.view.bounds.origin.x,
      self.view.bounds.origin.y + 60,
      self.view.bounds.size.width,
      self.view.bounds.size.height
    )
  }

  override func viewWillDisappear(animated: Bool) {
    self.navigationController?.navigationBarHidden = true
  }
}

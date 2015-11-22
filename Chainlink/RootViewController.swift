//
//  RootViewController.swift
//  Chainlink
//
//  Created by Ted Kalaw on 11/22/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

  var rootView: InitialView?
  var titleLabel: UILabel?

  override func viewDidLoad() {
    super.viewDidLoad();

    let newRootView:InitialView = InitialView()

    self.view.addSubview(newRootView)
    self.rootView = newRootView
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    self.rootView?.frame = self.view.bounds
  }
}

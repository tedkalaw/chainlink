//
//  RootViewController.swift
//  Chainlink
//
//  Created by Ted Kalaw on 11/22/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, InitialViewDelegate {

  var rootView: InitialView?
  var titleLabel: UILabel?

  override func viewDidLoad() {
    super.viewDidLoad();

    let newRootView:InitialView = InitialView()
    newRootView.delegate = self

    self.view.userInteractionEnabled = true
    self.view.addSubview(newRootView)
    self.rootView = newRootView
    self.navigationController?.navigationBarHidden = true
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    self.rootView?.frame = self.view.bounds
  }

  func handleGoButtonPress() {
    self.navigationController?.pushViewController(AllChainsViewController(), animated: true)
  }

  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBarHidden = true
  }
}

//
//  AllChainsViewController.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/8/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import UIKit

class AllChainsViewController: UIViewController,
  UITableViewDataSource,
  UITableViewDelegate {

  var allChainsView: AllChainsView?
  var chainModelStore: ChainModelStore?

  override func viewDidLoad() -> Void {
    super.viewDidLoad()

    self.title = "All Chains"
    self.navigationController?.navigationBarHidden = false

    self.allChainsView = AllChainsView() 
    self.view.addSubview(self.allChainsView!)

    self.chainModelStore = ChainModelStore.loadStore()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    self.allChainsView!.frame = CGRectMake(
      self.view.bounds.origin.x,
      self.view.bounds.origin.y,
      self.view.bounds.size.width,
      self.view.bounds.size.height
    )

  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell",
      forIndexPath: indexPath)
    cell.textLabel?.text = "hi"
    return cell
  }

  override func viewWillDisappear(animated: Bool) {
    self.navigationController?.navigationBarHidden = true
  }
}

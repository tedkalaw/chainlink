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

    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Add",
      style: .Plain,
      target: self,
      action: "addChain"
    )
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

  override func viewWillDisappear(animated: Bool) {
    self.navigationController?.navigationBarHidden = true
  }


  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (chainModelStore?.chainKeys.count)!
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell",
      forIndexPath: indexPath)
    cell.textLabel?.text = "hi"
    return cell
  }

  private func addChain() -> Void {
    let alert = UIAlertController(title: "New Chain",
      message: "Add a new chain",
      preferredStyle: .Alert)

    let cancelAction = UIAlertAction(title: "Cancel",
      style: .Default) { (action: UIAlertAction) -> Void in
    }

    alert.addTextFieldWithConfigurationHandler {
      (textField: UITextField) -> Void in
    }

    alert.addAction(cancelAction)

    presentViewController(alert,
      animated: true,
      completion: nil)
  }
}

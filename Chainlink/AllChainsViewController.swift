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

    let allChainsView = AllChainsView()
    allChainsView.delegate = self
    allChainsView.dataSource = self
    allChainsView.registerClass(
      UITableViewCell.self,
      forCellReuseIdentifier: "cell"
    )
    self.view.addSubview(allChainsView)
    self.allChainsView = allChainsView

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

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.chainModelStore!.chainsTitles().count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell",
      forIndexPath: indexPath)
    cell.textLabel?.text = self.chainModelStore!.chainsTitles()[indexPath.row]
    return cell
  }

  func addChain() -> Void {
    let alert = UIAlertController(title: "New Chain",
      message: "Add a new chain",
      preferredStyle: .Alert)

    let saveAction = UIAlertAction(title: "Save",
      style: .Default,
      handler: { (action:UIAlertAction) -> Void in
        self.chainModelStore!.newChain(alert.textFields!.first!.text!);
        self.allChainsView?.reloadData()
    })
    alert.addAction(saveAction)

    alert.addAction(UIAlertAction(
      title: "Cancel",
      style: .Default,
      handler: { (action: UIAlertAction) -> Void in }
    ))

    alert.addTextFieldWithConfigurationHandler {
      (textField: UITextField) -> Void in
    }

    presentViewController(alert,
      animated: true,
      completion: nil)
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    let chainTitle = self.chainModelStore!.chainsTitles()[indexPath.row]
    self.navigationController?.pushViewController(ChainViewController(chainTitle: chainTitle), animated: true)

  }
}

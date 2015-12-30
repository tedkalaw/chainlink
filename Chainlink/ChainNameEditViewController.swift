//
//  ChainNameEditViewController.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/29/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import Foundation
import UIKit

class ChainNameEditViewController: UITableViewController {
  var chain: Chain!
  var textCell: TextTableViewCell!

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  convenience init(chain: Chain) {
    self.init(nibName: nil, bundle: nil)
    self.chain = chain
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TextTableViewCell
    cell.label.text = chain.name
    self.textCell = cell
    return cell
  }

  override func viewDidLoad() {
    self.title = "Name"
    super.viewDidLoad()
    self.tableView = UITableView(frame: self.view.frame, style: .Grouped)
    self.tableView.registerClass(TextTableViewCell.self, forCellReuseIdentifier: "cell")
  }

  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    self.chain.name = self.textCell.label.text

    do {
      try self.chain.managedObjectContext!.save()
    } catch {
      NSLog("Failed to update chain name")
    }
  }

}
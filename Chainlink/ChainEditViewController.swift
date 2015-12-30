//
//  ChainEditViewController.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/23/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import Foundation
import UIKit

class ChainEditViewController: UITableViewController {
  var chain: Chain!

  var editOptions: [String]

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    self.editOptions = ["Name", "Frequency"]
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
    return self.editOptions.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    cell.textLabel?.text = self.editOptions[indexPath.row]
    cell.detailTextLabel?.text = self.chain.name
    return cell
  }

  override func viewDidAppear(animated: Bool) {
    self.tableView.reloadData()
  }

  override func viewWillAppear(animated: Bool) {
    self.title = self.chain.name
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let text = self.editOptions[indexPath.row]
    switch (text) {
      case "Name":
        self.navigationController?.pushViewController(
          ChainNameEditViewController(chain: self.chain),
          animated: true
        )
      break

      case "Frequency":
      break

    default:
      return
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView = UITableView(frame: self.view.frame, style: .Grouped)
    self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }

}
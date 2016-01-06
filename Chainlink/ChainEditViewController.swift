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
    self.editOptions = ["Name", "Frequency", "Delete"]
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
    let editOption = self.editOptions[indexPath.row]

    cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    cell.textLabel?.text = editOption

    if (editOption == "Delete") {
      cell.backgroundColor = UIColor.redColor()
      cell.textLabel?.textColor = UIColor.whiteColor()
      cell.accessoryType = .None
    }
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
        self.navigationController?.pushViewController(
          ChainFrequencyEditViewController(chain: self.chain),
          animated: true
        )
      break

      case "Delete":
        let alert = UIAlertController(
          title: "Delete chain",
          message: "Are you sure you want to permanently delete this chain?",
          preferredStyle: .Alert
        )

        let deleteAction = UIAlertAction(
          title: "Yes dude",
          style: .Destructive,
          handler: {
            (action:UIAlertAction) -> Void in
            self.chain.managedObjectContext!.deleteObject(self.chain)
            self.navigationController?.popViewControllerAnimated(true)
          }
        )

        alert.addAction(deleteAction)

        presentViewController(
          alert,
          animated: true,
          completion: nil
        )
        // TODO add
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
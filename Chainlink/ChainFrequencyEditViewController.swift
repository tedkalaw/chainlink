//
//  ChainFrequencyEditViewController.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/29/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import Foundation
import UIKit

class ChainFrequencyEditViewController: UITableViewController {
  var chain: Chain!

  var selectedRow: Int!

  // TODO use bitmap to do all this stuff so I can store the bitmap
  // in the db 8)
  var dayOptions: [String: Bool] = ["Sunday": false, "Monday": false, "Tuesday": false, "Wednesday": false, "Thursday": false, "Friday": false, "Saturday": false]

  // TODO: figure out swift map syntax
  static var days: [String] = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

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
    return ChainFrequencyEditViewController.days.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

    cell.textLabel?.text = ChainFrequencyEditViewController.days[indexPath.row]
    return cell
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    let selectedDay = ChainFrequencyEditViewController.days[indexPath.row]
    let isSelected = self.dayOptions[selectedDay]!


    self.dayOptions[selectedDay] = !isSelected

    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    let selectedCell = self.tableView.cellForRowAtIndexPath(indexPath)
    if (isSelected) {
      selectedCell!.accessoryType = .None
    } else {
      selectedCell!.accessoryType = .Checkmark
    }
  }

  override func viewDidLoad() {
    self.title = "Frequency"
    super.viewDidLoad()
    self.tableView = UITableView(frame: self.view.frame, style: .Grouped)
    self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }

  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)

    do {
      try self.chain.managedObjectContext!.save()
    } catch {
      NSLog("Failed to update chain name")
    }
  }

}
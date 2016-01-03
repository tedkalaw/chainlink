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
  var frequency: Frequency!

  var selectedRow: Int!

  static var days: [DayOfTheWeek] = [DayOfTheWeek.SUNDAY, DayOfTheWeek.MONDAY, DayOfTheWeek.TUESDAY, DayOfTheWeek.WEDNESDAY, DayOfTheWeek.THURSDAY, DayOfTheWeek.FRIDAY, DayOfTheWeek.SATURDAY]

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  convenience init(chain: Chain) {
    self.init(nibName: nil, bundle: nil)
    self.chain = chain
    self.frequency = Frequency(intValue: Int((chain.frequency!.intValue)))
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 7
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

    let day = ChainFrequencyEditViewController.days[indexPath.row]
    cell.textLabel?.text = ChainFrequencyEditViewController.getPrettyString(day)

    let selectedDay = ChainFrequencyEditViewController.days[indexPath.row]
    let isSelected = self.frequency.isDayOfTheWeekSet(selectedDay)
    if (isSelected) {
      cell.accessoryType = .Checkmark
    } else {
      cell.accessoryType = .None
    }
    return cell
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    let selectedDay = ChainFrequencyEditViewController.days[indexPath.row]
    let isSelected = self.frequency.isDayOfTheWeekSet(selectedDay)

    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    let selectedCell = self.tableView.cellForRowAtIndexPath(indexPath)
    if (isSelected) {
      selectedCell!.accessoryType = .None
      self.frequency.unsetDayOfTheWeek(selectedDay)
    } else {
      selectedCell!.accessoryType = .Checkmark
      self.frequency.setDayOfTheWeek(selectedDay)
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
      self.chain.frequency = self.frequency.intValue
      try self.chain.managedObjectContext!.save()
    } catch {
      NSLog("Failed to update frequency")
    }
  }

  static func getPrettyString(dayOfTheWeek: DayOfTheWeek) -> String {
    switch (dayOfTheWeek) {
    case DayOfTheWeek.SUNDAY:
      return "Sunday"
    case DayOfTheWeek.MONDAY:
      return "Monday"
    case DayOfTheWeek.TUESDAY:
      return "Tuesday"
    case DayOfTheWeek.WEDNESDAY:
      return "Wednesday"
    case DayOfTheWeek.THURSDAY:
      return "Thursday"
    case DayOfTheWeek.FRIDAY:
      return "Friday"
    case DayOfTheWeek.SATURDAY:
      return "Saturday"
    }
  }

}
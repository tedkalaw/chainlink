//
//  ChainViewController.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/5/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import UIKit

class ChainViewController:UIViewController,
  UITableViewDataSource,
  UITableViewDelegate,
  ChainViewDelegate {

  var chainView: ChainView?
  var links: [LinkModel]?

  override func viewDidLoad() {
    super.viewDidLoad();

    self.chainView = ChainView()
    self.chainView?.dataSource = self
    self.chainView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    self.view.addSubview(self.chainView!)

    self.title = "Chain"
    self.navigationController?.navigationBarHidden = false

    if (self.links != nil) {
      return
    }

    let dateFormatter = NSDateFormatter()
    let locale = NSLocale(localeIdentifier: "en_US_POSIX")

    dateFormatter.locale = locale
    dateFormatter.dateFormat = "MM-dd-yyyy"

    self.links = [
      LinkModel(date: dateFormatter.dateFromString("12-05-2015")!),
      LinkModel(date: dateFormatter.dateFromString("12-04-2015")!),
      LinkModel(date: dateFormatter.dateFromString("12-03-2015")!),
      LinkModel(date: dateFormatter.dateFromString("12-02-2015")!)
    ]
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    self.chainView?.frame = CGRectMake(
      self.view.bounds.origin.x,
      self.view.bounds.origin.y,
      self.view.bounds.size.width,
      self.view.bounds.size.height
    )
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.links!.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell",
      forIndexPath: indexPath) 
    let item = self.links![indexPath.row]
    cell.textLabel?.text = item.dateString()
    return cell
  }

  override func viewWillDisappear(animated: Bool) {
    self.navigationController?.navigationBarHidden = true
  }
}

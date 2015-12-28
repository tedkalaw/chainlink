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

  var chain: Chain!
  var chainView: ChainView?
  var addButton: UIBarButtonItem?
  var links: [Link]!

  override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  convenience init(chain: Chain) {
    self.init()
    self.chain = chain
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad();

    self.chainView = ChainView()
    self.chainView?.dataSource = self
    self.chainView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    self.view.addSubview(self.chainView!)

    self.title = self.chain.name

    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Add",
      style: .Plain,
      target: self,
      action: "addLink"
    )

    self.links = self.chain.getSortedLinks()
  }

  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if (editingStyle != UITableViewCellEditingStyle.Delete) {
      // Only handle delete in this controller for now
      return;
    }

    self.chain.removeLinksObject(self.links[indexPath.row])
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    self.chainView!.frame = CGRectMake(
      self.view.bounds.origin.x,
      self.view.bounds.origin.y,
      self.view.bounds.size.width,
      self.view.bounds.size.height
    )
  }

  func addLink() -> Void {
    self.chain.addLinkForNow()
    do {
      try self.chain.managedObjectContext!.save()
    } catch {
      NSLog("Failed to save added link")
    }

    self.links = chain.getSortedLinks()
    self.chainView!.insertRowsAtIndexPaths(
      [NSIndexPath(forRow: 0, inSection: 0)],
      withRowAnimation: UITableViewRowAnimation.Fade
    )
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.chain.links?.count ?? 0
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell",
      forIndexPath: indexPath) 
    let item = self.links![indexPath.row]
    cell.textLabel?.text = String(item.time)
    return cell
  }
}

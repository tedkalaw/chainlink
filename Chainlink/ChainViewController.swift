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

  var chain: ChainModel?
  var chainView: ChainView?
  var links: [LinkModel]?
  var addButton: UIBarButtonItem?

  override func viewDidLoad() {
    super.viewDidLoad();

    self.chainView = ChainView()
    self.chainView?.dataSource = self
    self.chainView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    self.view.addSubview(self.chainView!)

    self.title = "Chain"
    self.navigationController?.navigationBarHidden = false


    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Add",
      style: .Plain,
      target: self,
      action: "addLink"
    )

    self.chain = ChainModel(title: "Chainlink", links: [])
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

  func addLink() -> Void {
    self.chain?.addLink(LinkModel(date: NSDate()))
    self.chainView?.reloadData()
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.chain!.links.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell",
      forIndexPath: indexPath) 
    let item = self.chain!.links[indexPath.row]
    cell.textLabel?.text = item.dateString()
    return cell
  }

  override func viewWillDisappear(animated: Bool) {
    self.navigationController?.navigationBarHidden = true
  }
}

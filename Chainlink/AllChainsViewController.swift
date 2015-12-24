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
  UITableViewDelegate,
  ChainViewCellDelegate {

  var allChainsView: AllChainsView?
  var chainModelStore: ChainModelStore?
  var chainModelDictionary: Dictionary<String, ChainModel> = Dictionary<String, ChainModel>()

  override func viewDidLoad() -> Void {
    super.viewDidLoad()

    self.title = "All Chains"

    self.navigationController?.navigationBarHidden = false

    let allChainsView = AllChainsView()
    allChainsView.delegate = self
    allChainsView.dataSource = self
    allChainsView.registerClass(
      ChainViewCell.self,
      forCellReuseIdentifier: "cell"
    )
    self.view.addSubview(allChainsView)
    self.allChainsView = allChainsView

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

  override func viewWillAppear(animated: Bool) {
    // TODO: Remove the need to have a ref to the store? Will be nice to 
    // have a DB
    self.chainModelStore = ChainModelStore.loadStore()
    self.chainModelDictionary = self.chainModelStore!.getChainMap()
    self.allChainsView?.reloadData()
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.chainModelDictionary.keys.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell",
      forIndexPath: indexPath) as! ChainViewCell
    cell.chain = self.getChain(indexPath)
    cell.delegate = self
    return cell
  }

  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    tableView.layoutMargins = UIEdgeInsetsZero
    tableView.separatorInset = UIEdgeInsetsZero
  }

  func addChain() -> Void {
    let alert = UIAlertController(title: "New Chain",
      message: "Add a new chain",
      preferredStyle: .Alert)

    let saveAction = UIAlertAction(title: "Save",
      style: .Default,
      handler: { (action:UIAlertAction) -> Void in
        self.chainModelStore!.newChain(alert.textFields!.first!.text!);
        self.chainModelDictionary = ChainModelStore.chainMap()
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

  private func getChain(indexPath: NSIndexPath) -> ChainModel {
    let chainTitles:Array<String> = self.chainModelStore!.chainsTitles()
    return self.chainModelDictionary[chainTitles[indexPath.row]]!
  }

  func handleAddLink(chain:ChainModel) -> ChainModel {
    chain.addLinkForNow()
    return chain;
  }

  func handleSelectChain(chain: ChainModel) -> Void {
    self.navigationController?.pushViewController(ChainViewController(chainTitle: chain.title), animated: true)
  }

  func handleSelectChainEdit(chain: ChainModel) -> Void {
    self.navigationController?.pushViewController(ChainEditViewController(), animated: true)
  }

}

//
//  AllChainsViewController.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/8/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import UIKit
import CoreData

class AllChainsViewController: UIViewController,
  UITableViewDataSource,
  UITableViewDelegate,
  ChainViewCellDelegate {

  var allChainsView: AllChainsView?
  var chainModelStore: ChainModelStore?
  var chainModelDictionary: Dictionary<String, ChainModel> = Dictionary<String, ChainModel>()
  var managedObjectContext: NSManagedObjectContext
  var chains: [Chain]

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    self.chains = []
    self.managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  convenience init() {
    self.init(nibName: nil, bundle: nil)
  }

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
      action: "addChainAlert"
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
    self.chains = self.getChains()
    self.allChainsView?.reloadData()
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.chains.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell",
      forIndexPath: indexPath) as! ChainViewCell
    cell.chainMO = self.chains[indexPath.row]
    cell.delegate = self
    return cell
  }

  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    tableView.layoutMargins = UIEdgeInsetsZero
    tableView.separatorInset = UIEdgeInsetsZero
  }

  func addChainAlert() -> Void {
    let alert = UIAlertController(title: "New Chain",
      message: "Add a new chain",
      preferredStyle: .Alert)

    let saveAction = UIAlertAction(title: "Save",
      style: .Default,
      handler: { (action:UIAlertAction) -> Void in
        let newChainName = alert.textFields!.first!.text!
        self.chainModelStore!.newChain(newChainName)
        self.chainModelDictionary = ChainModelStore.chainMap()

        let newChain = NSEntityDescription.insertNewObjectForEntityForName(
          Chain.entityName(),
          inManagedObjectContext: self.managedObjectContext
        ) as! Chain
        newChain.name = newChainName

        do {
          try self.managedObjectContext.save()
        } catch {
          NSLog("ayy lmao")
        }

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

  private func getChains() -> [Chain] {
    var chains = [Chain]()
    do {
      chains = try self.managedObjectContext.executeFetchRequest(Chain.allSortedFetchRequest()) as! [Chain]
    } catch {
      // TODO: Add better logging
      NSLog("getting chains failed")
    }

    return chains
  }

  func handleAddLink(chain:ChainModel) -> ChainModel {
    chain.addLinkForNow()
    return chain;
  }

  func handleSelectChain(chain: Chain) -> Void {
    self.navigationController?.pushViewController(ChainViewController(chain: chain), animated: true)
  }

  func handleSelectChainEdit(chain: ChainModel) -> Void {
    self.navigationController?.pushViewController(ChainEditViewController(chain: chain), animated: true)
  }

}

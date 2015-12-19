//
//  ChainModelStore.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/8/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import Foundation

let kChainModelStoreChainKeysKey = "chainModelStoreChainKeys"
let kChainModelStoreFileName = "2chainz"

class ChainModelStore: NSObject, NSCoding {
  var chainKeys: Set<String>

  static func getFilePath(title: String) -> String {
    let manager = NSFileManager.defaultManager()
    let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as NSURL
    return url.URLByAppendingPathComponent(title).path!
  }

  override init() {
    self.chainKeys = Set<String>()
  }

  required init?(coder aDecoder: NSCoder) {
    self.chainKeys = aDecoder.decodeObjectForKey(kChainModelStoreChainKeysKey) as! Set<String>
  }

  func encodeWithCoder(aCoder: NSCoder) -> Void {
    aCoder.encodeObject(self.chainKeys, forKey: kChainModelStoreChainKeysKey)
  }

  func save() -> Void {
    NSKeyedArchiver.archiveRootObject(self, toFile: ChainModelStore.getFilePath(kChainModelStoreFileName))
  }

  static func loadStore() -> ChainModelStore {
    let unarchivedObject = NSKeyedUnarchiver.unarchiveObjectWithFile(
      ChainModelStore.getFilePath(kChainModelStoreFileName)
    ) as? ChainModelStore

    if (unarchivedObject != nil) {
      return unarchivedObject!
    }

    return ChainModelStore()
  }

  func chainsTitles() -> Array<String> {
    return Array(self.chainKeys).sort()
  }

  func newChain(title: String) -> ChainModel {
    let newChainModel = ChainModel(title: title, links: [])
    newChainModel.save()
    self.chainKeys.insert(title)
    self.save()
    return newChainModel
  }

  func getChain(title: String) -> ChainModel {
    return ChainModel.load(title)
  }
}
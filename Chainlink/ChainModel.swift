//
//  ChainModel.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/6/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import Foundation

let kChainModelTitleKey = "chainModelTitle"
let kChainModelLinksKey = "chainLinksTitle"
let kChainModelFrequencyKey = "chainFrequencyKey"

class ChainModel: NSObject, NSCoding {

  var links: [LinkModel]
  var title: String
  var frequency: Frequency

  static func getFilePath(title: String) -> String {
    let manager = NSFileManager.defaultManager()
    let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as NSURL
    return url.URLByAppendingPathComponent(title).path!
  }

  static func load(title: String) -> ChainModel {
    let unarchivedObject = NSKeyedUnarchiver.unarchiveObjectWithFile(ChainModel.getFilePath(title)) as? ChainModel

    if (unarchivedObject != nil) {
      return unarchivedObject!
    }

    return ChainModel(title: title, links: [])
  }

  init(title: String, links: [LinkModel]) {
    self.links = links
    self.title = title
    self.frequency = Frequency.DAILY
  }

  required init?(coder aDecoder: NSCoder) {
    self.title = aDecoder.decodeObjectForKey(kChainModelTitleKey) as! String
    self.links = aDecoder.decodeObjectForKey(kChainModelLinksKey) as! [LinkModel]
    self.frequency = Frequency(rawValue: aDecoder.decodeObjectForKey(kChainModelFrequencyKey) as! String? ?? Frequency.DAILY.rawValue)!
  }

  func encodeWithCoder(aCoder: NSCoder) -> Void {
    aCoder.encodeObject(self.title, forKey: kChainModelTitleKey)
    aCoder.encodeObject(self.links, forKey: kChainModelLinksKey)
    aCoder.encodeObject(self.frequency.rawValue, forKey: kChainModelFrequencyKey)
  }

  func save() -> Void {
    NSKeyedArchiver.archiveRootObject(self, toFile: ChainModel.getFilePath(self.title))
  }

  func addLink(link: LinkModel) -> Void {
    links.insert(link, atIndex: 0)
    self.save()
  }

  func addLinkForNow() -> Void {
    self.addLink(LinkModel(date: NSDate()))

  }

  func removeLink(linkToDelete: LinkModel) -> Void {
    for (var i = 0; i < links.count; i++) {
      if (links[i] == linkToDelete) {
        links.removeAtIndex(i)
        self.save()
        return
      }
    }
  }
}
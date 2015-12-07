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

class ChainModel: NSObject, NSCoding {

  var links: [LinkModel]
  var title: String

  init(title: String, links: [LinkModel]) {
    self.links = links
    self.title = title
  }

  required init?(coder aDecoder: NSCoder) {
    self.title = aDecoder.decodeObjectForKey(kChainModelTitleKey) as! String
    self.links = aDecoder.decodeObjectForKey(kChainModelLinksKey) as! [LinkModel]
  }

  func encodeWithCoder(aCoder: NSCoder) -> Void {
    aCoder.encodeObject(self.title, forKey: kChainModelTitleKey)
    aCoder.encodeObject(self.links, forKey: kChainModelLinksKey)
  }
}
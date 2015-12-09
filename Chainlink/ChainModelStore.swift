//
//  ChainModelStore.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/8/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import Foundation

class ChainModelStore: NSObject {
  var chains: [ChainModel]

  override init() {
    self.chains = []
  }
}
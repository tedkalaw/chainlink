//
//  ChainView.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/5/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import UIKit

protocol ChainViewDelegate {

}

class ChainView: UITableView {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  required override init(frame: CGRect, style: UITableViewStyle) {
    super.init(frame: frame, style: style)
  }
}

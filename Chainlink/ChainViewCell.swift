//
//  ChainViewCell.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/18/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import UIKit
import QuartzCore

class ChainViewCell: UITableViewCell {

  var chain:ChainModel? {
    didSet {
      self.chainTitleLabel?.text = chain?.title

      self.layoutIfNeeded()
    }
  }

  var chainTitleLabel:UILabel?

  required init(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.chainTitleLabel = UILabel()
    self.contentView.addSubview(self.chainTitleLabel!)
  }

  override func layoutSubviews() {
    self.chainTitleLabel!.frame = CGRectMake(10, 0, 200, 25)
    super.layoutSubviews()
  }

}
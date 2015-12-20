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
    }
  }

  var chainTitleLabel:UILabel?

  required init(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.chainTitleLabel = UILabel()
    self.selectionStyle = .None
    self.contentView.addSubview(self.chainTitleLabel!)
  }

  override func layoutSubviews() {
    self.chainTitleLabel!.frame = CGRectMake(20, 10, 200, 20)
    super.layoutSubviews()
  }

}
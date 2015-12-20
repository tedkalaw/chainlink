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
      self.chainTitleLabel?.text = chain!.title
      self.linkCountLabel?.text = String(chain!.links.count)
    }
  }

  var chainTitleLabel:UILabel?
  var linkCountLabel:UILabel?

  required init(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.chainTitleLabel = UILabel()
    self.linkCountLabel = UILabel()
    self.selectionStyle = .None
    self.separatorInset = UIEdgeInsetsZero
    self.contentView.addSubview(self.chainTitleLabel!)
    self.contentView.addSubview(self.linkCountLabel!)
  }

  // TODO lol figure out a non-shitty way to layout frames
  override func layoutSubviews() {
    super.layoutSubviews()
    self.contentView.layoutIfNeeded()
    self.chainTitleLabel!.frame = CGRectMake(20, 13, 200, 20)
    self.linkCountLabel!.frame = CGRectMake(340, 10, 30, 20)
  }

}
//
//  SwipeOptionView.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/23/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import Foundation
import UIKit

class SwipeOptionView: UIView {
  var optionsLabel: UILabel

  init() {
    self.optionsLabel = UILabel()
    self.optionsLabel.textColor = UIColor.whiteColor()
    self.optionsLabel.text = "\u{2699}"

    super.init(frame: CGRectZero)

    self.backgroundColor = UIColor.grayColor()
    self.addSubview(self.optionsLabel)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    let rect:CGRect = self.optionsLabel.textRectForBounds(self.bounds, limitedToNumberOfLines: 1)
    self.optionsLabel.frame = CGRectMake(
      self.bounds.size.width - 24 - rect.size.width,
      self.bounds.origin.y + (self.bounds.size.height - rect.size.height) / 2.0,
      self.bounds.size.width,
      rect.size.height
    )
  }
}
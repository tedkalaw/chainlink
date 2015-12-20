//
//  SwipeCounterView.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/20/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import Foundation
import UIKit

/**
 This class is meant to show up underneath a ChainViewCellDelegate when they
 are swipe to the right to give feedback on how many links have been created for
 a given chain. Eventually, this should be able to show us how much work there is
 left to do
*/
class SwipeCounterView : UIView {
  // TODO figure out if defaults need to be set like this
  var goalNumber: Int = 1
  var totalForPeriod: Int = 1 {
    didSet {
      self.totalCountLabel.text = String(format: "%d / %d", arguments:[ totalForPeriod, goalNumber])
    }
  }

  var totalCountLabel: UILabel

  init() {
    self.totalCountLabel = UILabel()
    self.totalCountLabel.textColor = UIColor.blackColor()

    super.init(frame: CGRectZero)
    self.addSubview(self.totalCountLabel)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    let rect:CGRect = self.totalCountLabel.textRectForBounds(self.bounds, limitedToNumberOfLines: 1)
    self.totalCountLabel.frame = CGRectMake(
      self.bounds.origin.x + 10,
      self.bounds.origin.y + (self.bounds.size.height - rect.size.height) / 2.0,
      self.bounds.size.width,
      rect.size.height
    )
  }

}
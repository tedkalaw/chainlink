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

class ChainView: UIView {
  var testLabel: UILabel

  required override init(frame:CGRect) {
    let testLabel:UILabel = UILabel()
    testLabel.text = "Chainlink"
    testLabel.textAlignment = NSTextAlignment.Center
    self.testLabel = testLabel

    super.init(frame:frame)
    self.backgroundColor = UIColor.whiteColor()
    self.addSubview(self.testLabel);
  }

  override func layoutSubviews() {
    self.testLabel.frame = CGRectMake(0, 0, self.bounds.width, 25)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("idc about nscoding")
  }

}

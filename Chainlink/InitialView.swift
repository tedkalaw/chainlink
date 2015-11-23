//
//  InitialView.swift
//  Chainlink
//
//  Created by Ted Kalaw on 11/22/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import UIKit

class InitialView: UIView {

  var titleLabel: UILabel
  var goButton: UIButton
  var settingsButton: UIButton

  required override init(frame: CGRect) {
    let titleLabel:UILabel = UILabel()
    titleLabel.text = "Chainlink"
    titleLabel.textAlignment = NSTextAlignment.Center
    self.titleLabel = titleLabel

    let goButton:UIButton = UIButton(type: UIButtonType.RoundedRect)
    goButton.setTitle("GO", forState: UIControlState.Normal)
    goButton.layer.cornerRadius = 5
    goButton.layer.borderWidth = 1
    goButton.layer.borderColor = UIColor.blackColor().CGColor
    self.goButton = goButton

    let settingsButton:UIButton = UIButton(type: UIButtonType.RoundedRect)
    settingsButton.setTitle("Settings", forState: UIControlState.Normal)
    settingsButton.layer.cornerRadius = 5
    settingsButton.layer.borderWidth = 1
    settingsButton.layer.borderColor = UIColor.blackColor().CGColor
    self.settingsButton = settingsButton

    super.init(frame: frame)
    self.backgroundColor = UIColor.whiteColor()
    self.addSubview(titleLabel)
    self.addSubview(goButton)
    self.addSubview(settingsButton)
  }

  override func layoutSubviews() {
    self.titleLabel.frame = CGRectMake(0, 50, self.bounds.width, 25)

    self.goButton.frame = CGRectMake(self.bounds.width / 4, 250, self.bounds.width / 2, 50)

    self.settingsButton.frame = CGRectMake(self.bounds.width / 4, 300 + 20, self.bounds.width / 2, 50)
  }

  // IDGAF
  required init?(coder aDecoder: NSCoder) {
      fatalError("idc about nscoding")
  }

}

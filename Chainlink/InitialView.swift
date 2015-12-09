//
//  InitialView.swift
//  Chainlink
//
//  Created by Ted Kalaw on 11/22/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import UIKit

protocol InitialViewDelegate {
  func handleGoButtonPress();
}

class InitialView: UIView {

  var titleLabel: UILabel
  var birthdayLabel: UILabel
  var goButton: UIButton
  var settingsButton: UIButton
  var delegate: InitialViewDelegate?

  required override init(frame: CGRect) {
    let titleLabel:UILabel = UILabel()
    titleLabel.text = "Chainlink"
    titleLabel.textAlignment = NSTextAlignment.Center
    self.titleLabel = titleLabel

    let birthdayLabel:UILabel = UILabel()
    birthdayLabel.textAlignment = .Center
    self.birthdayLabel = birthdayLabel

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

    self.birthdayLabel.text = String(
      format:"Days 'til birthday: %d",
      self.getDaysTilBirthday()
    )
    self.backgroundColor = UIColor.whiteColor()
    self.addSubview(self.titleLabel)
    self.addSubview(self.goButton)
    self.addSubview(self.settingsButton)
    self.addSubview(self.birthdayLabel)

    self.goButton.addTarget(self, action: "testFunc:", forControlEvents: UIControlEvents.TouchUpInside)
  }

  override func layoutSubviews() {
    self.titleLabel.frame = CGRectMake(0, 50, self.bounds.width, 25)
    self.birthdayLabel.frame = CGRectMake(0, 75, self.bounds.width, 25)

    self.goButton.frame = CGRectMake(self.bounds.width / 4, 250, self.bounds.width / 2, 50)

    self.settingsButton.frame = CGRectMake(self.bounds.width / 4, 300 + 20, self.bounds.width / 2, 50)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("idc about nscoding")
  }

  func testFunc(sender:UIButton!) {
    self.delegate?.handleGoButtonPress()
  }

  private func getBirthdayDate() -> NSDate {
    let dateFormatter = NSDateFormatter()
    let locale = NSLocale(localeIdentifier: "en_US_POSIX")

    dateFormatter.locale = locale
    dateFormatter.dateFormat = "MM-dd-yyyy"

    return dateFormatter.dateFromString("12-13-2015")!
  }

  private func getDaysTilBirthday() -> Int {
    let calendar = NSCalendar.currentCalendar()

    let components = calendar.components(
      [.Day],
      fromDate: NSDate(),
      toDate: self.getBirthdayDate(),
      options: []
    )

    return components.day
  }

}

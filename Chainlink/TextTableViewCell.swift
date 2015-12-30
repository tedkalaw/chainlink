//
//  TextTableViewCell.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/29/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import Foundation
import UIKit

class TextTableViewCell: UITableViewCell, UITextFieldDelegate {

  var label: UITextField
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    let label = UITextField(frame: CGRect.null)
    label.textColor = UIColor.blackColor()
    label.font = UIFont.systemFontOfSize(16)
    label.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
    self.label = label

    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.label.delegate = self
    addSubview(self.label)
  }

  let leftMarginForLabel: CGFloat = 15.0

  override func layoutSubviews() {
    super.layoutSubviews()
    label.frame = CGRect(
      x: leftMarginForLabel,
      y: 0,
      width: bounds.size.width - leftMarginForLabel,
      height: bounds.size.height
    )
  }
}
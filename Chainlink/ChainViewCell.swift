//
//  ChainViewCell.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/18/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import UIKit
import QuartzCore

protocol ChainViewCellDelegate {
  func handleAddLink(chain:ChainModel) -> ChainModel
}

class ChainViewCell: UITableViewCell {

  var chain:ChainModel? {
    didSet {
      self.chainTitleLabel?.text = chain!.title
      self.linkCountLabel?.text = String(chain!.links.count)
      self.layoutIfNeeded()
    }
  }

  var chainTitleLabel:UILabel?
  var linkCountLabel:UILabel?
  var delegate:ChainViewCellDelegate?
  var originalCenter:CGPoint = CGPoint()
  var shouldIncrement:Bool = false

  required init(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.separatorInset = UIEdgeInsetsZero
    self.layoutMargins = UIEdgeInsetsZero
    self.selectionStyle = .None

    self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

    self.chainTitleLabel = UILabel()
    self.linkCountLabel = UILabel()

    self.contentView.addSubview(self.chainTitleLabel!)
    self.contentView.addSubview(self.linkCountLabel!)

    let recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
    recognizer.delegate = self
    self.contentView.addGestureRecognizer(recognizer)

  }

  // TODO lol figure out a non-shitty way to layout frames
  override func layoutSubviews() {
    super.layoutSubviews()
    self.contentView.layoutIfNeeded()
    self.chainTitleLabel!.frame = CGRectMake(20, 12, 200, 20)
    self.linkCountLabel!.frame = CGRectMake(330, 12, 30, 20)
  }

  func handlePan(recognizer: UIPanGestureRecognizer) {
    if recognizer.state == .Began {
      // when the gesture begins, record the current center location
      self.originalCenter = center
    }

    if (recognizer.state == .Changed) {
      let translation = recognizer.translationInView(self)

      if (translation.x < 0) {
        // don't support swiping to the left right now
        return
      }

      center = CGPointMake(originalCenter.x + translation.x, originalCenter.y)
      // has the user dragged the item far enough
      self.shouldIncrement = frame.origin.x > frame.size.width / 8.0
    }

    if (recognizer.state == .Ended) {
      let originalFrame = CGRect(x: 0, y: frame.origin.y,
        width: bounds.size.width, height: bounds.size.height)
      if (shouldIncrement) {
        self.addLink()
      }
      // snap back to original location
      UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
    }
  }

  override func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }

  private func addLink() -> Void {
    self.chain = self.delegate?.handleAddLink(self.chain!)
  }
}
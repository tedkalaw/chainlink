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
  var settingsButton:UIButton?
  var myContentView:UITableViewCell!

  required init(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.separatorInset = UIEdgeInsetsZero
    self.layoutMargins = UIEdgeInsetsZero
    self.selectionStyle = .None

    self.chainTitleLabel = UILabel()
    self.linkCountLabel = UILabel()

    self.myContentView = UITableViewCell()
    self.myContentView!.addSubview(self.chainTitleLabel!)
    self.myContentView!.addSubview(self.linkCountLabel!)
    self.myContentView!.backgroundColor = UIColor.redColor()
    self.myContentView!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

    let recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
    recognizer.delegate = self
    self.contentView.addSubview(self.myContentView!)
    self.contentView.addGestureRecognizer(recognizer)
    self.contentView.backgroundColor = UIColor.blackColor()
  }

  // TODO lol figure out a non-shitty way to layout frames
  override func layoutSubviews() {
    super.layoutSubviews()
    self.contentView.layoutIfNeeded()
    self.chainTitleLabel!.frame = CGRectMake(20, 12, 200, 20)
    self.linkCountLabel!.frame = CGRectMake(330, 12, 30, 20)
    self.myContentView!.frame = self.bounds
  }

  func handlePan(recognizer: UIPanGestureRecognizer) {
    if recognizer.state == .Began {
      // when the gesture begins, record the current center location
      self.originalCenter = self.myContentView!.center
    }

    if (recognizer.state == .Changed) {
      let translation = recognizer.translationInView(self)

      if (translation.x < 0) {
        // don't support swiping to the left right now
        return
      }

      self.myContentView!.center = CGPointMake(originalCenter.x + translation.x, originalCenter.y)
      // has the user dragged the item far enough
      self.shouldIncrement = self.myContentView!.frame.origin.x > frame.size.width / 8.0
    }

    if (recognizer.state == .Ended) {
      let originalFrame = self.bounds
      if (shouldIncrement) {
        self.addLink()
      }
      // snap back to original location
      UIView.animateWithDuration(0.2, animations: {self.myContentView!.frame = originalFrame})
      self.shouldIncrement = false
    }
  }

  override func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }

  override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
    let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer
    if (panGestureRecognizer == nil) {
      return false
    }

    let translation = panGestureRecognizer!.translationInView(superview!)
    if fabs(translation.x) > fabs(translation.y) {
      return true
    }
    return false
  }

  private func addLink() -> Void {
    self.chain = self.delegate?.handleAddLink(self.chain!)
  }
}
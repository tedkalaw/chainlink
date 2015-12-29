//
//  ChainViewCell.swift
//  Chainlink
//
//  Created by Ted Kalaw on 12/18/15.
//  Copyright © 2015 Ted Kalaw. All rights reserved.
//

import UIKit
import QuartzCore

enum ActiveView {
  case LeftView
  case RightView
  case None
}

protocol ChainViewCellDelegate {
  func handleAddLink(chain: Chain) -> Chain
  func handleSelectChain(chain: Chain) -> Void
  func handleSelectChainEdit(chain: Chain) -> Void
}

class ChainViewCell: UITableViewCell {

  var chain: Chain? {
    didSet {
      self.chainTitleLabel?.text = chain!.name
      self.links = chain!.getTodaysLinks()
      self.linkCountLabel?.text = String(self.links.count)
      self.counterView.totalForPeriod = self.links.count
      self.layoutIfNeeded()
    }
  }

  var links: [Link]

  var chainTitleLabel:UILabel?
  var linkCountLabel:UILabel?
  var delegate:ChainViewCellDelegate?
  var originalCenter:CGPoint = CGPoint()
  var shouldIncrement:Bool = false
  var myContentView:UITableViewCell!
  var counterView:SwipeCounterView!
  var optionsView:SwipeOptionView!
  var activeView:ActiveView

  var topViewLeftEdge:CGPoint = CGPoint()
  var isRightViewOpen:Bool = false

  required init(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    self.activeView = .None
    self.links = []
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.separatorInset = UIEdgeInsetsZero
    self.layoutMargins = UIEdgeInsetsZero
    self.selectionStyle = .None

    self.chainTitleLabel = UILabel()
    self.linkCountLabel = UILabel()
    self.counterView = SwipeCounterView()
    self.optionsView = SwipeOptionView()

    self.myContentView = UITableViewCell()
    self.myContentView!.addSubview(self.chainTitleLabel!)
    self.myContentView!.addSubview(self.linkCountLabel!)
    self.myContentView!.backgroundColor = UIColor.whiteColor()
    self.myContentView!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

    let recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
    recognizer.delegate = self

    let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
    tapRecognizer.delegate = self

    let optionsTapRecognizer = UITapGestureRecognizer(
      target: self,
      action: "handleTapOptions:"
    )
    optionsTapRecognizer.delegate = self

    self.contentView.addSubview(self.optionsView)
    self.contentView.addSubview(self.counterView)
    self.contentView.addSubview(self.myContentView!)
    self.contentView.addGestureRecognizer(recognizer)
    self.myContentView!.addGestureRecognizer(tapRecognizer)
    self.optionsView.addGestureRecognizer(optionsTapRecognizer)
  }

  // TODO lol figure out a non-shitty way to layout frames
  override func layoutSubviews() {
    super.layoutSubviews()
    self.contentView.layoutIfNeeded()
    self.chainTitleLabel!.frame = CGRectMake(20, 12, 200, 20)
    self.linkCountLabel!.frame = CGRectMake(330, 12, 30, 20)
    self.myContentView!.frame = self.bounds
    self.counterView.frame = self.bounds
    self.optionsView.frame = self.bounds
  }

  func handlePan(recognizer: UIPanGestureRecognizer) {
    if recognizer.state == .Began {
      // When the gesture begins, record the current center location
      self.originalCenter = self.myContentView!.center
    }

    if (recognizer.state == .Changed) {
      let translation = recognizer.translationInView(self)
      if (translation.x < 0) {
        self.activeView = .RightView
        self.handleLeftSwipeChanged(recognizer)
      } else {
        if (self.activeView == .RightView && self.isRightViewOpen) {
          self.handleSwipeRightWithRightViewOpen(recognizer)
        } else {
          self.activeView = .LeftView
          self.handleSwipeRightChanged(recognizer)
        }
      }

      self.topViewLeftEdge = translation
    }

    if (recognizer.state == .Ended) {
      if (self.activeView == .LeftView) {
        if (self.isRightViewOpen) {
          self.closeRightView()
        } else {
          self.handleSwipeRightEnded()
        }
      } else if (self.activeView == .RightView) {
        if (self.isRightViewOpen && topViewLeftEdge.x < self.originalCenter.x) {
          // TODO: Make swiping right actually make this damn thing close
          //          self.closeRightView()
        } else {
          self.handleLeftSwipeEnded()
        }
      }
      self.activeView = .None
      topViewLeftEdge = self.originalCenter
    }
  }

  func handleTap(recognizer: UITapGestureRecognizer) {
    if (self.isRightViewOpen) {
      self.closeRightView()
    } else {
      self.delegate?.handleSelectChain(self.chain!)
    }
  }

  func handleTapOptions(recognizer: UITapGestureRecognizer) {
    self.closeRightView()
    self.delegate?.handleSelectChainEdit(self.chain!)
  }

  override func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return false
  }

  override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
    let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer

    if (panGestureRecognizer == nil) {
      return true
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

  /**
   In this view, swiping right is used to quickly add a link
   */
  private func handleSwipeRightChanged(recognizer: UIPanGestureRecognizer) -> Void {
    // TODO: handle what happens if you swipe right while the options thing is open
    self.optionsView.hidden = true
    self.counterView.hidden = false

    let translation = recognizer.translationInView(self)

    let swipeDistance:CGFloat = frame.size.width / 5.0
    
    self.myContentView!.center = CGPointMake(
      originalCenter.x + translation.x,
      originalCenter.y
    )
    // has the user dragged the item far enough
    self.shouldIncrement = self.myContentView!.frame.origin.x > swipeDistance
    
    if (self.shouldIncrement) {
      self.counterView.totalForPeriod = self.links.count + 1
    } else {
      self.counterView.totalForPeriod = self.links.count
    }
    
    // TODO: Refactor this
    let distanceRatio = self.myContentView!.frame.origin.x / (swipeDistance + 30)
    let greenColor = UIColor.greenColor()
    var hue:CGFloat = 0
    var saturation:CGFloat = 0
    var brightness:CGFloat = 0
    var alpha:CGFloat = 0
    
    greenColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
    self.counterView.backgroundColor = self.myContentView!.frame.origin.x >= swipeDistance
      ? greenColor
      : UIColor(hue: hue * distanceRatio, saturation: saturation, brightness: brightness, alpha: alpha)
  }

  private func handleSwipeRightEnded() -> Void {
    let originalFrame = self.bounds
    if (self.shouldIncrement) {
      self.addLink()
    }
    // snap back to original location
    UIView.animateWithDuration(0.2, animations: {
      self.myContentView!.frame = originalFrame
      if (!self.shouldIncrement) {
        self.counterView!.backgroundColor = UIColor.redColor()
      }
    })
    self.shouldIncrement = false
  }

  private func handleLeftSwipeChanged(recognizer: UIPanGestureRecognizer) -> Void {
    self.counterView.hidden = true
    self.optionsView.hidden = false

    if (self.isRightViewOpen) {
      return
    }

    let maxSwipeDistance = frame.size.width / 5.0
    let translation = recognizer.translationInView(self)
    if (fabs(translation.x) < maxSwipeDistance) {
      self.myContentView!.center = CGPointMake(
        originalCenter.x + translation.x,
        originalCenter.y
      )
    } else {
      self.isRightViewOpen = true
    }
    // TODO: handle manual close swipe
  }

  private func handleSwipeRightWithRightViewOpen(recognizer: UIPanGestureRecognizer) -> Void {
    let translation = recognizer.translationInView(self)

    self.myContentView!.center = CGPointMake(
      originalCenter.x + translation.x,
      originalCenter.y
    )
  }

  private func handleSwipeRightEndedWithRightViewOpen() -> Void {
    self.closeRightView()
  }

  private func handleLeftSwipeEnded() -> Void {
    if (!self.isRightViewOpen) {
      self.closeRightView()
    }
  }

  private func closeRightView() -> Void {
    UIView.animateWithDuration(
      0.2,
      animations: {
        self.myContentView!.frame = self.bounds
      },
      completion: {
        (finished: Bool) in
        if (finished) {
          self.isRightViewOpen = false
        }
      }
    )
  }
}
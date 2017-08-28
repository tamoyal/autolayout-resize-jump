//
//  UIView+AutoLayoutHelpers.swift
//  AutolayoutResizeJump
//
//  Created by Anthony Amoyal on 8/28/17.
//  Copyright © 2017 0Base. All rights reserved.
//

import UIKit

extension UIView {
    func widthConstraint(v: UIView, w: CGFloat) {
        addConstraint(NSLayoutConstraint(
            item: v,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: w))
    }

    func heightConstraint(v: UIView, h: CGFloat) {
        addConstraint(NSLayoutConstraint(
            item: v,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: h))
    }

    func centerCenterConstraint(v: UIView) {
        addConstraint(NSLayoutConstraint(
            item: v,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1,
            constant: 0))
        addConstraint(NSLayoutConstraint(
            item: v,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1,
            constant: 0))
    }
}

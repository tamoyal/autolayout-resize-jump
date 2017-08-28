//
//  ViewController.swift
//  AutolayoutResizeJump
//
//  Created by Anthony Amoyal on 8/28/17.
//  Copyright © 2017 0Base. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var profileTagsView: ProfileTagsView = {
        let v = ProfileTagsView(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    lazy var someLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Some label"
        l.textColor = UIColor.white
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        view.backgroundColor = UIColor.black

        view.addSubview(profileTagsView)
        view.addSubview(someLabel)

        view.addConstraint(NSLayoutConstraint(
            item: profileTagsView,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1,
            constant: 28))

        view.addConstraint(NSLayoutConstraint(
            item: profileTagsView,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1,
            constant: -48))

        view.addConstraint(NSLayoutConstraint(
            item: someLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: profileTagsView,
            attribute: .bottom,
            multiplier: 1,
            constant: 12))

        view.addConstraint(NSLayoutConstraint(
            item: someLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1,
            constant: -48))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


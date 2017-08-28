//
//  ProfileTagsView.swift
//  AutolayoutResizeJump
//
//  Created by Anthony Amoyal on 8/28/17.
//  Copyright © 2017 0Base. All rights reserved.
//

import UIKit

class ProfileTagsView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let minimumInteritemSpacingForTags: CGFloat = 12.0
    let minimumLineSpacingForTags: CGFloat = 12.0
    var tagsCollectionViewHeightConstraint: NSLayoutConstraint!

    var selectedSection = "Dos"
    let tags = [
        "Uno": ["T1", "T2", "T3", "T4"],
        "Dos": ["T5", "T6", "T7", "T8", "T9", "T10", "T11", "T12", "T13", "T14"],
        "Tres": [],
        ]

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    lazy var tagsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = self.minimumInteritemSpacingForTags
        layout.minimumLineSpacing = self.minimumLineSpacingForTags

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    let cellId = "ProfileTagsTypeCell"
    let tagViewCellId = "TagViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(ProfileTagsTypeCell.self, forCellWithReuseIdentifier: cellId)
        tagsCollectionView.register(TagViewCell.self, forCellWithReuseIdentifier: tagViewCellId)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        tagsCollectionView.backgroundColor = UIColor.red

        addSubview(collectionView)
        addSubview(tagsCollectionView)

        tagsCollectionViewHeightConstraint = NSLayoutConstraint(
            item: tagsCollectionView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 200)
        addConstraint(tagsCollectionViewHeightConstraint)

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[collectionView(tagTypesHeight)]-24-[tagsCollectionView]-|",
            options: NSLayoutFormatOptions(),
            metrics: ["tagTypesHeight": ProfileTagsTypeCell.totalHeight],
            views: ["collectionView": collectionView, "tagsCollectionView": tagsCollectionView]
        ))

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[collectionView]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: ["collectionView": collectionView]
        ))

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[tagsCollectionView]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: ["tagsCollectionView": tagsCollectionView]
        ))
    }

    func selectItem(_ i: Int) {
        collectionView.selectItem(at: IndexPath(row: i, section: 0), animated: false, scrollPosition:  UICollectionViewScrollPosition())
        reloadTagsCollection()
    }

    func reloadTagsCollection() {
        tagsCollectionView.reloadData()
        tagsCollectionView.performBatchUpdates(nil, completion: nil)

        UIView.animate(withDuration: 0.5) {
            let h = self.tagsCollectionView.collectionViewLayout.collectionViewContentSize.height
            self.tagsCollectionViewHeightConstraint.constant = h
            self.layoutIfNeeded()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagsCollectionView {
            return tags[selectedSection]?.count ?? 0
        } else {
            return 3
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            selectedSection = "Uno"
        } else if indexPath.row == 1 {
            selectedSection = "Dos"
        } else if indexPath.row == 2 {
            selectedSection = "Tres"
        }
        reloadTagsCollection()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == tagsCollectionView {
            return minimumInteritemSpacingForTags
        } else {
            return 0.0
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == tagsCollectionView {
            return minimumLineSpacingForTags
        } else {
            return 0.0
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tagsCollectionView {
            let text = tags[selectedSection]?[indexPath.row]
            if text == nil {
                return CGSize.zero
            } else {
                let h: CGFloat = 36.0
                return CGSize(width: 100.0, height: h)
            }
        } else {
            return CGSize(width: self.frame.width / 3.0, height: ProfileTagsTypeCell.totalHeight)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tagsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagViewCellId, for: indexPath) as! TagViewCell
            cell.text = tags[selectedSection]?[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileTagsTypeCell
            if indexPath.row == 0 {
                cell.text = "Uno"
            } else if indexPath.row == 1 {
                cell.text = "Dos"
            } else {
                cell.text = "Tres"
            }
            return cell
        }
    }
}

class ProfileTagsTypeCell: UICollectionViewCell {
    let iconBorderWidth: CGFloat = 60.0
    let iconViewWidth: CGFloat = 72.0
    static let totalHeight: CGFloat = 100.0

    lazy var iconView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    lazy var borderView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        v.layer.borderWidth = 1.0
        v.layer.cornerRadius = self.iconBorderWidth / 2.0
        return v
    }()

    lazy var textLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    var text: String? {
        didSet {
            textLabel.text = text
        }
    }

    override var isSelected: Bool {
        didSet {
            setSelectedState()
        }
    }

    func setSelectedState() {
        borderView.layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.lightGray.cgColor
        textLabel.textColor = isSelected ? UIColor.white : UIColor.lightGray
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setSelectedState()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(iconView)
        widthConstraint(v: iconView, w: iconViewWidth)
        heightConstraint(v: iconView, h: iconViewWidth)

        iconView.addSubview(borderView)
        iconView.widthConstraint(v: borderView, w: iconBorderWidth)
        iconView.heightConstraint(v: borderView, h: iconBorderWidth)
        iconView.centerCenterConstraint(v: borderView)

        addSubview(textLabel)

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[iconView(iconViewWidth)]", options: NSLayoutFormatOptions(), metrics: ["iconViewWidth": iconViewWidth], views: ["iconView" : iconView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[textLabel(14)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["textLabel": textLabel]))

        addConstraint(NSLayoutConstraint(
            item: iconView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1,
            constant: 0))

        addConstraint(NSLayoutConstraint(
            item: textLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1,
            constant: 0))
    }
}

class TagViewCell: UICollectionViewCell {
    lazy var textLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor.white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    var text: String? {
        didSet {
            textLabel.text = text
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.backgroundColor = UIColor.gray
        addSubview(textLabel)
        centerCenterConstraint(v: textLabel)
    }
}

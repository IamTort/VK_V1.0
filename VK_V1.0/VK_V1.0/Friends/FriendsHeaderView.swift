// FriendsHeaderView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Компонент кастомного вью
class FriendsHeaderView: UIView {
    var view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 35))

    override func awakeFromNib() {
        super.awakeFromNib()
        view.backgroundColor = .blue
        addSubview(view)
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
         // Drawing code
     }
     */
}

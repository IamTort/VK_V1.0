// FriendsHeaderView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомный хэдэр
final class FriendsHeaderView: UIView {
    // MARK: - Private enum

    private enum Constants {
        static let colorName = "tiffanyColor"
    }

    // MARK: - Private Visual Components

    private let charLabel: UILabel!
    private let backView: UIView!

    // MARK: - Private Properties

    private var text: String?

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        backView.frame = bounds
        charLabel.frame = bounds
        charLabel.frame.origin.x += 20
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        charLabel = UILabel()
        backView = UIView()
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aCoder: NSCoder) {
        charLabel = UILabel()
        backView = UIView()
        super.init(coder: aCoder)
        setupView()
    }

    // MARK: - Public Methods

    func configureText(text: String) {
        charLabel.text = text
    }

    // MARK: - Private Methods

    private func setupView() {
        backView.backgroundColor = UIColor(named: Constants.colorName)
        backView.layer.opacity = 0.5
        addSubview(backView)
        backView.addSubview(charLabel)
    }
}

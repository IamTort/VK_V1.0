// TextButtonDelegate.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol TextButtonDelegate: AnyObject {
    func didTappedButton(cell: TextTableViewCell)
}

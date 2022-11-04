// GradientView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью для отображения градиента
final class GradientView: UIView {
    // MARK: - Private property

    private var gradientLayer: CAGradientLayer? {
        layer as? CAGradientLayer
    }

    @IBInspectable private var startColor: UIColor = .blue {
        didSet {
            gradientLayer?.colors = [startColor.cgColor, endColor.cgColor]
        }
    }

    @IBInspectable private var endColor: UIColor = .green {
        didSet {
            updateColors()
        }
    }

    @IBInspectable private var startLocation: CGFloat = 0 {
        didSet {
            updateLocations()
        }
    }

    @IBInspectable private var endLocation: CGFloat = 1 {
        didSet {
            updateLocations()
        }
    }

    @IBInspectable private var startPoint: CGPoint = .zero {
        didSet {
            updateStartPoint()
        }
    }

    @IBInspectable private var endPoint: CGPoint = .init(x: 0, y: 1) {
        didSet {
            updateEndPoint()
        }
    }

    // MARK: - Public property

    override static var layerClass: AnyClass {
        CAGradientLayer.self
    }

    // MARK: - Private methods

    private func updateColors() {
        gradientLayer?.colors = [startColor.cgColor, endColor.cgColor]
    }

    private func updateStartPoint() {
        gradientLayer?.startPoint = startPoint
    }

    private func updateEndPoint() {
        gradientLayer?.endPoint = endPoint
    }

    private func updateLocations() {
        gradientLayer?.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
}

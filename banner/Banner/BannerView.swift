//
//  BannerView.swift
//  banner
//
//  Created by Amir on 24/08/2020.
//  Copyright © 2020 tech. All rights reserved.
//

import Foundation
import UIKit

public struct BannerStyle {
    public var backgroundColor: UIColor

    public init(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
    }
}

private let animationDuration: TimeInterval = 0.3
private let defaultAnchorY: CGFloat = 0.5
private let hiddenAnchorY: CGFloat = 1.5

public final class BannerView: UIView {
    private var contentView: UIView
    private var swipeIndicator: UIImageView
    private var style: BannerStyle
    private var action: (() -> Void)?

    public init(action: (() -> Void)? = nil, style: BannerStyle = BannerStyle(backgroundColor: .red)) {
        swipeIndicator = UIImageView(image: UIImage(named: "SiwipeIndicator"))
        contentView = UIView(frame: .zero)
        self.action = action
        self.style = style
        super.init(frame: .zero)

        setupUI()
        setupGestures()
    }

    public func setContent(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func setupUI() {
        addSubview(contentView)
        addSubview(swipeIndicator)

        backgroundColor = style.backgroundColor

        contentView.translatesAutoresizingMaskIntoConstraints = false
        swipeIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            swipeIndicator.heightAnchor.constraint(equalToConstant: 4),
            swipeIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            swipeIndicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: swipeIndicator.topAnchor, constant: -8)
        ])
    }

    @objc func show() {
        layer.anchorPoint.y = hiddenAnchorY
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: { [unowned self] in
                        self.layer.anchorPoint.y = defaultAnchorY
                        self.action?()
        })
    }

    @objc func dismiss() {
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: { [unowned self] in
            self.layer.anchorPoint.y = hiddenAnchorY
        }) { [unowned self] _ in
            self.layer.anchorPoint.y = defaultAnchorY
            self.removeFromSuperview()
        }
    }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(dismiss))
        addGestureRecognizer(tapGesture)

        let swipeGesture = UISwipeGestureRecognizer()
        swipeGesture.addTarget(self, action: #selector(dismiss))
        swipeGesture.direction = .up
        addGestureRecognizer(swipeGesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

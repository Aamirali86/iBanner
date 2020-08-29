//
//  BannerView.swift
//  banner
//
//  Created by Amir on 24/08/2020.
//  Copyright © 2020 tech. All rights reserved.
//

import Foundation
import UIKit

private let animationDuration: TimeInterval = 0.3
private let defaultAnchorY: CGFloat = 0.5
private let hiddenAnchorY: CGFloat = 1.5

public final class BannerView: UIView {
    private var contentView: UIView
    private var swipeIndicator: UIImageView
    private var message: String

    public init(_ message: String) {
        swipeIndicator = UIImageView(image: UIImage(named: "SiwipeIndicator"))
        contentView = UIView(frame: .zero)
        self.message = message
        super.init(frame: .zero)

        setupUI()
        setupGestures()
        if BannerConfiguration.shared.bannerType != .custom {
            setupContent()
        }
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

        backgroundColor = BannerConfiguration.shared.bannerType.backgroundColor

        contentView.translatesAutoresizingMaskIntoConstraints = false
        swipeIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            swipeIndicator.heightAnchor.constraint(equalToConstant: 4),
            swipeIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            swipeIndicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: swipeIndicator.topAnchor, constant: -8)
        ])
    }

    private func setupContent() {
        func makeSymbol() -> UIImageView {
            let imageView = UIImageView(image: BannerConfiguration.shared.bannerType.icon)
            imageView.contentMode = .scaleAspectFit
            imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = .white
            return imageView
        }

        func makeMessage() -> UILabel {
            let label = UILabel()
            label.text = message
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.textColor = BannerConfiguration.shared.bannerType.textColor
            label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
            return label
        }

        func makeContent() -> UIStackView {
            let symbol = makeSymbol()
            symbol.setContentHuggingPriority(.defaultHigh, for: .horizontal)

            let stackView = UIStackView(arrangedSubviews: [symbol, makeMessage()])
            stackView.distribution = .fillProportionally
            stackView.axis = .horizontal
            stackView.alignment = .top
            stackView.spacing = 12
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }

        setContent(makeContent())
    }

    @objc func show() {
        layer.anchorPoint.y = hiddenAnchorY
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.layer.anchorPoint.y = defaultAnchorY
                        BannerConfiguration.shared.dismissAction?()
            }, completion: { _ in
                if BannerConfiguration.shared.autoDismiss {
                    DispatchQueue.main.asyncAfter(deadline: .now() + BannerConfiguration.shared.autoDismissDelay) {
                        self.dismiss()
                    }
                }
        })
    }

    @objc func dismiss() {
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
            self.layer.anchorPoint.y = hiddenAnchorY
        }) { _ in
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

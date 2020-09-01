//
//  Extension.swift
//  banner
//
//  Created by Amir on 25/08/2020.
//  Copyright © 2020 tech. All rights reserved.
//

import UIKit

extension UIView {
    public func setBannerShadow() {
        setShadow(color: .shadow,
                  opacity: 1,
                  offset: CGSize(width: 0, height: 6.0),
                  radius: 24,
                  viewCornerRadius: 0)
    }

    public func setShadow(color: UIColor, opacity: Float, offset: CGSize = .zero, radius: CGFloat, viewCornerRadius: CGFloat = 0.0) {
        if viewCornerRadius > 0 {
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: viewCornerRadius).cgPath
        }

        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
}

extension UIColor {
    /// #C3CCD2, opacity 24%
    static let shadow = #colorLiteral(red: 0.18, green: 0.18, blue: 0.18, alpha: 0.2446990352)

    /// #41C977
    static let green = #colorLiteral(red: 0.2549019608, green: 0.7882352941, blue: 0.4666666667, alpha: 1)

    /// #ED9E37
    static let orange = #colorLiteral(red: 0.9294117647, green: 0.6196078431, blue: 0.2156862745, alpha: 1)

    /// #E25148
    static let red = #colorLiteral(red: 0.8862745098, green: 0.3176470588, blue: 0.2823529412, alpha: 1)

    /// #5697D3
    static let blue = #colorLiteral(red: 0.2329987586, green: 0.6000669003, blue: 0.8483656645, alpha: 1)
}

public typealias Content = ((BannerView) -> Void)?
extension UIViewController {
    private var bannerPresenter: UIViewController {
        func findRootPresenter(_ viewController: UIViewController, lastPresenter: UIViewController) -> UIViewController {

            guard let parent = viewController.parent else {
                return lastPresenter
            }

            return findRootPresenter(parent, lastPresenter: parent.takesOverBannerPresentation ? parent : lastPresenter)
        }

        return findRootPresenter(self, lastPresenter: self)
    }

    private func dismissAllBanners() {
        bannerPresenter.view.subviews.forEach { subView in
            guard subView is BannerView else { return }
            subView.removeFromSuperview()
        }
    }

    @objc var takesOverBannerPresentation: Bool {
        return false
    }

    public func presentBanner(message: String) {
        presentBanner(message, contentViewSetupHandler: nil)
    }
    
    public func presentBanner(_ message: String? = nil, contentViewSetupHandler: Content) {
        if let _ = contentViewSetupHandler {
            BannerConfiguration.shared.bannerType = .custom
        }
        
        let banner = BannerView(message ?? "")
        banner.setBannerShadow()
        bannerPresenter.dismissAllBanners()
        bannerPresenter.view.addSubview(banner)
        banner.show()

        banner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            banner.leadingAnchor.constraint(equalTo: bannerPresenter.view.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: bannerPresenter.view.trailingAnchor),
            banner.topAnchor.constraint(equalTo: bannerPresenter.view.topAnchor)
        ])

        contentViewSetupHandler?(banner)
    }
}

extension UINavigationController {
    @objc override var takesOverBannerPresentation: Bool {
        return true
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            setBackgroundImage(colorImage, for: forState)
        }
    }
}

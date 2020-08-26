//
//  Extension.swift
//  banner
//
//  Created by Amir on 25/08/2020.
//  Copyright © 2020 tech. All rights reserved.
//

import UIKit

extension UIView {
    /// Dark Long - For sheets covering items
    public func setSheetShadow() {
        setShadow(color: .shadow,
                  opacity: 1,
                  offset: CGSize(width: 0, height: 6.0),
                  radius: 30,
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
    /// #C3CCD2, alpha 20%
    static let shadow = #colorLiteral(red: 0.18, green: 0.18, blue: 0.18, alpha: 0.2)
    
    /// #41C977
    static let green = #colorLiteral(red: 0.2549019608, green: 0.7882352941, blue: 0.4666666667, alpha: 1)
    
    /// #ED9E37
    static let orange = #colorLiteral(red: 0.9294117647, green: 0.6196078431, blue: 0.2156862745, alpha: 1)
    
    /// #E25148
    static let red = #colorLiteral(red: 0.8862745098, green: 0.3176470588, blue: 0.2823529412, alpha: 1)
    
    /// #5697D3
    static let blue = #colorLiteral(red: 0.2329987586, green: 0.6000669003, blue: 0.8483656645, alpha: 1)
}

typealias Content = ((BannerView) -> Void)?
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

    @objc var takesOverBannerPresentation: Bool {
        return false
    }

    func presentBanner(message: String, contentViewSetupHandler: Content = nil) {
        if let _ = contentViewSetupHandler {
            BannerConfiguration.shared.bannerType = .custom
        }
        
        let banner = BannerView(message)
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

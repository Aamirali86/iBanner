//
//  ViewController.swift
//  banner
//
//  Created by Amir on 24/08/2020.
//  Copyright © 2020 tech. All rights reserved.
//

import UIKit
import iBanner

class ViewController: UIViewController {

    @IBOutlet private weak var dismissDelay: UITextField!
    @IBOutlet private weak var message: UITextField!
    @IBOutlet private weak var blue: UIButton!
    @IBOutlet private weak var green: UIButton!
    @IBOutlet private weak var orange: UIButton!
    @IBOutlet private weak var red: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefault()

        message.delegate = self
        dismissDelay.delegate = self
    }

    private func setupDefault() {
        greenTapped()
    }

    @IBAction func autoDismiss(_ sender: UISwitch) {
        BannerConfiguration.shared.autoDismiss = sender.isOn
        dismissDelay.isEnabled = sender.isOn
    }

    @IBAction private func blueTapped() {
        BannerConfiguration.shared.bannerType = .info
        blue.backgroundColor = #colorLiteral(red: 0.2329987586, green: 0.6000669003, blue: 0.8483656645, alpha: 1)
        green.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.7882352941, blue: 0.4666666667, alpha: 0.5)
        orange.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.6196078431, blue: 0.2156862745, alpha: 0.5)
        red.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0.3176470588, blue: 0.2823529412, alpha: 0.5)
    }

    @IBAction private func greenTapped() {
        BannerConfiguration.shared.bannerType = .success
        blue.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.6, blue: 0.8470588235, alpha: 0.5)
        green.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.7882352941, blue: 0.4666666667, alpha: 1)
        orange.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.6196078431, blue: 0.2156862745, alpha: 0.5)
        red.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0.3176470588, blue: 0.2823529412, alpha: 0.5)
    }

    @IBAction private func orangeTapped() {
        BannerConfiguration.shared.bannerType = .warning
        blue.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.6, blue: 0.8470588235, alpha: 0.5)
        green.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.7882352941, blue: 0.4666666667, alpha: 0.5)
        orange.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.6196078431, blue: 0.2156862745, alpha: 1)
        red.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0.3176470588, blue: 0.2823529412, alpha: 0.5)
    }

    @IBAction private func redTapped() {
        BannerConfiguration.shared.bannerType = .danger
        blue.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.6, blue: 0.8470588235, alpha: 0.5)
        green.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.7882352941, blue: 0.4666666667, alpha: 0.5)
        orange.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.6196078431, blue: 0.2156862745, alpha: 0.5)
        red.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0.3176470588, blue: 0.2823529412, alpha: 1)
    }

    @IBAction private func showBanner() {
        BannerConfiguration.shared.autoDismissDelay = Double(dismissDelay.text ?? "3") ?? 3
        if let message = message.text, !message.isEmpty {
            //presentBanner(message: message)
            presentBanner() { banner in
                guard let view = Bundle.main.loadNibNamed("CustomBanner", owner: self, options: nil)?.first as? UIView else { return }
                banner.setContent(view)
            }
        }
    }
}

extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

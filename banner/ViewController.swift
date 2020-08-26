//
//  ViewController.swift
//  banner
//
//  Created by Amir on 24/08/2020.
//  Copyright © 2020 tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = showButton()
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func showButton() -> UIButton {
        let button = UIButton()
        button.addTarget(self, action: #selector(showBanner), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }

    @objc func showBanner() {
        presentBanner(message: "Custom message")
    }
}

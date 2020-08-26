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
        presentBanner(action: {
            //some action
        }, contentViewSetupHandler: { banner in
            let stackView = makeContent()
            banner.setContent(stackView)
        })
    }

    private func makeContent() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [makeText(), makeText()])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }

    private func makeText() -> UILabel {
        let label = UILabel()
        label.text = "Empty banner"
        label.textColor = .white
        return label
    }
}

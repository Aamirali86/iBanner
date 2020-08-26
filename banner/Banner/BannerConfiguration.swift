//
//  BannerConfiguration.swift
//  banner
//
//  Created by Amir on 26/08/2020.
//  Copyright © 2020 tech. All rights reserved.
//

import Foundation

struct BannerConfiguration {
    public static var shared = BannerConfiguration()

    var autoDismiss: Bool = false
    var autoDismissDuration: TimeInterval = 3
    var bannerType: BannerType = .success
    var dismissAction: (() -> Void)?

    private init() {}

}

//
//  BannerConfiguration.swift
//  banner
//
//  Created by Amir on 26/08/2020.
//  Copyright © 2020 tech. All rights reserved.
//

import Foundation

public struct BannerConfiguration {
    public static var shared = BannerConfiguration()

    public var autoDismiss: Bool = true
    public var autoDismissDelay: TimeInterval = 3
    public var bannerType: BannerType = .info
    public var dismissAction: (() -> Void)?

    private init() {}

}

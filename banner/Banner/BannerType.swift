//
//  BannerType.swift
//  banner
//
//  Created by Amir on 26/08/2020.
//  Copyright © 2020 tech. All rights reserved.
//

import UIKit

public enum BannerType: Int {
    case success
    case danger
    case warning
    case info
    case custom
    
    var backgroundColor: UIColor {
        switch self {
        case .success:
            return .green
        case .danger:
            return .red
        case .info:
            return .blue
        case .warning:
            return .orange
        default:
            return .blue
        }
    }
    
    var textColor: UIColor {
        return .white
    }
    
    var icon: UIImage? {
        switch self {
        case .success:
            return UIImage(named: "success")
        case .danger:
            return UIImage(named: "danger")
        default:
            return UIImage(named: "info")
        }
    }
}

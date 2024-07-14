//
//  AppUtils.swift
//  SkinCareWidgetSample
//
//  Created by BTBP on 3/24/23.
//  Copyright © 2023 BrighTex Bio Photonics. All rights reserved.
//

import Foundation
import UIKit

internal class AppUtils{
    static let shared: AppUtils = AppUtils()
    let NotificationForLicenseExpirationInDays = 60
    var SWLicense_DaysToExpire = 0
    
    func getDeviceType() -> UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }
}
extension UIColor {
    static func rgb(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: redValue/255.0, green: greenValue/255.0, blue: blueValue/255.0, alpha: alpha)
    }
}

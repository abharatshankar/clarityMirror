//
//  AppConfigs.swift
//  SkinCareWidgetSample
//
//  Created by BTBP on 3/24/23.
//  Copyright © 2023 BrighTex Bio Photonics. All rights reserved.
//

import Foundation
import UIKit

class AppConfigs {
    static var shared : AppConfigs = AppConfigs()
    var backGroundColor : UIColor = UIColor.rgb(redValue: 51, greenValue: 51, blueValue: 51, alpha: 1)
    var isInstructionScreenDisplay : Bool = true
    var isAutoCapture : Bool = true
    var isGalleryOption : Bool = true
    var isFlipCamera : Bool = true
    var isCaptureButtonDisplayed : Bool = true
    var displayResults : Bool = true
    var resultsRightPane : Bool = true
    var isInstrClosed: Bool = false
}

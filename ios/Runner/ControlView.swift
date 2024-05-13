//Created by Kalavala Venkata Akhil
//Copyright © 2018 BrighTex Bio Photonics LLC. All rights reserved.

import Foundation
import UIKit
class ControlView : UIView{
    var configarray : [Bool] = [true,true,true,true]
    let isGallerySwitch : UISwitch = UISwitch()
    let isFlipSwitch : UISwitch = UISwitch()
    let isResultRightSideSwitch : UISwitch = UISwitch()
    let isInstructionScreenDisplaySwitch : UISwitch = UISwitch()
    
    let isGalleryLabel : UILabel = UILabel()
    let isFlipLabel : UILabel = UILabel()
    let isResultRightSideLabel : UILabel = UILabel()
    let isInstructionScreenDisplayLabel : UILabel = UILabel()
    var startButton = UIButton()
    let APIKey = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpGUI()
        addViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpGUI()
        addViews()
    }
    func setUpGUI(){
        isGalleryLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width * 0.6, height: self.frame.height * 0.1)
        isGallerySwitch.frame = CGRect(x: self.frame.width * 0.6, y: 0, width: self.frame.width * 0.5, height: self.frame.height * 0.1)
        isGalleryLabel.text = "Display_gallery"
        isGalleryLabel.textColor = UIColor.black
        isGalleryLabel.sizeToFit()
        isGalleryLabel.numberOfLines = 0
        isGallerySwitch.addTarget(self, action: #selector(switchConfig(_:)), for: .valueChanged)
        isGallerySwitch.tag = 0
        isFlipLabel.frame = CGRect(x: 0, y: self.frame.height * 0.1, width: self.frame.width * 0.6, height: self.frame.height * 0.1)
        isFlipSwitch.frame = CGRect(x: self.frame.width * 0.6, y:  self.frame.height * 0.1, width: self.frame.width * 0.5, height: self.frame.height * 0.1)
        isFlipSwitch.addTarget(self, action: #selector(switchConfig(_:)), for: .valueChanged)
        isFlipSwitch.tag = 1
        isResultRightSideLabel.frame = CGRect(x: 0, y:  self.frame.height * 0.2, width: self.frame.width * 0.6, height: self.frame.height * 0.1)
        isResultRightSideSwitch.frame = CGRect(x: self.frame.width * 0.6, y:  self.frame.height * 0.2, width: self.frame.width * 0.5, height: self.frame.height * 0.1)
        
        isResultRightSideSwitch.addTarget(self, action: #selector(switchConfig(_:)), for: .valueChanged)
        isResultRightSideSwitch.tag = 2
        
        isInstructionScreenDisplayLabel.frame = CGRect(x: 0, y:  self.frame.height * 0.3, width: self.frame.width * 0.6, height: self.frame.height * 0.1)
        isInstructionScreenDisplaySwitch.frame = CGRect(x: self.frame.width * 0.6, y:  self.frame.height * 0.3, width: self.frame.width * 0.5, height: self.frame.height * 0.1)
        
        isInstructionScreenDisplaySwitch.addTarget(self, action: #selector(switchConfig(_:)), for: .valueChanged)
        isInstructionScreenDisplaySwitch.tag = 3
        isResultRightSideLabel.text = "Display_Results_right_side"
        isResultRightSideLabel.textColor = UIColor.black
        isFlipLabel.text = "Display_Flip"
        isFlipLabel.textColor = UIColor.black
        isInstructionScreenDisplayLabel.text = "Display_Instructions"
        isInstructionScreenDisplayLabel.textColor = UIColor.black
        
        isGallerySwitch.setOn(true, animated: false)
        isFlipSwitch.setOn(true, animated: false)
        isResultRightSideSwitch.setOn(true, animated: false)
        isInstructionScreenDisplaySwitch.setOn(true, animated: false)
        isFlipLabel.sizeToFit()
        isFlipLabel.numberOfLines = 0
        
        isResultRightSideLabel.sizeToFit()
        isResultRightSideLabel.numberOfLines = 0
        
        isInstructionScreenDisplayLabel.sizeToFit()
        isInstructionScreenDisplayLabel.numberOfLines = 0
        APIKey.frame = CGRect(x: self.frame.width * 0.0, y: self.frame.height * 0.41, width: self.frame.width * 0.5, height: self.frame.height  * 0.08)
        APIKey.placeholder = "API Key"
        APIKey.layer.borderColor = UIColor.black.cgColor
        APIKey.layer.borderWidth = 1
        APIKey.center.x  = self.frame.width * 0.5
        APIKey.textColor = UIColor.black
        startButton.frame = CGRect(x: self.frame.width * 0.4, y: self.frame.height * 0.5, width: self.frame.width * 0.4, height: self.frame.height * 0.1)
        startButton.center.x = self.frame.width * 0.5
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        APIKey.text = "KROS-SV3L-EZVR-93V2"//(UserDefaults.standard.value(forKey: "API_KEY") as? String) ?? ""
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    @objc func switchConfig(_ sender : UISwitch){
        switch sender.tag {
        case 0:
            configarray[0] = sender.isOn
            
        case 1:
            configarray[1] = sender.isOn
            
        case 2:
            configarray[2] = sender.isOn
            
        case 3:
            configarray[3] = sender.isOn
        default:
            print("")
        }
    }
    func addViews(){
        self.addSubview(isGalleryLabel)
        self.addSubview(isGallerySwitch)
        self.addSubview(isFlipLabel)
        self.addSubview(isFlipSwitch)
        self.addSubview(isResultRightSideLabel)
        self.addSubview(isResultRightSideSwitch)
        self.addSubview(isInstructionScreenDisplayLabel)
        self.addSubview(isInstructionScreenDisplaySwitch)
        self.addSubview(startButton)
        self.addSubview(APIKey)
    }
}

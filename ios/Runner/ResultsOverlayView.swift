//Created by Kalavala Venkata Akhil
//Copyright © 2018 BrighTex Bio Photonics LLC. All rights reserved.

import Foundation
import UIKit
class ResultsOverLayControls : UIView{
    
    lazy var controlButton : UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var controlView :  UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    lazy var label1 : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Right Side"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var label2 : UILabel = {
        let label = UILabel()
        label.text = "Left Side"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
        
    }()
    lazy var selectSwitch : UISwitch = {
        let selSwitch = UISwitch()
        return selSwitch
    }()
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
        controlButton.frame = CGRect(x: self.frame.width * 0.15, y: self.frame.height * 0.5, width: self.frame.width * 0.08, height: self.frame.height * 0.5)
        controlButton.setImage(#imageLiteral(resourceName: "Settings Icon"), for: .normal)
        if UIDevice.current.userInterfaceIdiom == .phone{
            controlView.frame = CGRect(x: self.frame.width * 0.05, y: self.frame.height * 0.0  , width: self.frame.width * 0.9, height: self.frame.height * 0.5)
        }
        else{
            controlView.frame = CGRect(x: self.frame.width * 0.15, y: self.frame.height * 0.0  , width: self.frame.width * 0.71, height: self.frame.height * 0.5)
        }
        
        
        label1.frame = CGRect(x: 0, y: 0, width: controlView.frame.width * 0.35, height: controlView.frame.height )
        
        label2.frame = CGRect(x: controlView.frame.width * 0.6, y: 0, width: controlView.frame.width * 0.35, height: controlView.frame.height )
        
        selectSwitch.frame = CGRect(x: controlView.frame.width * 0.4, y: controlView.frame.height * 0.1, width: controlView.frame.width * 0.1, height: controlView.frame.height * 0.9)
        controlView.isHidden = true
    }
    
    func changePosition(isRight:Bool){
        if isRight{
            controlButton.frame = CGRect(x: self.frame.width * 0.78, y: self.frame.height * 0.5, width: self.frame.width * 0.08, height: self.frame.height * 0.5)
        }
        else{
            if UIDevice.current.userInterfaceIdiom == .phone{
                controlButton.frame = CGRect(x: self.frame.width * 0.05, y: self.frame.height * 0.5, width: self.frame.width * 0.08, height: self.frame.height * 0.5)
            }
            else{
                controlButton.frame = CGRect(x: self.frame.width * 0.15, y: self.frame.height * 0.5, width: self.frame.width * 0.08, height: self.frame.height * 0.5)
            }
        }
    }
    func addViews(){
        self.addSubview(controlButton)
        self.addSubview(controlView)
        controlView.addSubview(label1)
        controlView.addSubview(label2)
        controlView.addSubview(selectSwitch)
    }
}

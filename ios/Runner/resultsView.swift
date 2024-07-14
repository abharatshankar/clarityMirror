//
//  resultsView.swift
//  SkinCareWidget
//
//  Created by BTBPMiniMac on 5/25/18.
//  Copyright © 2018 btbp. All rights reserved.
//

import Foundation
import UIKit
public class ResultsView : UIView{
    
    var leftMenuView : LeftMenuView?
    var resultImageView : UIImageView?
    var bottomView : UIView?
    var resetView : UIButton?
    
    convenience init(result:GetTag,frame:CGRect) {
        self.init(frame: frame)
    }
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
    private func setUpGUI(){
        bottomView = UIView()
        bottomView?.frame = CGRect(x: 0, y: self.frame.height * 0.9, width: self.frame.width, height: self.frame.height * 0.1)
        if AppUtils.shared.getDeviceType() == .phone{
            leftMenuView = LeftMenuView(frame: CGRect(x: (self.frame.width) * 0.8, y: (self.frame.height) * 0.2, width: (self.frame.width) * 0.2, height: (self.frame.height) * 0.6))
            resultImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height * 0.9))
            resetView = UIButton(frame: CGRect(x: self.bottomView!.frame.width * 0.85, y: self.bottomView!.frame.height * 0.05, width: self.bottomView!.frame.width * 0.1, height: self.bottomView!.frame.height * 0.9))
            
        }
        else{
            leftMenuView = LeftMenuView(frame: CGRect(x: (self.frame.width) * 0.85, y: (self.frame.height) * 0.2, width: (self.frame.width) * 0.15, height: (self.frame.height) * 0.6))
            resultImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height * 0.9))
            resetView = UIButton(frame: CGRect(x: self.bottomView!.frame.width * 0.85, y: self.bottomView!.frame.height * 0.05, width: self.bottomView!.frame.width * 0.1, height: self.bottomView!.frame.height * 0.9))
            
        }
        
        leftMenuView?.delegate = self
        
        bottomView?.backgroundColor = .red//AppConfigs.shared.backGroundColor
        resetView?.setImage(UIImage(named: "Reset_icon.png", in: Bundle(for: ResultsView.self), compatibleWith: nil), for: .normal)
        resetView?.imageView?.contentMode = .scaleToFill
        resultImageView?.backgroundColor = .green//AppConfigs.shared.backGroundColor
    }
    private func addViews(){
        self.addSubview(resultImageView!)
        self.addSubview(leftMenuView!)
        self.bottomView?.addSubview(resetView!)
        self.addSubview(bottomView!)
    }
    func updateResultPosition(){
        if AppConfigs.shared.resultsRightPane {
            if AppUtils.shared.getDeviceType() == .phone{
                
                leftMenuView?.center.x = (self.frame.width) * 0.9
                resetView?.frame =  CGRect(x: self.bottomView!.frame.width * 0.85, y: self.bottomView!.frame.height * 0.05, width: self.bottomView!.frame.width * 0.1, height: self.bottomView!.frame.height * 0.9)
            }
            else{
                leftMenuView?.center.x = (self.frame.width) * 0.925
                resetView?.frame =  CGRect(x: self.bottomView!.frame.width * 0.85, y: self.bottomView!.frame.height * 0.05, width: self.bottomView!.frame.width * 0.1, height: self.bottomView!.frame.height * 0.9)
                
            }
            if #available(iOS 11.0, *) {
                self.leftMenuView?.bgView.clipsToBounds = true
                self.leftMenuView?.bgView.layer.cornerRadius = 10
                self.leftMenuView?.bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            } else {
                self.leftMenuView?.bgView.roundCorners([.topLeft,.bottomLeft], radius: 10)
                
            }
        }
        else{
            if AppUtils.shared.getDeviceType() == .phone{
                leftMenuView?.center.x = (self.frame.width) * 0.1
                resetView?.frame =  CGRect(x: self.bottomView!.frame.width * 0.05, y: self.bottomView!.frame.height * 0.05, width: self.bottomView!.frame.width * 0.1, height: self.bottomView!.frame.height * 0.9)
            }
            else{
                leftMenuView?.center.x = (self.frame.width) * 0.075
                resetView?.frame = CGRect(x: self.bottomView!.frame.width * 0.05, y: self.bottomView!.frame.height * 0.05, width: self.bottomView!.frame.width * 0.1, height: self.bottomView!.frame.height * 0.9)
                
            }
            
            if #available(iOS 11.0, *) {
                self.leftMenuView?.bgView.clipsToBounds = true
                self.leftMenuView?.bgView.layer.cornerRadius = 10
                self.leftMenuView?.bgView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            } else {
                self.leftMenuView?.bgView.roundCorners([.topRight,.bottomRight], radius: 10)
                
            }
        }
    }
}
extension ResultsView : resultImageDisplayClicked{
    func displayResultImage(_ image: String) {
        
        UIView.transition(with: self.resultImageView!,
                          duration:0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.resultImageView?.image = "".getUIImage(str:image) },
                          completion: nil)
        
        
        resultImageView?.contentMode = .scaleAspectFit
    }
}
extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.masksToBounds = true
        self.layer.mask = mask
    }
}
internal extension String{
    func replace(_ target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    func getUIImage(str:String) -> UIImage?{
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage
    }
}

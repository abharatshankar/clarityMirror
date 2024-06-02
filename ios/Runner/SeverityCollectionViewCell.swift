//
//  SkinConcernCollectionViewCell.swift
//  SkinCareWidget
//
//  Created by BTBPMiniMac on 5/24/18.
//  Copyright © 2018 btbp. All rights reserved.
//

import Foundation
//
//  SeverityCollectionViewCell.swift
//  DesignSamples
//
//  Created by BTBP Mini Mac on 10/12/17.
//  Copyright © 2017 BTBPMiniMac. All rights reserved.
//

import UIKit

internal class SeverityCollectionViewCell: UICollectionViewCell {
    let circleView = UIView()
    var circleLayer: CAShapeLayer! = nil
    var circleBgLayer: CAShapeLayer! = nil
    let severityScore = UILabel()
    let severityName = UILabel()
    let cellView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //        self.layer.borderWidth = 1.0
        //        self.layer.borderColor = UIColor.black.cgColor
        
        cellView.frame = CGRect(x: self.frame.width * 0.05, y: self.frame.height * 0.05, width: self.frame.width * 0.9, height: self.frame.height * 0.9)
        
        circleView.frame = CGRect(x: self.cellView.frame.width * 0, y: 0, width: self.cellView.frame.width , height:self.cellView.frame.height * 0.65)
        //        circleView.layer.borderColor = UIColor.blue.cgColor
        //        circleView.layer.borderWidth = 1.0
        print("cellView frame \(cellView.frame)")
        severityScore.frame = CGRect(x: 0, y: 0, width: (circleView.frame.width*0.5), height: CGFloat(circleView.frame.width*0.4))
        severityScore.center = CGPoint(x: circleView.frame.width * 0.5, y: circleView.frame.height * 0.55)
        severityScore.text = ""
        severityScore.textAlignment = .center
        severityScore.font = UIFont(name: "Avenir-Roman", size: 30)
        severityScore.textColor = .white
        severityName.frame = CGRect(x: self.cellView.frame.width * 0.02, y: self.cellView.frame.height*0.65, width: self.cellView.frame.width * 0.96, height: self.cellView.frame.height*0.35)
        severityName.textAlignment = .center
        severityName.font = UIFont(name: "Avenir-Roman", size: 12)
        severityName.text = "PORES"
        severityName.numberOfLines = 2
        severityName.adjustsFontSizeToFitWidth = true
        severityScore.adjustsFontSizeToFitWidth = true
        if UIDevice.current.userInterfaceIdiom == .phone{
            severityName.font = UIFont(name: "Avenir-Roman", size: 10)
            severityScore.font = UIFont(name: "Avenir-Roman", size: 10)
            
        }
        severityName.textColor = UIColor.rgb(redValue: 98, greenValue: 172, blueValue: 255, alpha: 1)
        //        cellView.layer.borderColor = UIColor.clear.cgColor
        //
        //        cellView.layer.borderWidth = 0
        cellView.addSubview(circleView)
        cellView.addSubview(severityScore)
        cellView.addSubview(severityName)
        self.addSubview(cellView)
    }
    func drwaCircleLayer(bgLayerWidth:CGFloat){
        
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: (self.circleView.bounds.width / 2.0), y: self.circleView.bounds.height * 0.55 ), radius: ((circleView.frame.width*0.2)), startAngle: CGFloat(-1.57079633), endAngle: CGFloat(4.71239), clockwise: true)
        circleBgLayer = CAShapeLayer()
        circleBgLayer.path = circlePath.cgPath
        circleBgLayer.fillColor = UIColor.clear.cgColor
        circleBgLayer.strokeColor = UIColor(red: 143/255, green: 144/255, blue: 145/255, alpha: 1).cgColor
        circleBgLayer.lineWidth = 4.0;
        circleBgLayer.strokeEnd = 1
        
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor(red: 176/255, green: 46/255, blue: 48/255, alpha: 1).cgColor
        circleLayer.strokeEnd = bgLayerWidth
        circleLayer.lineWidth = 4.0;
        
        self.circleView.layer.addSublayer(circleBgLayer)
        self.circleView.layer.addSublayer(circleLayer)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        //reset all the fields of cell
        self.cellView.backgroundColor = .clear
        self.cellView.layer.cornerRadius = 0.0
        self.cellView.layer.borderColor = UIColor.clear.cgColor
        self.cellView.layer.borderWidth = 0
        self.severityName.textColor = UIColor.rgb(redValue: 98, greenValue: 172, blueValue: 255, alpha: 1)
        self.severityScore.textColor = .white
        
    }
    //    override func setNeedsDisplay() {
    ////        cellView.frame = CGRect(x: self.cellView.frame.width * 0.05, y: self.cellView.frame.height * 0.05, width: self.cellView.frame.width * 0.9, height: self.cellView.frame.height * 0.9)
    ////        severityScore.frame = CGRect(x: 0, y: 0, width: (circleView.frame.width*0.5), height: CGFloat(circleView.frame.width*0.4))
    ////        severityScore.center = CGPoint(x: circleView.frame.width * 0.5, y: circleView.frame.height * 0.4)
    ////          severityName.frame = CGRect(x: 0, y: self.cellView.frame.height*0.7, width: self.cellView.frame.width, height: self.cellView.frame.height*0.2)
    //    }
    override var isSelected: Bool {
        didSet {
            DispatchQueue.main.async {
                self.cellView.backgroundColor =  !self.isSelected ? .clear : UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.1)
                self.cellView.layer.cornerRadius = !self.isSelected ?  0.0 : 10.0
                self.cellView.layer.borderColor = !self.isSelected ? UIColor.clear.cgColor : UIColor.white.cgColor
                self.cellView.layer.borderWidth = !self.isSelected ? 0 : 2
                //                self.severityName.textColor = !self.isSelected ? .white : UIColor(red: 176/255, green: 46/255, blue: 48/255, alpha: 1)
                //                self.severityScore.textColor = !self.isSelected ? .white : UIColor(red: 176/255, green: 46/255, blue: 48/255, alpha: 1)
            }
        }
    }
}

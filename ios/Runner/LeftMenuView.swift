//
//  LeftMenuView.swift
//  BTBPLive
//
//  Created by Ashutosh Chhibbar on 10/14/17.
//  Copyright © 2017 Mac5Dev1. All rights reserved.
//

import UIKit
protocol resultImageDisplayClicked{
    func displayResultImage(_ image:String)
}
internal class LeftMenuView: UIView {
    
    internal  var initialSeverity:CGFloat = 0.0
    private let severityCellReuseIdentifier = "severityCollectionCell"
    internal let severityFlowLayout = UICollectionViewFlowLayout()
    internal var severityCollectionView: UICollectionView?
    internal var bgView = UIView()
    internal var deafaultTags = [TagResult]()
    internal var itemCount : Int = 0 {
        didSet{
            changeBounds()
        }
    }
    internal var cellHeight : CGFloat = 0
    internal var cellWidth : CGFloat = 0
    internal var utils = AppUtils.shared
    internal var delegate : resultImageDisplayClicked?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        leftMenuBar()
        if UI_USER_INTERFACE_IDIOM() == .pad {
            UILabel.appearance().font = UIFont(name: "Avenir-Roman", size: 16)
        }
        else {
            UILabel.appearance().font = UIFont(name: "Avenir-Roman", size: 14)
        }
    }
    func changeBounds(){
        self.isHidden = false
        let height = cellHeight * CGFloat(itemCount)
        if itemCount == 0{
            
            
            self.isHidden = true
        }
        else if height < (severityCollectionView?.frame.height ?? 0){
            DispatchQueue.main.async {
                self.bgView.frame = CGRect(x: 0, y: self.frame.height*0.0, width: self.frame.width, height: height)
                self.severityCollectionView?.frame = CGRect(x: 0, y: self.frame.height*0.0, width: self.frame.width, height: height)
                
                self.bgView.center = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
                self.severityCollectionView?.center = CGPoint(x: self.bgView.frame.width * 0.5, y: self.bgView.frame.height * 0.5)
            }
            self.bgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            
        }
        else{
            DispatchQueue.main.async {
                self.bgView.frame = CGRect(x: 0, y: self.frame.height*0.0, width: self.frame.width, height: self.frame.height)
                self.severityCollectionView?.frame = CGRect(x: 0, y: self.frame.height*0.0, width: self.frame.width, height: self.frame.height)
                
                self.bgView.center = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
                self.severityCollectionView?.center = CGPoint(x: self.bgView.frame.width * 0.5, y: self.bgView.frame.height * 0.5)
            }
            self.bgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        }
    }
    func addResultData(tags:[TagResult]){
        deafaultTags.removeAll()
        deafaultTags = tags
        severityCollectionView?.reloadData()
        if deafaultTags.count > 0{
            severityCollectionView?.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
            self.collectionView(severityCollectionView!, didSelectItemAt: IndexPath(item: 0, section: 0))
            severityCollectionView?.contentOffset.x = 0
            severityCollectionView?.showsVerticalScrollIndicator = false
        }
        
    }
    fileprivate func leftMenuBar(){
        
        if utils.getDeviceType() == .phone{
            cellWidth = self.frame.width
            cellHeight = self.frame.height * 0.2
        }
        else{
            cellWidth = self.frame.width
            cellHeight = self.frame.height * 0.15
        }
        
        severityFlowLayout.minimumLineSpacing = 0.0
        severityFlowLayout.minimumInteritemSpacing = 0.0
        severityCollectionView = UICollectionView(frame: .zero, collectionViewLayout: severityFlowLayout)
        if(deafaultTags.count>5)
        {
            bgView.frame = CGRect(x: 0, y: self.frame.height*0.02, width: self.frame.width, height: self.frame.height * 0.95)
            severityCollectionView?.frame = CGRect(x: 0, y: self.frame.height*0.02, width: self.frame.width, height: self.frame.height * 0.95)
        }
        else
        {
            bgView.frame = CGRect(x: 0, y: self.frame.height*0.01, width: self.frame.width, height: self.frame.height)
            
            severityCollectionView?.frame = CGRect(x: 0, y: self.frame.height*0.01, width: self.frame.width, height: self.frame.height)
        }
        severityCollectionView?.delegate = self
        severityCollectionView?.dataSource = self
        severityCollectionView?.register(SeverityCollectionViewCell.self, forCellWithReuseIdentifier: severityCellReuseIdentifier)
        severityCollectionView?.backgroundColor = .clear
        severityCollectionView?.isScrollEnabled = true
        self.addSubview(bgView)
        
        bgView.addSubview(severityCollectionView!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func returnCGFloatForSeverity(severity:Int) ->CGFloat{
        
        if(severity == 1)
        {
            return 0.2
        }
        else if(severity == 2)
        {
            return 0.4
        }
        else if(severity == 3)
        {
            return 0.6
        }
        else if(severity == 4)
        {
            return 0.8
        }
        else if(severity == 5)
        {
            return 1.0
        }
        return 0.0
    }
}

extension LeftMenuView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as? SeverityCollectionViewCell
        cell?.cellView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.65)
        cell?.cellView.layer.cornerRadius = 10.0
        delegate?.displayResultImage((deafaultTags[indexPath.row].tagImage ?? ""))
    }
}

extension LeftMenuView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemCount = deafaultTags.count
        print("itemCount\(itemCount)")
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: severityCellReuseIdentifier, for: indexPath) as! SeverityCollectionViewCell
        
        if deafaultTags[indexPath.row].statusCode == 200{
            let sevrityValue = Int(deafaultTags[indexPath.row].tagSeverity ?? "0") ?? 0
            print(deafaultTags[indexPath.row].tagName )
            cell.severityName.text =  deafaultTags[indexPath.row].tagDisplayName
            
            cell.drwaCircleLayer(bgLayerWidth:returnCGFloatForSeverity(severity: sevrityValue))
            if(sevrityValue > 0)
            {
                cell.severityScore.text = "\(sevrityValue)"//SkinConcernArr[indexPath.row].Severity
            }
            else
            {
                cell.severityScore.text = ""
            }
        }
        return cell
    }
}

extension LeftMenuView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

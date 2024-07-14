//
//  Custom?View.swift
//  Runner
//
//  Created by apple on 17/04/24.
//

import UIKit
import Flutter
import SkinCareWidget


class CustomViewController: NSObject, FlutterPlatformView {
    
    
    private var viewId: Int64 = 0
    private var frame: CGRect
    private var viewController: ViewController?
    var controlSelectionView: ControlView?
    
    init(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, binaryMessenger messenger: FlutterBinaryMessenger,flutterEngine: FlutterEngine) {
        self.frame = frame
        self.viewId = viewId
        super.init()
        
        createView()
    }
    
    
    
    
    func view() -> UIView {

        return viewController?.view ?? UIView()
    }
    
    private func createView() {
  
        viewController = ViewController()
    }
}



class ViewController: UIViewController {
    
    let autoCaptureOnLabel = UILabel()
    var config = Configurations()
    var overlayControl : CameraOverLayControls?
    var resultsControl : ResultsOverLayControls?
    var controlSelectionView: ControlView = ControlView()
    var mainView : UIView?
    var resultsView: ResultsView?
    let widget = SkinCareWidget()
    var key = String()
    var capturedImage: UIImage?
    var serviceManager : ServiceManager?
    var btbpTags: [[String]] = [
        //Display Name, Score tag, image tag
        ["Acne", "ACNE_SEVERITY_SCORE_FAST","ACNE_IMAGE_FAST"],
        ["Wrinkles", "WRINKLES_SEVERITY_SCORE_FAST","WRINKLES_IMAGE_FAST"],
        ["Redness", "REDNESS_SEVERITY_SCORE_FAST", "REDNESS_IMAGE"],
        ["DarkCircles","DARK_CIRCLES_SEVERITY_SCORE_FAST","DARK_CIRCLES_IMAGE"],
        ["Spots","SPOTS_SEVERITY_SCORE_FAST","SPOTS_IMAGE_FAST"],
        ["UnevenSkinTone", "UNEVEN_SKINTONE_SEVERITY_SCORE_FAST", "UNEVEN_SKINTONE_IMAGE"],
        ["LipHealth","LIP_HEALTH_SCORE","LIP_HEALTH_IMAGE"],
        ["Dehydration","DEHYDRATION_SEVERITY_SCORE_FAST","DEHYDRATION_CONTOURS_COLORIZED_IMAGE_FAST"],
        ["Oiliness","OILINESS_SEVERITY_SCORE","OILINESS_IMAGE"],
        ["LipRoughness","LIP_ROUGHNESS_SEVERITY_SCORE_FAST","LIP_ROUGHNESS_IMAGE"],
        ["Pores","PORES_SEVERITY_SCORE_FAST","PORES_IMAGE"]
    ]
    
    var selectedTags: [String]?
    var widgetCurrentScreen : ScreenName?
    
    
    func infoForKey(_ key: String) -> String? {
        let value = Bundle.main.object(forInfoDictionaryKey: key) as! String
        return value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autoCaptureOnLabel.text = ""//AUTO CAPTURE\nis ON"
        autoCaptureOnLabel.numberOfLines = 0
        autoCaptureOnLabel.textColor = .white
        autoCaptureOnLabel.isHidden = true
        autoCaptureOnLabel.textAlignment = .center
        autoCaptureOnLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.5, height: self.view.frame.height * 0.1)
        autoCaptureOnLabel.center = CGPoint(x: self.view.frame.width * 0.5, y: self.view.frame.height * 0.95)
//        controlSelectionView = ControlView(frame: CGRect(x: 0, y: self.view.frame.height * 0.2, width: self.view.frame.width * 0.8, height: self.view.frame.height * 0.8))
//        controlSelectionView?.center =  CGPoint(x: self.view.center.x , y: self.view.frame.height * 0.5)
//        overlayControl = CameraOverLayControls(frame:CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.5))
//        overlayControl?.isHidden = true
//        resultsControl = ResultsOverLayControls(frame: CGRect(x: self.view.frame.width * 0.1, y: self.view.frame.height * 0.9, width: self.view.frame.width * 0.8, height: self.view.frame.height * 0.1))
//        
        mainView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 200))
        mainView?.isHidden = true
//        controlSelectionView?.startButton.addTarget(self, action: #selector(startWidget), for: .touchUpInside)
//        controlSelectionView?.isHidden = true
//        overlayControl?.controlButton.addTarget(self, action: #selector(changeState(_:)), for: .touchUpInside)
//        resultsControl?.controlButton.addTarget(self, action: #selector(changeState(_:)), for: .touchUpInside)
//        resultsControl?.isHidden = true
        self.view.addSubview(mainView!)
//        self.view.addSubview(overlayControl!)
//        self.view.addSubview(controlSelectionView!)
        self.view.addSubview(autoCaptureOnLabel)
//        self.view.addSubview(resultsControl!)
        self.addResultView()
//        overlayControl?.selectSwitch.addTarget(self, action: #selector(changeevent), for: .valueChanged)
//        resultsControl?.selectSwitch.addTarget(self, action: #selector(changeResultControl), for: .valueChanged)
        self.startWidget()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func startWidget(){
        print("start button clicked")
        DispatchQueue.main.async {
            
            self.selectedTags = ["acne", "wrinkles","Redness",  "DarkCircles", "Spots",
                                 "UnevenSkinTone", "LipHealth", "Dehydration", "Oiliness","LipRoughness", "Pores"];
            
            self.config = self.getWidgetConfig()
            
            let value = self.controlSelectionView.APIKey.text
            UserDefaults.standard.set(self.controlSelectionView.APIKey.text, forKey: "API_KEY")
            self.key =  value ?? ""
            self.config.licenseKey = self.key
            self.view.endEditing(true)
            self.config.widgetView = self.mainView!
            
            self.setIQCMessages();
            
            SkinCareWidget.skinCareWidget.appLicenseCallback = self
            SkinCareWidget.skinCareWidget.captureScreenCallback = self
            SkinCareWidget.skinCareWidget.widgetScreenCallBacks = self
            SkinCareWidget.skinCareWidget.checkLicense(config: self.config)
        }
    }
    
    func showCaptureScreen(){
        DispatchQueue.main.async {
//            self.controlSelectionView?.isHidden = true
            self.mainView?.isHidden = false
//            self.overlayControl?.isHidden = false
        }
    }
    
    private func getWidgetConfig() -> Configurations {
        let widgetConfig  = Configurations()

        //set Required tags for process
        widgetConfig.btbpTags = self.btbpTags
        widgetConfig.tags = self.selectedTags
        
        //Widget UI configurations
        widgetConfig.resultsRightPane = false
        widgetConfig.isInstructionScreenDisplay = true
        widgetConfig.isAutoCapture = true
        widgetConfig.isCaptureButtonDisplayed = false
        widgetConfig.resultsRightPane = true//self.controlSelectionView?.configarray[2]
        widgetConfig.isGalleryOption = false//self.controlSelectionView?.configarray[0]
        widgetConfig.isFlipCamera = false//self.controlSelectionView?.configarray[1]
        widgetConfig.isInstructionScreenDisplay = false//self.controlSelectionView?.configarray[3]
        
        //Set resources to widget
        widgetConfig.instrScreenImages = [UIImage(named: "Instruction_1.png", in: Bundle(for: ViewController.self), compatibleWith: nil)!,
                                         UIImage(named: "Instruction_2.png", in: Bundle(for: ViewController.self), compatibleWith: nil)!,
                                         UIImage(named: "Instruction_3.png", in: Bundle(for: ViewController.self), compatibleWith: nil)!,
                                         UIImage(named: "Instruction_4.png", in: Bundle(for: ViewController.self), compatibleWith: nil)!]
        widgetConfig.instrScreenText = ["Remove Glasses",
                                       "Remove Makeup",
                                       "Pull your hair back",
                                       "Align face correctly"]
        widgetConfig.captureButtonImage = UIImage(named: "Capture_Icon.png", in: Bundle(for: ViewController.self), compatibleWith: nil)!
        widgetConfig.flipCamButtonImage = UIImage(named: "Flip_Camera_Icon.png", in: Bundle(for: ViewController.self), compatibleWith: nil)!
        widgetConfig.uploadButtonImage = UIImage(named: "Upload icon.png", in: Bundle(for: ViewController.self), compatibleWith: nil)!
        widgetConfig.analyzeTickMark = UIImage(named: "ok.png", in: Bundle(for: ViewController.self), compatibleWith: nil)!
        widgetConfig.retakeCrossMark = UIImage(named: "cancel.png", in: Bundle(for: ViewController.self), compatibleWith: nil)!
        
        return widgetConfig
    }
    
    @objc func addResultView(){
        self.resultsView = ResultsView(frame: self.mainView!.bounds)
        self.resultsView?.resetView?.addTarget(self, action: #selector(self.resetWidget), for: .touchUpInside)
        self.mainView!.addSubview(self.resultsView!)
        self.resultsView?.isHidden = true
    }
    
    @objc public func resetWidget(){
        DispatchQueue.main.async {
            self.resultsView?.isHidden = true
            self.resultsView?.resultImageView?.image = nil
            
            SkinCareWidget.skinCareWidget.resetWidget();
        }
    }
    @objc func changeResultControl(){
        if !(resultsControl?.selectSwitch.isOn)!{
            config.resultsRightPane = true
        }
        else{
            config.resultsRightPane = false
        }
        AppConfigs.shared.resultsRightPane  = self.config.resultsRightPane ?? AppConfigs.shared.resultsRightPane
        resultsView?.updateResultPosition()
    }
    @objc func changeevent(){
        if !(overlayControl?.selectSwitch.isOn)!{
            config.isAutoCapture = true
            config.isCaptureButtonDisplayed = false
        }
        else{
            config.isAutoCapture = false
            config.isCaptureButtonDisplayed = true
        }
        if self.config.isAutoCapture == true && self.config.isCaptureButtonDisplayed == false {
            self.autoCaptureOnLabel.isHidden = false
        } else {
            self.autoCaptureOnLabel.isHidden = true
        }
    }
    @objc func changeState(_ sender : UIButton){
        if sender.image(for: .normal) == #imageLiteral(resourceName: "Settings Icon"){
            sender.setImage(#imageLiteral(resourceName: "Settings panel close icon"), for: .normal)
            sender.backgroundColor = .white
            if widgetCurrentScreen!  == .results{
                resultsControl?.controlView.isHidden = false
            }
            else if widgetCurrentScreen == .live{
                overlayControl?.controlView.isHidden = false
            }
        }
        else {
            sender.setImage(#imageLiteral(resourceName: "Settings Icon"), for: .normal)
            sender.backgroundColor = .clear
            if widgetCurrentScreen!  == .results{
                resultsControl?.controlView.isHidden = true
            }
            else if widgetCurrentScreen == .live{
                overlayControl?.controlView.isHidden = true
            }
        }
    }
    private func getTagsDataFromConfig(config: Configurations)->[String]{
        var btbpTagsInfo: [String] = [String]();
        if let selectedTags = config.tags {
            for tag in selectedTags{
                for mtag in getTagNameByDisplayName(config: config, matchTagName: tag) {
                    btbpTagsInfo.append(mtag);
                }
            }
        }
        return btbpTagsInfo
    }
    private func getTagNameByDisplayName(config: Configurations!, matchTagName: String) -> [String] {
        var resTags: [String] = [String]();
        config.btbpTags?.forEach( {
            if $0[0].uppercased() == matchTagName.uppercased() {
                resTags.append($0[1])
                if $0.count == 3{
                    resTags.append($0[2])
                }
            }
        })
        return resTags;
    }
    
   
    
    func widgetAnalysisResult(widgetResult: [TagResult]?) {
        var count = 0
        for (_,value) in widgetResult!.enumerated(){
            //print("status code \(value.statusCode ?? -1)")
            if value.statusCode != 200{
                count += 1
            }
        }
        if count == (widgetResult?.count ?? -1){
            let alert = UIAlertController(title: "widget", message: "message : \(widgetResult?[0].Message ?? ""),code:\(widgetResult?[0].statusCode ?? -1)", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "reset", style: .default) { _ in
                SkinCareWidget.skinCareWidget.resetWidget()
            }
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    func notificationCallback(message: String) {
        print("log::\(message)")
    }
}

extension ViewController: AppLicenseCallbacks {
    func onLicenseSuccess(code:LicenseError,licenseSuccess :LicenseSuccess){
        self.showCaptureScreen()
        print("onLicenseSucess");
    }
    
    public func onLicenseError(licenseError: LicenseError) {
        let errorCode = licenseError.errorCode;
        print("log::\(errorCode)")
        
        if errorCode != "2004" {
            let alert = UIAlertController(title: "widget", message: "error  code : \(errorCode)", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "ok", style: .default) { _ in
                self.view.subviews.forEach{
                    $0.isHidden = true
                }
                DispatchQueue.main.async {
                    self.controlSelectionView.isHidden = false
                }
                
            }
            alert.addAction(alertAction)
            
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension ViewController: CaptureScreenCallbacks {
    func onCapturedImage(imageData:UIImage) {
        print("On captured image")
        self.serviceManager = ServiceManager(serviceCallBacks: self)
        let tagsToAnalysed : [String]  = getTagsDataFromConfig(config:self.config)
        self.capturedImage = imageData
        
        
        uploadImage(config: self.config, serviceMager: serviceManager!, imageData: self.capturedImage!,tagsToAnalysed:tagsToAnalysed)
    }
    
    internal func uploadImage(config: Configurations,serviceMager:ServiceManager,
                              imageData:UIImage,tagsToAnalysed:[String]){
        
        let imageUpload = ImageUpload()
        imageUpload.APIKey = config.licenseKey!
        imageUpload.Latitude = config.latitude ?? "0"
        imageUpload.Longitude = config.longitude ?? "0"
        imageUpload.UserId = config.userEmailId ?? "unknown@skincareWidget.com"
        imageUpload.ImageBytes = [imageData.getBase64FromImage(image: imageData)]
        imageUpload.Tags = tagsToAnalysed
        
        let url = "\(ServiceManager.SERVICE_BASE_URL)getTags"
        do{
            let data = try JSONEncoder().encode(imageUpload.self)
            ServiceManager.UPLOAD_IMAGE_REQUEST = Int64(Date().timeIntervalSince1970)
            serviceMager.httpPOSTRequest(urlStr: url, json: data, requestCode: ServiceManager.UPLOAD_IMAGE_REQUEST)
        }
        catch {
            print(error)
        }
    }
    func setIQCMessages() {
        self.config.IqcMessages = [
            0: "",
            2012: "I don't see you. Please align yourself.",
            999: "I don't see you. Please align yourself.",
            2013: "You're too far away. Please move closer to the camera.",
            2014: "You're too close. Please move further from the camera.",
            2015: "Your mouth is open. Please keep a neutral expression.",
            2016: "You're not centered. Please align yourself.",
            -3: "You're not centered. Please align yourself.",
            2017: "You're rotated left. Please align yourself.",
            2001: "You're rotated right. Please align yourself.",
            2002: "Environment's a little dark. Please move to a brighter environment.",
            2003: "Environment's a little dark. Please move to a brighter environment.",
            2004: "You're tilted upward. Please face the camera.",
            2005: "You're tilted downward. Please face the camera.",
            2006: "You're rotated left. Please align yourself.",
            2007: "You're rotated right. Please align yourself.",
            2008: "You're unevenly lit. Please use a more evenly lit environment.",
            2009: "You're unevenly lit. Please use a more evenly lit environment.",
            2010: "You're unevenly lit. Please use a more evenly lit environment.",
            2011: "Environment's a little bright. Please use a more evenly lit environment.",
            888: "No calibration information found. Please take the capture of color chart.",
            1234: "Environment's a little bright. Please use a more evenly lit environment.",
            1264: "Environment's a little dark. Please use a more evenly lit environment.",
            3000: "Please keep the camera stable.",
            2083: "Your eyes are closed. Please open your eyes.",
            2146: "You're too far away. Please move closer to the camera.",
        ]
    }
}
extension ViewController : WidgetScreenCallBacks {
    func getCurrentViewName(screenName: ScreenName) {
        widgetCurrentScreen = screenName
        DispatchQueue.main.async{
            if screenName == .live{
                self.resultsControl?.isHidden = true
                self.overlayControl?.isHidden = false
                self.overlayControl?.controlButton.setImage(#imageLiteral(resourceName: "Settings Icon"), for: .normal)
                self.overlayControl?.controlButton.backgroundColor = .clear
                self.overlayControl?.controlView.isHidden = true
                if self.config.isAutoCapture == true && self.config.isCaptureButtonDisplayed == false{
                    self.autoCaptureOnLabel.isHidden = false
                }
            }
            else if screenName == .results{
                self.resultsControl?.isHidden = false
                self.overlayControl?.isHidden = true
                self.autoCaptureOnLabel.isHidden = true
                self.resultsControl?.controlButton.setImage(#imageLiteral(resourceName: "Settings Icon"), for: .normal)
                self.resultsControl?.controlButton.backgroundColor = .clear
                self.resultsControl?.controlView.isHidden = true
            }
            else{
                self.overlayControl?.isHidden = true
                self.autoCaptureOnLabel.isHidden = true
                self.resultsControl?.isHidden = true
            }
        }
    }
    
    func widgetCaptureSucess(isSucess:Bool,image:UIImage){
        print ("capture success")
    }
    
    func widgetErrorCallBack(errorCode:ErrorCodes) {
        print("log::\(errorCode.rawValue)")
        
        if errorCode.rawValue != 2004 {
            let alert = UIAlertController(title: "widget", message: "error  code : \(errorCode.rawValue)", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "ok", style: .default) { _ in
                self.view.subviews.forEach{
                    $0.isHidden = true
                }
                DispatchQueue.main.async {
                    self.controlSelectionView.isHidden = false
                }
                
            }
            alert.addAction(alertAction)
            
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}


extension ViewController: ServiceCallBacks {
    internal func bringResultViewToFront(){
        self.mainView?.subviews.forEach{
            $0.isHidden = true
        }
        resultsView?.isHidden = false
        self.mainView?.bringSubviewToFront(resultsView!)
    }
    func onServiceCallSuccess(serviceResponse: ServiceResponse, requestCode: Int64, jsonData: Data?, url: String?) {
        
        switch requestCode {
        case ServiceManager.UPLOAD_IMAGE_REQUEST:
            print(serviceResponse.response)
            if serviceResponse.status {
                do{
                    let tagJsonResult = try JSONDecoder().decode(GetTag.self, from: serviceResponse.response.data(using: .utf8)!)
                    
                    if tagJsonResult.ErrorCode == nil{
                        var analysisResult = addJSONResultToArray(widgetResult : tagJsonResult.Tags,_config : self.config)
                        DispatchQueue.main.async {
                            self.bringResultViewToFront()
                            
                            self.resultsView?.leftMenuView?.addResultData(tags: analysisResult.0)
                            
                        }
                        let finalResult = analysisResult.0 + analysisResult.1
                        
                        self.widgetAnalysisResult(widgetResult: finalResult)
                        if AppConfigs.shared.displayResults {
                            getCurrentViewName(screenName: .results)
                        }
                    }
                    else{
                        var tagResult = TagResult()
                        tagResult.statusCode = tagJsonResult.ErrorCode
                        tagResult.Message = tagJsonResult.Message
                        widgetAnalysisResult(widgetResult: [tagResult])
                    }
                    
                }
                catch{
                    print(error)
                }
            }
            else{
                DispatchQueue.main.async {
                    //self.loader.isHidden = true
                    //self.loader.stopAnimating()
                    UIAlertController.displayAlert(message: "Please check internet connection", title: "Widget", actionTitle: "Retry", action: {
                        self.serviceManager?.httpPOSTRequest(urlStr: url!, json: jsonData, requestCode: requestCode)
                    })
                }
                
                self.widgetErrorCallBack(errorCode: .ERROR_IMAGE_UPLOAD_FAILED)
            }
            
            
        default:
            print(serviceResponse.response)
        }
    }
    internal func addJSONResultToArray(widgetResult : [Tag]?,_config : Configurations)->([TagResult],[TagResult]){
        var finalResultArray = [TagResult]()
        widgetResult?.forEach{
            let indexOfTag = getFeatureIndexFromtag(tagName: $0.TagName ?? "")
            if indexOfTag != -1{
                let tagResult = TagResult()
                tagResult.statusCode = $0.StatusCode
                tagResult.Message = $0.Message
                tagResult.tagDisplayName = getTagDisplayName(config: _config, matchTagName: $0.TagName ?? "")
                let splittedTagName = $0.TagName?.split(separator: "_")
                
                tagResult.tagName = getfeatureNameFromFeaturesList(featureGroup: Features(rawValue: indexOfTag))//String(splittedTagName?.first ?? "xxx")
                
                //print("splittedTagName : \(splittedTagName) , tagResult.tagName \(tagResult.tagName )" );
                
                
                if splittedTagName != nil {
                    if splittedTagName!.contains("IMAGE"){
                        if $0.StatusCode == 200{
                            if (($0.TagValues?.count) ?? -1) > 0{
                                tagResult.tagImage = $0.TagValues?[0].Value
                                //print("\(tagResult.tagImage)");
                            }
                        }
                        finalResultArray = addToResult(resultArray: finalResultArray, tagResult: tagResult,isImage: true)
                    }
                    if splittedTagName!.contains("SCORE")        {
                        if $0.StatusCode == 200{
                            if (($0.TagValues?.count) ?? -1) > 0{
                                //tagResult.tagSeverity = $0.TagValues?[0].Value
                                //print("First Result: \($0.TagName)  \($0.TagValues)");
                                if (($0.TagValues?.count) ?? -1) > 1 {
                                    //print("Multivalue Result: \($0.TagName)  \($0.TagValues)");
                                    $0.TagValues?.forEach({ (TagContent) in
                                        if TagContent.ValueName == "Combined"{
                                            tagResult.tagSeverity = TagContent.Value
                                        }
                                    })
                                } else if (($0.TagValues?.count) ?? -1) == 1{
                                    //print("Single Result: \($0.TagName)  \($0.TagValues)");
                                    tagResult.tagSeverity = $0.TagValues?[0].Value
                                }
                            }
                            else{
                                print("No Result: \($0.TagName)  \($0.TagValues)");
                            }
                            /*if (($0.TagValues?.count) ?? -1) > 0{
                             tagResult.tagSeverity = $0.TagValues?[0].Value
                             tagResult.statusCode = $0.StatusCode
                             }*/
                        }
                        finalResultArray = addToResult(resultArray: finalResultArray, tagResult: tagResult,isImage: false)
                    }
                }
            }
        }
        
        let analysedArray = finalResultArray.filter{
            if $0.statusArray.count == 2{
                if $0.statusArray[0] == 200 || $0.statusArray[1] == 200 {
                    return true
                }
            }
            return false
        }
        let failedResultArray = finalResultArray.filter{
            
            if $0.statusArray.count == 2{
                if $0.statusArray[0] != 200 && $0.statusArray[1] != 200{
                    return true
                }
            }
            return false
        }
        return (analysedArray,failedResultArray)
    }
    internal func getfeatureNameFromFeaturesList(featureGroup: Features?)->String
    {
        var featName = ""
        if let userTags = self.config.features, let featGroup = featureGroup
        {
            for tag in userTags{
                if tag.0 == featureGroup{
                    featName = tag.1
                }
            }
        }
        return featName
    }
    func addToResult(resultArray : [TagResult],tagResult : TagResult , isImage:Bool) -> [TagResult] {
        var resArray = resultArray
        var isAdded = false
        resArray.forEach{
            if $0.tagDisplayName == tagResult.tagDisplayName{
                if isImage{
                    $0.statusArray[0] = tagResult.statusCode!
                    $0.tagImage = tagResult.tagImage
                    isAdded = true
                }
                else{
                    $0.statusArray[1] = tagResult.statusCode!
                    $0.tagSeverity = tagResult.tagSeverity
                    isAdded = true
                }
            }
        }
        
        if isAdded == false{
            let tempResult = tagResult
            if isImage{
                tempResult.statusArray[0] = tagResult.statusCode ?? -1
            }
            else{
                tempResult.statusArray[1] = tagResult.statusCode ?? -1
            }
            resArray.append(tempResult)
        }
        return resArray
    }
    func getFeatureIndexFromtag(tagName : String)->Int{
        let index =  indicesOf(x: tagName, arr: self.btbpTags)
        if let indexValue = index {
            return indexValue.0
        }
        else{
            return 0
        }
    }
    func indicesOf<T: Equatable>(x: T, arr: [[T]]) -> (Int, Int)? {
        for (i, row) in arr.enumerated() {
            if let j = row.index(of:x) {
                return (i, j)
            }
        }
        return nil
    }
    private func getTagDisplayName(config: Configurations, matchTagName: String)->String{
        var displayTagName: String = ""
        config.btbpTags?.forEach( {
            if $0[1] == matchTagName{
                displayTagName =  $0[0]
            }
            else if $0.count == 3 {
                if $0[2] == matchTagName{
                    displayTagName =  $0[0]
                }
            }
        })
        return displayTagName;
    }
}
internal extension UIImage{
    func getBase64FromImage(image: UIImage) -> String
    {
        let imageData = image.jpegData(compressionQuality: 0)//UIImagePNGRepresentation(image)
        let str64:String = (imageData?.base64EncodedString())!
        if case let stringVal = str64 {
            return stringVal
        }
        return "nil"
    }
}
extension UIAlertController{
    static func displayAlert(message:String,title:String,actionTitle:String,action: @escaping () -> ()) -> UIAlertController{
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .default) { _ in
            action()
        }
        alert.addAction(alertAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        return alert
    }
}

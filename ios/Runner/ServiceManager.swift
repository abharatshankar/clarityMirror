//
//  ServiceManager.swift
//  SkinCareWidgetSample
//
//  Created by BTBP on 3/24/23.
//  Copyright © 2023 BrighTex Bio Photonics. All rights reserved.
//

import Foundation
internal protocol ServiceCallBacks
{
    func onServiceCallSuccess(serviceResponse:ServiceResponse , requestCode:Int64 ,jsonData : Data?,url:String?)
    
}
internal class ServiceManager {
    
    internal static var SERVICE_BASE_URL = "https://api.btbp.org/deeptag/Appservice.svc/"
    internal static let License_service_Base_URL = "http://bserver1.btbp.org/BTBPLicensing/services/BTBPLicensingService.svc/"
    internal static var UPLOAD_IMAGE_REQUEST : Int64 = 101
    internal static var GET_SYSYTEM_LICENSE_DETAILS2 : Int64 = 102
    private var serviceCallBacks: ServiceCallBacks
    internal init(serviceCallBacks: ServiceCallBacks)
    {
        self.serviceCallBacks = serviceCallBacks
    }
    
    //MARK: - POST, GET & PUT REQUESTS
    /// used for http GET Request
    ///
    /// - Parameters:
    ///   - urlStr: request url in String format
    ///   - requestCode: request code
    
    internal func httpGETRequest(urlStr : String, requestCode : Int64,timeStamp : Double = Date().timeIntervalSince1970){
        let url : URL = URL(string: urlStr)!
        let session = URLSession.shared
        var responseText : String = "false"
        let request = NSMutableURLRequest(url : url)
        //request.setValue(Bundle.main.releaseVersionNumberPretty, forHTTPHeaderField: "versionNumber")
        request.httpMethod = "GET"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        
        let task = session.dataTask(with: url, completionHandler: {
            (data,response,error) in
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                
                responseText = "false"
                let response = ServiceResponse()
                response.response = responseText
                response.status = false
                response.message = (error?.localizedDescription)!
                self.serviceCallBacks.onServiceCallSuccess(serviceResponse: response, requestCode: requestCode, jsonData: nil, url: urlStr)
                return
            }
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            responseText = (dataString!  as String)
            let response = ServiceResponse()
            response.response = responseText
            response.status = true
            let timeTaken = Date().timeIntervalSince1970 - timeStamp
            self.serviceCallBacks.onServiceCallSuccess(serviceResponse: response, requestCode: requestCode, jsonData: nil, url: urlStr)
        })
        task.resume()
    }
    
    
    /// used for http POST Request
    ///
    /// - Parameters:
    ///   - urlStr: request url in String format
    ///   - json: post request json body in Data format
    ///   - requestCode: request code
    internal func httpPOSTRequest(urlStr: String,json: Data?, requestCode: Int64,timeStamp : Double = Date().timeIntervalSince1970)
    {
        
        let url:URL = URL(string: urlStr)!
        
        let session = URLSession.shared
        var responseText = "false"
        let request = NSMutableURLRequest(url: url)
        if json != nil
        {
            request.httpBody = json
        }
        request.httpMethod = "POST"
        request.timeoutInterval = 120
        //request.setValue(Bundle.main.releaseVersionNumberPretty, forHTTPHeaderField: "versionNumber")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData//NSURLRequest.CachePolicy.reloadIgnoringCacheData
        print(String(data:json!,encoding:.utf8))
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                responseText = "false"
                
                let response = ServiceResponse()
                response.response = responseText
                response.status = false
                response.message = (error?.localizedDescription)!
                self.serviceCallBacks.onServiceCallSuccess(serviceResponse: response, requestCode: requestCode, jsonData: json, url: urlStr)
                return
            }
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            responseText = (dataString!  as String)
            
            let response = ServiceResponse()
            response.response = responseText
            response.status = true
            let timeTaken = Date().timeIntervalSince1970 - timeStamp
            self.serviceCallBacks.onServiceCallSuccess(serviceResponse: response, requestCode: requestCode,jsonData : json, url: urlStr)
        })
        
        task.resume()
    }
}

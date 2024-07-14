//
//  Models.swift
//  SkinCareWidgetSample
//
//  Created by BTBP on 3/24/23.
//  Copyright © 2023 BrighTex Bio Photonics. All rights reserved.
//

import Foundation
internal class ServiceResponse{
    var response: String = ""
    var stream: AnyObject?
    var status: Bool = false
    var statusCode: Int = 0
    var errorCode = 999
    var message: String = ""
    var length: Int = 0
}
internal class ImageUpload: NSObject,Codable
{
    var APIKey:String?
    var UserId:String?
    var AppId:String?
    var ClientId: String?
    var Latitude:String?
    var Longitude:String?
    var Tags: [String] = [String]()
    var ImageBytes:[String]?
}


public class GetTag: Codable {
    var TimeStamp: String?
    var ImageID: String?
    var Message: String?
    var Tags: [Tag]?
    var ErrorCode: Int?
}
public class Tag: Codable {
    var TagName: String?
    var TagImage: String?
    var Status: Bool?
    var Message: String?
    var StatusCode: Int?
    var TagValues: [TagValue]?
}

public class TagValue: Codable {
    var Value: String?
    var ValueName: String?
    var Units: String?
    var Confidence: String?    
}

public class TagResult {
    public var tagName : String?
    public var tagDisplayName : String?
    public var tagSeverity : String?
    public var tagImage : String?
    public var statusCode : Int?
    public var Status: Bool?
    public var Message: String?
    public var statusArray = [-1,-1]
}

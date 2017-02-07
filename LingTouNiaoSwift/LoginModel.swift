//
//  LoginModel.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/23.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

typealias block = ((UIImage) -> ())

class LoginModel: NSObject {
    
    class func getPictureCode(block: ((UIImage?) -> ())?) {
        let machineNo = UIDevice.current.identifierForVendor?.uuidString
        let path = API_BASE_URL + GetPictureCaptchaUrl + "/" + machineNo!
        let request = URLRequest.init(url: URL(string: path)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, connectionError) in
            var image: UIImage?
            if data != nil {
                image = UIImage.init(data: data!)
            }
            if block != nil {
                block!(image)
            }
        }
    }
}

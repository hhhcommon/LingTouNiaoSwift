//
//  NetAPIManager.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/16.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit
import AFNetworking

enum NetworkMethod {
    case Get
    case Post
}

func pathKey(path: String, parameters: NSDictionary?) -> String {
    if parameters != nil {
        return path.appending(AFQueryStringFromParameters(parameters as! [AnyHashable : Any]))
    }
    return path
}

class NetAPIManager: AFHTTPSessionManager {
    
    static let sharedManager = NetAPIManager();
    let private_key = "ltn$%^qpdhTH18"
    
    func request(path: String, params: Dictionary<String, Any>?, methodType: NetworkMethod, block: @escaping (_ response: Any?, _ error: Error?) -> Void) -> Void {
        self.request(path: path, params: params, methodType: methodType, autoShowError: true, block: block)
    }
    
    func request(path: String, params: Dictionary<String, Any>?, methodType: NetworkMethod, autoShowError: Bool, block: @escaping (_ response: Any?, _ error: Error?) -> Void) -> Void {
        
        // log请求数据
        print("\n===========request===========\n\(methodType)\n\(path):\n\(params)")
        
        // 封装基础参数
        let params = self.configParameters(parameters: params)
        
        // 发起请求
        switch (methodType) {
        case .Get:
            //所有 Get 请求，根据需要增加缓存机制
            var localPath: String?
            let cachePaths = getCachePaths();
            if cachePaths.contains(path) {
                if params.count > 0 {
                    localPath?.append(params.description)
                }
            }
            self.get(path.netAbsolutePath(), parameters: params, progress: nil, success: { (task, responseObject) in
                print("\n===========response===========\n\(path.netAbsolutePath()):\n\(responseObject)")
                let error = self.handleResponse(response: responseObject as! NSDictionary, autoShowError: autoShowError)
                if error != nil {
                    let responseObject = NSObject.loadResponse(requestPath: pathKey(path: localPath!, parameters: params as NSDictionary?))
                    block(responseObject, error);
                } else {
                    // 如果需要缓存，则缓存
                    if responseObject is NSDictionary {
                        _ = NSObject.saveResponseData(data: responseObject as! NSDictionary, requestPath: pathKey(path: localPath!, parameters: params as NSDictionary?))
                    }
                    block(responseObject, nil);
                }
                
            }, failure: { (task, error) in
                print("\n===========response===========\n\(path.netAbsolutePath()):\n\(error.localizedDescription)")
                _ = NSObject.showError(error: error as NSError)
                let responseObject = NSObject.loadResponse(requestPath: pathKey(path: localPath!, parameters: params as NSDictionary?))
                block(responseObject, error);
            })
        case .Post:
            self.post(path.netAbsolutePath(), parameters: params, progress: nil, success: { (task, responseObject) in
                print("\n===========response===========\n\(path.netAbsolutePath()):\n\(responseObject)")
                let error = self.handleResponse(response: responseObject as! NSDictionary, autoShowError: autoShowError)
                if error != nil {
                    block(nil, error);
                } else {
                    block(responseObject, nil);
                }
            }, failure: { (task, error) in
                print("\n===========response===========\n\(path):\n\(error.localizedDescription)")
                _ = NSObject.showError(error: error as NSError)
                block(nil, error);
                
            })
        }
    }
    
    fileprivate func configParameters(parameters: Dictionary<String, Any>?) -> Dictionary<String, Any> {
        
        var params = parameters == nil ? Dictionary<String, Any>() : parameters!
        
        // 基础参数
        params.updateValue(GlobalManager.appVersion(), forKey: "appVersion")
        params.updateValue("I", forKey: "clientType")
        params.updateValue(UserDefaults.standard.value(forKey: SessionKey) ?? "", forKey: SessionKey)
        
        // 加密参数
        //        let signParams = NSMutableDictionary(dictionary: params)
        //        signParams.setValue(private_key, forKey: "private_key")
        //        let signString = [NSString serialize:signParameters];
        //        signString = [NSString md5:signString];
        
        //        [parameters setValue:signString forKey:@"sign"];
        
        return params
    }
}

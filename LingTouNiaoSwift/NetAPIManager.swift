//
//  NetAPIManager.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/16.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit
import AFNetworking

typealias responseBlock = ((_ response: Any?, _ error: Error?) -> Void)
typealias responsedDataBlock = ((_ response: Any?, _ data: Any?, _ error: Error?) -> Void)

enum NetworkMethod {
    case Get
    case Post
}

func pathKey(path: String?, parameters: NSDictionary?) -> String {
    if path == nil {
        return ""
    }
    if parameters != nil {
        return path!.appending(AFQueryStringFromParameters(parameters as! [AnyHashable : Any]))
    }
    return path!
}

class NetAPIManager: AFHTTPSessionManager {
    
    static let shared = NetAPIManager();
    let private_key = "ltn$%^qpdhTH18"
    
    func request(path: String, params: Dictionary<String, Any>?, methodType: NetworkMethod, block: @escaping responseBlock) -> Void {
        self.request(path: path, params: params, methodType: methodType, autoShowError: true, block: block)
    }
    
    func request(path: String, params: Dictionary<String, Any>?, methodType: NetworkMethod, autoShowError: Bool, block: @escaping responseBlock) -> Void {
        
        // 封装基础参数
        let params = self.configParameters(parameters: params)
        
        // 头部签名
        var signParams = params
        signParams.updateValue(private_key, forKey: "private_key")
        var signString = String.serialize(dict: signParams)
        signString = signString.md5()
        self.requestSerializer.setValue(signString, forHTTPHeaderField: "header_sign")
        
        // log请求数据
        print("\n===========request===========\n\(methodType)\n\(path):\n\(params)")
        
        // 发起请求
        switch (methodType) {
        case .Get:
            //所有 Get 请求，根据需要增加缓存机制
            var localPath: String?
            let cachePaths = getCachePaths()
            if cachePaths.contains(path) {
                if params.count > 0 {
                    localPath?.append(params.description)
                }
            }
            self.get(path.netAbsolutePath(), parameters: params, progress: nil, success: { (task, responseObject) in
                print("\n===========response===========\n\(path.netAbsolutePath()):\n\(responseObject)")
                let error = self.handleResponse(response: responseObject as! NSDictionary, autoShowError: autoShowError)
                if error != nil {
                    let responseObject = NSObject.loadResponse(requestPath: pathKey(path: localPath, parameters: params as NSDictionary?))
                    block(responseObject, error);
                } else {
                    // 如果需要缓存，则缓存
                    if responseObject is NSDictionary {
                        _ = NSObject.saveResponseData(data: responseObject as! NSDictionary, requestPath: pathKey(path: localPath, parameters: params as NSDictionary?))
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
        params.updateValue(UIDevice.current.systemVersion, forKey: "osVersion")
        params.updateValue("I", forKey: "clientType")
        params.updateValue(UserDefaults.standard.value(forKey: SessionKey) ?? "", forKey: SessionKey)
//        params.updateValue(NSNumber.init(value: 1), forKey: "app_client_id")
//        params.updateValue("AppStore", forKey: "channel")
        
        return params
    }
}

//
//  NSObject+Common.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/17.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit
import MBProgressHUD

let PathResponseCache = "ResponseCache"

extension NSObject {
    // MARK: - File Manager
    // 获取fileName在缓存文件夹中的完整地址
    static func pathInCacheDirectory(fileName: String) -> String {
        let cachePaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let cachePath = cachePaths[0] as NSString
        return cachePath.appendingPathComponent(fileName)
    }
    
    // 创建缓存文件夹
    static func createDirInCache(dirName: String) -> Bool {
        let dirPath = self.pathInCacheDirectory(fileName: dirName)
        var isDir: ObjCBool = ObjCBool(false)
        let fileManager = FileManager.default
        let existed = fileManager.fileExists(atPath: dirPath, isDirectory: &isDir)
        var isCreated = false
        if !(isDir.boolValue && existed) {
            do {
                try fileManager.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
                isCreated = true
            } catch {
                isCreated = false
            }
        }
        if existed {
            isCreated = true
        }
        return isCreated
    }

    // MARK: - Net Data Persistence
    // 保存网络请求数据
    static func saveResponseData(data: NSDictionary, requestPath: String) -> Bool {
        if requestPath.isEmpty {
            return false
        }
        if self.createDirInCache(dirName: PathResponseCache) {
            let abslutePath = self.pathInCacheDirectory(fileName: PathResponseCache) + "/" + requestPath.md5() + ".plist"
            return data.write(to: URL(fileURLWithPath: abslutePath), atomically: true)
        } else {
            return false
        }
    }
    
    // 返回一个NSDictionary类型的json数据
    static func loadResponse(requestPath: String) -> NSDictionary? {
        if requestPath.isEmpty {
            return nil
        }
        let abslutePath = self.pathInCacheDirectory(fileName: PathResponseCache) + "/" + requestPath.md5() + ".plist"
        return NSDictionary.init(contentsOf: URL(fileURLWithPath: abslutePath))
    }
    
    // MARK: - Net Error Handle
    func handleResponse(response: NSDictionary) -> Error? {
        return self.handleResponse(response: response, autoShowError: true)
    }

    func handleResponse(response: NSDictionary, autoShowError: Bool) -> Error? {
        var error:  Error?
        let codeNumber = response["resultCode"] as! NSString
        let resultCode = codeNumber.intValue
        if resultCode != 0 {
            error = NSError.init(domain: API_BASE_URL, code: Int(resultCode), userInfo: response as? [AnyHashable : Any])
            if autoShowError {
                _ = NSObject.showError(error: error as! NSError)
            }
        }
        return error
    }
    
    // MARK: - tips
    static func showWaitingIconInView(_ view: UIView) {
        self.dismissWaitingIconInView(view)
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.bezelView.backgroundColor = UIColor.colorWithRGBA(0, 0, 0, a: 0.2)
        hud.removeFromSuperViewOnHide = true
    }
    
    static func dismissWaitingIconInView(_ view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }

    static func tipFromError(error: NSError?) -> String? {
        if error != nil && error?.userInfo != nil {
            let tipStr: String
            if (error?.userInfo["resultMessage"]) != nil {
                tipStr = error?.userInfo["resultMessage"] as! String
            } else {
                if (error?.userInfo["NSLocalizedDescription"]) != nil {
                    tipStr = error?.userInfo["NSLocalizedDescription"] as! String
                } else {
                    tipStr = "ErrorCode:\(error?.code)"
                }
            }
            return tipStr
        }
        return nil;
    }
    
    static func showError(error: NSError) -> Bool {
        let tipStr = self.tipFromError(error: error)
        self.showHudTipStr(tipStr)
        return true
    }
    
    static func showMessage(message: String?) -> Bool {
        self.showHudTipStr(message)
        return true
    }
    
    static func showHudTipStr(_ tipStr: String?) {
        if tipStr != nil && (tipStr?.characters.count)! > 0 {
            let hud = MBProgressHUD.showAdded(to: GlobalManager.keyWindow(), animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.bezelView.backgroundColor = UIColor.colorWithRGBA(0, 0, 0, a: 0.8)
            hud.detailsLabel.font = UIFont.boldSystemFont(ofSize: 15)
            hud.detailsLabel.textColor = UIColor.white
            hud.detailsLabel.text = tipStr
            hud.margin = 10
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 2)
        }
    }
    
    // MARK: - runtime
    /**
     *  获取对象的所有方法
     */
//    + (NSArray *)getAllMethodsFromClass:(Class)class
//    {
//    unsigned int count_f =0;
//    //获取方法链表
//    Method * methodList_f = class_copyMethodList(class,&count_f);
//    NSMutableArray *methodsArray = [NSMutableArray arrayWithCapacity:count_f];
//    
//    for(int i=0;i<count_f;i++)
//    {
//    Method temp_f = methodList_f[i];
//    //方法
//    SEL name_f = method_getName(temp_f);
//    NSString *methodStr = NSStringFromSelector(name_f);
//    [methodsArray addObject:methodStr];
//    }
//    free(methodList_f);
//    
//    return methodsArray;
//    }
//    
//    #pragma mark - Dictionary to Object
//    + (id)objectOfClass:(Class)modelClass fromJSON:(NSDictionary *)dict {
//    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
//    return nil;
//    }
//    BaseModel * model = [(BaseModel *)[modelClass alloc] init];
//    [model mj_setKeyValues:dict[@"data"]];
//    return model;
//    }
}

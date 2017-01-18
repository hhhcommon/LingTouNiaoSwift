//
//  NSObject+Common.swift
//  LingTouNiaoSwift
//
//  Created by LiuFeifei on 17/1/17.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

import UIKit

let PathResponseCache = "ResponseCache"

extension NSObject {
    // File Manager
    // 获取fileName在缓存文件夹中的完整地址
    static func pathInCacheDirectory(fileName: String) -> String {
        let cachePaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let cachePath = cachePaths[0] as NSString
        return cachePath.appendingPathComponent(fileName)
    }
    
    // 创建缓存文件夹
    static func createDirInCache(dirName: String) -> Bool {
//        let dirPath = self.pathInCacheDirectory(fileName: dirName)
//        var isDir = false
//        let fileManager = FileManager.default
//        let existed = fileManager.fileExists(atPath: dirPath, isDirectory: isDir)
//        let isCreated = false
//        if !(isDir && existed) {
//            isCreated = fileManager.createDirectory(at: URL., withIntermediateDirectories: true, attributes: <#T##[String : Any]?#>)
//            isCreated = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
//        }
//        if (existed) {
//            isCreated = YES;
//        }
//        return isCreated;
        return true
    }

    //#pragma mark - Net Data Persistence
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
    
    //#pragma mark - Net Error Handle
//    func handleResponse(response: Any) -> <#return type#> {
//        <#function body#>
//    }
//    -(id)handleResponse:(id)response{
//    return [self handleResponse:response autoShowError:YES];
//    }
    func handleResponse(response: NSDictionary, autoShowError: Bool) -> Error? {
        var error:  Error?
        //code为2值时，表示有错,1表示无错
        let codeNumber = response["code"] as! NSNumber
        let errorCode = codeNumber.intValue
        if errorCode != 1 {
            error = NSError.init(domain: API_BASE_URL, code: errorCode, userInfo: response as? [AnyHashable : Any])
            if autoShowError {
//                [NSObject showError:error];
            }
        }
        return error
    }
    
    //#pragma mark - tips
    static func showWaitingIconInView(_ view: UIView) {
        self.dismissWaitingIconInView(view)
//        
//        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//        hud.mode = MBProgressHUDModeIndeterminate;
//        hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
//        hud.removeFromSuperViewOnHide = YES;
    }
    
    static func dismissWaitingIconInView(_ view: UIView) {
//        [MBProgressHUD hideHUDForView:view animated:YES];
    }

    static func tipFromError(error: NSError?) -> String? {
        if error != nil && error?.userInfo != nil {
            let tipStr: String
            if (error?.userInfo["reason"]) != nil {
                tipStr = error?.userInfo["reason"] as! String
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
//            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[GlobalManager keyWindow]  animated:YES];
//            hud.mode = MBProgressHUDModeText;
//            hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
//            hud.detailsLabel.font = [UIFont boldSystemFontOfSize:15.0];
//            hud.detailsLabel.textColor = [UIColor whiteColor];
//            hud.detailsLabel.text = tipStr;
//            hud.margin = 10.f;
//            hud.removeFromSuperViewOnHide = YES;
//            [hud hideAnimated:YES afterDelay:2.0];
        }
    }
    
    //#pragma mark - runtime
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

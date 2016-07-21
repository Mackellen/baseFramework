//
//  MKAPIManager+User.swift
//  baseFramework
//
//  Created by Mackellen on 16/7/20.
//  Copyright © 2016年 Mackellen. All rights reserved.
//

import Foundation
import RxSwift

class MKAPIManager_User: MKAPIManager {

    class var sharedInstance: MKAPIManager_User {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: MKAPIManager_User? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = MKAPIManager_User()
        }
        return Static.instance!
    }
    

    func getNewsList(diction:NSDictionary)-> Observable<AnyObject>{
        let parameters = NSDictionary.init(dictionary: diction) as! [String:AnyObject]
        return super.requestWithType(MKReqeustType.Get, path: "news/list.do", parameters: parameters).map({ values  in
            let  result =  values as! NSDictionary
            return result.valueForKey("detail")!
        })
    }
    
}

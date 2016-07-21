//
//  MKAPIManager.swift
//  baseFramework
//
//  Created by Mackellen on 16/7/18.
//  Copyright © 2016年 Mackellen. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

enum MKReqeustType {
    case Get
    case Post
    case Patch
}

let prefixPath = "http://api.1-blog.com/biz/bizserver/"

class MKAPIManager: NSObject {
    
    
    // MARK:- request  Type Filter
    func requestWithType(type:MKReqeustType, path:String , parameters:[String: AnyObject]) -> Observable<AnyObject> {
        let basePath = prefixPath+(path)
        
        switch type {
        case .Get:
            return self.interfaceGetWithPath(basePath, parameters: parameters)
        case .Post:
            return self.interfacePostWithPath(basePath, parameters: parameters)
        case .Patch:
            return self.interfacePatchWithPath(basePath, parameters: parameters)
        }
    }
    
    

    // MARK:- POST request
    func interfacePostWithPath(path:String, parameters:[String: AnyObject]) -> Observable<AnyObject> {
        return Observable.create({ observer -> Disposable in
            let reqObject =  Alamofire.request(.POST, path.URLString,parameters:parameters).responseJSON(completionHandler: { responseObject in
                switch  responseObject.result  {
                    case .Success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                        
                    case .Failure(let error):
                        observer.onError(error)
                }
            })
            return AnonymousDisposable{
                reqObject.cancel()
            }
        })
    }

    
    // MARK:-  GET request
    func interfaceGetWithPath(path:String, parameters: [String: AnyObject]) -> Observable<AnyObject>{
        return Observable.create({ observer -> Disposable in
            let reqObject = Alamofire.request(.GET, path.URLString, parameters: parameters).responseJSON(completionHandler: { responseObject in
                switch responseObject.result {
                case .Success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                    
                case .Failure(let error):
                    observer.onError(error)
                }
            })

            return AnonymousDisposable{
                reqObject.cancel()
            }
        })
    }
    
    // MARK:-  Patch request
    func interfacePatchWithPath(path:String, parameters: [String: AnyObject]) -> Observable<AnyObject>{
        return Observable.create({ observer -> Disposable in
            let reqObject = Alamofire.request(.PATCH, path.URLString, parameters: parameters).responseJSON(completionHandler: { responseObject in
                switch responseObject.result {
                case .Success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                    
                case .Failure(let error):
                    observer.onError(error)
                }
            })
            return AnonymousDisposable{
                reqObject.cancel()
            }
        })
    }
    
    
}

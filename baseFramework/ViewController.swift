//
//  ViewController.swift
//  baseFramework
//
//  Created by Mackellen on 16/7/15.
//  Copyright © 2016年 Mackellen. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        MKAPIManager_User.sharedInstance.getNewsList(["size":20]).subscribe(onNext: { object in
                print("objct------------->\(object)")
            }, onError: { type in
                print("type------------->\(type)")
            }, onCompleted: { 
                print("complete------------->onCompleted")
            }).addDisposableTo(bag)
        
        
}

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


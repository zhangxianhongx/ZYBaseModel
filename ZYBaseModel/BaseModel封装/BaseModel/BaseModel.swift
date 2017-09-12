//
//  BaseModel.swift
//  BQPReader
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 BQP. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    //用于判断的属性
    private var zyteststr:String?;
    
    private var _map : Dictionary<String,Any>?;
    
    public var map : Dictionary<String,Any>{
        
        set{
            
            _map = newValue
        }
        
        get{
            
            return _map!
        }
    }
    
   public init(dic:Dictionary<String,Any>) {
        super.init()
        
        setAtribute(dic: dic);
        
    }
       
    
    
    public func setAtribute(dic:Dictionary<String,Any>){
        
        for i in dic.keys{
            
            let keys = i ;
           
            let firstP = keys.substring(to: keys.index(keys.startIndex, offsetBy: 1)).uppercased();
            
            let selectedName = NSString (format: "set%@%@:", firstP,keys.substring(from: keys.index(keys.startIndex, offsetBy: 1)));
            let method :Selector = NSSelectorFromString(selectedName as String);
    
            if self.responds(to: method){
                setKeyForValue(key: keys, dic: dic,method: method);
            }
        }
        
        
        if _map == nil{
            return;
        }
//        对特殊字的处理

        
        for i in (_map?.keys)!{
            let key = i;
            let selectedName : NSString = key as NSString;
            let method :Selector = NSSelectorFromString(selectedName as String);
            if self.responds(to: method){
                setKeyForValue(key: key, dic: dic,method: method);
            }

            
        }
        
        
    }
    
    //数据处理
    private func setKeyForValue(key:String,dic:Dictionary<String, Any>,method:Selector){
        
        if dic[key] is NSNull{
            self.performSelector(onMainThread: method, with: nil, waitUntilDone: Thread.isMainThread);
        }else if let values = dic[key] {
            self.performSelector(onMainThread: method, with: values, waitUntilDone: Thread.isMainThread);
        }else{
            self.performSelector(onMainThread: method, with: nil, waitUntilDone: Thread.isMainThread);
        }
    }
    
    
}

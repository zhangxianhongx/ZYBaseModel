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
    
    var _map : NSDictionary?;
    
    var map : NSDictionary{
        
        set{
            
            _map = newValue
        }
        
        get{
            
            return _map!
        }
    }
    
    init(dic:NSDictionary) {
        super.init()
        
        setAtribute(dic: dic);
        
    }
    
    
    
    
    func setAtribute(dic:NSDictionary){
        
        if dic.isEqual(NSNull()){
           
            return;
        }
        
        let keyArray = dic.allKeys;
        
        for i in 0..<keyArray.count{
            
            let keys : NSString = keyArray[i] as! NSString;
           
            let firstP = keys.substring(to: 1).uppercased();
            
            let selectedName = NSString (format: "set%@%@:", firstP,keys.substring(from: 1));
            let method :Selector = NSSelectorFromString(selectedName as String);
           
            //对特殊数据类型处理
            let ddic = ["strkye":zyteststr,"sex":NSNull.init()] as [String : Any] ;
            if object_getClass(dic.object(forKey: keys)) == object_getClass(ddic["strkye"]) || object_getClass(dic.object(forKey: keys)) == NSNull.classForCoder() || dic.object(forKey: keys) == nil{
                self.performSelector(onMainThread: method, with: "", waitUntilDone: Thread.isMainThread);
                
            }else if self.responds(to: method){
              
                self.performSelector(onMainThread: method, with: dic.object(forKey: keys), waitUntilDone: Thread.isMainThread);
            }
            
        }
        
        
        if _map == nil{
            return;
        }
//        对特殊字的处理
        let mapArray = _map!.allKeys;
        
        for i in 0 ..< mapArray.count{
            let key : NSString = mapArray[i] as! NSString;
            let selectedName : NSString = (_map?.object(forKey: key))! as! NSString;
            let method :Selector = NSSelectorFromString(selectedName as String);
            if self.responds(to: method){
                //对特殊数据类型处理
                let ddic = ["strkye":zyteststr,"sex":NSNull.init()] as [String : Any] ;
                if object_getClass(dic.object(forKey: key)) == object_getClass(ddic["strkye"]) || object_getClass(dic.object(forKey: key)) == NSNull.classForCoder() || dic.object(forKey: key) == nil{
                    self.performSelector(onMainThread: method, with: "", waitUntilDone: Thread.isMainThread);
                }else{
                    self.performSelector(onMainThread: method, with: dic.object(forKey: key), waitUntilDone: Thread.isMainThread);
                    
                }
                
                
                
            }

            
        }
        
        
    }
    
    
    
    
}

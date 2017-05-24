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
    
    var _map : Dictionary<String,Any>?;
    
    var map : Dictionary<String,Any>{
        
        set{
            
            _map = newValue
        }
        
        get{
            
            return _map!
        }
    }
    
    init(dic:Dictionary<String,Any>) {
        super.init()
        
        setAtribute(dic: dic);
        
    }
       
    
    
    func setAtribute(dic:Dictionary<String,Any>){
        
        for i in dic.keys{
            
            let keys = i ;
           
            let firstP = keys.substring(to: keys.index(keys.startIndex, offsetBy: 1)).uppercased();
            
            let selectedName = NSString (format: "set%@%@:", firstP,keys.substring(from: keys.index(keys.startIndex, offsetBy: 1)));
            let method :Selector = NSSelectorFromString(selectedName as String);
    
            if dic[keys] is NSNull{
                self.performSelector(onMainThread: method, with: "", waitUntilDone: Thread.isMainThread);
            }else if dic[keys] == nil {
                self.performSelector(onMainThread: method, with: "", waitUntilDone: Thread.isMainThread);
            }else
            if let values = dic[keys] {
                self.performSelector(onMainThread: method, with: values, waitUntilDone: Thread.isMainThread);
            }else{
                self.performSelector(onMainThread: method, with: "", waitUntilDone: Thread.isMainThread);

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
                
                if dic[key] is NSNull{
                    self.performSelector(onMainThread: method, with: "", waitUntilDone: Thread.isMainThread);
                }else
                    if let values = dic[key] {
                        self.performSelector(onMainThread: method, with: values, waitUntilDone: Thread.isMainThread);
                    }else{
                        self.performSelector(onMainThread: method, with: "", waitUntilDone: Thread.isMainThread);
                        
                }
              
                
                
            }

            
        }
        
        
    }
    
    
    
    
}

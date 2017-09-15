//
//  ZYBaseModel.swift
//  BaseModel封装
//
//  Created by 贝尔特伦 on 2017/9/14.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class ZYBaseModel: NSObject {
    //用于判断的属性
    private var zyteststr:String?;
    
    private var _map : Dictionary<String,String>?;
    
    public var map : Dictionary<String,String>{
        
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
                setKeyForValue(keys, dic,method,false);
            }
        }
        
        
        if _map == nil{
            return;
        }
        //MARK:        对特殊字的处理
        
        
        for i in (_map?.keys)!{
            let key = i;
            let firstP = _map?[key]?.substring(to: (_map?[key]?.index((_map?[key]?.startIndex)!, offsetBy: 1))!).uppercased();
            let selectedName = NSString (format: "set%@%@:", firstP!,(_map?[key]?.substring(from: (_map?[key]?.index((_map?[key]?.startIndex)!, offsetBy: 1))!))!);
            let method :Selector = NSSelectorFromString(selectedName as String);
            if self.responds(to: method){
                setKeyForValue(key, dic,method,true);
            }
            
            
        }
        
        
    }
    
    //MARK: 数据处理
    private func setKeyForValue(_ key:String,_ dic:Dictionary<String, Any>,_ method:Selector, _ isMap:Bool){
        
        let proDic = zygetPropetyType();
       
        let provalue = isMap == true ? proDic?[(_map?[key]!)!] : proDic?[key];
        if dic[key] is NSNull{
            self.performSelector(onMainThread: method, with: nil, waitUntilDone: Thread.isMainThread);
        }else if dic[key] == nil{
            self.performSelector(onMainThread: method, with: nil, waitUntilDone: Thread.isMainThread);
        }else if let values = dic[key] {
            
            if getValueTyep(object: values) == provalue as? String {
                self.performSelector(onMainThread: method, with: values, waitUntilDone: Thread.isMainThread);
            }else{
                self.performSelector(onMainThread: method, with: nil, waitUntilDone: Thread.isMainThread);
            }
            
        }else{
            self.performSelector(onMainThread: method, with: nil, waitUntilDone: Thread.isMainThread);
        }
        
    }
    //MARK: 获取属性类型
    func zygetPropetyType()->Dictionary<String,Any>?{
        var propertyCount:UInt32 = 0;
        let ivars = class_copyPropertyList(self.classForCoder, &propertyCount);
        
        var dic:Dictionary<String,Any> = [:];
        for i in 0..<propertyCount{
            let property = ivars?[Int(i)];
            //获取属性名
            let ivarCstring = property_getName(property);
            let ivarName = String.init(cString: ivarCstring!);
            //获取属性类型
            let typeCstring = property_getAttributes(property);
            let typeName = String.init(cString: typeCstring!);
            
            dic[ivarName] = getTypeClass(typeName: typeName);
            
            
            
        }
        
        return dic;
        
    }
    
    //判断属性的类型
    private func getTypeClass(typeName:String)->String?{
        
        if (typeName.range(of: "NSString") != nil) {
            return "NSString";
        }else if (typeName.range(of: "NSNumber") != nil) {
            return "NSNumber";
        }else if (typeName.range(of: "NSData") != nil) {
            return "NSData";
        }else if (typeName.range(of: "NSDate") != nil) {
            return "NSDate";
        }else if (typeName.range(of: "NSDictionary") != nil) {
            return "NSDictionary";
        }else if (typeName.range(of: "NSArray") != nil) {
            return "NSArray";
        }else if (typeName.range(of: "NSValue") != nil) {
            return "NSValue";
        }
        
        
        return nil;
    }
    //判断数据类型
    func getValueTyep(object:Any)->String?{
        
        if object is NSString {
            return "NSString";
        }else if object is NSNumber {
            return "NSNumber";
        }else if object is NSData {
            return "NSData";
        }else if object is NSDate {
            return "NSDate";
        }else if object is NSDictionary {
            return "NSDictionary";
        }else if object is NSArray {
            return "NSArray";
        }else if object is NSValue {
            return "NSValue";
        }
        return nil;
    }
    
}

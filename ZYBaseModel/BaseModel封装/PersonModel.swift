//
//  PersonModel.swift
//  BaseModel封装
//
//  Created by 贝尔特伦 on 2016/11/7.
//  Copyright © 2016年 ybon. All rights reserved.
//

import UIKit

class PersonModel: ZYBaseModel {

    var name:String?;
    var age:NSNumber?;
    var addr:String?;
    var sex:NSNumber?;
    var intT:Int?;
    var arrT:Array<String>?;
    var dicT:Dictionary<String,Any>?;
    var zYID:NSNumber?;
    override func setAtribute(dic: Dictionary<String, Any>) {
        map = ["id":"zYID"];
        super.setAtribute(dic: dic);
    }
}

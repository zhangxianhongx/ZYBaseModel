//
//  PersonModel.swift
//  BaseModel封装
//
//  Created by ybon on 2016/11/7.
//  Copyright © 2016年 ybon. All rights reserved.
//

import UIKit

class PersonModel: BaseModel {

    var name:String?;
    var age:NSNumber?;
    var addr:String?;
    var sex:NSNumber?;
    
    override func setAtribute(dic: Dictionary<String, Any>) {
        map = ["id":"setZYID:"];
        super.setAtribute(dic: dic);
    }
}

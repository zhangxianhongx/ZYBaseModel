//
//  ViewController.swift
//  BaseModel封装
//
//  Created by ybon on 2016/11/7.
//  Copyright © 2016年 ybon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var str = String();
    var age = NSNumber();
    @IBOutlet weak var viewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        let dataDiac = ["addr":str,"age":age,"sex":NSNull.init(),"name":"sss"] as [String : Any]
        let pModel = PersonModel.init(dic:dataDiac);
        
//        print("ddd",pModel.name,"\n",pModel.age,"\n",pModel.addr,pModel.sex);
        viewLabel.text = pModel.name;
//        viewLabel.text = String.init(format: "%@%@", pModel.sex!,pModel.age!);
      
        
    }


}


//
//  Todo.swift
//  TodoApp
//
//  Created by MaedaAkira on 2017/06/08.
//  Copyright © 2017年 d_na_ser. All rights reserved.
//

import Foundation

class Todo: NSObject,NSCoding {
    var isChecked:Bool
    var todoText:String
    
    override init() {
        isChecked = false
        todoText = ""
    }
    
    //シリアライズ(データを保存できる形にする)
    func encode(with aCoder: NSCoder) {
        aCoder.encode(todoText, forKey: "todoText")
        aCoder.encode(isChecked, forKey: "isChecked")
    }
    
    //デシリアライズ(データを取り出す)
    required init?(coder aDecoder: NSCoder) {
        todoText = (aDecoder.decodeObject(forKey: "todoText") as? String)!
        isChecked = aDecoder.decodeBool(forKey: "isChecked")
    }

}

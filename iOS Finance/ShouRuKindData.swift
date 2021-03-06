//
//  ShouRuKindData.swift
//  iOS Finance
//
//  Created by dawen wang on 16/11/1.
//  Copyright © 2016年 dawen wang. All rights reserved.
//

import Foundation


class ShouRuKindDataModel: NSObject {
    var ShouruKindList=[ShouRuKindInfo]()
    override init(){
        super.init()
        print("沙盒文件夹路径：\(documentsDirectory())")
        print("数据文件路径：\(dataFilePath())")
    }
    func saveData(){
        let data=NSMutableData()
        let archiver=NSKeyedArchiver(forWritingWith: data)
        archiver.encode(ShouruKindList, forKey: "ShouruKindList")
        archiver.finishEncoding()
        data.write(toFile: dataFilePath(), atomically: true)
    }
    func loadData(){
        let path=self.dataFilePath()
        let defaultManager=FileManager()
        if defaultManager.fileExists(atPath: path)
        {
            let data = NSData(contentsOfFile: path)
            let unarchiver=NSKeyedUnarchiver(forReadingWith: data! as Data)
            ShouruKindList=unarchiver.decodeObject(forKey: "ShouruKindList") as! Array
            unarchiver.finishDecoding()
        }
        
    }
    func documentsDirectory() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(
            FileManager.SearchPathDirectory.documentationDirectory,FileManager.SearchPathDomainMask.userDomainMask,true)
        let documentsDirectory:String = paths.first! as String
        return documentsDirectory
    }
    
    func dataFilePath ()->String{
        return self.documentsDirectory().appending("ShouruKindList.plist")
    }
}

//
//  CoreDataController.swift
//  Inventory Of Lounge
//
//  Created by 朱志明 on 2017/3/21.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import UIKit
import CoreData

enum EntityName: String{
    case lounge = "Lounges"
    case items = "Items"
}

class CoreDataController: NSObject {
    
    static func getContext() -> NSManagedObjectContext{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    //保存
    static func save(with context: NSManagedObjectContext) -> Bool{
        do {
            try context.save()
            return true
        } catch  {
            fatalError("insert data fail!")
        }
        return false
    }
    
    //删除
    static func delete(with context: NSManagedObjectContext,with objectID: NSManagedObjectID) ->Bool {
        if let object = context.registeredObject(for: objectID){
            context.delete(object)
            return true
        }
        return false
    }
    
    //如果predicate为nil,则取全部数据
    static func fetch(with context: NSManagedObjectContext,with predicate: NSPredicate?) -> [Lounges] {
        let fetchLounges = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.lounge.rawValue)
        var loungeResult: [Lounges]? = nil
        
        if predicate != nil {
            fetchLounges.predicate = predicate
        }
        do {
            loungeResult = try context.fetch(fetchLounges) as? [Lounges]
        } catch  {
            fatalError("load fail!!")
        }
        return loungeResult!
    }
    
    //修改指定的lounge的Items
    static func modify(with context: NSManagedObjectContext ,modifyEntity: Lounges,predicate: NSPredicate?) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.lounge.rawValue)
        var result: [Lounges]? = nil
        
        if predicate != nil {
            fetchRequest.predicate = predicate
        }
        
        do {
           result = try context.fetch(fetchRequest) as? [Lounges]
        } catch  {
            fatalError("fetch fail!!")
        }
        for tmp in (result?.enumerated())!{
            if tmp.element.loungeName == modifyEntity.loungeName {
               result?[tmp.offset].address = modifyEntity.address
               result?[tmp.offset].contactNumber = modifyEntity.contactNumber
               result?[tmp.offset].item = modifyEntity.item
               break
            }
        }
        do {
            try context.save()
        } catch  {
            fatalError("modify successfully")
        }
        return true
    }

}

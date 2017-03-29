//
//  Inventory_Of_LoungeTests.swift
//  Inventory Of LoungeTests
//
//  Created by 朱志明 on 2017/3/1.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import XCTest
import CoreData
@testable import Inventory_Of_Lounge

class Inventory_Of_LoungeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCoredatacontroller() {
        let entityDescription = NSEntityDescription.entity(forEntityName: EntityName.lounge.rawValue, in: CoreDataController.getContext())
        let lounge = Lounges(entity: entityDescription!, insertInto: CoreDataController.getContext())
        
        let items = Items(entity: NSEntityDescription.entity(forEntityName: EntityName.items.rawValue, in: CoreDataController.getContext())!, insertInto: CoreDataController.getContext())
        items.aisaFood = 10
        items.magazine = 20
        items.wine = 30
        
        lounge.loungeName = "zhuzhiming"
        lounge.address = "First Floor"
        lounge.contactNumber = "1369741574"
        lounge.item = items
        
        XCTAssertTrue(CoreDataController.save(with: CoreDataController.getContext()))
        
        let result: [NSManagedObject] = CoreDataController.fetch(with: CoreDataController.getContext(), with: nil)
        
        print(result)
    }
    
    func testmodify() {
        let context = CoreDataController.getContext()
        let me = Lounges(entity: NSEntityDescription.entity(forEntityName: EntityName.lounge.rawValue, in: context)!, insertInto: context)
        
        me.loungeName = "zhuzhiming"
        me.address = "Second Flood"
        me.contactNumber = "123455675"
        
        XCTAssertTrue(CoreDataController.modify(with: context, modifyEntity: me, predicate: nil))
        
        let result: [NSManagedObject] = CoreDataController.fetch(with: CoreDataController.getContext(), with: nil)
        print(result)
    }
    
    func testdelete() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.lounge.rawValue)
        let context = CoreDataController.getContext()
        var entity: [Lounges]? = nil
        do {
            entity = try context.fetch(request) as? [Lounges]
        } catch  {
            print(false)
        }
        let _ = CoreDataController.delete(with: context, with: (entity?.first?.objectID)!)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

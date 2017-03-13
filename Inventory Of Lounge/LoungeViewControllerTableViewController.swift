//
//  LoungeViewControllerTableViewController.swift
//  Inventory Of Lounge
//
//  Created by 朱志明 on 2017/3/1.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import UIKit
import CoreData

class LoungeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var lastSction: Int? = 0
    var loungeResult: [NSManagedObject]? = nil
    var itemsResult: [NSManagedObject]? = nil
    
    var currentItemsArray: [Int]? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard insertBaseInfo(context: getContext()) else {
            fatalError("insert Base Info fail!!")
        }
        guard fetch(context: getContext()) else {
            fatalError("fetch data fail!!")
        }
        currentItemsArray = [Int](repeating: 0, count: (loungeResult?.count)!)
    }
    
    func insertBaseInfo(context: NSManagedObjectContext) -> Bool {
        let loungeArray = ["The Cabin","The Arrival","The Bridge","The Wing Frist","The Wing Business","The Peri First","The Peri Business"]
        
        var index: Int? = 0
        for loungeName in loungeArray {
            let lounges = NSEntityDescription.insertNewObject(forEntityName: "Lounges", into: context)
            lounges.setValue(index, forKey: "loungeID")
            lounges.setValue(loungeName, forKey: "loungeName")
            lounges.setValue(index!+1, forKey: "itemsAmount")
            index = index! + 1
            
            do {
                try context.save()
            } catch  {
                return false
            }
        }
        return true
    }
    
    func fetch(context: NSManagedObjectContext) -> Bool {
        let fetchLounges = NSFetchRequest<NSFetchRequestResult>(entityName: "Lounges")
        let fetchItems = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
        
        do {
            loungeResult = try context.fetch(fetchLounges) as? [NSManagedObject]
            itemsResult = try context.fetch(fetchItems) as? [NSManagedObject]
        } catch  {
            fatalError("load fail!!")
        }
        return true
    }
    
    func getContext() -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        tableView.dataSource = self
        tableView.delegate = self
       
        tableView.register(UINib(nibName: "LoungeHeaderView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "LoungeCellViewID")
        tableView.register(UINib(nibName: "ValueTableViewCellView", bundle: Bundle.main), forCellReuseIdentifier: "ValueTableViewCellViewID")
        automaticallyAdjustsScrollViewInsets = false
    }
    
    private func setupNavigationBar() {
        let add = UIBarButtonItem(image: #imageLiteral(resourceName: "accordion_more"), style: .plain, target: self, action: #selector(addTabbed))
        navigationItem.title = "Lounge"
        navigationItem.rightBarButtonItem = add
    }
    
    @objc func addTabbed() {
        let addLoungeVC = AddLoungeViewController()
        
        print("fuck!")
        self.present(addLoungeVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension LoungeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "LoungeCellViewID") as! LoungeHeaderView
        headerView.delegate = self
        headerView.section = section
        headerView.LoungeLabel.text = loungeResult?[section].value(forKey: "loungeName") as? String
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    //控制cell的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (currentItemsArray?[section])! as Int
    }
    
    //给cell安装cellView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ValueTableViewCellViewID", for: indexPath) as! ValueTableViewCell
        return cell
    }
    
    func numberOfSections(in: UITableView) -> Int{
        return (loungeResult?.count)!
    }
}

extension LoungeViewController: LoungeHeaderViewDelegate{
    func tapHeaderViewWith(section: Int){
        let amount = loungeResult?[section].value(forKey: "itemsAmount") as! Int
        
        if section != lastSction {
            currentItemsArray?[section] = amount
            currentItemsArray?[lastSction!] = 0
            
            var indexSet = IndexSet()
            indexSet.insert(section)
            indexSet.insert(lastSction!)
            tableView.reloadSections(indexSet, with: .left)
  
            lastSction = section
        }else{
            //当前点击的section与之前的一致时候，
            let countOfItems = (currentItemsArray?[section])! as Int
            
            if countOfItems != 0 {
                currentItemsArray?[section] = 0
            }else{
                currentItemsArray?[section] = amount
            }
            tableView.reloadSections(IndexSet(integer: section), with: .left)
        }
  
    }
    
    func deleteHeaderViewWith(section :Int){
        
    }
    
    func outletInfoWith(section: Int){
        
    }
}



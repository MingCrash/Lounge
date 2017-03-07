//
//  LoungeViewControllerTableViewController.swift
//  Inventory Of Lounge
//
//  Created by 朱志明 on 2017/3/1.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import UIKit

class LoungeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var lastSction: Int? = 0
    var RoungeDictionary: NSMutableDictionary? = nil
    //被展开的items的数据组，直接唯一地控制整个tableView显示的对应结构体
    var currentItemsArray: NSMutableArray? = NSMutableArray()
    var roungeArray: NSArray? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let dataPath = Bundle.main.path(forResource: "data", ofType: "plist")
        RoungeDictionary = NSMutableDictionary(contentsOfFile: dataPath!)
        roungeArray = RoungeDictionary?.allKeys as NSArray?
        
        //获取一个具有结构的而且空白的结构
        for _ in RoungeDictionary! {
            let element: NSMutableArray = NSMutableArray()
            currentItemsArray?.add(element)
        }
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
        headerView.LoungeLabel.text = roungeArray?.object(at: section) as? String
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    //控制cell的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (currentItemsArray?.object(at: section) as! NSMutableArray).count
    }
    
    //给cell安装cellView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ValueTableViewCellViewID", for: indexPath) as! ValueTableViewCell
        return cell
    }
    
    func numberOfSections(in: UITableView) -> Int{
        return (roungeArray?.count)!
    }
}

extension LoungeViewController: LoungeHeaderViewDelegate{
    func tapHeaderViewWith(section: Int){
        //拿到休息室名
        let name = roungeArray?.object(at: section) as! String
        //休息室所对应的items
        let tmpItemsArray = RoungeDictionary!.object(forKey: name) as! NSMutableArray?
        
        if section != lastSction {
            currentItemsArray?.replaceObject(at: section, with: tmpItemsArray as Any)
            currentItemsArray?.replaceObject(at: lastSction!, with: NSMutableArray())
            
            var indexSet = IndexSet()
            indexSet.insert(section)
            indexSet.insert(lastSction!)
            tableView.reloadSections(indexSet, with: .automatic)
  
            lastSction = section
        }else{
            //当前点击的section与之前的一致时候，
            let countOfItems = (currentItemsArray?.object(at: section) as! NSMutableArray).count
            
            if countOfItems != 0 {
                currentItemsArray?.replaceObject(at: section, with: NSMutableArray())
            }else{
                currentItemsArray?.replaceObject(at: section, with: tmpItemsArray as Any)
            }
            
            tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
  
    }
    
    func deleteHeaderViewWith(section :Int){
    
    }
    
    func outletInfoWith(section: Int){
        
    }
}



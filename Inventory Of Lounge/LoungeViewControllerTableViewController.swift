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
    var loungeResult: [Lounges]? = nil
    let context = CoreDataController.getContext()
    var currentItemsArray = [Int]()
    let alter = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
       
        tableView.register(UINib(nibName: "LoungeHeaderView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "LoungeCellViewID")
        tableView.register(UINib(nibName: "ValueTableViewCellView", bundle: Bundle.main), forCellReuseIdentifier: "ValueTableViewCellViewID")
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationitem()
        //
        loungeResult = CoreDataController.fetch(with: context, with: nil)
        //
        for tmp in loungeResult! {
            currentItemsArray.append(Int(tmp.items))
        }
        //
        tableView.reloadData()
        //
        alter.title = "Alter!!"
        alter.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
    
    private func setupNavigationitem() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTabbed))
//        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTabbed))
        navigationItem.title = "Lounges"
        navigationItem.rightBarButtonItem = add
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    @objc func addTabbed() {
        let addVC = AddLoungeViewController()
        navigationController?.pushViewController(addVC, animated: true)
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
        return 1.0
    }
    
    //给cell安装cellView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ValueTableViewCellViewID", for: indexPath) as! ValueTableViewCell
        return cell
    }
    
    func numberOfSections(in: UITableView) -> Int{
        return (loungeResult?.count)!
    }
    
    //控制cell的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (currentItemsArray[section]) as Int
    }
    
    //给row添加编辑模式
    //Asks the data source to verify that the given row is editable.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        print("the \(indexPath.row) can endit")
        return true
    }
    
    //设置左滑出现的文字
    //Changes the default title of the delete-confirmation button.
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        print("the \(indexPath.row) has been swiped!")
        return "Delete!!"
    }
    
    //定义删除的动作内容
    //删除lounge
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id = loungeResult?[indexPath.section].objectID
            guard CoreDataController.delete(with: context, with: id!) else{
                    alter.message = "delete fail!!"
                    present(alter, animated: true, completion: nil)
                    return
                }
            currentItemsArray.remove(at: indexPath.section)
        }
    }
}

extension LoungeViewController: LoungeHeaderViewDelegate{
    func tapHeaderViewWith(section: Int){
        let amount = loungeResult?[section].value(forKey: "items") as! Int
        
        if section != lastSction {
            currentItemsArray[section] = amount
            currentItemsArray[lastSction!] = 0
            
            var indexSet = IndexSet()
            indexSet.insert(section)
            indexSet.insert(lastSction!)
//            tableView.reloadSections(indexSet, with: .none)
            tableView.reloadData()
            
            lastSction = section
        }else{
            //当前点击的section与之前的一致时候，
            let countOfItems = (currentItemsArray[section]) as Int
            
            if countOfItems != 0 {
                currentItemsArray[section] = 0
            }else{
                currentItemsArray[section] = amount
            }
//            tableView.reloadSections(IndexSet(integer: section), with: .none)
            tableView.reloadData()
        }
    }
    
    func deleteHeaderViewWith(section :Int){
        
    }
    
    func outletInfoWith(section: Int){
        
    }
}



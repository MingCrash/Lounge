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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        tableView.dataSource = self
        tableView.delegate = self
       
        tableView.register(UINib(nibName: "LoungeHeaderView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "LoungeCellViewID")
        tableView.register(UINib(nibName: "ValueTableViewCellView", bundle: Bundle.main), forCellReuseIdentifier: "ValueTableViewCellViewID")
        automaticallyAdjustsScrollViewInsets = false
        
       // tableView.reloadData()
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
        headerView.LoungeLabel.text = "Lounge \(section)"
        headerView.backgroundColor = UIColor.red
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.01
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ValueTableViewCellViewID", for: indexPath) as! ValueTableViewCell
        return cell
    }
    
    func numberOfSections(in: UITableView) -> Int{
        return 5
    }
        
    
}
//    func tableView(_ didSelectRowAttableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
//        
//    }



//
//  LoungeViewControllerTableViewController.swift
//  Inventory Of Lounge
//
//  Created by 朱志明 on 2017/3/1.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import UIKit

class LoungeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
//        let add = UIBarButtonItem(image: #imageLiteral(resourceName: "addLounge"), style: .plain, target: self, action: #selector(addTabbed))
        navigationItem.title = "Lounge"
//        navigationItem.rightBarButtonItem = add
    }
    
    @objc func addTabbed() {
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source





}

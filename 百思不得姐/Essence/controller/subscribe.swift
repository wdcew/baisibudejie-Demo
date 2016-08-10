//
//  File.swift
//  百思不得姐
//
//  Created by 高冠东 on 8/3/16.
//  Copyright © 2016 高冠东. All rights reserved.
//
import UIKit

class SubscribeController: UITableViewController {
    lazy var getManager = { AFHTTPSessionManager(baseURL: nil)
    } ()
    var arraydataSource: ArrayDataSource?
    var subscriptList: Array<AnyObject>?
    
    override func viewDidLoad() {
        func setupTableView() {
            tableView.backgroundColor = UIColor(red: 206.0 / 255, green: 206.0 / 255, blue: 206.0 / 255, alpha: 1);
            //设置edges,保证所有 ViewController 中的 content 都不会被tabbar 与navigationBar  遮挡overlay
            self.edgesForExtendedLayout = UIRectEdge.None;
            
            self.automaticallyAdjustsScrollViewInsets = false;
            tableView.registerClass(GDbaseCell.self, forCellReuseIdentifier: "cell")
        }
        
        setupTableView();
    }
    
    //MARK: -GetData
    func loadSubscribeData() {
        let paramDict = ["a":"tag_recommend","action":"sub","c":"topic","type":0]
        getManager.GET("http://api.budejie.com/api/api_open.php",
                       parameters: paramDict,
                       progress: nil,
                       success: { (dataTaske, responseObj) in
                        if let josnDict = responseObj as? NSDictionary {
                            self.subscriptList = NSArray.yy_modelArrayWithClass(GDSubscribeModel.self, json: josnDict);
                            self.setupDataSorce()
                        }
        })
        { (dataTask, erroe) in
                
        }
    }
    
    func setupDataSorce() {
         arraydataSource = ArrayDataSource.init(identifier: "cell",
                                                items: self.subscriptList!,
                                                exeuteClosure: {(cell, item) in
         })
        
        tableView.dataSource = arraydataSource
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}


//MARK: - Class
class ArrayDataSource: NSObject,UITableViewDataSource {
    typealias Exeute = (GDbaseCell, AnyObject) -> Void
    var items :Array<AnyObject>
    let identifier :String
    var execute : Exeute
    
    init(identifier: String, items: Array<AnyObject>,exeuteClosure: Exeute) {
        self.items = items
        self.identifier = identifier
        execute = exeuteClosure
    }
    
    func itemAtIndex(index: Int) -> AnyObject {
        return items[index]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("cell") {
//            cell.configurateForItem
            return cell
        }
        return UITableViewCell(style: .Value1, reuseIdentifier: "tablecell");
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
}

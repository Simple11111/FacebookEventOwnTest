//
//  SearchViewController.swift
//  FacebookEventOwnTest
//
//  Created by Yan Paing Hein on 5/26/16.
//  Copyright © 2016 YanPaingHein. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let recentHistory = ["Mexican restaurants in Del Mar", "Concerts tonight in the city (San Francisco)", "Challenging hike in Tahoe"]
    
    let cellId = "cellId"
    let headerId = "headerId"
    let footerId = "footerId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recentTableView: UITableView = {
            let tableView = UITableView()
            tableView.dataSource = self
            tableView.delegate = self
            tableView.frame = CGRectMake(0, 180, self.view.frame.width, self.view.frame.height)
            tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)

            tableView.separatorStyle = .None
            tableView.registerClass(TableCell.self, forCellReuseIdentifier: cellId)
            tableView.registerClass(Header.self, forHeaderFooterViewReuseIdentifier: headerId)
            tableView.registerClass(Footer.self, forHeaderFooterViewReuseIdentifier: footerId)
            tableView.tableFooterView = UIView()
        
            tableView.sectionHeaderHeight = 50
            tableView.sectionFooterHeight = 50

            return tableView
        }()
                
        navigationController?.navigationBarHidden = true
        
        let searchView: UIView = {
            let view = UIView()
            view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height * 0.27)
            view.backgroundColor = UIColor.whiteColor()
            
            return view
        }()

        let searchDoTextField: UITextField = {
            let textField = UITextField()
            textField.frame = CGRectMake(55, 25, 250, 60)
            
            textField.placeholder = "What do you want to do ?"
            textField.font = UIFont(name: "HelveticaNeue", size: CGFloat(15))
            
            return textField
        }()
        
        let currentTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Current Location"
            textField.frame = CGRectMake(55, 63, 250, 60)
            textField.font = UIFont(name: "HelveticaNeue", size: CGFloat(15))

            return textField
        }()
        
        let searchImageView: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: "search_blue")
            image.frame = CGRectMake(18, 47, 18, 18)
            
            return image
        }()
        
        let currentLocationImageView: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: "location")
            image.tintColor = UIColor(white: 1, alpha: 0.5)
            image.frame = CGRectMake(17, 85, 20, 20)
            
            return image
        }()
        
        let todayImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "today")
            imageView.frame = CGRectMake(18, 125, 18, 18)

            
            return imageView
        }()
        
        let todayTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Today"
            textField.frame = CGRectMake(55, 105, 250, 60)
            textField.font = UIFont(name: "HelveticaNeue", size: CGFloat(15))
            
            return textField
        }()
        
        self.view.addSubview(searchView)
        self.view.addSubview(searchImageView)
        self.view.addSubview(searchDoTextField)
        self.view.addSubview(currentLocationImageView)
        self.view.addSubview(currentTextField)
        self.view.addSubview(todayTextField)
        self.view.addSubview(todayImageView)
        self.view.addSubview(recentTableView)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentHistory.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: CGFloat(14))
        cell.textLabel?.text = "\"\(recentHistory[indexPath.row])\""
        cell.imageView?.image = UIImage(named: "recentSearch")
        
        cell.textLabel?.textColor = UIColor.darkGrayColor()
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(headerId)
        headerView?.backgroundView = UIView(frame: self.view.bounds)
        headerView?.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)

        return headerView
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(footerId)
        footerView?.backgroundView = UIView(frame: self.view.bounds)
        footerView?.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        return footerView
    }
}

class Header: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "SEARCH HISTORY"
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont(name: "HelveticaNeue-Light", size: CGFloat(12))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Footer: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "View More ..."
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont(name: "HelveticaNeue-Light", size: CGFloat(13))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func setupViews() {
        
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-52-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
}

class TableCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
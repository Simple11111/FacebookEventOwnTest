//
//  ViewController.swift
//  FacebookEventOwnTest
//
//  Created by Yan Paing Hein on 5/25/16.
//  Copyright © 2016 YanPaingHein. All rights reserved.
//

import UIKit

let cellId = "cellId"

class Event: NSObject {
    var date: String?
    var day: String?
    var title: String?
    var detailTitle: String?
    var profileImageName: String?
}

class HomePageViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = NSBundle.mainBundle().pathForResource("Events", ofType: "json") {
            do {
                let data = try(NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe))
                
                let jsonDictionary = try(NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers))
                
                if let eventArray = jsonDictionary["events"] as? [[String: AnyObject]] {
                    self.events = [Event]()
                    
                    for eventDictionary in eventArray {
                        let event = Event()
                        event.setValuesForKeysWithDictionary(eventDictionary)
                        self.events.append(event)
                    }
                }
            } catch let err {
                print(err)
            }
        }
        
        let infoButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "InfoButton"), forState: .Normal)
            button.frame = CGRectMake(0, 0, 20, 10)
            
            return button
        }()
        
        let addButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "AddButton"), forState: .Normal)
            button.frame = CGRectMake(0, 0, 15, 15)
            
            return button
        }()
        
        navigationItem.title = "Facebook Events"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: CGFloat(18))!]
        
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if childView is UIImageView {
                    childView.removeFromSuperview()
                }
            }
        }

        navigationItem.setLeftBarButtonItem(UIBarButtonItem(customView: infoButton), animated: true)
        navigationItem.setRightBarButtonItem(UIBarButtonItem(customView: addButton), animated: true)
        navigationController?.navigationBar.translucent = true
        
        collectionView?.alwaysBounceVertical = true

        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        collectionView?.registerClass(EventCell.self, forCellWithReuseIdentifier: cellId)
        
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let eventCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! EventCell
        eventCell.event = events[indexPath.item]
        
        return eventCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(self.view.frame.width, 180)
    }
}

class EventCell: UICollectionViewCell {
    
    var event: Event? {
        didSet {
            if let date = event?.date {
                let attributeText = NSMutableAttributedString(string: date, attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: CGFloat(25))!])
                dateLabel.attributedText = attributeText
            }
            
            if let day = event?.day {
                let attributeText = NSMutableAttributedString(string: day, attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: CGFloat(10))!])
                dayLabel.attributedText = attributeText
            }
            if let title = event?.title {
                let attributeText = NSMutableAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: CGFloat(19))!])
                titleLabel.attributedText = attributeText
            }
            if let detailLabelTitle = event?.detailTitle {
                let attributeText = NSMutableAttributedString(string: detailLabelTitle, attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: CGFloat(14))!])
                detailTitle.attributedText = attributeText
            }
            if let profileImageView = event?.profileImageName {
                imageView.image = UIImage(named: profileImageView)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }

    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.textColor = UIColor.lightGrayColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.textColor = UIColor.lightGrayColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BG1")
        imageView.contentMode = .ScaleAspectFill
        imageView.backgroundColor = UIColor.redColor()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 3
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let detailTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(dateLabel)
        addSubview(dayLabel)
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(detailTitle)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-18-[v0]-30-[v1(275)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dateLabel, "v1": imageView]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-21-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dayLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-90-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": titleLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-25-[v0]-2-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": titleLabel, "v1": detailTitle]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-91-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": detailTitle]))

        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[v0]-1-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dateLabel, "v1": dayLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[v0(170)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
    }
}


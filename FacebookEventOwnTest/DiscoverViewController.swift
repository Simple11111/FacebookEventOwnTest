import UIKit

let recommendId = "recommendId"

class Recommend: NSObject {
    var date: String?
    var day: String?
    var title: String?
    var detailTitle: String?
    var profileImageName: String?
}
class DiscoverViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var recommends = [Recommend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = NSBundle.mainBundle().pathForResource("Events", ofType: "json") {
            do {
                let data = try(NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe))
                
                let jsonDictionary = try(NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers))
                
                if let recommendArray = jsonDictionary["recommended"] as? [[String: AnyObject]] {
                    self.recommends = [Recommend]()
                    
                    for recommendDictionary in recommendArray {
                        let recommend = Recommend()
                        recommend.setValuesForKeysWithDictionary(recommendDictionary)
                        self.recommends.append(recommend)
                    }
                }
            } catch let err {
                print(err)
            }
        }

        navigationItem.title = ""
        
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.alwaysBounceVertical = true
        collectionView?.registerClass(RecommendCell.self, forCellWithReuseIdentifier: recommendId)
        
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if childView is UIImageView {
                    childView.removeFromSuperview()
                }
            }
        }
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommends.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let recommendCell = collectionView.dequeueReusableCellWithReuseIdentifier(recommendId, forIndexPath: indexPath) as! RecommendCell
        recommendCell.recommend = recommends[indexPath.item]
        
        return recommendCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(self.view.frame.width, 180)
    }
}

class RecommendCell: UICollectionViewCell {
    
    var recommend: Recommend? {
        didSet {
            if let date = recommend?.date {
                let attributeText = NSMutableAttributedString(string: date, attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: CGFloat(25))!])
                dateLabel.attributedText = attributeText
            }
            if let day = recommend?.day {
                let attributeText = NSMutableAttributedString(string: day, attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: CGFloat(10))!])
                dayLabel.attributedText = attributeText
            }
            if let title = recommend?.title {
                let attributeText = NSMutableAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: CGFloat(18))!])
                titleLabel.attributedText = attributeText
            }
            if let detailLabelTitle = recommend?.detailTitle {
                let attributeText = NSMutableAttributedString(string: detailLabelTitle, attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: CGFloat(12))!])
                detailTitle.attributedText = attributeText
            }
            if let profileImageView = recommend?.profileImageName {
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
//
//  ActivityCell.swift
//  FunRun
//
//  Created by hideki on 12/5/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {

//    var date:Date!
//    var type:String!
//    var routeName:String!
//    var distance:Double!
//    var duration:String!
//    var avgPace:String!
//    var avgSpeed:Double!
//    var caloriesBurned:Double!
//    var climb:Double!
//    var avgHeartRate:String!
//    var notes:String!
//    var gpxFile:String!
    
    @IBOutlet weak var runImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    let shareImage = UIImage(named: "shared")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    let likeImage = UIImage(named: "like")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    let durationImage = UIImage(named: "duration")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    var leftBtnOn: Bool = false
    var centerBtnOn: Bool = false
    var rightBtnOn: Bool = false
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter
    }()
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mma"
        return formatter
    }()
    
    var activity:Activity!{
        didSet{
            dateLabel.text = ActivityCell.dateFormatter.string(from: activity.date).uppercased()
            timeLabel.text = ActivityCell.timeFormatter.string(from: activity.date)
            if activity.routeName.characters.count == 0 {
                nameLabel.text = String(format: "%@ Run", activity.date.strWeekDay)
            } else {
                nameLabel.text = activity.routeName
            }
            distanceLabel.text =  String(format: "%.2f mi", activity.distance)
            // avgPaceLabel.text = String(format: "%@ min/mi", activity.avgPace)
            durationLabel.text =    String(format: "%@", activity.duration)
            // caloriesBurnedLabel.text = String(format: "%.0f cal", activity.caloriesBurned)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Setup runImageView
        runImageView.layer.cornerRadius = 3.0
        runImageView.clipsToBounds = true
        
        // Setup Buttons
        leftButton.setImage(shareImage, for: UIControlState.normal)
        leftButton.imageView?.alpha = 0.4
        leftButton.imageView?.tintColor = UIColor.lightGray
        leftButton.addTarget(self, action: #selector(leftButtonPressed), for: UIControlEvents.touchUpInside)
        centerButton.setImage(likeImage, for: UIControlState.normal)
        centerButton.imageView?.alpha = 0.4
        centerButton.imageView?.tintColor = UIColor.lightGray
        centerButton.addTarget(self, action: #selector(centerButtonPressed), for: UIControlEvents.touchUpInside)
        rightButton.setImage(durationImage, for: UIControlState.normal)
        rightButton.imageView?.alpha = 0.4
        rightButton.imageView?.tintColor = UIColor.lightGray
        rightButton.addTarget(self, action: #selector(rightButtonPressed), for: UIControlEvents.touchUpInside)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    /* MARK: - helper functions */
    func leftButtonPressed() {
        if leftBtnOn {
            leftButton.imageView?.alpha = 0.4
            leftButton.imageView?.tintColor = UIColor.lightGray
            leftBtnOn = false
        } else {
            leftButton.imageView?.alpha = 1.0
            leftButton.imageView?.tintColor = UIColor.blue
            leftBtnOn = true
        }
    }
    
    func centerButtonPressed() {
        if centerBtnOn {
            centerButton.imageView?.alpha = 0.4
            centerButton.imageView?.tintColor = UIColor.lightGray
            centerBtnOn = false
        } else {
            centerButton.imageView?.alpha = 1.0
            centerButton.imageView?.tintColor = UIColor.blue
            centerBtnOn = true
        }
    }
    
    func rightButtonPressed() {
        if rightBtnOn {
            rightButton.imageView?.alpha = 0.4
            rightButton.imageView?.tintColor = UIColor.lightGray
            rightBtnOn = false
        } else {
            rightButton.imageView?.alpha = 1.0
            rightButton.imageView?.tintColor = UIColor.blue
            rightBtnOn = true
        }
    }
    
}

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
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var avgPaceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var caloriesBurnedLabel: UILabel!
    
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
            avgPaceLabel.text = String(format: "%@ min/mi", activity.avgPace)
            durationLabel.text =    String(format: "%@", activity.duration)
            caloriesBurnedLabel.text = String(format: "%.0f cal", activity.caloriesBurned)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //distanceLabel.textColor = UIColor(red: 53/255,  green: 151/255, blue: 44/255,  alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

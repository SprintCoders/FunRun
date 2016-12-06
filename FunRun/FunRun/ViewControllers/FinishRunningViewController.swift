//
//  FinishRunningViewController.swift
//  FunRun
//
//  Created by DINGKaile on 11/26/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class FinishRunningViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, MakeNoteViewControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var runDayLabel: UILabel!
    @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var distanceViewbox: UIView!
    @IBOutlet weak var durationViewBox: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distanceUnitLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var routeMapView: MKMapView!
    
    @IBOutlet weak var avgPaceViewBox: UIView!
    @IBOutlet weak var bestSpeedViewBox: UIView!
    @IBOutlet weak var CaloriesViewBox: UIView!
    @IBOutlet weak var avgPaceLabel: UILabel!
    @IBOutlet weak var bestSpeedLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var faceViewBox: UIView!
    @IBOutlet weak var face1: UIImageView!
    @IBOutlet weak var face2: UIImageView!
    @IBOutlet weak var face3: UIImageView!
    @IBOutlet weak var face4: UIImageView!
    @IBOutlet weak var face5: UIImageView!
    
    @IBOutlet weak var notesViewBox: UIView!
    @IBOutlet weak var notesLabel: UILabel!
    
    @IBOutlet weak var scheduleViewBox: UIView!
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var totalDistance: Double = 0.0
    var totalTime: UInt32 = 0
    var avgPace: String = ""
    var bestSpeed: Double = 0.0
    var worstSpeed: Double = 0.0
    var calories: UInt32 = 0
    var chosenFace: UIImageView?
    var tabBarHeight: CGFloat = 0.0
    var notes: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.scrollView.clipsToBounds = true
        self.distanceViewbox.layer.borderWidth = 1.0
        self.distanceViewbox.layer.borderColor = UIColor.black.cgColor
        self.durationViewBox.layer.borderWidth = 1.0
        self.durationViewBox.layer.borderColor = UIColor.black.cgColor
        
        // Setup Map View
        self.routeMapView.delegate = self
        self.routeMapView.showsTraffic = false
        
        // Setup Emoji face images and their container view
        let tapFace1 = UITapGestureRecognizer(target: self, action: #selector(tapEmojiFace(gesture:)))
        self.face1.addGestureRecognizer(tapFace1)
        self.face1.tag = 1
        let tapFace2 = UITapGestureRecognizer(target: self, action: #selector(tapEmojiFace(gesture:)))
        self.face2.addGestureRecognizer(tapFace2)
        self.face2.tag = 2
        let tapFace3 = UITapGestureRecognizer(target: self, action: #selector(tapEmojiFace(gesture:)))
        self.face3.addGestureRecognizer(tapFace3)
        self.face3.tag = 3
        let tapFace4 = UITapGestureRecognizer(target: self, action: #selector(tapEmojiFace(gesture:)))
        self.face4.addGestureRecognizer(tapFace4)
        self.face4.tag = 4
        let tapFace5 = UITapGestureRecognizer(target: self, action: #selector(tapEmojiFace(gesture:)))
        self.face5.addGestureRecognizer(tapFace5)
        self.face5.tag = 5
        self.faceViewBox.layer.borderWidth = 1.0
        self.faceViewBox.layer.borderColor = UIColor.black.cgColor
        
        // Setup detail view boxes
        self.avgPaceViewBox.layer.borderWidth = 1.0
        self.avgPaceViewBox.layer.borderColor = UIColor.black.cgColor
        self.bestSpeedViewBox.layer.borderWidth = 1.0
        self.bestSpeedViewBox.layer.borderColor = UIColor.black.cgColor
        self.CaloriesViewBox.layer.borderWidth = 1.0
        self.CaloriesViewBox.layer.borderColor = UIColor.black.cgColor
        
        // Setup other view boxes
        self.notesViewBox.layer.borderWidth = 1.0
        self.notesViewBox.layer.borderColor = UIColor.black.cgColor
        self.scheduleViewBox.layer.borderWidth = 1.0
        self.scheduleViewBox.layer.borderColor = UIColor.black.cgColor
        
        // Setup buttons
        // self.saveBtn.layer.borderWidth = 2.0
        self.saveBtn.layer.cornerRadius = 10.0
        self.saveBtn.clipsToBounds = true
        // let saveBtnClr = self.saveBtn.currentTitleColor
        // self.saveBtn.layer.borderColor = saveBtnClr.cgColor
        self.saveBtn.addTarget(self, action: #selector(saveButtonPressed), for: UIControlEvents.touchUpInside)
        // self.deleteBtn.layer.borderWidth = 2.0
        self.deleteBtn.layer.cornerRadius = 10.0
        self.deleteBtn.clipsToBounds = true
        // let deleteBtnClr = self.deleteBtn.currentTitleColor
        // self.deleteBtn.layer.borderColor = deleteBtnClr.cgColor
        self.deleteBtn.addTarget(self, action: #selector(deleteButtonPressed), for: UIControlEvents.touchUpInside)
        
        // Setup variables
        self.chosenFace = nil
        self.tabBarHeight = (self.tabBarController?.tabBar.frame.height)!
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Review", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false        
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
        self.runDayLabel.text = dateFormatter.string(from: Date()).appending(" Run")
        if self.totalDistance/1609.344 < 0.01 {
            self.distanceLabel.text = String(format: "%.0f", arguments: [self.totalDistance/0.3048])
            self.distanceUnitLabel.text = "feet"
        } else {
            self.distanceLabel.text = String(format: "%.2f", arguments: [self.totalDistance/1609.344])
            self.distanceUnitLabel.text = "miles"
        }
        self.durationLabel.text = TimeCount.convertIntToTime(seconds: self.totalTime)
        self.avgPaceLabel.text = self.avgPace
        self.bestSpeedLabel.text = String(format: "%.2f", arguments: [self.bestSpeed*2.23694])
        self.caloriesLabel.text = "\(self.calories)"
        self.notesLabel.text = self.notes
        
        self.drawRouteOnMap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /* MARK: - Navigation */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "FinishToNote" {
            let makeNoteVC = segue.destination as! MakeNoteViewController
            makeNoteVC.noteDelegate = self
            makeNoteVC.notes = self.notes
        }
    }
    
    
    /* MARK: - MapView Delegate function */
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay.isKind(of: MulticolorPolylineSegment.classForCoder()) {
            let colorPolyline = overlay as! MulticolorPolylineSegment
            let polylineRenderer = MKPolylineRenderer(polyline: colorPolyline)
            polylineRenderer.strokeColor = colorPolyline.color
            polylineRenderer.lineWidth = 8.0
            return polylineRenderer
        }
        return MKOverlayPathRenderer(overlay: overlay)
    }
    
    
    
    /* MARK: - MakeNoteViewControllerDelegate function */
    func makeNoteViewController(finishWithNote note: String) {
        self.notes = note
        self.notesLabel.text = self.notes
    }
    
    /* MARK: - helper functions */
    func tapEmojiFace(gesture: UITapGestureRecognizer) {
        let faceImgView = gesture.view as! UIImageView
        if self.chosenFace != nil {
            self.chosenFace!.alpha = 0.3
        }
        faceImgView.alpha = 1.0
        self.chosenFace = faceImgView
    }
    
    func saveButtonPressed() {
        self.saveRunDataToCoreData {
            _ = self.navigationController?.popToRootViewController(animated: true)
            RunTracker.shared.runningStatus = RunningStatus.notStart
        }
    }
    
    func deleteButtonPressed() {
        let deleteAlert = UIAlertController(title: "Delete this run?", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let confirmAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive) {(UIAlertAction) in
            RunTracker.shared.runningStatus = RunningStatus.notStart
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        deleteAlert.addAction(confirmAction)
        deleteAlert.addAction(cancelAction)
        self.present(deleteAlert, animated: true, completion: nil)
    }

    @IBAction func tapViewToMakeNote(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "FinishToNote", sender: nil)
    }
    
    func getMapRegion() -> MKCoordinateRegion {
        let locationSet = RunTracker.shared.locations
        var minLatitude: Double = (locationSet?.first?.coordinate.latitude)!
        var minLongitude: Double = (locationSet?.first?.coordinate.longitude)!
        var maxLatitude: Double = minLatitude
        var maxLongitude: Double = minLongitude
        for gpsXY in locationSet! {
            if gpsXY.coordinate.latitude < minLatitude {
                minLatitude = gpsXY.coordinate.latitude
            }
            if gpsXY.coordinate.latitude > maxLatitude {
                maxLatitude = gpsXY.coordinate.latitude
            }
            if gpsXY.coordinate.longitude < minLongitude {
                minLongitude = gpsXY.coordinate.longitude
            }
            if gpsXY.coordinate.longitude > maxLongitude {
                maxLongitude = gpsXY.coordinate.longitude
            }
        }
        let center = CLLocationCoordinate2D(latitude: (minLatitude + maxLatitude)*0.5, longitude: (minLongitude + maxLongitude)*0.5)
        let centerSpan = MKCoordinateSpan(latitudeDelta: (maxLatitude - minLatitude)*1.2, longitudeDelta: (maxLongitude - minLongitude)*1.2)
        let fitRegion = MKCoordinateRegion(center: center, span: centerSpan)
        
        return fitRegion
    }
    
    func getPolyline() -> MKPolyline {
        var coords = [CLLocationCoordinate2D]()
        let numOfLocations = RunTracker.shared.locations?.count
        for location in RunTracker.shared.locations! {
            coords.append(location.coordinate)
        }
        return MKPolyline(coordinates: coords, count: numOfLocations!)
    }
    
    func getColoredPolyline() -> [MulticolorPolylineSegment] {
        let meanSpeed = (self.bestSpeed + self.worstSpeed) * 0.5
        let locationSet = RunTracker.shared.locations!
        var colorSegments = [MulticolorPolylineSegment]()
        for index in 1...(locationSet.count-1) {
            let firstLoc = locationSet[index-1]
            let secondLoc = locationSet[index]
            var color: UIColor?
            if secondLoc.speed < meanSpeed {
                let ratio = (secondLoc.speed - self.worstSpeed) / (meanSpeed - self.worstSpeed)
                color = ColorGradient.colorBetweenRedAndYellow(ratio: ratio)
            } else {
                let ratio = (secondLoc.speed - meanSpeed) / (self.bestSpeed - meanSpeed)
                color = ColorGradient.colorBetweenYellowAndBlue(ratio: ratio)
            }
            let colorSegment = MulticolorPolylineSegment(coordinates: [firstLoc.coordinate, secondLoc.coordinate], count: 2)
            colorSegment.color = color
            colorSegments.append(colorSegment)
        }
        return colorSegments
    }
    
    func drawRouteOnMap() {
        if (RunTracker.shared.locations?.count)! > 1 {
            self.routeMapView.setRegion(self.getMapRegion(), animated: true)
            // self.routeMapView.addOverlays([self.getPolyline()])
            self.routeMapView.addOverlays(self.getColoredPolyline())
        }
    }
    
    /*
    @IBOutlet var lineFields:[UITextField]!
    fileprivate let lineEntityName = "Line"
    fileprivate let lineNumberKey = "lineNumber"
    fileprivate let lineTextKey = "lineText"
    */
    
    func saveRunDataToCoreData(completion block: (() -> Void)) {
        do {
            var locationSet = [Any]()
            for location in RunTracker.shared.locations! {
                let oneLocationInfo: [String: Any] = [
                    "latitude": location.coordinate.latitude,
                    "longitude": location.coordinate.longitude,
                    "speed": location.speed,
                    "time": location.timestamp.description
                ]
                locationSet.append(oneLocationInfo as Any)
            }
            let jsonObj = ["data": locationSet]
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObj, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "RunActivity", in: context)
            let transaction = NSManagedObject(entity: entity!, insertInto: context)
            
            transaction.setValue(RunTracker.shared.startTime, forKey: "day")
            transaction.setValue(self.totalDistance, forKey: "totalDistance")
            transaction.setValue(self.totalTime, forKey: "totalDuration")
            transaction.setValue(self.calories, forKey: "totalCalories")
            transaction.setValue(self.bestSpeed, forKey: "bestSpeed")
            transaction.setValue(self.worstSpeed, forKey: "worstSpeed")
            transaction.setValue(jsonData, forKey: "locationSet")
        
            try context.save()
            print("Successfully saved a running data")
        } catch let error as NSError {
            print("Failed to save run data to CoreData: \(error.localizedDescription)")
        } catch {
            print("Unable to save run data to CoreData")
        }
        block()
    }
    
    func retrieveRunDataFromCoreData() {
        /*
         
         //create a fetch request, telling it about the entity
         let fetchRequest: NSFetchRequest<Transcription> = Transcription.fetchRequest()
         
         do {
         //go get the results
         let searchResults = try getContext().fetch(fetchRequest)
         
         //I like to check the size of the returned results!
         print ("num of results = \(searchResults.count)")
         
         //You need to convert to NSManagedObject to use 'for' loops
         for trans in searchResults as [NSManagedObject] {
         //get the Key Value pairs (although there may be a better way to do that...
         print("\(trans.value(forKey: "audioFileUrlString"))")
         }
         } catch {
         print("Error with request: \(error)")
         }
        */
    }
    
    /*
    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return paths[0].appending("data.sqlite")
    }
    */
        
}

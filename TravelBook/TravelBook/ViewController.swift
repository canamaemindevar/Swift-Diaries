//
//  ViewController.swift
//  TravelBook
//
//  Created by Emincan on 23.06.2022.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var commentText: UITextField!
    var selectedTitle = ""
    var selectedTitleId: UUID?
    var annatotionTitle = ""
    var annatotionSubtitle = ""
    var annatotionLatitude = Double()
    var annatotionLongitude = Double()
    
    
    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    var choosenLatitude = Double()
    var choosenLongitude = Double()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // best accuracy costs battery
      //  locationManager.desiredAccuracy = kCLLocationAccuracyKilometer // less battery useage less accuracy
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let gestureRec = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRec.minimumPressDuration = 1
        mapView.addGestureRecognizer(gestureRec)
        
        if selectedTitle != "" {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            let idString = selectedTitleId!.uuidString
            request.predicate = NSPredicate(format: "id = %@",  idString)
            request.returnsObjectsAsFaults = false
       
            do {
                let results = try context.fetch(request)
                if results.count>0{
                    for result in results as! [NSManagedObject]{
                        if let title = result.value(forKey: "title"){
                            annatotionTitle = title as! String
                            if let subtitle = result.value(forKey: "subtitle"){
                                annatotionSubtitle = subtitle as! String
                                if let latitude = result.value(forKey: "latitude"){
                                    annatotionLatitude = latitude as! Double
                                    if let longitutde = result.value(forKey: "longitude"){
                                        annatotionLongitude = longitutde as! Double
                                        let annatotion = MKPointAnnotation()
                                        annatotion.title = annatotionTitle
                                        annatotion.subtitle = annatotionSubtitle
                                        let coordinate = CLLocationCoordinate2D(latitude: annatotionLatitude, longitude: annatotionLongitude)
                                        annatotion.coordinate = coordinate
                                        mapView.addAnnotation(annatotion)
                                        nameText.text = annatotionTitle
                                        commentText.text = annatotionSubtitle
                                        locationManager.stopUpdatingLocation()
                                        
                                        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                        let region = MKCoordinateRegion(center: coordinate, span: span)
                                        mapView.setRegion(region, animated: true)
                            }
                        }
                    }
                        
                }
                        
            }
        }
            } catch{
                
            }
            
        }else {
            
            
        }
        
    }
    
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began{
            let touchPoint = gestureRecognizer.location(in: self.mapView)
            let touchedPoints = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedPoints
            annotation.title = nameText.text
            annotation.subtitle = commentText.text
            
            self.mapView.addAnnotation(annotation)
            choosenLatitude = touchedPoints.latitude
            choosenLongitude = touchedPoints.longitude
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation{return nil}
        
        
        let reuseId = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.tintColor = UIColor.black
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }else{
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if selectedTitle != "" {
            var requestLocation = CLLocation(latitude: annatotionLatitude, longitude: annatotionLongitude)
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placesMarks, error in
                
                if let placeMark = placesMarks{
                    if placeMark.count > 0 {
                        let newPlaceMark = MKPlacemark(placemark: placeMark[0])
                        let item = MKMapItem(placemark: newPlaceMark)
                        item.name = self.annatotionTitle
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                        item.openInMaps(launchOptions: launchOptions)
                    }
                }
                
                
                
            }
        }
    }

    @IBAction func saveButton(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places" , into: context )
        
        
        if nameText.text != "" && commentText.text != ""{
            newPlace.setValue(nameText.text, forKey: "title")
            newPlace.setValue(commentText.text, forKey: "subtitle")
            newPlace.setValue(choosenLatitude, forKey: "latitude")
            newPlace.setValue(choosenLongitude, forKey: "longitude")
            newPlace.setValue(UUID(), forKey: "id")
            
            do {
               try context.save()
                print("succes")
            } catch {
                print("error")
            }
            
            NotificationCenter.default.post(name: NSNotification.Name("newPlace"), object: nil)
            
            
            
        } else {
            let errorMessage = UIAlertController(title: "Attention", message: "No valid expressions.", preferredStyle: .alert)
            errorMessage.addAction(UIAlertAction(title: "Okey", style: .default))
            
            self.present(errorMessage, animated: true)
        }
        
        
    }
}


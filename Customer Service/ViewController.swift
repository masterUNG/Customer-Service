//
//  ViewController.swift
//  Customer Service
//
//  Created by masterUNG on 5/3/2560 BE.
//  Copyright © 2560 EWTC. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //Explicit
    var strName = ""
    var strSurname = ""
    var strPhohe = ""
    var strCurrentName = ""
    var strCureentPhone = ""
    
    var bolStatus = true
    var locationManager = CLLocationManager()
    
    
    @IBOutlet weak var myMap: MKMapView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    @IBAction func userAction(_ sender: Any) {
        
        //Find Name and Phone
        print("currentName ==> " + strCurrentName)
        print("currentPhone ==> " + strCureentPhone)
        
        //Find id of Passenger
        let urlPHP1 = "http://woodriverservice.com/Android/getIDpassengerWhereNamePhone.php?isAdd=true&Name="
        let urlPHP2 = "&Phone="
        let urlPHP3 = urlPHP1 + strCurrentName + urlPHP2 + strCureentPhone
        print("urlPHP ==> " + urlPHP3)
        let urlPHP = URL(string: urlPHP3)
        
        let request = NSMutableURLRequest(url: urlPHP!)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            if error != nil {
                print("Have Error")
            }   else {
                if let unwrappedData = data {
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    print(dataString as Any)
                }
            }
            
        }
        task.resume()
        
        
        
        
    }   // userAction

    
    @IBAction func resetData(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        request.predicate = NSPredicate(format: "name = %@", strCurrentName)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let myName = result.value(forKey: "name") as? String {
                        print("myName ==> " + myName)
                        context.delete(result)
                        
                        do {
                            try context.save()
                            print("Delete Data OK")
                        } catch {
                            print("Have Error")
                        }
                        
                    }
                    
                }
                
            }   else    {
                print("Emty Data")
            }
            
        }   catch {
            print("Cannot Fetch Result")
        }

        
        
        
    }   // resetData
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        //Get Value from TextField
        strName = nameTextField.text!
        strSurname = surnameTextField.text!
        strPhohe = phoneTextField.text!
        
        showLog(messageLog: "strName ==> " + strName)
        showLog(messageLog: "strSurname ==> " + strSurname)
        showLog(messageLog: "strPhone ==> " + strPhohe)
        
        //Sent String to Save on CoreData
        addDataToCoreData(strName: strName, strSurname: strSurname, strPhone: strPhohe)
        
        //Sent String to Server
        saveDataToServer(strName: strName, StrSurname: strSurname, strPhome: strPhohe)
        
        
    }   // saveButton
    
    func saveDataToServer(strName: String, StrSurname: String, strPhome: String) -> Void {
        
        let urlPHP1 = "http://woodriverservice.com/Android/addPassenger.php?isAdd=true&Name="
        let urlpHP2 = "&Phone="
        let urlPHP3 = urlPHP1 + strName + urlpHP2 + strPhome
        let urlPHP4 = urlPHP3
        
        let urlPHP = URL(string: urlPHP4)
        
        print("urlPHP1 ==> " + urlPHP1)
        print("urlPHP2 ==> " + urlpHP2)
        print("urlPHP3 ==> " + urlPHP3)
        
        let request = NSMutableURLRequest(url: urlPHP!)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            if error != nil {
                print("Have Error")
            }   else {
                if let unwrappedData = data {
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    print(dataString as Any)
                }
            }
        
        }
        task.resume()
        
        
    }   // saveDataToServer
    
    
    
    func addDataToCoreData(strName: String, strSurname: String, strPhone: String) -> Void {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newName = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        
        newName.setValue(strName, forKey: "name")
        newName.setValue(strSurname, forKey: "surname")
        newName.setValue(strPhohe, forKey: "phone")
        
        do {
            try context.save()
            print("Save Data OK")
        } catch {
            print("Have Error")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let myName = result.value(forKey: "name") as? String {
                        print("myName ==> " + myName)
                    }
                    
                }
                
            }   else    {
                print("Emty Data")
            }
            
        }   catch {
            print("Cannot Fetch Result")
        }

        
    }   // addDataToCoreDate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("videDidLoad Work")
        
        //Get Location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
       // locationManager.requestLocation()
        
        myMap.showsUserLocation = true
        
       //About Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                print("Data not Emty ==> \(results.count)")
                for result in results as! [NSManagedObject] {
                    
                    if let myName = result.value(forKey: "name") as? String {
                        strCurrentName = myName
                        print("myName ==> " + strCurrentName)
                    }
                    if let myPhone = result.value(forKey: "phone") as? String {
                        strCureentPhone = myPhone
                        print("myPhome ==> " + strCureentPhone)
                    }
                    
                }
                
                nameTextField.alpha = 0
                surnameTextField.alpha = 0
                phoneTextField.alpha = 0
                saveButtonOutlet.alpha = 0
                
                myMap.alpha = 1
            
            }   else    {
                print("Emty Data")
            }
            
        }   catch {
            print("Cannot Fetch Result")
        }
        
        
        
        
    }   // viewDidLoad
    
    func createMap(lat: Double, lng: Double) -> Void {
        
        //About Map
        let lat:CLLocationDegrees = lat
        let lng:CLLocationDegrees = lng
        let latDelta:CLLocationDegrees = 0.05
        let lngDelta:CLLocationDegrees = 0.05
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lngDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let retion:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        myMap.setRegion(retion, animated: true)
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("result ==> \(locations)")
        
        let userLocation: CLLocation = locations[locations.count-1]
        let douLat = userLocation.coordinate.latitude
        let douLng = userLocation.coordinate.longitude
//        print("lat ==>\(douLat)")
//        print("lng ==>\(douLng)")
        
        if bolStatus {
            createMap(lat: douLat, lng: douLng)
            bolStatus = false
        }
        
        
        
        
    }
    
    func animateMap(_ location: CLLocation) {
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)
        myMap.setRegion(region, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }   // didReceiveMemoryWarning
    
    
    func showLog(messageLog:String) -> Void {
        print(messageLog)
    }
    


}   // Main Class


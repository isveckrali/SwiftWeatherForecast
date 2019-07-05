//
//  ViewController.swift
//  KlarnaWeatherForecastChallenge
//
//  Created by Mehmet Can Seyhan on 2019-07-04.
//  Copyright © 2019 Mehmet Can Seyhan. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import SCLAlertView

class ViewController: BaseViewController,CLLocationManagerDelegate {

    // IBOUTLETS
    @IBOutlet var imgIcon: UIImageView!
    @IBOutlet var lblSummary: UILabel!
    @IBOutlet var lblHumidity: UILabel!
    @IBOutlet var lblRain: UILabel!
    @IBOutlet var lblTemparature: UILabel!
    @IBOutlet var lblLocation: UILabel!
    @IBOutlet var activityIndicatorWhite: UIActivityIndicatorView!
    
    //VARİABLES
    let locationManager = CLLocationManager()
    var currentWeatherModel:CurrentWeatherModel?
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    
    //Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        checkInterneConnectionAndLocationInformations()
        // Do any additional setup after loading the view.
       
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {        return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        latitude = locValue.latitude
        longitude = locValue.longitude
        getData(url: "\(Services.BASE_URL)\(latitude),\(longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .notDetermined:
                // If status has not yet been determied, ask for authorization
                manager.requestWhenInUseAuthorization()
                break
            case .authorizedWhenInUse, .authorizedAlways:
                // If authorized when in use
                manager.startUpdatingLocation()
                break
            case .restricted, .denied:
                SCLAlertView().showWarning("Please check location permission", subTitle: "Warning")
                activityIndicatorWhite.stopAnimating()
                // If restricted by e.g. parental controls. User can't enable Location Services
                break
            default:
                break
        }
    }
    
    @IBAction func btnRefreshClicked(_ sender: UIButton) {
        activityIndicatorWhite.startAnimating()
            if Reachability.isConnectedToNetwork() {
                if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                    getData(url: "\(Services.BASE_URL)\(latitude),\(longitude)")
                } else {
                    SCLAlertView().showWarning("Please check location permission", subTitle: "Warning")
                    activityIndicatorWhite.stopAnimating()
                }
            } else {
                activityIndicatorWhite.stopAnimating()
             SCLAlertView().showWarning("Please check your internet connection", subTitle: "Warning")
        }
    }
    
    func checkInterneConnectionAndLocationInformations() {
        if Reachability.isConnectedToNetwork(){
            locationManager.requestWhenInUseAuthorization()
        }else{
            activityIndicatorWhite.stopAnimating()
            SCLAlertView().showWarning("Please check your internet connection", subTitle: "Warning")
        }
    }
    
    func setData() {
        if let model = currentWeatherModel?.currently {
            self.lblTemparature.text = String(model.temperature!) + "°"
            self.lblSummary.text = String(model.summary!)
            self.lblHumidity.text = String(model.humidity!) + "%"
            self.lblRain.text = String(model.precipProbability!) + "%"
            self.lblLocation.text = currentWeatherModel?.timezone!
        } else {
            SCLAlertView().showWarning("An error has occurred while data modelling", subTitle: "Warning")
        } 
    }
    
    func getData(url:String){
        Alamofire.request(url).responseJSON { (dataResponse) in
         do {
             if dataResponse.result.isSuccess {
                self.currentWeatherModel = try JSONDecoder().decode(CurrentWeatherModel.self, from: dataResponse.data!)
                self.setData()
                self.activityIndicatorWhite.stopAnimating()
             } else {
                SCLAlertView().showWarning("Please check your internet connection", subTitle: "Warning")
             }
          } catch {
            SCLAlertView().showWarning(error.localizedDescription, subTitle: "Warning")
        }
     }
   }
}


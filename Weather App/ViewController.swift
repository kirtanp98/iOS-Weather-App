

import UIKit
import CoreLocation


class ViewController: UIViewController, JSONFetcherDelegate, CLLocationManagerDelegate {
    
    var jsonFetcher:JSONFetcher?
    var weather:WeatherModel?
    let userAsked = UserDefaults.standard.bool(forKey: "hasChosen")
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonFetcher = JSONFetcher()
        jsonFetcher?.delegate = self
        jsonFetcher?.fetchWeather(longitute: 40.493630, latitude: -74.504770)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(userAsked)
        checkLocationServices()
    }
    
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
            print(getLatLong())
        } else {
            if userAsked == false {
                showLocationServicesOffPopUp()
            }
        }
    }
    
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()
        print("Location Manger Setup")
    }
    
    
    
    func checkLocationAuthorization() {
        print("Location Authorization Check")
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            if userAsked == false {
                showLocationDisabledPopUp()
            }
            break
        case .authorizedAlways:
            break
        case .denied:
            if userAsked == false {
                showLocationDisabledPopUp()
            }
            break
        @unknown default:
            break
        }
    }
    
    
    
    func userChoseAccess() {
        print("Chose Access")
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "hasChosen")
    }

    
    
    func getLatLong() -> Array<Any> {
        let currentLocation = locationManager.location
        let longitude = currentLocation?.coordinate.longitude as Any
        let latitude = currentLocation?.coordinate.latitude as Any
        
        return [latitude, longitude]
    }
    

    
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Location Access Disabled", message: "Please allow Location Services to enable automatic local weather", preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (ACTION) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
        userChoseAccess()
    }
    
    
    
    func showLocationServicesOffPopUp() {
        let alertController = UIAlertController(title: "Device Location Services Disabled", message: "Please allow Location Services to enable automatic local weather", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        userChoseAccess()
    }
    
    
    
    func didFinishFetching(_ sender: JSONFetcher) {
        weather = jsonFetcher!.weather
        print(weather!.currentWeather.temperature)
    }
    


}

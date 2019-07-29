

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, JSONFetcherDelegate, CLLocationManagerDelegate {
    
    var jsonFetcher:JSONFetcher?
    var weather:WeatherModel?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        jsonFetcher = JSONFetcher()
        jsonFetcher?.delegate = self
        jsonFetcher?.fetchWeather(longitute: 40.493630, latitude: -74.504770)
    }
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
            setupLocationManager()
        } else {
            // Turn on
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
            print(getLatLong())
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            checkLocationAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            print(getLatLong())
        case .denied:
            break
        @unknown default:
            break
        }
    }
    
    func getLatLong() -> Array<Any> {
        let currentLocation = locationManager.location
        let longitude = currentLocation?.coordinate.longitude as Any
        let latitude = currentLocation?.coordinate.latitude as Any
        
        return [latitude, longitude]
    }
    
    func didFinishFetching(_ sender: JSONFetcher) {
        weather = jsonFetcher!.weather
        print(weather!.currentWeather.temperature)
    }
    

}

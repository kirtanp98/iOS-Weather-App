//
//  JSONFetcher.swift
//  Weather App
//
//  Created by Kirtan Patel on 7/28/19.
//  Copyright © 2019 Kirtan Patel. All rights reserved.
//

import Foundation

class JSONFetcher {
    
    var weather:WeatherModel?
    var delegate:JSONFetcherDelegate?
    
    init() {
        self.weather = nil
    }
    
    func fetchWeather(longitute: Double, latitude : Double) {
        let urlString = "https://api.darksky.net/forecast/6fbcf7b85b9cd3021c8a39883c63389d/\(longitute),\(latitude)"
        
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        self.weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                        self.didFetchJSON()
                    } catch let error {
                        print(error)
                    }
                }
                }.resume()
        }
    }
    
    func didFetchJSON() {
        delegate?.didFinishFetching(self)
    }
    
}

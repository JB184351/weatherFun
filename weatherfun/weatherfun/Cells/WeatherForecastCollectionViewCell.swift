//
//  WeatherForecastCollectionViewCell.swift
//  weatherfun
//
//  Created by Justin Bengtson on 10/28/21.
//

import UIKit

class WeatherForecastCollectionViewCell: UICollectionViewCell {
    
    private var weatherLocationNameLabel = UILabel()
    private var weatherLocationDailyTempLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        weatherLocationNameLabel.textColor = .black
        weatherLocationNameLabel.font = .systemFont(ofSize: 17)
        weatherLocationNameLabel.textAlignment = .left
        weatherLocationNameLabel.sizeToFit()
        
        weatherLocationDailyTempLabel.textColor = .black
        weatherLocationDailyTempLabel.font = .systemFont(ofSize: 17)
        weatherLocationDailyTempLabel.textAlignment = .left
        weatherLocationNameLabel.sizeToFit()
    
        self.addSubview(weatherLocationNameLabel)
        self.addSubview(weatherLocationDailyTempLabel)
        
        setupConstraints()
    }
 
    private func setupConstraints() {
        weatherLocationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLocationNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        weatherLocationNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        weatherLocationNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        weatherLocationNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        weatherLocationDailyTempLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLocationDailyTempLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        weatherLocationDailyTempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        weatherLocationDailyTempLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20).isActive = true
        weatherLocationDailyTempLabel.topAnchor.constraint(equalTo: self.weatherLocationNameLabel.topAnchor, constant: 40).isActive = true
    }
    
    public func setup(with model: WeatherProtocol) {
        let weatherForecastModel = model as! WeatherForecast
        weatherLocationNameLabel.text = weatherForecastModel.timezone
        weatherLocationDailyTempLabel.text = "Min Temp: \(weatherForecastModel.daily[0].temp.min) Max Temp: \(weatherForecastModel.daily[0].temp.max)\n"
        
        for i in 1..<weatherForecastModel.daily.count {
            weatherLocationDailyTempLabel.text! +=  "Min Temp: \(weatherForecastModel.daily[i].temp.min) Max Temp: \(weatherForecastModel.daily[i].temp.max)\t"
        }
        
    }
}

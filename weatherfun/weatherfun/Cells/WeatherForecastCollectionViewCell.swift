//
//  WeatherForecastCollectionViewCell.swift
//  weatherfun
//
//  Created by Justin Bengtson on 10/28/21.
//

import UIKit

class WeatherForecastCollectionViewCell: UICollectionViewCell {
    
    private var weatherLocationNameLabel = UILabel()
    
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
    
        self.addSubview(weatherLocationNameLabel)
        
        setupConstraints()
    }
 
    private func setupConstraints() {
        weatherLocationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLocationNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        weatherLocationNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        weatherLocationNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        weatherLocationNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
    }
    
    public func setup(with model: Double) {
        weatherLocationNameLabel.text = "\(model)"
    }
}

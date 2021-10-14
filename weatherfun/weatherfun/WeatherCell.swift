//
//  WeatherCell.swift
//  weatherfun
//
//  Created by Justin Bengtson on 10/13/21.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    private var locationNameLabel = UILabel()
    
    //==================================================
    // MARK: - Init Methods
    //==================================================
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //==================================================
    // MARK: - Setup Methods
    //==================================================
    
    private func setupUI() {
        self.backgroundColor = .white
        
        locationNameLabel.textColor = .black
        locationNameLabel.font = .systemFont(ofSize: 17)
        locationNameLabel.textAlignment = .left
        self.addSubview(locationNameLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        locationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        locationNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        locationNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        locationNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        locationNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
    }
    
    public func setup(with model: Weather) {
        locationNameLabel.text = model.name
    }
    
}

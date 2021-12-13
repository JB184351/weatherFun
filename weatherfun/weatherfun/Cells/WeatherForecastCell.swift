//
//  WeatherForecastCell.swift
//  weatherfun
//
//  Created by Justin Bengtson on 10/25/21.
//

import UIKit

class WeatherForecastCell: UICollectionViewCell {
    
    private var weatherTemps = [Double]()
    private var weatherLocationNameLabel = UILabel()
    private var weatherCurrentTempLabel = UILabel()
    private var weatherForeCastStackView = UIStackView()
    private var locationInfoStackView = UIStackView()
    private var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        weatherForeCastStackView.axis = .vertical
        weatherForeCastStackView.alignment = .fill
        weatherForeCastStackView.distribution = .fillEqually
        
        locationInfoStackView.axis = .horizontal
        locationInfoStackView.alignment = .fill
        locationInfoStackView.distribution = .fill
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
        collectionView.bounces = false
        
        weatherLocationNameLabel.textColor = .black
        weatherLocationNameLabel.font = .systemFont(ofSize: 17)
        weatherLocationNameLabel.textAlignment = .left
        weatherLocationNameLabel.numberOfLines = 2
        weatherLocationNameLabel.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)

        weatherCurrentTempLabel.textColor = .black
        weatherCurrentTempLabel.font = .systemFont(ofSize: 17)
        weatherCurrentTempLabel.textAlignment = .right
        weatherCurrentTempLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

    
        self.addSubview(weatherForeCastStackView)
        self.weatherForeCastStackView.addArrangedSubview(locationInfoStackView)
        self.weatherForeCastStackView.addArrangedSubview(collectionView)
        
        self.locationInfoStackView.addArrangedSubview(weatherLocationNameLabel)
        self.locationInfoStackView.addArrangedSubview(weatherCurrentTempLabel)
        
        setupConstraints()
    }
    
    private func registerCells() {
        collectionView.register(WeatherForecastCollectionViewCell.self, forCellWithReuseIdentifier: "weatherForecastCollectionViewCell")
    }
    
    private func setupConstraints() {
        weatherForeCastStackView.translatesAutoresizingMaskIntoConstraints = false
        weatherForeCastStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        weatherForeCastStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        weatherForeCastStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        weatherForeCastStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    public func setup(with model: WeatherForecast) {
        for temp in model.daily {
            weatherTemps.append(temp.temp.day)
        }
        
        weatherLocationNameLabel.text = model.timezone
        weatherCurrentTempLabel.text = "\(weatherTemps[0])"
        collectionView.reloadData()
    }

}

extension WeatherForecastCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherTemps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weatherTemp = weatherTemps[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherForecastCollectionViewCell", for: indexPath) as! WeatherForecastCollectionViewCell
        cell.backgroundColor = .white
        cell.setup(with: weatherTemp)
        return cell
    }
        
}

extension WeatherForecastCell: UICollectionViewDelegate {
    
}

extension WeatherForecastCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let temp = weatherTemps[indexPath.row]
        let tempString = "\(temp)"
        
        return CGSize(width: tempString.size(withAttributes: nil).width + 25, height: collectionView.bounds.height)
    }
}

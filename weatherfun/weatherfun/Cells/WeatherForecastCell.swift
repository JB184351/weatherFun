//
//  WeatherForecastCell.swift
//  weatherfun
//
//  Created by Justin Bengtson on 10/25/21.
//

import UIKit

class WeatherForecastCell: UICollectionViewCell {
    
    private var weatherLocations = [WeatherProtocol]()
    private var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addToWeatherArray()
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.bounces = false
        
        self.addSubview(collectionView)
        
        setupConstraints()
    }
    
    private func registerCells() {
        collectionView.register(WeatherForecastCollectionViewCell.self, forCellWithReuseIdentifier: "weatherForecastCollectionViewCell")
    }
 
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    private func addToWeatherArray() {
        WeatherAPI.getWeatherForecastForCurrentUserLocation { weatherForecast in
            self.weatherLocations.append(weatherForecast)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    
}

extension WeatherForecastCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherLocations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weatherLocation = weatherLocations[indexPath.row] as! WeatherForecast
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherForecastCollectionViewCell", for: indexPath) as! WeatherForecastCollectionViewCell
        cell.backgroundColor = .white
        cell.setup(with: weatherLocation)
        return cell
    }
    
    
}

extension WeatherForecastCell: UICollectionViewDelegate {
    
}

//TODO: Look into using compositional layout for this scenario OR selfsizing
extension WeatherForecastCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

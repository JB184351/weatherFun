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
        weatherLocationNameLabel.sizeToFit()
        
        weatherCurrentTempLabel.textColor = .black
        weatherCurrentTempLabel.font = .systemFont(ofSize: 17)
        weatherCurrentTempLabel.textAlignment = .left
        weatherCurrentTempLabel.sizeToFit()
    
        self.addSubview(collectionView)
        self.addSubview(weatherLocationNameLabel)
        self.addSubview(weatherCurrentTempLabel)
        
        setupConstraints()
    }
    
    private func registerCells() {
        collectionView.register(WeatherForecastCollectionViewCell.self, forCellWithReuseIdentifier: "weatherForecastCollectionViewCell")
    }
 
    
    private func setupConstraints() {
        weatherLocationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLocationNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        weatherLocationNameLabel.trailingAnchor.constraint(equalTo: self.weatherCurrentTempLabel.leadingAnchor).isActive = true
        weatherLocationNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive = true
        weatherLocationNameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        weatherCurrentTempLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherCurrentTempLabel.leadingAnchor.constraint(equalTo: self.weatherLocationNameLabel.trailingAnchor, constant: -10).isActive = true
        weatherCurrentTempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        weatherCurrentTempLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive = true
        weatherCurrentTempLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.bounds.height / 2).isActive = true
    }
    
    public func setup(with model: TempModel) {
        weatherTemps = model.temps
        weatherLocationNameLabel.text = model.name
        weatherCurrentTempLabel.text = "\(model.currentTemp)"
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

//TODO: Look into using compositional layout for this scenario OR selfsizing
extension WeatherForecastCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let temp = weatherTemps[indexPath.row]
        let tempString = "\(temp)"
        
        return CGSize(width: tempString.size(withAttributes: nil).width + 25, height: collectionView.bounds.height)
    }
}

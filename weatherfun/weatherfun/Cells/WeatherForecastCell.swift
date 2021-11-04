//
//  WeatherForecastCell.swift
//  weatherfun
//
//  Created by Justin Bengtson on 10/25/21.
//

import UIKit

class WeatherForecastCell: UICollectionViewCell {
    
//    private var weatherLocationNameLabel = UILabel()
//    private var weatherLocationDailyTempLabel = UILabel()
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
    
    public func setup(with model: WeatherProtocol) {
        let model = model as! WeatherForecast
//        weatherLocationNameLabel.text = model.timezone
//        weatherLocationDailyTempLabel.text = "\(model.daily[0].temp)"
    }
    
}

extension WeatherForecastCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherForecastCollectionViewCell", for: indexPath) as! WeatherForecastCollectionViewCell
        cell.backgroundColor = .white
        cell.test()
        return cell
    }
    
    
}

extension WeatherForecastCell: UICollectionViewDelegate {
    
}

extension WeatherForecastCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

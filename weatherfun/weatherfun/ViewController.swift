//
//  ViewController.swift
//  weatherfun
//
//  Created by Justin Bengtson on 9/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    var weatherLocations = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToWeatherArray()
        setUpCollectionView()
        registerCells()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.reloadData()
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        self.view.addSubview(collectionView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    }
    
    private func addToWeatherArray() {
        WeatherAPI.getWeatherForCurrentUserLocation { weatherForCurrentLocation in
            self.weatherLocations.append(weatherForCurrentLocation)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func registerCells() {
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: "weatherCell")
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherLocations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weatherLocation = weatherLocations[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as! WeatherCell
        cell.backgroundColor = .blue
        cell.setup(with: weatherLocation)
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
}


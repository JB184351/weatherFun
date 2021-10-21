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
        weatherLocations.removeAll()
        addToWeatherArray()
        setUpCollectionView()
        registerCells()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.reloadData()
    }
    
    private func setUpCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .red
        self.view.addSubview(collectionView)
        setupConstraints()
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let fullItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3)))

        fullItem.contentInsets = NSDirectionalEdgeInsets(
          top: 2,
          leading: 2,
          bottom: 2,
          trailing: 2)
        
        let doubleItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/2),
            heightDimension: .fractionalHeight(1.0)))

        doubleItem.contentInsets = NSDirectionalEdgeInsets(
          top: 2,
          leading: 2,
          bottom: 2,
          trailing: 2)
        
        let doubleGroup = NSCollectionLayoutGroup.horizontal(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1/2)),
          subitems: [doubleItem, doubleItem])
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(5/3)), subitems: [fullItem, doubleGroup])
        
        let section = NSCollectionLayoutSection(group: nestedGroup)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
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
            self.weatherLocations.append(weatherForCurrentLocation)
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


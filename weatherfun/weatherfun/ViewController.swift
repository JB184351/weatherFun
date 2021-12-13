//
//  ViewController.swift
//  weatherfun
//
//  Created by Justin Bengtson on 9/6/21.
//

import UIKit

struct TempModel {
    var name: String
    var currentTemp: Double
    var temps: [Double]
}

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var weatherForecasts = [WeatherForecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addWeatherForecastData()
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
    
    private func registerCells() {
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: "weatherCell")
        collectionView.register(WeatherForecastCell.self, forCellWithReuseIdentifier: "weatherForecastCell")
    }
    
    private func addWeatherForecastData() {
        WeatherAPI.getWeatherForecastForCurrentUserLocation { weatherForecast in
            self.weatherForecasts.append(weatherForecast)
            self.weatherForecasts.append(weatherForecast)
            self.weatherForecasts.append(weatherForecast)
            self.weatherForecasts.append(weatherForecast)
            self.weatherForecasts.append(weatherForecast)
            self.weatherForecasts.append(weatherForecast)
            self.weatherForecasts.append(weatherForecast)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherForecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: Possibly use only one cell type otherwise handle cases where different types of cells might exist at the same time
        let weatherForecast = weatherForecasts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherForecastCell", for: indexPath) as! WeatherForecastCell
        cell.backgroundColor = .systemBlue
        cell.setup(with: weatherForecast)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 2)
    }
}


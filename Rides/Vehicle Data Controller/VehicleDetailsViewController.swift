//
//  VehicleDetailsViewController.swift
//  Rides
//
//  Created by Jay Kaushal on 2022-12-14.
//

import UIKit

class VehicleDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    // MARK: - properties
    
    var model = ""
    var vin = ""
    var carType = ""
    var color = ""
    var kiloMeterTravelled = 0.0
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = 2
        
    }
    
    
    // MARK: - actions
    
    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - functionalities
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VehicleDetailsCollectionViewCell
            
            cell.modelLbl.text = model
            cell.vinLbl.text = vin
            cell.carTypeLbl.text = carType
            cell.colorLbl.text = color
            
            cell.colorView.layer.borderColor = UIColor.init(hexString: "#212121")?.cgColor
            cell.colorView.layer.borderWidth = 1
            cell.colorView.backgroundColor = UIColor.init(name: color) ?? UIColor.white
            
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carbonCell", for: indexPath) as! VehicleCarbonEmissionCollectionViewCell
            
            if kiloMeterTravelled < 5000 {
                kiloMeterTravelled = kiloMeterTravelled * 1
                cell.carbonEmissionLbl.text = "\(kiloMeterTravelled) units/km"
                print(kiloMeterTravelled)
            }
            
            if kiloMeterTravelled > 5000
            {
                kiloMeterTravelled = kiloMeterTravelled - 5000
                kiloMeterTravelled = kiloMeterTravelled * 1.5
                kiloMeterTravelled = kiloMeterTravelled + 5000
                cell.carbonEmissionLbl.text = "\(kiloMeterTravelled) units/km"
                print(kiloMeterTravelled)
            }
            
            
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carbonCell", for: indexPath) as! VehicleCarbonEmissionCollectionViewCell
            
            cell.carbonEmissionLbl.text = "\(kiloMeterTravelled)"
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.section
    }
    
}

extension VehicleListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}

//
//  VehicleDetailsViewController.swift
//  Rides
//
//  Created by Jay Kaushal on 2022-12-14.
//

import UIKit

class VehicleDetailsViewController: UIViewController {
    
    ///OUTLETS
    
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var vinLbl: UILabel!
    @IBOutlet weak var carTypeLbl: UILabel!
    @IBOutlet weak var colorLbl: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    var model = ""
    var vin = ""
    var carType = ""
    var color = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        modelLbl.text = model
        vinLbl.text = vin
        carTypeLbl.text = carType
        colorLbl.text = color
        
        colorView.layer.borderColor = UIColor.init(hexString: "#212121")?.cgColor
        colorView.layer.borderWidth = 1
        colorView.backgroundColor = UIColor.init(name: color) ?? UIColor.white
        
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

}

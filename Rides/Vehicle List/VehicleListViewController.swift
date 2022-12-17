//
//  VehicleListViewController.swift
//  Rides
//
//  Created by Jay Kaushal on 2022-12-14.
//

import UIKit
import Network

class VehicleListViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var dialogView: UIView!
    @IBOutlet weak var filterTf: UITextField!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - properties
    var vehicleData: [VehicleData] = []
    var searchText = ""
    var carType = UIPickerView()
    
    var filterText: String? = nil {
        didSet {
            filterTf?.text = filterText
        }
    }
    
    var filterCarTypes: [VehicleData] {
        
        if filterTf.text == "" {
            return vehicleData
        } else {
            return vehicleData.filter {
                $0.car_type?.localizedCaseInsensitiveContains(filterTf.text ?? "") ?? false
            }
        }
    }
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        
        carType.delegate = self
        carType.dataSource = self
        
        searchTF.delegate = self
        
        filterTf.inputView = carType
        carType.delegate = self
        carType.dataSource = self
        filterTf.delegate = self
        
        filterView.layer.borderWidth = 1
        filterView.layer.borderColor = UIColor.init(hexString: "#212121")?.cgColor
        
        blurView.bounds = self.view.bounds
        dialogView.bounds = CGRect(x: 0.0, y: 0.0, width: 250, height: 250)
        dialogView.layer.cornerRadius = dialogView.frame.size.height/10
        dialogView.clipsToBounds = true
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePicker))
        toolBar.items = [doneButton]
        toolBar.barTintColor = UIColor.white
        toolBar.isUserInteractionEnabled = true
        filterTf.inputAccessoryView = toolBar
        searchTF.inputAccessoryView = toolBar
        
        activityIndicator.isHidden = true
        
        mobileNetwork()
    }
    
    // MARK: - actions
    
    @IBAction func searchBtn(_ sender: UIButton) {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        searchText = searchTF.text ?? "2"
        filterTf.text = ""
        tableView.isHidden = false
        
        if searchText.isNumberValid {
            getData()
        } else {
            tableView.isHidden = true
            displayAlertMessage(userMessage: "Please enter a valid number that ranges between 1 to 100.")
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
        
        mobileNetwork()
        
        tableView.reloadData()
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {
        
        if searchText.isNumberValid {
            animateIn(desiredView: blurView)
            animateIn(desiredView: dialogView)
        } else {
            displayAlertMessage(userMessage: "There is no available list to filter.")
        }
        
    }
    
    @IBAction func filterDialogBtn(_ sender: UIButton) {
        
        animateOut(desiredView: blurView)
        animateOut(desiredView: dialogView)
        tableView.reloadData()
    }
    
    
    // MARK: - functionalities
    
    @objc func donePicker()
    {
        filterTf.resignFirstResponder()
        searchTF.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterCarTypes.count > 0 {
            return filterCarTypes.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VehicleListTableViewCell
        
        let data = filterCarTypes[indexPath.row]
        let viewModel = VehicleViewModel(vin: data.vin, make_and_model: data.make_and_model, color: data.color, car_type: data.car_type, error: data.error)
        
        cell.makeLbl.text = viewModel.make_and_model
        cell.vinLbl.text = viewModel.vin
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "VehicleDetailsViewController") as! VehicleDetailsViewController
        let data = filterCarTypes[indexPath.row]
        let viewModel = VehicleViewModel(vin: data.vin, make_and_model: data.make_and_model, color: data.color, car_type: data.car_type, error: data.error)
        
        vc.model = viewModel.make_and_model ?? ""
        vc.vin = viewModel.vin ?? ""
        vc.carType = viewModel.car_type ?? ""
        vc.color = viewModel.color ?? ""
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return vehicleData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        vehicleData[row].car_type
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        filterTf.text = vehicleData[row].car_type ?? ""
    }
    
    // TO APPEAR THE DIALOG BOX
    func animateIn(desiredView: UIView){
        let bgView = self.view!
        bgView.addSubview(desiredView)
        
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = bgView.center
        
        UIView.animate(withDuration: 0.3) {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 0.9
            self.blurView.backgroundColor = UIColor(hexString: "#212121")
        }
    }
    
    // TO HIDE THE DIALOG BOX
    func animateOut(desiredView: UIView){
        let bgView = self.view!
        bgView.addSubview(desiredView)
        
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
        }, completion: { _ in
            desiredView.removeFromSuperview()
            
        })
    }
    
    //CHECKING NETWORK
    func mobileNetwork()
    {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    print("Connected")
                }
            } else {
                DispatchQueue.main.async {
                    self.displayAlertMessage(userMessage: "Please check the network")
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
            }
            
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
    
    func displayAlertMessage(userMessage: String)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}

//MARK: - API

extension VehicleListViewController  {
    
    func getData()
    {
        if let url = URL(string: "https://random-data-api.com/api/vehicle/random_vehicle?size=\(searchText)"){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if error == nil{
                    print(url)
                    do {
                        
                        let response = try JSONDecoder().decode([VehicleData].self, from: data ?? Data())
                        
                        // DISPATCH TO MAIN QUEUE
                        DispatchQueue.main.async {
                            self.activityIndicator.isHidden = true
                            self.activityIndicator.stopAnimating()
                            
                            // CAPTURE DATA
                            self.vehicleData = response
                            self.tableView.isHidden = false
                            
                            // SORTING THE LIST BASED ON VIN
                            self.vehicleData.sort(by: {$0.vin! < $1.vin!})
                            
                            // RELOAD TABLEVIEW
                            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                            print("API executed successfully!!! ✅ ")
                            
                            //PRINTING THE RESPONSE
                            print(response)
                            print(self.vehicleData.count)
                        }
                        
                    }
                    catch{
                        // ERROR HANDLING
                        DispatchQueue.main.async {
                            self.tableView.isHidden = true
                            self.displayAlertMessage(userMessage: "Maximum allowed size is 100")
                        }
                        
                    }
                }else
                {
                    //ERROR HANDLING
                    self.displayAlertMessage(userMessage: error?.localizedDescription ?? "Data not found")
                }
                
            }.resume()
            
        }
        
    }
    
    
}



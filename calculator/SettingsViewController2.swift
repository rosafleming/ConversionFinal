//
//  SettingsViewController.swift
//  calculator
//
//  Created by Rosa Fleming on 9/23/18.
//  Copyright © 2018 Rosa Fleming. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func settingsChanged(fromUnits: LengthUnit, toUnits: LengthUnit)
    func settingsChanged(fromUnits: VolumeUnit, toUnits: VolumeUnit)
}

class SettingsViewController2: UIViewController {
    
    var pickerData: [String] = [String]()
    var selection : String = ""
    var delegate : SettingsViewControllerDelegate?
    
    var is_Length: Bool = true
    
    @IBOutlet weak var picker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (is_Length == false){
            for item in VolumeUnit.allCases {
                
            }
        }
        
        
        // Do any additional setup after loading the view.
        self.pickerData = ["Yards", "Meters", "Miles"]
        self.picker.delegate = self
        self.picker.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let d = self.delegate {
            d.settingsChanged(fromUnits: LengthUnit(rawValue: selection)!, toUnits: LengthUnit(rawValue: selection)!)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension SettingsViewController2 : UIPickerViewDataSource, UIPickerViewDelegate {
    // The number of columns of data
    func numberOfComponents(in: UIPickerView) -> Int
    {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.selection = self.pickerData[row]
    }
}

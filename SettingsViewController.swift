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

class SettingsViewController: UIViewController {

    
    var From_Text: String = ""
    var To_Text: String = ""
    var pickerData: [String] = [String]()
    var selection : String = ""
    var delegate : SettingsViewControllerDelegate?
    var mode : CalculatorMode = .Length {
        didSet{
            switch(mode){
                case .Length:
                    var vals : [String] = []
                    for val in LengthUnit.allCases{
                        vals.append(val.rawValue)
                    }
                    pickerData = vals
                case .Volume:
                    var vals : [String] = []
                    for val in VolumeUnit.allCases{
                        vals.append(val.rawValue)
                    }
                    pickerData = vals

            }
        }
    }
    
    @IBOutlet weak var From_Label: UILabel!
    @IBOutlet weak var To_Label: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet var Screen: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        picker.isHidden = true
//        for x in LengthUnit.allCases{
//            self.pickerData.append(x.rawValue)
//        }
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        let fromtap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.fromTap))
        self.From_Label.isUserInteractionEnabled = true
        self.From_Label.addGestureRecognizer(fromtap)
        
        let totap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.toTap))
        self.To_Label.isUserInteractionEnabled = true
        self.To_Label.addGestureRecognizer(totap)
        
        let screentap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.screenTap))
        Screen.addGestureRecognizer(screentap)

        From_Label.text = From_Text
        To_Label.text = To_Text
        
        // Do any additional setup after loading the view.
        switch (mode){
        case .Length:
            self.pickerData  = ["Yards", "Meters", "Miles"]
            self.picker.delegate = self
            self.picker.dataSource = self
            
        case .Volume:
            self.pickerData  = ["Liters", "Gallons", "Quarts"]
            self.picker.delegate = self
            self.picker.dataSource = self
        }
        
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

    }

    @objc
    func fromTap(sender:UITapGestureRecognizer){
        From_Label.text = ""
        picker.isHidden = false
    }
    
    @objc
    func toTap(sender:UITapGestureRecognizer){
        To_Label.text = ""
        picker.isHidden = false
    }
    
    @objc
    func screenTap(sender:UITapGestureRecognizer){
        if(From_Label.text == ""){
            From_Label.text = selection
        }
        else if(To_Label.text == ""){
            To_Label.text = selection
        }
        picker.isHidden = true
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if let del = self.delegate{
            switch(mode){
            case .Length:
                del.settingsChanged(fromUnits: LengthUnit(rawValue: From_Label.text!)!, toUnits: LengthUnit(rawValue: To_Label.text!)!)
            case .Volume:
                del.settingsChanged(fromUnits: VolumeUnit(rawValue: From_Label.text!)!, toUnits: VolumeUnit(rawValue: To_Label.text!)!)
            }
        }
        self.dismiss(animated: true, completion: nil)
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


extension SettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate {
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


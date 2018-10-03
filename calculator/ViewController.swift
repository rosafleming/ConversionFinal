//
//  ViewController.swift
//  calculator
//
//  Created by Rosa Fleming on 9/19/18.
//  Copyright © 2018 Rosa Fleming. All rights reserved.
//
import UIKit
import Foundation


class ViewController: UIViewController, SettingsViewControllerDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var from_unit: LengthUnit = LengthUnit.Yards
    var to_unit: LengthUnit = LengthUnit.Meters
    var from_unit_v: VolumeUnit = VolumeUnit.Gallons
    var to_unit_v: VolumeUnit = VolumeUnit.Liters
    var currentMode: CalculatorMode = .Length

    
    @IBOutlet weak var From_Label: UILabel!
    @IBOutlet weak var To_Label: UILabel!
    @IBOutlet weak var yardsInput: UITextField!
    @IBOutlet weak var metersInput: UITextField!
    
    func settingsChanged(fromUnits: LengthUnit, toUnits: LengthUnit) {
        from_unit = fromUnits
        to_unit = toUnits
        
        From_Label.text = from_unit.rawValue
        To_Label.text = to_unit.rawValue
    }
    
    func settingsChanged(fromUnits: VolumeUnit, toUnits: VolumeUnit) {
        from_unit_v = fromUnits
        to_unit_v = toUnits
        
        From_Label.text = from_unit_v.rawValue
        To_Label.text = to_unit_v.rawValue
    }
    
    @objc func dissmissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func clearBoxMeters(){
        self.metersInput.text = ""
    }
    @objc func clearBoxYards(){
        self.yardsInput.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //yardsInput.delegate = self
        //metersInput.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        let detectMetersBox = UITapGestureRecognizer(target: self, action: #selector(self.clearBoxMeters))
        let detectYardsBox = UITapGestureRecognizer(target: self, action: #selector(self.clearBoxYards))
        
        
        self.view.addGestureRecognizer(detectTouch)
        self.metersInput.addGestureRecognizer(detectYardsBox)
        self.yardsInput.addGestureRecognizer(detectMetersBox)
        
        self.view.backgroundColor = BACKGROUND_COLOR
    }

    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

    @IBAction func clearButton(_ sender: UIButton) {
            self.yardsInput.text = ""
            self.metersInput.text = ""
        
    
    }
    
    @IBAction func calculateButton(_ sender: UIButton) {
        
        switch(currentMode){
            case .Length:
                var input: Double = 0.0
                
                if(yardsInput.text == ""){
                    input = Double(self.metersInput.text!)!
                }else if(metersInput.text == "") {
                    input = Double(self.yardsInput.text!)!
                }
                
                var conv_num: Double = 0.0
                var solution: Double = 0.0
                
                for value in lengthConversionTable {
                    if value.key == LengthConversionKey(toUnits: to_unit, fromUnits: from_unit) {
                        conv_num = value.value
                    }
                }
                solution = input * conv_num
                if(metersInput.text == ""){
                    metersInput.text = String(solution)
                }else if(yardsInput.text == ""){
                    yardsInput.text = String(solution)
            }
        case .Volume:
            var input: Double = 0.0
            
            if(yardsInput.text == ""){
                input = Double(self.metersInput.text!)!
            }else if(metersInput.text == "") {
                input = Double(self.yardsInput.text!)!
            }
            
            var conv_num: Double = 0.0
            var solution: Double = 0.0
            
            for value in volumeConversionTable {
                if value.key == VolumeConversionKey(toUnits: to_unit_v, fromUnits: from_unit_v) {
                    conv_num = value.value
                }
            }
            solution = input * conv_num
            if(metersInput.text == ""){
                metersInput.text = String(solution)
            }else if(yardsInput.text == ""){
                yardsInput.text = String(solution)
            }
        }
    }
    @IBAction func mode(_ sender: Any) {
        switch(currentMode){
        case .Length:
            currentMode = .Volume
            From_Label.text = VolumeUnit.Gallons.rawValue
            To_Label.text = VolumeUnit.Liters.rawValue
            yardsInput.placeholder  = "Volume in Gallons"
            metersInput.placeholder = "Volume in Liters"
        case .Volume:
            currentMode = .Length
            From_Label.text = LengthUnit.Yards.rawValue
            To_Label.text = LengthUnit.Meters.rawValue
            yardsInput.placeholder  = "Volume in Yards"
            metersInput.placeholder = "Volume in Meters"
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "SegueToSettings"{
            if let target = segue.destination.childViewControllers[0] as? SettingsViewController{
                target.mode = currentMode
                target.From_Text = From_Label.text!
                target.To_Text = To_Label.text!
                target.delegate = self
            }
        }
    }
}

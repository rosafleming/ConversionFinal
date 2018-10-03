//
//  ViewController.swift
//  calculator
//
//  Created by Rosa Fleming on 9/19/18.
//  Copyright © 2018 Rosa Fleming. All rights reserved.
//
import UIKit
import Foundation


class ViewController2: UIViewController, SettingsViewControllerDelegate {
    
    var from_unit: VolumeUnit = VolumeUnit.Liters
    var to_unit: VolumeUnit = VolumeUnit.Quarts
    
    
    func settingsChanged(fromUnits: LengthUnit, toUnits: LengthUnit) {
        //
    }
    
    func settingsChanged(fromUnits: VolumeUnit, toUnits: VolumeUnit) {
        from_unit = fromUnits
        to_unit = toUnits
    }
    
    
    @IBOutlet weak var yardsInput: UITextField!
    @IBOutlet weak var metersInput: UITextField!
    
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
        // Do any additional setup after loading the view, typically from a nib.
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        let detectMetersBox = UITapGestureRecognizer(target: self, action: #selector(self.clearBoxMeters))
        let detectYardsBox = UITapGestureRecognizer(target: self, action: #selector(self.clearBoxYards))
        
        self.view.addGestureRecognizer(detectTouch)
        self.metersInput.addGestureRecognizer(detectYardsBox)
        self.yardsInput.addGestureRecognizer(detectMetersBox)
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
        
        var input: Double = 0.0
        
        if(yardsInput.text == ""){
            input = Double(self.metersInput.text!)!
        }else if(metersInput.text == "") {
            input = Double(self.yardsInput.text!)!
        }
        
        // let y = Double(self.yardsInput.text!)!
        //let x = Double(self.metersInput.text!)!
        var conv_num: Double = 0.0
        var solution: Double = 0.0
        
        for value in volumeConversionTable {
            if value.key == VolumeConversionKey(toUnits: to_unit, fromUnits: from_unit) {
                conv_num = value.value
            }
        }
        
        solution = input * conv_num
        if(metersInput.text == ""){
            metersInput.text = String(solution)
        }else if(yardsInput.text == ""){
            yardsInput.text = String(solution)
        }
        
        /*if self.yardsInput.text != "" || self.metersInput.text != ""{
         if self.yardsInput.text != ""{
         self.metersInput.text = String(y / 1.0936)}
         else {
         self.yardsInput.text = String(x * 1.0936)}
         }*/
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let dest = segue.destination as? SettingsViewController2 {
            dest.delegate = self
        }
    }
}





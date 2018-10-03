//
//  ConversionCalcTextField.swift
//  calculator
//
//  Created by Rosa Fleming on 9/27/18.
//  Copyright © 2018 Rosa Fleming. All rights reserved.
//

import UIKit

class ConversionCalcTextField: DecimalMinusTextField {

    override func awakeFromNib() {
       
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 1.0
        self.layer.borderColor = FOREGROUND_COLOR.cgColor
        self.layer.cornerRadius = 5.0
        self.textColor = FOREGROUND_COLOR
        
        guard let place = self.placeholder else{
            return
        }
        self.attributedPlaceholder = NSAttributedString(string: place, attributes: [NSAttributedStringKey.foregroundColor :FOREGROUND_COLOR])
        
        
}
}

//
//  ConversionCalcButton.swift
//  calculator
//
//  Created by Rosa Fleming on 9/27/18.
//  Copyright © 2018 Rosa Fleming. All rights reserved.
//

import UIKit

class ConversionCalcButton: UIButton {

    override func awakeFromNib() {
        self.backgroundColor = FOREGROUND_COLOR
         self.tintColor = BACKGROUND_COLOR
        self.layer.cornerRadius = 5.0
    }

}

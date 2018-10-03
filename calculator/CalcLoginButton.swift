//
//  CalcLoginButton.swift
//  calculator
//
//  Created by Rosa Fleming on 9/27/18.
//  Copyright © 2018 Rosa Fleming. All rights reserved.
//

import UIKit

class CalcLoginButton: UIButton {

    override func awakeFromNib() {
        self.backgroundColor = BACKGROUND_COLOR
        self.tintColor = BACKGROUND_COLOR
        self.layer.borderWidth = 1.0
        self.layer.borderColor = BACKGROUND_COLOR
        self.layer.cornerRadius = 5.0
    }

}

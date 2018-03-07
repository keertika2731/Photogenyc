//
//  CKButton.swift
//  SocialNetwork
//
//  Created by Keertika Gupta on 31/03/17.
//  Copyright © 2017 Keertika Gupta. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CKButton:UIButton {
    @IBInspectable var borderColor:CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderColor
        }
    }
    
    
    func configure(){
    
    }
    
    
}

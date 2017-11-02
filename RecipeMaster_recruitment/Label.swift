//
//  Label.swift
//  RecipeMaster_recruitment
//
//  Created by Kacper Kowalski on 02.11.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import Foundation
import UIKit

class InsetLabel: UILabel {
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)))
    }
}

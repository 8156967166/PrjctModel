//
//  SampleTable.swift
//  PrjctModel
//
//  Created by Bimal@AppStation on 03/06/22.

import Foundation
import UIKit
enum Functionality {
    case button
    case buttonImage
    case textFieldLabel
    case labelImage
    case textField
}
class Sample {
    var type: Functionality?
    var identifier: String = ""
    var enteredtxt: String = ""
    var selectedImg: UIImage?
    init () {
    }
    init(strType: Functionality) {
        self.type = strType
        switch type {
        case .button:
            identifier = "table.button"
        case .buttonImage:
            identifier = "table.buttonImg"
        case .textFieldLabel:
            identifier = "table.textLabel"
        case .labelImage:
            identifier = "tabel.labelImg"
        case .textField:
            identifier = "table.textField"
        case .none:
            print("None")
        }
    }
}

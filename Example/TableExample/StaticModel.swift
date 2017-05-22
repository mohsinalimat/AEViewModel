//
//  StaticModel.swift
//  TableExample
//
//  Created by Marko Tadić on 5/8/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Foundation
import Table

extension Model {
    
    static var Settings: Model {
        var model = Model("settings")
        model.sections = [.User, .Device]
        return model
    }
    
}

extension Section {
    
    static var User: Section {
        var section = Section("user")
        section.items = [.Profile]
        return section
    }
    
    static var Device: Section {
        var section = Section("device")
        section.items = [.Airplane, .Wifi]
        return section
    }
    
}

extension Item {
    
    static var Profile: Item {
        var item = Item("profile")
        item.image = "IconGray"
        item.title = "Marko Tadic"
        item.detail = "Apple ID, iCloud, iTunes & App Store"
        return item
    }
    
    static var Airplane: Item {
        var item = Item("airplane")
        item.image = "IconOrange"
        item.title = "Airplane Mode"
        return item
    }
    
    static var Wifi: Item {
        var item = Item("wifi")
        item.image = "IconBlue"
        item.title = "Wi-Fi"
        item.detail = "Off"
        return item
    }
    
}

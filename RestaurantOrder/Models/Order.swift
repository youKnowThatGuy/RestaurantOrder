//
//  Order.swift
//  RestaurantOrder
//
//  Created by Клим on 21.10.2020.
//

import Foundation

class Order{
    var dishList: [Dish]
    var fName: String
    var sName: String
    var bill: Double
    var tipAm: Double
    
    init(dishList: [Dish], fName: String, sName: String, bill: Double, tipAm: Double ) {
        self.sName = sName
        self.fName = fName
        self.dishList = dishList
        self.bill = bill
        self.tipAm = tipAm
    }
    var fullName: String {
        "\(sName) \(fName)"
}
}

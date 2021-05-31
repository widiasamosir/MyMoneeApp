//
//  Impian.swift
//  MyMonee
//
//  Created by Macbook on 15/05/21.
//

import Foundation
struct ImpianResponse: Codable {
    var results: [Impian]?
}
struct Impian : Codable {
    var id : String?
    var name: String?
    var target: Int?
    var reachedTarget: Int?
    var status: Bool?
}

//var wishLists : [Impian] = [Impian(id: 1, name: "Membeli Mobil", target: 200000000, reachedTarget: 1000000, status: false), Impian(id: 2, name: "Membeli Airpods Baru", target: 1500000, reachedTarget: 500000, status: false)]

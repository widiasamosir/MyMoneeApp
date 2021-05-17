//
//  File.swift
//  SampleApp
//
//  Created by Macbook on 11/05/21.
//

import Foundation
protocol SaveData {
    func updateData(pengeluaran: [Pengeluaran])
}
struct Pengeluaran: Codable {
    var id: Int?
    var pengeluaranName: String?
    var pengeluaranPrice: Int?
    var status: Bool = false
    var date: String?
    
}

func dateNow() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    formatter.dateStyle = .medium
    let result = formatter.string(from: date)
    return result
}
var pengeluaran : [Pengeluaran] = [Pengeluaran(id: 1, pengeluaranName: "Bayar Listrik", pengeluaranPrice: 100000, status: true, date: dateNow()), Pengeluaran(id: 2, pengeluaranName: "Bayar Gopay", pengeluaranPrice: 2000000, status: false, date: dateNow())]

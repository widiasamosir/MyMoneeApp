//
//  File.swift
//  SampleApp
//
//  Created by Macbook on 11/05/21.
//

import Foundation

struct Pengeluaran {
    var id: Int?
    var pengeluaranName: String?
    var pengeluaranPrice: Int?
    var status: Bool = false
    var date: String?
}

var pengeluaran : [Pengeluaran] = []
//var pengeluaran : [Pengeluaran] = [Pengeluaran(id: 1, pengeluaranName: "Bayar Listrik", pengeluaranPrice: 100000, status: true, date: "2 Januari 2021"), Pengeluaran(id: 2, pengeluaranName: "Bayar Gopay", pengeluaranPrice: 2000000, status: false, date: "14 Mei 2021"), Pengeluaran(id: 3, pengeluaranName: "Bayar Nonton", pengeluaranPrice: 1000000, status: true),Pengeluaran(id: 4, pengeluaranName: "Bayar Gopay", pengeluaranPrice: 2000000, status: false, date: "14 Mei 2021"), Pengeluaran(id: 5, pengeluaranName: "Bayar Nonton", pengeluaranPrice: 1000000, status: true, date: "14 Mei 2021")]

//
//  Customer.swift
//  MyMonee
//
//  Created by Macbook on 13/05/21.
//

import Foundation
struct Customer : Codable {
    var userName: String?
    var userStatus: String?
    var balance: String?
}

var customer : Customer = Customer( userName: "Widia Angelina", userStatus: "Bagus! Pengeluaranmu lebih sedikit dari Pemasukan", balance: "Rp. 999.000")
//
//extension Encodable {
//    var convertToString: String? {
//        let jsonEncoder = JSONEncoder()
//        jsonEncoder.outputFormatting = .prettyPrinted
//        do {
//            let jsonData = try jsonEncoder.encode(self)
//            return String(data: jsonData, encoding: .utf8)
//        } catch {
//            return nil
//        }
//    }
//}

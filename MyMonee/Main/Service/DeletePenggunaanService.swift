import Foundation

class DeletePenggunaanService {
//    let apiKey: String = "99bc66d74f8686fc34d985741a078dc0"
    
//    let parameters: Pengeluaran? = Pengeluaran(id: "10", pengeluaranName: "Beli Apapun", pengeluaranPrice: 100000, status: false, date: "date 1")
    func deletePenggunaan(id: String,completion: @escaping (_ pengeluaran: Pengeluaran) -> ()) {
        let url: String = "https://60a5e28ac0c1fd00175f4924.mockapi.io/api/v1/pengeluaran/"+id
      
        print("index at delete",id)
        let components = URLComponents(string: url)
        var request = URLRequest(url: (components?.url)!)
                request.httpMethod = "DELETE"
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard error == nil else {
                        print("Error: error calling DELETE")
                        print(error!)
                        return
                    }
                    guard let data = data else {
                        print("Error: Did not receive data")
                        return
                    }
                    guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                        print("Error: HTTP request failed")
                        return
                    }
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            return
                        }
                        
                        print(prettyPrintedJson)
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                }.resume()
    }
}

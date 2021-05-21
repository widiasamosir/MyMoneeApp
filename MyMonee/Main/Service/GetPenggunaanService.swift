import Foundation

class GetPenggunaanService {

    let url: String = "https://60a5e28ac0c1fd00175f4924.mockapi.io/api/v1/pengeluaran"
    
    func loadPengeluaran(completion: @escaping (_ pengeluaran: [Pengeluaran]) -> ()) {
        
        let components = URLComponents(string: self.url)
        
        let request = URLRequest(url: (components?.url)!)
        
        let task = URLSession.shared.dataTask(with: request){(data, response, error) in
            
            if let data = data{
                
                let decoder = JSONDecoder()
                if let pengeluaranList = try? decoder.decode(PengeluaranResponse.self, from: data) as PengeluaranResponse {

                    
                    completion(pengeluaranList.results ?? [])
                }
            }
        }
        
        task.resume()
        
    }
}

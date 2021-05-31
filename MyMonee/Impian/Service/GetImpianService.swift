import Foundation

class GetImpianService {

    let url: String = "https://60a5e28ac0c1fd00175f4924.mockapi.io/api/v1/impian"
    
    func loadImpian(completion: @escaping (_ wishList: [Impian]) -> ()) {
        
        let components = URLComponents(string: self.url)
        
        let request = URLRequest(url: (components?.url)!)
        
        let task = URLSession.shared.dataTask(with: request){(data, response, error) in
            
            if let data = data{
                
                let decoder = JSONDecoder()
                if let wishLists = try? decoder.decode(ImpianResponse.self, from: data) as ImpianResponse {

                    
                    completion(wishLists.results ?? [])
                }
            }
        }
        
        task.resume()
        
    }
}

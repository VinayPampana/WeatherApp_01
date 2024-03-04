import Foundation

public class APIManager {
    
   public static let shared = APIManager()
    
   public enum APIError : Error {
        case error( errorString : String)
    }
    
    
  public func getJSON <T : Decodable>(urlString: String,
                                 dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                 keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                 completion: @escaping (Result<T,APIError>) -> Void){
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(errorString: NSLocalizedString("Invalid URL",comment: ""))))
            return
        }
        
        
        let requesst = URLRequest(url: url)
        URLSession.shared.dataTask(with: requesst) { (data, response, error) in
            if let error = error {
                completion(.failure(.error(errorString: "Error :\(error.localizedDescription)")))
                return
            }
            guard let data = data else{
                completion(.failure(.error(errorString: "Error :\(error?.localizedDescription)")))
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            do{
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
                return
            } catch let decodingError {
                completion(.failure(APIError.error(errorString: "Error : \(error?.localizedDescription)")))
                return
            }
            
            
        }.resume()
    }
}

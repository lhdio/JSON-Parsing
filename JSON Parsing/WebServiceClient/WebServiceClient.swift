//
//  WebServiceClient.swift
//  JSON Parsing
//
//  Created by Raju on 6/8/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import Foundation

struct WebServiceClient {
    
    static let sharedInstance = WebServiceClient()
    
    public func fetchData<T: Decodable>(urlRequest: URLRequest, completion: @escaping (T?, WebServiceError?) ->()) {
  
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if !Reachability.isConnectedToNetwork() {
                completion(nil, .network)
            }
            if error != nil {
                completion(nil, .fetch)
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode, let data = data  else {
                completion(nil, .fetch)
                return
            }
        
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try decoder.decode(T.self, from: data)
                completion(decodedResponse, nil)
            } catch _ {
                completion(nil, .decode)
            }
        }.resume()
    }
}

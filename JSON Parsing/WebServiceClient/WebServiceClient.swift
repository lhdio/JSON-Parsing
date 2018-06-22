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
    
    public func fetchData<T: Decodable>(urlString: String, completion: @escaping (T?, WebServiceError?) ->()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            if !Reachability.isConnectedToNetwork() {
                completion(nil, .noInternetConnection)
            }
            if let err = err {
                print("Failed to fetch data:", err)
                completion(nil, .fetchFailed)
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let obj = try decoder.decode(T.self, from: data)
                completion(obj, nil)
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
                completion(nil, .decodeFailed)
            }
        }.resume()
    }
    
}

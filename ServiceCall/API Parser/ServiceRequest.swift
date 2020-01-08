//
//  ServiceRequest.swift
//  ServiceCall
//
//  Created by gowri anguraj on 08/01/20.
//  Copyright © 2020 gowri anguraj. All rights reserved.
//

import Foundation

class ServiceRequest: URLSession {
    
    /*
    private static let requestEndPoint = "https://carfax-for-consumers.firebaseio.com/assignment.json"
    
    func fetchUsedCarListingsResponse(completion: @escaping (Result<[UsedCarSpecs], Error>) -> ()) {
        guard let url = URL(string:ServiceRequest.requestEndPoint) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, resp, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            do{
                let responseInfo = try JSONDecoder().decode(CarListings.self, from: data!)
                completion(.success(responseInfo.listings))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            } .resume()
    } */
}



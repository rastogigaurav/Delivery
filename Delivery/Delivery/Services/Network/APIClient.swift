//
//  APIClient.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/24/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import Alamofire
import Foundation

struct APIClient {
    
    /// A static/class method used to get deliveries from server
    ///
    /// - Parameters:
    ///   - offset: Starting offset/index for delivery data being fetched
    ///   - limit: Number of items per page being fetched
    ///   - completion: A Completion handler passing Result<[Delivery],Error>
    static func get(deliveriesWith offset:Int, limit:Int, completion:@escaping (Result<[Delivery],DataResponseError>)->Void) {
        Alamofire.request(APIRouter.deliveries(offset: offset, limit: limit))
            .responseJSON { (response) in
                guard let data = response.data else {
                    print("An error occurred while fetching data")
                    completion(.failure(DataResponseError.network))
                    return
                }
                
                do {
                    let jsonDecoder = JSONDecoder()
                    let deliveries = try jsonDecoder.decode([Delivery].self, from: data)
                    print("Data Fetched : \(deliveries)")
                    completion(.success(deliveries))
                } catch {
                    print(error)
                    completion(.failure(DataResponseError.decoding))
                }
        }
    }
}

//
//  APIClient.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/24/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import Alamofire
import CodableAlamofire
import Foundation

enum APIRouter: URLRequestConvertible {
    
    case deliveries(offset: Int, limit: Int)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .deliveries:
            return .get
        }
    }
    
    // MARK: - Path
    private var endpoint: String {
        switch self {
        case .deliveries:
            return "/deliveries"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .deliveries(let offset, let limit):
            return [K.APIParameterKey.offset: offset, K.APIParameterKey.limit: limit]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(endpoint))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}

struct APIClient {
    static func getDeliveries(offset:Int, limit:Int, completion:@escaping (Result<[DeliveryItem]>)->Void) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        Alamofire.request(APIRouter.deliveries(offset: offset, limit: limit))
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<[DeliveryItem]>) in
                print("Result : \(String(describing: response.result.value))")
                completion(response.result)
        }
    }
}

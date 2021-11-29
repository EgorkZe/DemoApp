//
//  URLSession+Extension.swift
//  DemoApp
//
//  Created by Egor Shashkov on 27.11.2021.
//

import Foundation
import UIKit

extension URLSession {
    
    // MARK: - ENUM
    
    enum SessionError: Error {
        case noData
        case statusCode
    }

    /// Wrap, which helps decode result and check response errors.
    /// Get generic type and decode it
    func dataTask<T: Decodable>(with url: URL,
                                completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { (data, response, error) in
            /// Delay response
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                guard error == nil else {
                    completionHandler(nil, response, error)
                    return
                }
                
                if let response = response as? HTTPURLResponse,
                   (200..<300).contains(response.statusCode) == false {
                    completionHandler(nil, response, SessionError.statusCode)
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil, response, SessionError.noData)
                    return
                }
                
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(decoded, response, nil)
                } catch(let error) {
                    completionHandler(nil, response, error)
                }
            }
        }
    }
}

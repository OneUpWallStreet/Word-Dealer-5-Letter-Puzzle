//
//  GeneralRequestManager.swift
//  Juliet
//
//  Created by Arteezy on 2/7/22.
//

import Foundation


class GeneralRequestManager {
    
    static let sharedInstance = GeneralRequestManager()
    
    
    /// Use of for generic get requests like dictionary api
    /// - Parameters:
    ///   - url: pass url as a string
    ///   - completion: returns data fetched from server, otherwise nil
    func generateGETRequest(url: String, completion: @escaping (Data?) -> Void) {
        
        guard let serverURL = URL(string: url) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: serverURL)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("error \(error) and \(error.localizedDescription)")
                completion(nil)
            }
            
            if let data = data {
                completion(data)
            }
            
        }.resume()
        
        
    }
    
    /// Only use as a request to AWS since it contains aws auth token
    /// - Parameters:
    ///   - url: aws api gateway url
    ///   - body: body to send
    ///   - completion: data fetched
    func generatePOSTServerRequest(url: String,body: [String:Any],completion: @escaping (Data?) -> Void)  {
        
        let serverURL = URL(string: url)
        var request = URLRequest(url: serverURL!)
        
        request.setValue(AWSAPIAuthToken.AWSAPIGatewayAuthToken, forHTTPHeaderField: "AuthToken")
        
        let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        request.httpMethod = "POST"
        request.httpBody = bodyData

        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, error in

            if let error = error {
                print("error: \(error) server request POST")
                completion(nil)
            }
            
            if let data = data {
                completion(data)
            }
        }.resume()
    }
    
    
    
}

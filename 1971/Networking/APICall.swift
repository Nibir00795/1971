//
//  APICall.swift
//  JCH VCC
//
//  Created by mobioapp on 6/12/18.
//  Copyright © 2018 Sami. All rights reserved.
//

import UIKit

class APICall: NSObject{
    
    // singleton...
    static let shared = APICall()
    //private override init(){}

    func getHeaderDataFromServer(url: URL, parameter: [String:Any], httpMethodType:String, completion: @escaping (_ success: [String : Any]) -> Void) {
        
        let parameters = parameter
        //create the session object
        
        //        let session = URLSession.shared
        //
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20.0
        sessionConfig.timeoutIntervalForResource = 40.0
        let session = URLSession(configuration: sessionConfig)
        
        //now create the NSMutableRequest object using the url object
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "\(httpMethodType)"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }

        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //        if let authValue = UserDefaults.standard.value(forKey: "accessTocken") as? String {
        //            request.addValue(authValue, forHTTPHeaderField: "Authorization")
        //        }
        //
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                print("error")
                completion(NSDictionary() as! [String : Any])
                return
            }
            
            guard let data = data else {
                print("data")
                completion(NSDictionary() as! [String : Any])
                return
            }
            var responseDict = [String:Any]()
            
            // sending header response from request response
            if let response = response as? HTTPURLResponse {
                var dict = [String:Any]()
                dict["response"] = response
                dict["statusCode"] = response.statusCode
                responseDict["header"] = dict
                //completion(dict)
            }
            // open if request body is needed to parse
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    responseDict["body"] = json
                    completion(responseDict)
                }
            } catch let error {
                responseDict["error"] = error
                completion(responseDict)
                print("error-- \(error.localizedDescription)")
            }
            
        })
        
        task.resume()
    }

    
    func getDataFromServer(url: URL, parameter: [String:Any], httpMethodType:String, completion: @escaping (_ success: [String : Any]) -> Void) {
        
        let parameters = parameter

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20.0
        sessionConfig.timeoutIntervalForResource = 40.0
        let session = URLSession(configuration: sessionConfig)
        
        //now create the NSMutableRequest object using the url object
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "\(httpMethodType)"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
        
       
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        
//        if let authValue = UserDefaults.standard.value(forKey: "accessTocken") as? String {
//            request.addValue(authValue, forHTTPHeaderField: "Authorization")
//        }
//        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
           
            guard error == nil else {
                 print("error")
                completion(NSDictionary() as! [String : Any])
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                    print("Http status code failed!")
                    return
            }
            
            guard let data = data else {
                 print("data")
                completion(NSDictionary() as! [String : Any])
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    var jsonObj = json
                    jsonObj["httpResponse"] = httpResponse
                    completion(jsonObj)
                }
            } catch let error {
                completion(NSDictionary() as! [String : Any])
                print("error-- \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
    func getDataFromServerWithParamaterTypeArray(url: URL, parameter: [NSMutableDictionary], httpMethodType:String, completion: @escaping (_ success: [String : Any]) -> Void) {
        
        let parameters = parameter
        //create the session object
        
        //        let session = URLSession.shared
        //
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20.0
        sessionConfig.timeoutIntervalForResource = 40.0
        let session = URLSession(configuration: sessionConfig)
        
        //now create the NSMutableRequest object using the url object
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "\(httpMethodType)"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            print("request = \(request.httpBody!)")
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                print("error")
                completion(NSDictionary() as! [String : Any])
                return
            }
            
            guard let data = data else {
                print("data")
                completion(NSDictionary() as! [String : Any])
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    completion(json)
                }
            } catch let error {
                completion(NSDictionary() as! [String : Any])
                print("error-- \(error.localizedDescription)")
            }
        })
        task.resume()
        
    }
    
    func getDataFromServerWithAuthorization(url: URL, parameter: [String:Any], httpMethodType:String, Authorization : String, completion: @escaping (_ success: [String : Any]) -> Void) {
        
        let parameters = parameter
        //create the session object
        //let session = URLSession.shared
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20.0
        sessionConfig.timeoutIntervalForResource = 40.0
        let session = URLSession(configuration: sessionConfig)
        
        //now create the NSMutableRequest object using the url object
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "\(httpMethodType)"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(Authorization, forHTTPHeaderField: "Authorization")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                print("error")
                completion(NSDictionary() as! [String : Any])
                return
            }
            
            guard let data = data else {
                print("data")
                completion(NSDictionary() as! [String : Any])
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    completion(json)
                }
            } catch let error {
                completion(NSDictionary() as! [String : Any])
                print("error-- \(error.localizedDescription)")
            }
        })
        task.resume()
        
    }
    
    func getDataFromServerWithoutSerialization(url: URL, parameter: [String:Any], httpMethodType:String, completion: @escaping (_ data: Data?, _ response:URLResponse?, _ errir:Error?) -> Void) {
        
        let parameters = parameter
        //create the session object
        
        //        let session = URLSession.shared
        //
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20.0
        sessionConfig.timeoutIntervalForResource = 40.0
        let session = URLSession(configuration: sessionConfig)
        
        //now create the NSMutableRequest object using the url object
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "\(httpMethodType)"
        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
//            
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        
//        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       // request.addValue("application/json", forHTTPHeaderField: "Accept")
        if let authorization_Token = UserDefaults.standard.string(forKey: "access_token"){
            print("token.......................: ",authorization_Token)
            request.setValue(authorization_Token, forHTTPHeaderField: "Authorization")
        }
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            completion(data, response,error)
        })
        task.resume()
        
    }
    
    func GET(url: URL, completion: @escaping (_ response: [String : Any], _ success:Bool) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url as URL, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data else {
                completion([String : Any](),false)
                return
            }
            
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                completion(result,true)
            } catch {
                fatalError("json error: \(error)")
            }
        })
        task.resume()
    }
    
    func GET_WithoutSerialization(url: URL, completion: @escaping (_ data: Data?, _ response:URLResponse?, _ errir:Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url as URL, completionHandler: { (data, response, error) -> Void in
            do {
                let result = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                print("resut = \(result)")
            } catch {
                fatalError("json error: \(error)")
            }
            completion(data, response,error)
        })
        
        task.resume()
    }
    
    //zihan
    
    func GET(url: URL, completion: @escaping (_ response: URLResponse?, _ data:Data?, _ error: Error?) -> Void) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
      
        
        let task =  URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            
          //  guard let httpResponse = response as? HTTPURLResponse else {return}
            
            completion(response,data,error)
        })
        task.resume()
        
    }
    
  
    func getDataFromServer(url: URL,parameter: [String:Any]? = nil, httpMethodType:String, completion: @escaping (_ response: URLResponse?, _ data:Data?, _ error: Error?) -> Void){
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20.0
        sessionConfig.timeoutIntervalForResource = 40.0
        let session = URLSession(configuration: sessionConfig)
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "\(httpMethodType)"
        
        if parameter != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameter!, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue(authorization, forHTTPHeaderField: "Authorization")
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            completion(response,data,error)
        })
        task.resume()
    }
    
    func getDataFromServer(url: URL, authorization : String? = nil, parameter: [String:Any]? = nil, httpMethodType:String, completion: @escaping (_ response: URLResponse?, _ data:Data?, _ error: Error?) -> Void){
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20.0
        sessionConfig.timeoutIntervalForResource = 40.0
        let session = URLSession(configuration: sessionConfig)
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "\(httpMethodType)"
        
        if let  parameter = parameter  {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        
        if let authorization_Token = UserDefaults.standard.string(forKey: "access_token"){
            
          request.setValue(authorization_Token, forHTTPHeaderField: "Authorization")
          print(authorization_Token)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            completion(response,data,error)
        })
        task.resume()
    }
    
        func getPostString(params:[String:Any]) -> String
        {
            var data = [String]()
            for(key, value) in params
            {
                data.append(key + "=\(value)")
            }
            return data.map { String($0) }.joined(separator: "&")
        }

        func callPost(url:URL, httpMethodType:String, params:[String:Any], finish: @escaping ((message:String, data:Data?)) -> Void)
        {
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = 20.0
            sessionConfig.timeoutIntervalForResource = 40.0
            let session = URLSession(configuration: sessionConfig)
            
            var request = URLRequest(url: url)
            request.httpMethod = "\(httpMethodType)"

            let postString = self.getPostString(params: params)
            request.httpBody = postString.data(using: .utf8)

            var result:(message:String, data:Data?) = (message: "Fail", data: nil)
            let task = session.dataTask(with: request) { data, response, error in

                if(error != nil)
                {
                    result.message = "Fail Error not null : \(error.debugDescription)"
                }
                else
                {
                    result.message = "Success"
                    result.data = data
                }

                finish(result)
            }
            task.resume()
        }
        
}


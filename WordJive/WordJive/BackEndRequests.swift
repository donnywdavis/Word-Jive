//
//  BackEndRequests.swift
//  WordJive
//
//  Created by Nick Perkins on 5/17/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import Foundation

enum BackEndURLs : String {
    case Capabilities = "https://floating-taiga-20677.herokuapp.com/capabilities"
    case Puzzle = "https://floating-taiga-20677.herokuapp.com/puzzle"
}

class BackEndRequests : AnyObject {
    
    var receivedData : NSMutableData?
    class func getCapabilities() {
        
    }
    
    class func getPuzzle() {
        
    }
    
    private class func startSession(urlString: BackEndURLs) {
        
        let url = NSURL(string: urlString.rawValue)
        let urlSessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let urlSession = NSURLSession(configuration: urlSessionConfig)
        
        let task = urlSession.dataTaskWithURL(url!)
        task.resume()
        
    }
    
//    @objc func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
//        
//        receivedData?.appendData(data)
//        
//    }
//    
//    @objc func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
//        guard let receivedData = receivedData else
//        {
//            self.receivedData = nil
//            return
//        }
//        if (error != nil){
//            
////            let data = NSJSONSerialization.dataWithJSONObject(receivedData, options: NSJSONWritingOptions.PrettyPrinted) as? [String:String]
//            
//        }
//        
//    }
    
}


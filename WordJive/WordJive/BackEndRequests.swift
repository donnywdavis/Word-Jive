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
    
    weak static var delegate: CapabilitiesDelegate?
    
    var receivedData : NSMutableData?
    
    
    class func getCapabilities() {
        startSession(BackEndURLs.Capabilities)
    }
    
    class func getPuzzle() {
        
    }
    
    private class func startSession(urlString: BackEndURLs) {
        
        let url = NSURL(string: urlString.rawValue)
        let urlRequest = NSMutableURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            let urlValue = httpResponse.URL?.absoluteString
            
            if (statusCode == 200) {
                parseData(data!, urlString: urlValue!)
            }
        }
        
        task.resume()
        
    }
    
    private class func parseData(data: NSData, urlString: String) {
        switch urlString {
        case BackEndURLs.Capabilities.rawValue:
            do {
                let parsedData = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [[String: String]]
                delegate?.availableCapabilities(parsedData!)
            } catch {
                print("Uh oh!")
            }
            
        case BackEndURLs.Puzzle.rawValue:
            break
            
        default:
            break
        }
    }
    
}


//
//  DownloadURLData.swift
//  GameList
//
//  Created by guest2 on 23/07/15.
//  Copyright (c) 2015 guest2. All rights reserved.
//

import Foundation
import UIKit

//class to download data from URL and pass it jsonparser

class DownloadURLData:NSObject {
    
    var gameDataList = [GameData]()
    
    var parseJsonContent:ParseJsonContent!
    
    init(url:String) {
        
        
        var URL:NSURL = NSURL(string: url)!
        
        var request = NSMutableURLRequest(URL:URL)
        
        var response: NSURLResponse?
        
        var error: NSError?
        
        
        var data:NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error:&error)!
        
        if error == nil {
            
            parseJsonContent = ParseJsonContent(data: data)
        
            self.gameDataList =  parseJsonContent.gameDataArray
        
        
    
        }
        else
        {
            let alert = UIAlertView(title:"Oops!",message:error?.description, delegate:nil, cancelButtonTitle:"OK")
            alert.show()
        }


        
    }
    
    
}
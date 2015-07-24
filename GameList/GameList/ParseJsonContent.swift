//
//  ParseJsonContent.swift
//  GameList
//
//  Created by guest2 on 23/07/15.
//  Copyright (c) 2015 guest2. All rights reserved.
//

import Foundation
import UIKit

//class to pasrse the json content and pass to GameInfoData to store them

class ParseJsonContent:NSObject {
    
    
    var links:NSMutableDictionary = NSMutableDictionary()
    
    var prevLink:String = ""
    
    var nextLink:String = ""
    
    var gameDataArray = [GameData]()
    
    
    init(data:NSData) {
        
        
        
        let jsonData = JSON(data:data)
        

        
        if let prev = jsonData["_links"]["prev"].string {
            
            self.prevLink = jsonData["_links"]["prev"].string!
            
            
        }
        
        
        if let next = jsonData["_links"]["next"].string {
            
            self.nextLink = jsonData["_links"]["next"].string!
            
            
        }
        
       
        if let topGames = jsonData["top"].array {
            
            for topGame in topGames {
                
                
                var gameData:GameData = GameData()
                
                
                if topGame["viewers"].int != 0 {
                    
                    gameData.viewers = topGame["viewers"].int!
                }
                
                if topGame["channels"].int != 0 {
                    
                    gameData.channels = topGame["channels"].int!
                }
                
                if topGame["game"]["name"].string != "" {
                    
                    gameData.title = topGame["game"]["name"].string
                }
            
                if topGame["game"]["giantbomb_id"].int != 0 {
                    
                    gameData.bombId = topGame["game"]["giantbomb_id"].int!
                }
                
                
                if topGame["game"]["_id"].int != 0 {
                    
                    gameData.gameId = topGame["game"]["_id"].int!
                }
                
                
                
                
                for (key: String, subJson: JSON) in topGame["game"]["box"] {
                    
                    var str:NSString = topGame["game"]["box"][key].description
                    
                    gameData.boxURLs.setObject(str, forKey: key)
                }
                
                
                for (key: String, subJson: JSON) in topGame["game"]["logo"] {
                    
                    var str:NSString = topGame["game"]["logo"][key].description
                    
                    gameData.iconURLs.setObject(str, forKey: key)
                }
                
                
                gameDataArray.append(gameData)
                
               
            }
            
            
            
        }
        
        
    }
    
}
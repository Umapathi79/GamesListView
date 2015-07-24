//
//  GameData.swift
//  GameList
//
//  Created by guest2 on 23/07/15.
//  Copyright (c) 2015 guest2. All rights reserved.
//

import Foundation
import UIKit

//class to store information of each game parsed from json content

class GameData:NSObject {
    
    var gameData:NSData!
    var iconData:NSData!
    
    var title:String!
    var bombId:Int = 0
    var gameId:Int = 0
    
    var viewers:Int = 0
    var channels:Int = 0
    
    var gameImage:UIImageView!
    var iconImage:UIImageView!
    
    var boxURLs:NSMutableDictionary = NSMutableDictionary()
    
    var iconURLs:NSMutableDictionary = NSMutableDictionary()
    
    override init() {
        
        
    }
    
    init(title:String,bid:Int,id:Int) {
        
        self.title = title
        self.bombId = bid
        self.gameId = id
        
        self.gameImage = UIImageView()
        
        self.gameImage.image = UIImage(named: "placeholder")
        
        self.iconImage = UIImageView()
        
        self.iconImage.image = UIImage(named: "placeholder")
        
        self.gameData = nil;
        
        self.iconData = nil;
    }
    
    func setDataForImage(data:NSData) ->Void {
        
        self.gameData = data
        
        self.gameImage.image = UIImage(data: self.gameData)
    }
    
    
    func setDataForIconImage(data:NSData) ->Void {
        
        self.iconData = data
        
        self.iconImage.image = UIImage(data: self.iconData)
    }
    
    //returns bomb id as string
    func getBombIdAsString() ->String {
        
        return String(format: "%d", self.bombId)
    }
    
    //returns  id as string
    func getIdAsString() ->String {
        
        return String(format: "%d", self.gameId)
    }
    
    //returns  viewers as string
    func getViewersAsString() ->String {
        
        return "Viewers: " + String(format: "%d", self.viewers)
    }
    
    //returns  channels as string
    func getChannelsAsString() ->String {
        
        return "Channels: " + String(format: "%d", self.channels)
    }
    
    //return image url of type example large,medium etc
    
    func getboxURL(boxURL:String) ->String {
        
        return self.boxURLs.objectForKey(boxURL) as String
    }
    
    //return image url of type example large,medium etc
    
    func geticonURL(iconURL:String) ->String {
        
        return self.iconURLs.objectForKey(iconURL) as String
    }
    
}
//
//  ViewController.swift
//  GameList
//
//  Created by guest2 on 23/07/15.
//  Copyright (c) 2015 guest2. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet var gameListTableView:UITableView!
    
    var downloadData:DownloadURLData!
    
    var gameDataList = [GameData]()
    
    //assign the custom cell name to a variable
    let cellIndentifier = "GameInfoCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let alert = UIAlertView(title:"Oops!",message:"Hi", delegate:nil, cancelButtonTitle:"OK")
        alert.show()*/
        
        self.downloadData = DownloadURLData(url:"https://api.twitch.tv/kraken/games/top")
        
        self.gameDataList = downloadData.gameDataList
        
        //TableView header
        var topView:UIView = UIView(frame: CGRectMake(self.gameListTableView.bounds.origin.x, self.gameListTableView.bounds.origin.y, self.gameListTableView.bounds.size.width, 50))
        
        topView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.25, alpha: 1.0)
        
        self.gameListTableView.tableHeaderView = topView
        
        
        //adding components to tableview header
        
        //list title
        var label = UILabel(frame: CGRectMake(250, 20, 200, 25))
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.text = "Games List"
        topView.addSubview(label)
        
        
        //pervious button
        var prevButton = UIButton(frame: CGRectMake(25, 20 ,50, 25))
        
        prevButton .setTitle("Prev", forState: UIControlState.Normal)
        
        prevButton .addTarget(self, action: "prevLink:", forControlEvents: UIControlEvents.TouchUpInside)
        
        topView .addSubview(prevButton)
        
        //next button
        var nextButton = UIButton(frame: CGRectMake(580, 20 ,50, 25))
        
        nextButton .setTitle("Next", forState: UIControlState.Normal)
        
        nextButton .addTarget(self, action: "nextLink:", forControlEvents: UIControlEvents.TouchUpInside)
        
        topView .addSubview(nextButton)

        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func prevLink(sender:UIButton!) ->Void {
        
        //move to next link
        if self.downloadData.parseJsonContent.prevLink != "" {
            
            self.downloadData = DownloadURLData(url:self.downloadData.parseJsonContent.prevLink)
            
            self.gameDataList = downloadData.gameDataList
            
            self.gameListTableView.reloadData()
        }
        else
        {
            let alert = UIAlertView(title:"Oops!",message:"No Link", delegate:nil, cancelButtonTitle:"OK")
            alert.show()
        }
        
    }
   
    
    func nextLink(sender:UIButton!) ->Void {
        
        //move to next link
        if self.downloadData.parseJsonContent.nextLink != "" {
            
            self.downloadData = DownloadURLData(url:self.downloadData.parseJsonContent.nextLink)
            
            self.gameDataList = downloadData.gameDataList
            
            self.gameListTableView.reloadData()
        }
        else
        {
            let alert = UIAlertView(title:"Oops!",message:"No Link", delegate:nil, cancelButtonTitle:"OK")
            alert.show()
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameDataList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIndentifier) as GameInfoCell!
        
        
        self.setCellContent(cell, index: indexPath)
        
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.estimatedRowHeight = 300.0
        
        return 300.0;
    }
    
    
    func setCellContent(cell:GameInfoCell,index:NSIndexPath) {
        
        
        
        cell.titleLabel.text = "Title: " + gameDataList[index.row].title
        
        cell.titleLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        cell.titleLabel.numberOfLines = 0
        
        cell.gamebombId.text = "Bomb_id: " + gameDataList[index.row].getBombIdAsString()
        
        cell.gameId.text = "Id: " + gameDataList[index.row].getIdAsString()
        
        cell.viewers.text = gameDataList[index.row].getViewersAsString()
        
        cell.channels.text = gameDataList[index.row].getChannelsAsString()
        
        let gameimageURL = NSURL(string: gameDataList[index.row].getboxURL("medium"))
        
        let iconImageURL = NSURL(string: gameDataList[index.row].geticonURL("medium"))
        
        self.gameDataList[index.row].gameData = NSData(contentsOfURL: gameimageURL!)
        
        cell.imageView.image = UIImage(data: self.gameDataList[index.row].gameData)
        
        self.gameDataList[index.row].iconData = NSData(contentsOfURL: iconImageURL!)
        
        cell.iconImage.image = UIImage(data: self.gameDataList[index.row].iconData)
        
    
        
    }
        
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


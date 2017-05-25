//
//  ViewController.swift
//  FirstProject
//
//  Created by bechir kaddech on 5/24/17.
//  Copyright © 2017 bechir kaddech. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource {

    
    @IBOutlet weak var FirstColelctionView: UICollectionView!
    
    @IBOutlet weak var SecondColectionView: UICollectionView!
    
    
    
    var searchUrl = "https://api.spotify.com/v1/search?q=Rihanna&type=track&limit=20"
    
    
    var songs = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        FirstColelctionView.delegate = self
        FirstColelctionView.dataSource = self
        
        SecondColectionView.delegate = self
        SecondColectionView.dataSource = self 
   
        callAlamo(url: searchUrl)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.FirstColelctionView{
            return songs.count ;}
        
    
        
        else { return 2 ;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.FirstColelctionView {
        
        //Collection view cell
        let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath) as UICollectionViewCell
        
        
        //cell: Label Song Name
        let labelSongName:UILabel = firstCell.viewWithTag(200) as! UILabel
        //cell: Label Artist Name
        let labelAlbumName:UILabel = firstCell.viewWithTag(201) as! UILabel
        //cell : Image View
        let ImageAlbum:UIImageView = firstCell.viewWithTag(100) as! UIImageView
   
        
        

        //Song and Artist Name
        labelSongName.text = songs[indexPath.row].songTitle
        labelAlbumName.text = songs[indexPath.row].albumName
            
            
        //Image View
            ImageAlbum.layer.cornerRadius = 10.0
            ImageAlbum.clipsToBounds = true
       let imageURL = URL(string: songs[indexPath.row].songImageURL!)
       ImageAlbum.kf.setImage(with: imageURL)
        
            
                    return firstCell ;
        
        }
        else {
            
            //Collection view cell
            let secondCell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCell", for: indexPath) as UICollectionViewCell
            
            
            
            return secondCell;
            
        }
        

        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func callAlamo(url : String) {
        Alamofire.request(url).responseJSON { response in
          
            
            if let JSON = response.result.value as? NSDictionary {
                
                if  let tracks = JSON["tracks"] as? NSDictionary {
                    if let items = tracks["items"] as? [NSDictionary] {
                        
                        
                        for item in items {
                            
                           let song = Song()
                            
                            //fetch song Name
                           song.songTitle = item["name"] as? String
                            
                            
                            if let album = item["album"] as? NSDictionary {
                                
                                
                                
                                
                                let images = album["images"] as? [NSDictionary]
                                let imageData = images?[0]
                                
                                song.songImageURL = imageData?["url"] as? String
                                song.albumName = album["name"] as? String

                              
                                
                            }
                            self.songs.append(song)
                            
                         
                            self.FirstColelctionView.reloadData()

                          
                            
                            
                        }
                   
                    }

                
            
                }
            }
        }
    }
    
    
    


}


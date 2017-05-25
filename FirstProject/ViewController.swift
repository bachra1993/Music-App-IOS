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
import AVFoundation

class ViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet weak var FirstColelctionView: UICollectionView!
    
    @IBOutlet weak var SecondColectionView: UICollectionView!
    
    @IBOutlet weak var ThirdCollectionView: UICollectionView!
    
    
    var searchUrlRihanna = "https://api.spotify.com/v1/search?q=Rihanna&type=track&limit=20"
    var searchUrlBalvin = "https://api.spotify.com/v1/search?q=J+balvin&type=track&limit=20"
    var searchUrlEminem = "https://api.spotify.com/v1/search?q=Eminem&type=track&limit=20"
    
    
    var songsRihanna = [Song]()
    var songsBalvin = [Song]()
    var songsEminem = [Song]()
    
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        FirstColelctionView.delegate = self
        FirstColelctionView.dataSource = self
        
        SecondColectionView.delegate = self
        SecondColectionView.dataSource = self
        
        ThirdCollectionView.delegate = self
        ThirdCollectionView.dataSource = self
        
        callAlamo(url: searchUrlRihanna, index : 1)
        callAlamo(url: searchUrlBalvin, index : 2)
        callAlamo(url: searchUrlEminem, index : 3)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.FirstColelctionView{
            return songsRihanna.count ;}
            
            
        else if collectionView == self.SecondColectionView {
            return songsBalvin.count ;
        }
            
            
            
        else { return songsEminem.count ;
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
            
            
            if songsRihanna[indexPath.row].previewURL == nil {
                
                var imageBTN: UIImage = UIImage(named: "btn_small")!
                var i = UIImageView(image : imageBTN )
                i.frame = CGRect(x: 15 , y: 10, width: 30, height: 30)
                firstCell.contentView.addSubview(i)

            }
            

            
            
            //Song and Artist Name
            labelSongName.text = songsRihanna[indexPath.row].songTitle
            labelAlbumName.text = songsRihanna[indexPath.row].previewURL
            
            
            //Image View
            ImageAlbum.layer.cornerRadius = 10.0
            ImageAlbum.clipsToBounds = true
            let imageURL = URL(string: songsRihanna[indexPath.row].songImageURL!)
            ImageAlbum.kf.setImage(with: imageURL)
            
            
            return firstCell ;
            
        }
        else if collectionView == self.SecondColectionView{
            
            //Collection view cell
            let secondCell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCell", for: indexPath) as UICollectionViewCell
            
            
            //cell: Label Song Name
            let labelSongName:UILabel = secondCell.viewWithTag(200) as! UILabel
            //cell: Label Artist Name
            let labelAlbumName:UILabel = secondCell.viewWithTag(201) as! UILabel
            //cell : Image View
            let ImageAlbum:UIImageView = secondCell.viewWithTag(100) as! UIImageView
            
            //Song and Artist Name
            labelSongName.text = songsBalvin[indexPath.row].songTitle
            labelAlbumName.text = songsBalvin[indexPath.row].albumName
            
            
            
            //Image View
            ImageAlbum.layer.cornerRadius = 10.0
            ImageAlbum.clipsToBounds = true
            let imageURL = URL(string: songsBalvin[indexPath.row].songImageURL!)
            ImageAlbum.kf.setImage(with: imageURL)
            
            
            
            return secondCell;
            
        }
            
        else {
            
            //Collection view cell
            let thirdCell = collectionView.dequeueReusableCell(withReuseIdentifier: "thirdCell", for: indexPath) as UICollectionViewCell
            
            
            
            //cell: Label Song Name
            let labelSongName:UILabel = thirdCell.viewWithTag(200) as! UILabel
            //cell: Label Artist Name
            let labelAlbumName:UILabel = thirdCell.viewWithTag(201) as! UILabel
            //cell : Image View
            let ImageAlbum:UIImageView = thirdCell.viewWithTag(100) as! UIImageView
            
            //Song and Artist Name
            labelSongName.text = songsEminem[indexPath.row].songTitle
            labelAlbumName.text = songsEminem[indexPath.row].albumName
            
            
            
            //Image View
            ImageAlbum.layer.cornerRadius = 10.0
            ImageAlbum.clipsToBounds = true
            let imageURL = URL(string: songsEminem[indexPath.row].songImageURL!)
            ImageAlbum.kf.setImage(with: imageURL)
            
            
            
            return thirdCell;
            
            
        }
        
        
        
        
        
    }
    
    
    
    
    //Select item collection view action
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.SecondColectionView {
            
            
            
       
            
            if let urlstring = songsBalvin[indexPath.row].previewURL {
                
                let url = NSURL(string: urlstring)
                print("the url = \(url!)")
                downloadFileFromURL(url: url!)
            }
            
            
        }
        else if collectionView == self.FirstColelctionView {
            
            
            
            print("test song")
            print(songsRihanna[indexPath.row].songTitle)

            
            print(songsRihanna[indexPath.row].albumName)

            print(songsRihanna[indexPath.row].previewURL)
            
            
            if let urlstring = songsRihanna[indexPath.row].previewURL {
                
                let url = NSURL(string: urlstring)
                print("the url = \(url!)")
                downloadFileFromURL(url: url!)
            }
            
        }
            
        else {
            print("other")
        }
    }
    
    
    
    //Downlaod music mp3 with url
    func downloadFileFromURL(url:NSURL){
        weak var weakSelf = self
        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url as URL, completionHandler: { (URL, response, error) -> Void in
            
            weakSelf!.play(url: (URL as? NSURL)!)
            
        })
        
        downloadTask.resume()
        
    }
    
    
    
    //PLay music
    func play(url:NSURL) {
        print("playing \(url)")
        
        do {
            self.player = try AVAudioPlayer(contentsOf: url as URL)
            player.prepareToPlay()
            player.volume = 1.0
            player.play()
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
    
    
    
    
    
    
    //Function fetch songs
    func callAlamo(url : String , index: Int ) {
        Alamofire.request(url).responseJSON { response in
            if let JSON = response.result.value as? NSDictionary {
                if  let tracks = JSON["tracks"] as? NSDictionary {
                    if let items = tracks["items"] as? [NSDictionary] {
                        
                        
                        for item in items {
                            
                            let song = Song()
                            
                            //fetch song Name
                            song.songTitle = item["name"] as? String
                            song.previewURL = item["preview_url"] as? String
                            
                            
                            
                            if let album = item["album"] as? NSDictionary {
                                
                                
                                
                                
                                let images = album["images"] as? [NSDictionary]
                                let imageData = images?[0]
                                
                                song.songImageURL = imageData?["url"] as? String
                                song.albumName = album["name"] as? String
                                
                                
                                
                            }
                            
                            if(index == 1 ) {
                                self.songsRihanna.append(song)
                                self.FirstColelctionView.reloadData()
                                
                            }
                            else if(index == 2) {
                                self.songsBalvin.append(song)
                                self.SecondColectionView.reloadData()
                                
                                
                            }
                            else {
                                
                                self.songsEminem.append(song)
                                self.ThirdCollectionView.reloadData()
                            }
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                    }
                    
                    
                    
                }
            }
        }
    }
    
    
    
    
    
}


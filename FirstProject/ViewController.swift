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
    
    @IBOutlet weak var btn_play_pause: UIButton!
    
    @IBOutlet weak var song_progress: UIProgressView!
    
    @IBOutlet weak var label_progress: UILabel!
    
    @IBOutlet weak var label_song: UILabel!
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
            
            
            //Song and Artist Name
            labelSongName.text = songsRihanna[indexPath.row].songTitle
            labelAlbumName.text = songsRihanna[indexPath.row].albumName
            
            
            //Image View
            ImageAlbum.layer.cornerRadius = 10.0
            ImageAlbum.clipsToBounds = true
            let imageURL = URL(string: songsRihanna[indexPath.row].songImageURL!)
            ImageAlbum.kf.setImage(with: imageURL)
            
            
            
            
            //Check if the song has stram link and give it green if yes red if no
            if songsRihanna[indexPath.row].previewURL == nil {
                
                var imageBTN: UIImage = UIImage(named: "btn_small")!
                var i = UIImageView(image : imageBTN )
                
                i.frame = CGRect(x: 15 , y: 10, width: 30, height: 30)
                firstCell.contentView.addSubview(i)
                
            }
            else {
                var imageBTN: UIImage = UIImage(named: "btn_green")!
                var i = UIImageView(image : imageBTN )
                
                i.frame = CGRect(x: 15 , y: 10, width: 30, height: 30)
                firstCell.contentView.addSubview(i)
                
                
            }
            
            
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
            
            
            
            
            //Check if the song has stram link and give it green if yes red if no
            if songsBalvin[indexPath.row].previewURL == nil {
                
                var imageBTN: UIImage = UIImage(named: "btn_small")!
                var i = UIImageView(image : imageBTN )
                
                i.frame = CGRect(x: 15 , y: 10, width: 30, height: 30)
                secondCell.contentView.addSubview(i)
                
            }
            else {
                var imageBTN: UIImage = UIImage(named: "btn_green")!
                var i = UIImageView(image : imageBTN )
                
                i.frame = CGRect(x: 15 , y: 10, width: 30, height: 30)
                secondCell.contentView.addSubview(i)
                
                
            }
            
            
            
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
            
            
            
            
            //Check if the song has stram link and give it green if yes red if no
            if songsEminem[indexPath.row].previewURL == nil {
                
                var imageBTN: UIImage = UIImage(named: "btn_small")!
                var i = UIImageView(image : imageBTN )
                
                i.frame = CGRect(x: 15 , y: 10, width: 30, height: 30)
                thirdCell.contentView.addSubview(i)
                
            }
            else {
                var imageBTN: UIImage = UIImage(named: "btn_green")!
                var i = UIImageView(image : imageBTN )
                
                i.frame = CGRect(x: 15 , y: 10, width: 30, height: 30)
                thirdCell.contentView.addSubview(i)
                
                
            }
            
            
            
            return thirdCell;
            
            
        }
        
        
        
        
        
    }
    
    
    
    
    //Select item collection view action
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.SecondColectionView {
            
            
            label_song.text = songsBalvin[indexPath.row].songTitle
            
            
            if let urlstring = songsBalvin[indexPath.row].previewURL {
                
                let url = NSURL(string: urlstring)
                print("the url = \(url!)")
                downloadFileFromURL(url: url!)
            }
            
            
        }
        else if collectionView == self.FirstColelctionView {
            
            label_song.text = songsRihanna[indexPath.row].songTitle

            
            if let urlstring = songsRihanna[indexPath.row].previewURL {
                
                let url = NSURL(string: urlstring)
                print("the url = \(url!)")
                downloadFileFromURL(url: url!)
            }
            
        }
            
        else {

            label_song.text = songsEminem[indexPath.row].songTitle
            
            
            if let urlstring = songsEminem[indexPath.row].previewURL {
                
                let url = NSURL(string: urlstring)
                print("the url = \(url!)")
                downloadFileFromURL(url: url!)
            }
        
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
        btn_play_pause.setImage(UIImage(named: "btn_pause"), for: UIControlState.normal)
        
        scheduledTimerWithTimeInterval()
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
    
    
    
    //Progress view update every 1 second
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function **Countdown** with the interval of 1 seconds
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    func updateCounting(){
        
        if player.isPlaying {
            song_progress.progress = Float(player.currentTime) / 100
            
            
            let current = stringFromTimeInterval(interval: player.currentTime) as String
            let duration = stringFromTimeInterval(interval: player.duration) as String
            
            
            
            label_progress.text = "\(current)-\(duration)"
            
           
        }
        
    }
    

    
    
    //player play / pause control
    @IBAction func play_pause(_ sender: Any) {
        
        if player.isPlaying {
            
            btn_play_pause.setImage(UIImage(named: "btn_big"), for: UIControlState.normal)

            player.pause()
        }
        else {
            btn_play_pause.setImage(UIImage(named: "btn_pause"), for: UIControlState.normal)


            player.play()
        }
        
        
    }
    
    
    //From time intervale to Sting
    func stringFromTimeInterval(interval: TimeInterval) -> NSString {
        
        let ti = NSInteger(interval)
        
        let ms = Int((interval.truncatingRemainder (dividingBy: 1)) * 1000)
        
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        return NSString(format: "%0.2d:%0.2d",minutes,seconds)
    }
    
    
}


//
//  ViewController.swift
//  SwiftMusicKitStarter
//
//  Created by MacBook on 1/26/19.
//  Copyright © 2019 Ahil. All rights reserved.
//

import UIKit
import MediaPlayer

class MusicMainVC: UIViewController {
    
    @IBOutlet weak var songImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    
    var mediaPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeButtonTitle()
    }
    
    
    func changeButtonTitle(){
        if mediaPlayer.playbackState == .playing{
            playPauseButton.setTitle("Pause", for: .normal)
        }
        else{
            playPauseButton.setTitle("Play", for: .normal)
        }
    }
    
    @IBAction func chooseButtonTapped(_ sender: Any) {
        
        //provides a graphical interface for selecting media items.
        let mediaPickerVC = MPMediaPickerController(mediaTypes: .music)
        mediaPickerVC.allowsPickingMultipleItems = false
        mediaPickerVC.popoverPresentationController?.sourceView = view
        mediaPickerVC.delegate = self
        present(mediaPickerVC, animated: true, completion: nil)
    }
    
    @IBAction func randomButtonTapped(_ sender: Any) {
        if let songs = MPMediaQuery.songs().items{
            let randomIndex = arc4random_uniform(UInt32(songs.count) - 1)
            let item = songs[Int(randomIndex)]
            playItem(item: item)
        }
    }
    
    func playItem(item : MPMediaItem){
        
        
        if let artWorkImage = item.artwork?.image(at: CGSize(width: 50, height: 50)){
            songImageView.image = artWorkImage
            if let songName = item.title{
                titleLabel.text = songName
            }
        }
        
        //Sets a music player’s playback queue using a media item collection.
        mediaPlayer.setQueue(with: MPMediaItemCollection(items: [item]))
        mediaPlayer.play()
        changeButtonTitle()
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        if mediaPlayer.playbackState == .playing{
            mediaPlayer.pause()
            playPauseButton.setTitle("Play", for: .normal)
        }
        else{
            mediaPlayer.play()
            playPauseButton.setTitle("Pause", for: .normal)
        }
    }
}


extension MusicMainVC : MPMediaPickerControllerDelegate{
    
    //Called when a user has selected a set of media items.
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        for item in mediaItemCollection.items{
           playItem(item: item)
        }
        mediaPicker.dismiss(animated: true, completion: nil)

    }
    
    //Called when a user dismisses a media item picker by tapping Cancel.
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
}

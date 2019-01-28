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
    
    var mediaPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
    }
    @IBAction func playButtonTapped(_ sender: Any) {
        
    }
}


extension MusicMainVC : MPMediaPickerControllerDelegate{
    
    //Called when a user has selected a set of media items.
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        
        for item in mediaItemCollection.items{
            if let artWorkImage = item.artwork?.image(at: CGSize(width: 50, height: 50)){
                songImageView.image = artWorkImage
                if let songName = item.title{
                    titleLabel.text = songName
                }
            }
        }
        mediaPicker.dismiss(animated: true, completion: nil)
        //Sets a music player’s playback queue using a media item collection.
        mediaPlayer.setQueue(with: mediaItemCollection)
        mediaPlayer.play()
    }
    
    //Called when a user dismisses a media item picker by tapping Cancel.
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
}

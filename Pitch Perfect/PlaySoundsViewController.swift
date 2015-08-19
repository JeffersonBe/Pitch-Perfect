//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jefferson Bonnaire on 17/08/2015.
//  Copyright © 2015 Jefferson Bonnaire. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {
    var soundPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        soundPlayer = setupAudioPlayerWithFile("movie_quote", type: "mp3")
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        soundPlayer.stop()
    }
    
    @IBAction func playAudioQuickly(sender: AnyObject) {
        soundPlayer.enableRate = true
        soundPlayer.currentTime = soundPlayer.currentTime
        soundPlayer.rate = 2.0
        soundPlayer.play()
    }

    @IBAction func playAudioSlowly(sender: AnyObject?) {
        soundPlayer.enableRate = true
        soundPlayer.currentTime = soundPlayer.currentTime
        soundPlayer.currentTime = 0.0
        soundPlayer.rate = 0.5
        soundPlayer.play()
    }
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
        let path = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)!)
        var audioPlayer:AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: path)
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        return audioPlayer!
    }
}

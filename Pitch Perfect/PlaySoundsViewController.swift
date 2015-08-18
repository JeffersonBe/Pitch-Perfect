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
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func stopAudio(sender: AnyObject) {
        soundPlayer.stop()
    }
    
    @IBAction func playAudioQuickly(sender: AnyObject) {
        soundPlayer = setupAudioPlayerWithFile("movie_quote", type: "mp3")
        soundPlayer.stop()
        soundPlayer.enableRate = true
        soundPlayer.rate = 2.0
        soundPlayer.play()
    }

    @IBAction func playAudioSlowly(sender: AnyObject?) {
        soundPlayer = setupAudioPlayerWithFile("movie_quote", type: "mp3")
        soundPlayer.stop()
        soundPlayer.enableRate = true
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

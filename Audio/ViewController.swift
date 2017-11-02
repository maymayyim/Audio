//
//  ViewController.swift
//  Audio
//
//  Created by 6272 on 11/2/2560 BE.
//  Copyright © 2560 6272. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer : AVAudioPlayer?
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let mySound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "song",ofType:"mp3")!)
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }catch _{
        }
        do{
            try AVAudioSession.sharedInstance().setActive(true)
        }catch _{
            
        }
        var error:NSError?
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: mySound as URL)
        }catch let error as NSError{
            audioPlayer = nil
        }
        audioPlayer?.delegate = self
        audioPlayer?.prepareToPlay()
        audioPlayer?.volume = 0.3
        slider.value = 0.3
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func playMethod(_ sender: Any) {
        if(audioPlayer!.isPlaying){
            audioPlayer?.pause()
            playBtn.setTitle("Play", for: UIControlState.normal)
        }else{
            audioPlayer?.play()
            playBtn.setTitle("Pause", for: UIControlState.normal)
        }
    }
    
    @IBAction func stopMethod(_ sender: Any) {
        audioPlayer?.stop()
        self.resetMethod()
    }
    
    @IBAction func volumeMethod(_ sender: Any) {
        audioPlayer?.volume = slider.value
    }
    
    func resetMethod(){
        slider.value = 0.3
        audioPlayer?.volume = 0.3
        audioPlayer?.currentTime = 0
        playBtn.setTitle("Play", for: UIControlState.normal)
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.resetMethod()
    }
}


//
//  InputViewController.swift
//  spriteKit_harumaki
//
//  Created by yuki takei on 2017/11/12.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class InputViewController: UIViewController {
    
    @IBOutlet var skView:SKView!
    
    @IBOutlet var rightButton:UIButton!
    @IBOutlet var leftButton:UIButton!
    
    var rightTime:[UInt] = []
    var leftTime:[UInt] = []
    
    var nowTime:Float = 0.00
    
    var audioPlayer:AVAudioPlayer!
    
    var audioName:String = "sound"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        soundPlay()
    }
    
    @IBAction func saveButton(button:UIButton){
        if audioPlayer.isPlaying == true {
            saveTimingData()
            audioPlayer.stop()
        }
    }

    @IBAction func tappedButton(button:UIButton){
        
        if audioPlayer.isPlaying == false {
            return
        }
        
        if button == rightButton {
            print("right:\(UInt(audioPlayer.currentTime * 100))")
            rightTime.append(UInt(audioPlayer.currentTime * 100))
        }
        if button == leftButton {
            print("left:\(UInt(audioPlayer.currentTime * 100))")
            leftTime.append(UInt(audioPlayer.currentTime * 100))
        }
    }
    
    
    func soundPlay(){
        // 再生する audio ファイルのパスを取得
        do {
            let filePath = Bundle.main.path(forResource: audioName,ofType: "mp3")
            let musicPath = URL(fileURLWithPath: filePath!)
            audioPlayer = try AVAudioPlayer(contentsOf: musicPath)
        } catch {
            print("error")
        }
        audioPlayer.play()
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
    }
    
    
    func saveTimingData(){
        print("save!!!")
        let defaults = UserDefaults.standard
        defaults.set(rightTime, forKey: "\(audioName)_rightTime")
        defaults.set(leftTime, forKey: "\(audioName)_leftTime")
    }
    
}

extension InputViewController: AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
       saveTimingData()
    }
}


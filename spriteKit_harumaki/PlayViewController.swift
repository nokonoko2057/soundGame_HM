//
//  ViewController.swift
//  spriteKit_harumaki
//
//  Created by yuki takei on 2017/11/11.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class PlayViewController: UIViewController {

    @IBOutlet var skView:SKView!
    var scene:HMGamePlayScene = HMGamePlayScene()
    
    var audioPlayer:AVAudioPlayer!
    
    var rightTime:[UInt] = []
    var leftTime:[UInt] = []
    
    var audioName: String = "sound"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupSKView()
        addScene(to: skView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getTimingData(audioName: audioName)
        soundPlay()
    }
    
    
    //ベースになるskViewの設定
    func setupSKView() {
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.backgroundColor = UIColor.clear
    }
    
    
     //シーンを呼び出して、skViewに追加する
    func addScene(to skView:SKView){
//        scene = HMGamePlayScene()
        scene.size = skView.frame.size
        scene.backgroundColor = UIColor.clear
        skView.presentScene(scene)
    }
    
    func soundPlay(){
        // 再生する audio ファイルのパスを取得
        do {
            let filePath = Bundle.main.path(forResource: audioName ,ofType: "mp3")
            let musicPath = URL(fileURLWithPath: filePath!)
            audioPlayer = try AVAudioPlayer(contentsOf: musicPath)
        } catch {
            print("error")
        }
        audioPlayer.play()
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        
        if audioPlayer.isPlaying == true {
            soundObserver()
        }
    }
    
    
    func soundObserver(){
        var intCurrentTime:UInt = 0
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
            intCurrentTime = UInt(self.audioPlayer.currentTime * 100)
            
            print(intCurrentTime)
//            self.scene.isRightSwitch = true
            
            if self.rightTime.count != 0 {
                if self.rightTime.first! - 200 <= intCurrentTime {
                    self.rightTime.removeFirst()
                    self.scene.makeMoveNode(direction: .right)
                }
            }

            if self.leftTime.count != 0 {
                if self.leftTime.first! <= intCurrentTime {
                    self.leftTime.removeFirst()
                    self.scene.makeMoveNode(direction: .left)
                }
            }
        }
    }
    
    func getTimingData(audioName:String) {
        let defaults = UserDefaults.standard
        self.rightTime =  defaults.array(forKey: "\(audioName)_rightTime") as! [UInt]
        self.leftTime = defaults.array(forKey: "\(audioName)_leftTime") as! [UInt]
    }

}


extension PlayViewController: AVAudioPlayerDelegate {
    
}

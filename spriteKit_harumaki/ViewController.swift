//
//  ViewController.swift
//  spriteKit_harumaki
//
//  Created by yuki takei on 2017/11/11.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    @IBOutlet var skView:SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupSKView()
        addScene(skView: skView)
        
    }
    
    
    //ベースになるskViewの設定
    func setupSKView() {
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.backgroundColor = UIColor.clear
    }
    
    
     //シーンを呼び出して、skViewに追加する
    func addScene(skView:SKView){
        let scene = HMScene()
        scene.size = skView.frame.size
        scene.backgroundColor = UIColor.clear
        skView.presentScene(scene)
    }

 


}


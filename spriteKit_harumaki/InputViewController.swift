//
//  InputViewController.swift
//  spriteKit_harumaki
//
//  Created by yuki takei on 2017/11/12.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit
import SpriteKit

class InputViewController: UIViewController {
    
    @IBOutlet var skView:SKView!
    
    @IBOutlet var rightButton:UIButton!
    @IBOutlet var leftButton:UIButton!
    
    var rightTime:[Float] = []
    var leftTime:[Float] = []
    
    var nowTime:Float = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let timeInterval:Float = 0.01
        Timer.scheduledTimer(withTimeInterval: TimeInterval(timeInterval), repeats: true){ (timer) in
            self.nowTime += timeInterval * 100
            
            
            print(self.nowTime)
        }
        
    }

    @IBAction func tappedButton(button:UIButton){
        if button == rightButton {
            print("right")
            rightTime.append(nowTime)
        }
        
        if button == leftButton {
            print("left")
            leftTime.append(nowTime)
        }
    }
    

}


//
//  HMScene.swift
//  spriteKit_harumaki
//
//  Created by yuki takei on 2017/11/11.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit
import SpriteKit

class HMGamePlayScene: SKScene {

    //最初に呼ばれるところ
    override func didMove(to view: SKView) {
//        fallCubes()
        
        self.parent?.alpha = 0.0
        self.backgroundColor = UIColor.clear
        setupTapButton()
    
        
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            self.makeMoveNode()
        }
    }
    
    //画像を落とすところ //使わない
    func fallCubes(){
        let texture = SKTexture(imageNamed: "1")
        let sprite = SKSpriteNode(texture: texture)
        sprite.position = CGPoint(x: self.size.width / 2 , y: self.size.height/2)
        sprite.size = CGSize(width: texture.size().width, height: texture.size().height)
        
        self.addChild(sprite)
    }
    
    //MARK: - タップボタン
    
    //中心のタップボタンの座標を設定するところ
    func setupTapButton(){
        let leftButtonPos = CGPoint(x: self.size.width * 1 / 4, y: self.size.height / 2)
        let rightButtonPos = CGPoint(x: self.size.width * 3 / 4, y: self.size.height / 2)
        
        makeTapButton(pos: leftButtonPos)
        makeTapButton(pos: rightButtonPos)
    }
    
    
    //タップボタンを実際に作るところ
    func makeTapButton(pos:CGPoint){
        let circle = SKShapeNode(circleOfRadius: 15)
        circle.position = pos
        circle.fillColor = UIColor.white
        self.addChild(circle)
    }
    
    
    //MARK: - ムーブノード
    
    //ムーブノード(移動する球)を作るところ
    func makeMoveNode(){
   
        let circle = SKShapeNode(circleOfRadius: 5)
        circle.position = CGPoint(x: 0.0, y: 0.0)
        circle.fillColor = UIColor.yellow
        self.addChild(circle)
        
       moveNodeActions(node: circle)
        
    }
    
    
    //ムーブノードを生成するポジションの設定
    func makeMoveNodePos(){
        
    }
    
    //アクションの設定する
    func moveNodeActions(node:SKNode){
        let moveTime = 2.0
        
        //移動のアクション
        let moveAction = SKAction.move(to: CGPoint(x: self.size.width * 1 / 4, y: self.size.height / 2), duration: moveTime)
        //大きさのアクション
        let scaleAction = SKAction.scale(to: 3, duration: moveTime)
        //移動と大きさの変更を同時に行うグループ
        let actionGroup = SKAction.group([moveAction,scaleAction])
        
        //削除するアクション
        let removeAction = SKAction.removeFromParent()
        
        //グループのアクションの後に、削除を行うシーケンス
        let actionSequence = SKAction.sequence([actionGroup,removeAction])
        
        //動きを実行する
        node.run(actionSequence)
    }
    
    func toGoalPoint(){
        
    }
    
}

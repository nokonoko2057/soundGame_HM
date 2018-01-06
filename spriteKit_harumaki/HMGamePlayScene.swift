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

    var isRightSwitch:Bool = false
    
    var leftTapButton:SKNode!
    var rightTapButton:SKNode!
    
    let rightCate:UInt32 = (1 << 0) //0x1 << 0
    let leftCate:UInt32 = (1 << 1) //0x1 << 1
    let moveCate:UInt32 = (1 << 2) //0x1 << 1
    
    //最初に呼ばれるところ
    override func didMove(to view: SKView) {
        self.parent?.alpha = 0.0
        self.backgroundColor = UIColor.clear
        
        self.physicsWorld.contactDelegate = self
        setupTapButton()
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
        makeTapButton(direction: .left)
        makeTapButton(direction: .right)
    }
    
    
    //タップボタンを実際に作るところ
    func makeTapButton(direction:Direction){
        let circle = SKShapeNode(circleOfRadius: 15)
        circle.fillColor = UIColor.white
        circle.physicsBody?.contactTestBitMask = moveCate
        switch direction {
        case .left:
            circle.physicsBody?.categoryBitMask = leftCate
            circle.position = CGPoint(x: self.size.width * 1 / 4, y: self.size.height / 2)
        case .right:
            circle.physicsBody?.categoryBitMask = rightCate
            circle.position = CGPoint(x: self.size.width * 3 / 4, y: self.size.height / 2)
        default:
            break
        }
        
        
        self.addChild(circle)
        
        switch direction {
        case .left:
            leftTapButton = circle
        case .right:
            rightTapButton = circle
        default:
            break
        }
        
        
        
        
    }
    
    
    //MARK: - ムーブノード
    
    //ムーブノード(移動する球)を作るところ
    func makeMoveNode(direction:Direction){
        
        let circle = SKShapeNode(circleOfRadius: 5)
        circle.physicsBody?.categoryBitMask = moveCate
//        circle.physicsBody?.contactTestBitMask =
        
        switch direction {
        case .right:
            circle.position = makeMoveNodePos(centerPos: rightTapButton.position)
            circle.fillColor = UIColor.blue//.withAlphaComponent(0.0)
            
        case .left:
            circle.position = makeMoveNodePos(centerPos: leftTapButton.position)
            circle.fillColor = UIColor.red//.withAlphaComponent(0.0)
            
        default:
            break
        }
        self.addChild(circle)
        
        moveNodeActions(node: circle, direction: direction)
        
    }
    
    
    //ムーブノードを生成するポジションの設定
    func makeMoveNodePos(centerPos:CGPoint) -> CGPoint{
        let radius = CGFloat(UIScreen.main.bounds.width) / 2.0
        let theta = CGFloat(arc4random_uniform(360)) * 2 * CGFloat.pi / 360.0
        
        let makePos:CGPoint = CGPoint(x: centerPos.x - radius * cos(theta),
                                      y: centerPos.y - radius * sin(theta))
        return makePos
    }
    
    
    //アクションの設定する
    func moveNodeActions(node:SKNode, direction:Direction){
        let moveTime = 2.0
        
        var moveToPos:CGPoint!
        switch direction {
        case .right:
            moveToPos = rightTapButton.position
        case .left:
            moveToPos = leftTapButton.position
        default:
            break
        }
        
        //透明度を上げる
        let clearAction = SKAction.fadeAlpha(by: 0.0, duration: 0.5)
        //動きのアクション
        let moveAction = SKAction.move(to: moveToPos, duration: moveTime)
        //大きさのアクション
        let scaleAction = SKAction.scale(to: 3, duration: moveTime)
        //移動と大きさの変更を同時に行うグループ
        let actionGroup = SKAction.group([moveAction,scaleAction,clearAction])
        
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

extension HMGamePlayScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        print("contact!!!")
    }
}


enum Direction: String {
    case right = "right"
    case left = "left"
}

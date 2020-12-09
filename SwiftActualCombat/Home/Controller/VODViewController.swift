//
//  VODViewController.swift
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/8/27.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

import UIKit
import AliyunPlayer

class VODViewController: BaseViewController {
    
//    lazy var player: AliPlayer = {[weak self] in
//        let player = AliPlayer()
//        player?.delegate = self
//        player?.playerView =
//        return player!
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.5, green: 0.8, blue: 1.0, alpha: 1.0)
        self.title = "云点播"
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
}
// MARK: - 页面创建
extension VODViewController {
    func setUI() {
        let plv = PLVDome()
        plv.polyvInit()

        let playController = plv.play()
        let playerPlaceholder = UIView()
        playerPlaceholder.frame = CGRect(x: 0, y: kNavAndStatusBarH, width: UIScreen.main.bounds.width, height: 200)
        self.view.addSubview(playerPlaceholder)
        playController.addPlayer(onPlaceholderView: playerPlaceholder, rootViewController: self)
    }
}
// MARK: - 阿里云代理
extension VODViewController: AVPDelegate {
    func onPlayerEvent(_ player: AliPlayer!, eventType: AVPEventType) {
        switch eventType {
        case AVPEventPrepareDone:
            print("zhunbeiwancheng")
        default:
            print("moren")
        }
    }
}

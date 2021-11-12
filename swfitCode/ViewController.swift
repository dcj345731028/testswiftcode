//
//  ViewController.swift
//  swfitCode
//
//  Created by 杜长金 on 2021/7/22.
//

import UIKit
import AVKit

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
let SafeAreaBottomHeight = (UIScreen.main.bounds.size.height >= 812.0 ? 34 : 0)


var playView:UIView!
var player:AVPlayer!
var playerLabyer:AVPlayerLayer!
var playItem:AVPlayerItem!
var showImage:UIImageView!
var enterMainButton:UIButton!
var qrcodeImage:UIImageView!
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //播放视频
        playView = UIView.init(frame:UIScreen.main.bounds)
        view.addSubview(playView)
        playAV()
        
        showImage = UIImageView.init(frame: CGRect(x: screenWidth/2 - 100, y: screenHeight/2 - 90, width: 200, height: 180))
        //showImage.alpha = 0
        showImage.image = UIImage.init(named: "img_ricepon_logo_slogan")
        view.addSubview(showImage)
        
        enterMainButton = UIButton.init(frame: CGRect(x: 20, y: screenHeight - 132 - CGFloat(SafeAreaBottomHeight), width: screenWidth - 40, height: 48))
        enterMainButton.layer.cornerRadius = 8
        enterMainButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        enterMainButton.backgroundColor = UIColor.init(cgColor: CGColor(red: 192/255.0, green: 28/255.0, blue: 66/255.0, alpha: 1))
        enterMainButton.setTitle(NSLocalizedString("Scan QR Code", comment: ""), for: UIControl.State.normal)
        enterMainButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
        enterMainButton.addTarget(self, action:#selector(enterMainAction), for: UIControl.Event.touchUpInside)
        view .addSubview(enterMainButton)
        let string:NSString = NSLocalizedString("Scan QR Code", comment: "") as NSString
        let font:UIFont! = UIFont.systemFont(ofSize: 20)
        let attributes = [NSAttributedString.Key.font:font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = string.boundingRect(with: CGSize(width: screenWidth, height: 48), options: option, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        qrcodeImage = UIImageView.init(frame: CGRect(x: screenWidth/2 - rect.width/2 - 12.5, y: screenHeight - 120 - CGFloat(SafeAreaBottomHeight), width: 22, height: 22))
        qrcodeImage.image = UIImage.init(named: "icn qr button")
        view.addSubview(qrcodeImage)
        
        // Do any additional setup after loading the view.
    }
    
    //视频初始化
    func playAV(){
        guard let moivePath = Bundle.main.path(forResource: "1242px×2688", ofType: "mp4")
        else { return }
        let url = NSURL(fileURLWithPath:moivePath)
        playItem = AVPlayerItem(url: url as URL)
        //监听播放完成
        NotificationCenter.default.addObserver(self, selector: #selector(playDidFinish), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: playItem)
        player = AVPlayer(playerItem: playItem)
        playerLabyer = AVPlayerLayer(player: player)
        playerLabyer.frame = UIScreen.main.bounds
        playerLabyer.videoGravity = AVLayerVideoGravity.resizeAspect
        playView.layer.addSublayer(playerLabyer)
        player.play()
    }
    
    //视频播放完毕
    @objc func playDidFinish() {
        player.seek(to: CMTime(value: 0, timescale: 1))
        player.play()
    }
    
    //扫码二维码
    @objc func enterMainAction(sender:UIButton){
        print("%@",sender.frame)
    }
}



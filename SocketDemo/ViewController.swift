//
//  ViewController.swift
//  SocketDemo
//
//  Created by 李伟超 on 16/2/24.
//  Copyright © 2016年 LWC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var hintLabel: UILabel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hintLabel.text = "1111"
        
//        if #available(iOS 8.0, *) {
//            
//        }
        navigationController?.automaticallyAdjustsScrollViewInsets = false
        navigationController?.edgesForExtendedLayout = UIRectEdge.None
//        navigationController?.navigationBar.translucent = true
//        navigationController?.extendedLayoutIncludesOpaqueBars = true
        
        let image: UIImage!
        image = UIImage(named: "1")
        NSLog("%@", image)
        
        navigationController?.navigationBar.setBackgroundImage(image!.imageWithRenderingMode(.AlwaysTemplate), forBarMetrics: UIBarMetrics.DefaultPrompt)
        navigationController?.navigationBar.tintColor = UIColor.yellowColor()
        
        navigationController?.navigationBar.backgroundColor = UIColor.redColor()
        navigationItem.title = "标题"
        
        let button: UIButton! = UIButton(type: UIButtonType.Custom)
        button.frame = CGRectMake(0, 66, 100, 50)
        button.setTitle("按钮", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
//        button.setImage(image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("clickButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        button.tintColor = UIColor.yellowColor()
        self.view.addSubview(button)
        
//        let d: NSData = NSData()
//        let socket = AsyncSendPacket(data: d, address: d, timeout: 1.0, tag: 111)
//        print("====")
//        print(socket.buffer)
        
        var test = 10
        test = withUnsafeMutablePointer(&test, { (ptr: UnsafeMutablePointer<Int>) -> Int in
            ptr.memory += 1
            return ptr.memory
        })
        print(test)
        
        self.view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clickButton(sender: AnyObject) {
        NSLog("点击按钮")
    }
}


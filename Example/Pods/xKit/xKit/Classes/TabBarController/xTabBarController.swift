//
//  xTabBarController.swift
//  Alamofire
//
//  Created by Mac on 2020/9/15.
//

import UIKit
import xExtension

open class xTabBarController: UITabBarController {
    
    // MARK: - 内存释放
    deinit {
        print("💥 TBC \(self.xClassInfoStruct.name)")
    }
    
    // MARK: - Open Override Func
    open override func viewDidLoad() {
        super.viewDidLoad()
        // 强制白天模式
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        DispatchQueue.main.async {
            self.addKit()
            self.addChildren()
            self.requestData()
        }
    }
    
}

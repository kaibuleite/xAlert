//
//  xViewController.swift
//  Pods-xSDK_Example
//
//  Created by Mac on 2020/9/15.
//

import UIKit
import xExtension

open class xViewController: UIViewController {
    
    // MARK: - IBOutlet Property
    /// 自定义导航栏
    @IBOutlet open weak var topNaviBar: xNavigationView?
    /// 安全区域
    @IBOutlet open weak var safeView: xSafeView?
    /// 子控制器容器
    @IBOutlet open weak var childContainer: xContainerView?
    
    // MARK: - IBInspectable Property
    /// 控制器描述
    @IBInspectable public var xTitle : String = ""
    
    // MARK: - Public Property
    /// 是否显示中
    public var isAppear = false
    /// 是否完成数据加载(默认已完成)
    public var isLoadRequestDataCompleted = true
    /// 是否是根级父控制器
    public var isRootParentViewController = false
    /// 子控制器Key
    public var childViewControllerKeys = [String]()
    
    // MARK: - 内存释放
    deinit {
        if self.isRootParentViewController {
            print(">>>>> 释放视图控制器")
        }
        print("♻️ \(self.xClassInfoStruct.name)")
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
        // 模态全屏
        self.modalPresentationStyle = .fullScreen
        // 子控制器的Key
        self.childViewControllerKeys = ["Child", "child"]
        // 主线程初始化UI
        DispatchQueue.main.async {
            self.addKit()
            self.addChildren()
            self.requestData()
        }
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isAppear = true
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.isAppear = false
    }
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let ident = segue.identifier else { return }
        for key in self.childViewControllerKeys {
            guard key == ident else { continue }
            self.addChild(segue.destination)   // 绑定父控制器
            break
        }
    }
    
}

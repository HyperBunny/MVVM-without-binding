//
//  ViewController.swift
//  test
//
//  Created by DcBunny on 16/1/11.
//  Copyright © 2016年 IOTeam. All rights reserved.
//

import UIKit
import SnapKit

private let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width

class HomeViewController: UIViewController, HomeListViewDelegate
{
    var homeBannerView = HomeBannerView()
    var homeInfoView = HomeInfoView()
    var homeListView = HomeListView()
    
    var homeDataController = HomeDataController()
    
    var homeBannerViewModel: HomeBannerViewModel?
    var homeInfoViewModel: HomeInfoViewModel?
    var homeListViewModel: HomeListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContentView()
        layoutContentView()
        setupContentViewEvent()
        setupContentViewDelegate()
        
        renderSubjectView()
    }
    
    func setupContentView() {
        view.addSubview(homeBannerView)
        view.addSubview(homeInfoView)
        view.addSubview(homeListView)
    }
    
    func layoutContentView() {
        homeBannerView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(view)
            make.height.equalTo(SCREEN_WIDTH / 2)
        }
        
        homeInfoView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(homeBannerView.snp_bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(100)
        }
        
        homeListView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(homeInfoView.snp_bottom)
            make.left.bottom.right.equalTo(view)
        }
    }
    
    func setupContentViewEvent() {
        homeInfoView.eventMethod = { [unowned self] in
            self.homeInfoViewModel?.text = self.homeDataController.homeInfoData()
            self.homeInfoView.updateInfoData()
        }
    }
    
    func setupContentViewDelegate() {
        homeListView.delegate = self
    }
    
    func renderSubjectView() {
        homeBannerViewModel = HomeBannerViewModel() // 实际上应该从Data Controller获取数据
        homeBannerView.bindDataWithViewModel(homeBannerViewModel!)
        
        homeInfoViewModel = HomeInfoViewModel()
        homeInfoView.bindDataWithViewModel(homeInfoViewModel!)
        
        homeListViewModel = HomeListViewModel()
        homeListView.bindDataWithViewModel(homeListViewModel!)
    }
    
    func homeList(homeList: HomeListView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("press at row \(indexPath.row)")
    }
}
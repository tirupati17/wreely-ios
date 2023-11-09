//
//  TBCommonSettingPresenter.swift
//  Medical Calculator
//
//  Created by Tirupati Balan on 18/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

class TBCommonSettingPresenter {
    var commonSettingViewProtocol : TBCommonSettingViewProtocol!
}

/**
 * Description : Methods for communication between VIEW -> PRESENTER
 * Purpose : Handle view interaction like button actions, table row selection etc
 */

extension TBCommonSettingPresenter : TBCommonSettingPresenterProtocol {
    func loadRecentApps() {
        
    }
}

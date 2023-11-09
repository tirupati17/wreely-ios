//
//  TBCommonSettingProtocol.swift
//  Medical Calculator
//
//  Created by Tirupati Balan on 18/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation


/**
 * Description : Methods for communication between PRESENTER -> VIEW
 * Purpose : Mediator between model and view i.e pass processed data from server->model to view
 */

protocol TBCommonSettingViewProtocol {
    func didLoadRecentApps(_ moreApps : [TBMoreAppItem])
}

/**
 * Description : Methods for communication between VIEW -> PRESENTER
 * Purpose : Handle view interaction like button actions, table row selection etc
 */

protocol TBCommonSettingPresenterProtocol {
    func loadRecentApps()
}



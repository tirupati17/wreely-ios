///
//  e-Where
//
//  Created by Sean Warren on 2/19/17.
//  Copyright © 2017 Sean Warren. All rights reserved.
//

import LBTAComponents

class SettingsDatasource: Datasource {
    override init() {
        super.init()
        var menuItems = [SWMenuItem]()
        let item1 = SWMenuItem(title: "General Settings", imageName: "" )
        let item2 = SWMenuItem(title: "Sign Out", imageName: "" )
        let item3 = SWMenuItem(title: "Invite Friends", imageName: "")
        let item4 = SWMenuItem(title: "About Us", imageName: "")
        let item5 = SWMenuItem(title: "View Profile", imageName: "" )
        let item6 = SWMenuItem(title: "Give us Feedack", imageName: "")
        menuItems = [item5, item1, item4, item2]
        objects = menuItems
    }
    override func cellClass(_ indexPath: IndexPath) -> DatasourceCell.Type? {
            return SWSettingsMenuCell.self
    }
    override func cellClasses() -> [DatasourceCell.Type] {
        return [SWSettingsMenuCell.self]
    }
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [SWSettingsHeader.self]
    }
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [SWSettingsFooter.self]
    }
}

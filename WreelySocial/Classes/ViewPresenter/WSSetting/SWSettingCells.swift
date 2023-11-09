//
//  SWSettings.swift
//  e-Where
//
//  Created by Sean Warren on 2/19/17.
//  Copyright © 2017 Sean Warren. All rights reserved.
//
import LBTAComponents
import Kingfisher

class SWSettingsHeader: DatasourceCell {
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = WSSession.activeSession().currentUser().name
        label.font = UIFont.getAppBoldFont(size: 23)//UIFont(name: "HelveticaNeue-CondensedBlack", size: 35)
        return label
    }()
    let secondaryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = WSSession.activeSession().currentUser().contactNo
        label.font = UIFont.getAppRegularFont(size: 15) //UIFont(name: "HelveticaNeue-Light", size: 15)

        return label
    }()

    let userProfileImage: UIImageView = {
        let theImageView = UIImageView()
        //theImageView.image = UIImage(named: "user-shape")
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        theImageView.layer.borderWidth = 0
        theImageView.layer.masksToBounds = false
        theImageView.layer.cornerRadius = 30
        theImageView.clipsToBounds = true
        return theImageView
    }()
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.white
        addSubview(userNameLabel)
        addSubview(secondaryLabel)
        addSubview(userProfileImage)
        
        userProfileImage.kf.setImage(with: URL.init(string: WSSession.activeSession().currentVendor().vendorLogoUrl!), placeholder: Image.init(named: "user-placeholder"))
        userProfileImage.contentMode = .scaleAspectFit

        userNameLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 50,
        leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        secondaryLabel.anchor(userNameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil,
        topConstant: 5, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        userProfileImage.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor,
        topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 30, widthConstant: 60, heightConstant: 60)
    }
}
class SWSettingsFooter: DatasourceCell {
    let textlabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.white
        addSubview(textlabel)
        textlabel.fillSuperview()
    }
}

class SWSettingsMenuCell: DatasourceCell {
    override var datasourceItem: Any? {
        didSet {
            guard let data = datasourceItem as? SWMenuItem else { return }
           menuTitle.text = data.title
            menuIcon.image = UIImage(named: "\(data.imageName)")
        }
    }
    let menuTitle = UILabel()
    let menuIcon: UIImageView = {
        let theImageView = UIImageView()
        theImageView.image = UIImage(named: "Bagitems-1")
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        return theImageView
    }()
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.08)
        return view
    }()
    override func setupViews() {
        super.setupViews()
        menuTitle.font = UIFont.getAppRegularFont(size: 16)//UIFont(name: "Avenir-Book", size: 25)
        menuTitle.textColor = UIColor(r: 83, g: 83, b: 83)

        addSubview(menuTitle)
        addSubview(menuIcon)

        addSubview(dividerLineView)
        menuTitle.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
        topConstant: 0, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 0)
        menuIcon.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 15,
        leftConstant: 0, bottomConstant: 0, rightConstant: 30, widthConstant: 40, heightConstant: 40)
        dividerLineView.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0,
        leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 0.5)
    }

}

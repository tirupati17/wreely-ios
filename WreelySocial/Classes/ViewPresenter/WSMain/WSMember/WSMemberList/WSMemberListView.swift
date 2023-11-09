//
//  WSMemberListView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 10/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

class WSMemberListView : WSViewController, SideMenuItemContent {
    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet var segmentControl : UISegmentedControl! {
        didSet {
            
        }
    }
    var memberListPresenterProtocol : WSMemberListPresenterProtocol!
    var members = [WSMember]() {
        didSet {
            searchResult = members
            collectionView.reloadData()
            
            if (searchResult.count > 0) {
                self.collectionView.removeNoResult()
            } else {
                self.collectionView.showNoResult()
            }
            self.collectionView.reloadData()
        }
    }
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            //searchBar.change(textFont: UIFont.init(name: WSConstant.AppCustomFontRegular, size: 14) ?? UIFont.systemFont(ofSize: 14))
        }
    }

    lazy var searchResult : [WSMember] = members
    var filterString: String? = nil {
        didSet {
            if filterString == nil || filterString!.isEmpty {
                searchResult = members
            } else {
                searchResult = members.filter({ (member) -> Bool in
                    return ((member.name?.lowercased().range(of: filterString!.lowercased())) != nil)
                })
            }
            collectionView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        self.title = "Members".localized
        
        self.configureDependencies()
        self.configureSearch()
        self.collectionView.register(UINib(nibName:"WSMemberListCell",
                                           bundle: nil), forCellWithReuseIdentifier: "cell")
        self.collectionView.addSubview(self.refreshControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startViewAnimation() //for initial load
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }

    func configureDependencies() {
        let memberListPresenter = WSMemberListPresenter()
        memberListPresenter.memberListViewProtocol = self
        self.memberListPresenterProtocol = memberListPresenter
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func returnCell(forIndexPath row : Int, _ section : Int? = 0) -> WSMemberListCell! {
        return self.collectionView.cellForItem(at: NSIndexPath.init(row: row, section: section!) as IndexPath) as! WSMemberListCell
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.memberListPresenterProtocol.didFetchMembers()
    }
    
    func loadData() {
        self.memberListPresenterProtocol.didFetchMembers()
    }

    @objc func showMenu() {
        showSideMenu()
    }
    
    func configureSearch() {
        searchBar.delegate = self
        searchBar.placeholder = "Search members"
    }
}

extension WSMemberListView: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {// return NO to not become first responder
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { // called when text changes (including clear)
        filterString = searchBar.text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("The default search bar keyboard search button was tapped: \(String(describing: searchBar.text)).")
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("The default search bar cancel button was tapped.")
        searchBar.resignFirstResponder()
    }
}

/**
 * Add here your methods for communication PRESENTER -> VIEW
 */

extension WSMemberListView : WSMemberListViewProtocol {
    
    func didFailedResponse<T>(_ error: T) {
        let error = error as! Error
        self.stopViewAnimation()
        self.showToastMessage(error.localizedDescription)
    }    
    
    func presentController<T>(_ vc: T) {
        self.present(vc as! WSViewController, animated: true) {}
    }
    
    func pushController<T>(_ vc: T) {
        self.navigationController?.pushViewController(vc as! WSViewController, animated: true)
    }
    
    func updateMembers(_ members : [WSMember]) {
        self.members = members
        self.stopViewAnimation()
    }
 }

extension WSMemberListView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let member = self.searchResult[safe : indexPath.row] {
            self.memberListPresenterProtocol.didSelectMember(member: member)
        }
    }
}

extension WSMemberListView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:WSMemberListCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WSMemberListCell)
        
        if let member = self.searchResult[safe : indexPath.row] {
            cell.memberNameLabel.text! = member.name!
            let font = UIFont.getAppBoldFont(size: 14)
            if !(member.profilePicUrl?.isEmpty)! {
                cell.memberImageView?.kf.setImage(with: URL.init(string: member.profilePicUrl!))
            } else {
                cell.memberImageView?.setImage(string: member.name, color: .random, circular: true, textAttributes: [NSAttributedString.Key.font: font.withSize(font.pointSize * 2), NSAttributedString.Key.foregroundColor: UIColor.white])
            }
        }
        return cell
    }
}

extension WSMemberListView : TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

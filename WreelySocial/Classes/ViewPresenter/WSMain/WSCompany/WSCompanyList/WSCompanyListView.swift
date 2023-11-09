//
//  WSCompanyListView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 21/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

class WSCompanyListView : WSViewController, SideMenuItemContent {
    @IBOutlet var collectionView : UICollectionView!
    var companyListPresenterProtocol : WSCompanyListPresenterProtocol!
    var companies = [WSCompany]() {
        didSet {
            searchResult = companies
            if (searchResult.count > 0) {
                self.collectionView.removeNoResult()
            } else {
                self.collectionView.showNoResult()
            }
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            //searchBar.change(textFont: UIFont.init(name: WSConstant.AppCustomFontRegular, size: 14) ?? UIFont.systemFont(ofSize: 14))
        }
    }

    lazy var searchResult : [WSCompany] = companies
    var filterString: String? = nil {
        didSet {
            if filterString == nil || filterString!.isEmpty {
                searchResult = companies
            } else {
                searchResult = companies.filter({ (company) -> Bool in
                    return ((company.name?.lowercased().range(of: filterString!.lowercased())) != nil)
                })
            }
            collectionView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        self.title = "Companies".localized
        
        self.configureDependencies()
        self.configureSearch()
        
        self.collectionView.register(UINib(nibName:"WSCompanyListCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.collectionView.addSubview(self.refreshControl)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.startViewAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }

    func configureDependencies() {
        let companyListPresenter = WSCompanyListPresenter()
        companyListPresenter.companyListViewProtocol = self
        self.companyListPresenterProtocol = companyListPresenter
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func returnCell(forIndexPath row : Int, _ section : Int? = 0) -> WSCompanyListCell! {
        return self.collectionView.cellForItem(at: NSIndexPath.init(row: row, section: section!) as IndexPath) as! WSCompanyListCell
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.companyListPresenterProtocol.didFetchCompanies()
    }
    
    func loadData() {
        self.companyListPresenterProtocol.didFetchCompanies()
    }

    @objc func showMenu() {
        showSideMenu()
    }
    
    func configureSearch() {
        searchBar.delegate = self
        searchBar.placeholder = "Search companies"
    }
}

extension WSCompanyListView: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterString = searchBar.text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

/**
 * Add here your methods for communication PRESENTER -> VIEW
 */

extension WSCompanyListView : WSCompanyListViewProtocol {
    func updateCompanies(_ companies: [WSCompany]) {
        self.companies = companies

        self.stopViewAnimation()
    }
    
    func didFailedResponse(_ error: Error) {
        self.stopViewAnimation()
        self.showToastMessage(error.localizedDescription)
    }
    
    func presentController<T>(_ vc: T) {
        
    }
    
    func pushController<T>(_ vc: T) {
        self.navigationController?.pushViewController(vc as! WSCompanyDetailView, animated: true)
    }

 }

extension WSCompanyListView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let company = self.searchResult[safe : indexPath.row] {
            self.companyListPresenterProtocol.didSelectCompany(company: company)
        }
    }
}

extension WSCompanyListView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:WSCompanyListCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WSCompanyListCell)
        
        if let company = self.searchResult[safe : indexPath.row] {
            cell.companyNameLabel.text! = company.name!
            let font = UIFont.getAppBoldFont(size: 14)
            if !(company.companyLogoURL?.isEmpty)! {
                cell.companyLogoImageView?.kf.setImage(with: URL.init(string: company.companyLogoURL!))
            } else {
                cell.companyLogoImageView?.setImage(string: company.name, color: .random, circular: true, textAttributes: [NSAttributedString.Key.font: font.withSize(font.pointSize * 2), NSAttributedString.Key.foregroundColor: UIColor.white])
            }
        }
        return cell
    }
}

extension WSCompanyListView : TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

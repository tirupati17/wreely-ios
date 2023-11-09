//
//  WSWorkspaceListView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 14/08/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import SwiftLocation
import CoreLocation
import SwiftWebVC
import LocationPickerViewController
import FontAwesome_swift
import GoogleMaps

extension UISearchBar {
    func change(textFont : UIFont?) {
        for view : UIView in (self.subviews[0]).subviews {
            if let textField = view as? UITextField {
                textField.font = textFont
            }
        }
    }
}
extension GMSMapView {
    func getCenterCoordinate() -> CLLocationCoordinate2D {
        let centerPoint = self.center
        let centerCoordinate = self.projection.coordinate(for: centerPoint)
        return centerCoordinate
    }
    
    func getTopCenterCoordinate() -> CLLocationCoordinate2D {
        let topCenterCoor = self.convert(CGPoint(x: self.frame.size.width, y: 0), from: self)
        let point = self.projection.coordinate(for: topCenterCoor)
        return point
    }
    
    func getRadius() -> CLLocationDistance {
        let centerCoordinate = getCenterCoordinate()
        let centerLocation = CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
        let topCenterCoordinate = self.getTopCenterCoordinate()
        let topCenterLocation = CLLocation(latitude: topCenterCoordinate.latitude, longitude: topCenterCoordinate.longitude)
        let radius = CLLocationDistance(centerLocation.distance(from: topCenterLocation))
        return round(radius)/1609
    }
}

class POIItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var name: String!
    
    init(position: CLLocationCoordinate2D, name: String) {
        self.position = position
        self.name = name
    }
}

struct WSWorkspaceListItem {
    var lat : String = "19.1726" //Default mulund, mumbai lat, lon
    var lon : String = "72.9425"
    var rad : String = "60"
    var scale : Int = 12
}

class WSWorkspaceListView : WSViewController {
    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet weak var mapView: GMSMapView!
    private var clusterManager: GMUClusterManager!
    var workspaceListItem = WSWorkspaceListItem() {
        didSet {
            self.startViewAnimation()
            self.workspaceListPresenterProtocol.didFetchWorkspaces(self.workspaceListItem.lat, lon: self.workspaceListItem.lon, rad: self.workspaceListItem.rad)
        }
    }
    var workspaceListPresenterProtocol : WSWorkspaceListPresenterProtocol!
    var workspaces = [WSWorkspace]() {
        didSet {
            searchResult = workspaces
            if (searchResult.count > 0) {
                self.title = "Nearby" + " (\(searchResult.count))"
            } else {
                self.title = "Nearby"
            }
            self.collectionView.reloadData()
            self.addAnnotation(searchResult)
        }
    }
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.change(textFont: UIFont.init(name: WSConstant.AppCustomFontRegular, size: 14) ?? UIFont.systemFont(ofSize: 14))
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    var pinIconImage : UIImage {
        return UIImage.init(named: "marker-oval")!
    }
    
    var mapIconImage : UIImage {
        return UIImage.init(named: "earth-globe")!
    }
    
    var listIconImage : UIImage {
        return UIImage.init(named: "tasks-list")!
    }
    
    lazy var searchResult : [WSWorkspace] = workspaces
    var filterString: String? = nil {
        didSet {
            if filterString == nil || filterString!.isEmpty {
                searchResult = workspaces
            } else {
                searchResult = workspaces.filter({ (workspace) -> Bool in
                    return ((workspace.name.lowercased().range(of: filterString!.lowercased())) != nil)
                })
            }
            self.collectionView.reloadData()
        }
    }
    
    var collectionViewHeight : CGFloat {
        return self.isListView ? view.height - (55 + 64) : 160
    }
    
    var collectionViewWidth : CGFloat {
        return view.width
    }
    
    var collectionViewCellWidth : CGFloat {
        return self.isListView ? self.collectionView.width : (self.collectionView.width/2) - 15 // 30/15 for margin
    }

    var collectionViewCellHeight : CGFloat {
        return self.isListView ? 240 : 140
    }
    
    var isListView : Bool = true {
        didSet {
            if (isListView) {
                UIView.animate(withDuration: 0.3) {
                    self.switchToList()
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.switchToMap()
                }
            }
        }
    }

    override func loadView() {
        super.loadView()
        
        let rightButton = UIBarButtonItem.init(image: self.pinIconImage, style: .plain, target: self, action: #selector(self.showLocationPicker))
        rightButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightButton

//        let leftButton = UIBarButtonItem.init(image: self.listIconImage, style: .plain, target: self, action: #selector(self.switchView))
//        leftButton.tintColor = UIColor.white
//        self.navigationItem.leftBarButtonItem = leftButton
        
        self.title = "Nearby"
        self.configureDependencies()
        self.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureDependencies() {
        let workspaceListPresenter = WSWorkspaceListPresenter()
        workspaceListPresenter.workspaceListViewProtocol = self
        self.workspaceListPresenterProtocol = workspaceListPresenter
        
        self.scrollView.frame = CGRect(origin: CGPoint(x: 0, y: isIPhoneX ? 88 : 64), size: CGSize(width: self.scrollView.width, height: self.scrollView.height))
        Locator.requestAuthorizationIfNeeded(.whenInUse)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset = UIEdgeInsetsMake(0,0,0,0)
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 10
        }
        self.isListView = false

        self.collectionView.register(UINib(nibName:"WSWorkspaceCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.configureSearch()
        self.confirgureMapView()
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.workspaceListPresenterProtocol.didFetchCurrentLocation()
    }
    
    func loadData() {
        self.workspaceListPresenterProtocol.didFetchCurrentLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func switchView( _ sender : UIBarButtonItem) {
        self.isListView = !(self.isListView)
        sender.image = self.isListView ? self.mapIconImage : self.listIconImage
    }
    
    func switchToList() {
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        self.collectionView.frame = CGRect(origin: CGPoint(x: 0, y: 55), size: CGSize(width: self.collectionViewWidth, height: self.collectionViewHeight))
    }
    
    func switchToMap() {
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        self.collectionView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.collectionViewWidth, height: self.collectionViewHeight))
    }

    @IBAction func searchThisArea() {
        self.workspaceListItem = WSWorkspaceListItem(lat: "\(self.mapView.getCenterCoordinate().latitude)", lon: "\(self.mapView.getCenterCoordinate().longitude)", rad: "\(self.mapView.getRadius())", scale: Int(self.mapView.camera.zoom))
    }
    
    @IBAction func searchWithin(_ sender : UISegmentedControl) {
        var radius = 60
        var scale = 12
        switch sender.selectedSegmentIndex {
            case 0:
                radius = 60
                scale = 12
                break
            case 1:
                radius = 100
                scale = 8
                break
            case 2:
                radius = 1000
                scale = 4
                break
            case 3:
                radius = 100000
                scale = 1
                break
            default:
                radius = 60
                scale = 12
        }
        self.workspaceListItem = WSWorkspaceListItem(lat: "\(self.workspaceListItem.lat)", lon: "\(self.workspaceListItem.lon)", rad: "\(radius)", scale: scale)
    }
    
    @objc func showLocationPicker() {
        let locationPicker = LocationPicker()
        locationPicker.searchBar.change(textFont: UIFont.init(name: WSConstant.AppCustomFontRegular, size: 14) ?? UIFont.systemFont(ofSize: 14))
        locationPicker.searchResultLocationIcon = nil
        locationPicker.searchResultLocationIconColor = UIColor.themeColor()
        locationPicker.currentLocationIconColor = UIColor.themeColor()
        locationPicker.alternativeLocationIconColor = UIColor.themeColor()
        locationPicker.pinColor = UIColor.themeColor()
        locationPicker.pickCompletion = { location in
            self.workspaceListItem = WSWorkspaceListItem(lat: "\(location.coordinate!.latitude)", lon: "\(location.coordinate!.longitude)", rad: self.workspaceListItem.rad, scale: 12)
        }
        self.navigationController?.pushViewController(locationPicker, animated: true)
    }

    func addAnnotation(_ searchResult : [WSWorkspace]) {
        DispatchQueue.global(qos: .userInitiated).async {
            var itemArray = [POIItem]()
            DispatchQueue.global(qos: .background).async {
                for workspace in searchResult {
                    let item = POIItem(position: CLLocationCoordinate2DMake(workspace.latitude.toDouble(), workspace.longitude.toDouble()), name: workspace.name)
                    itemArray.append(item)
                }
                DispatchQueue.main.async {
                    self.clusterManager.clearItems()
                    self.clusterManager.add(itemArray)
                }
            }
        }

        
        let center = CLLocationCoordinate2D(latitude: self.workspaceListItem.lat.toDouble(), longitude: self.workspaceListItem.lon.toDouble()) // region center
        let update = GMSCameraUpdate.setTarget(center)
        mapView.moveCamera(update)
        mapView.animate(toZoom: Float(self.workspaceListItem.scale))
    }

    func configureSearch() {
        searchBar.delegate = self
        searchBar.placeholder = "Search workspace"
    }
    
    func confirgureMapView() {
        mapView?.delegate = self
        do {
            if let styleURL = Bundle.main.url(forResource: "silver", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        
        clusterManager.cluster()
        clusterManager.setDelegate(self, mapDelegate: self)
    }
    
    @objc func showDirection(_ sender : UIButton) {
        if let workspace = self.searchResult[safe : (sender.accessibilityIdentifier?.toInt())!] {
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
                UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=\(self.workspaceListItem.lat),\(self.workspaceListItem.lon)&daddr=\(workspace.latitude),\(workspace.longitude)&directionsmode=driving")!)
            } else {
                if (UIApplication.shared.canOpenURL(NSURL(string:"https://maps.google.com")! as URL))
                {
                    UIApplication.shared.openURL(NSURL(string:
                        "https://maps.google.com/?q=@\(workspace.latitude),\(workspace.longitude)")! as URL)
                }
            }
        }
    }
}

extension WSWorkspaceListView: GMSMapViewDelegate, GMUClusterManagerDelegate {
    
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
                                                 zoom: mapView.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(newCamera)
        mapView.moveCamera(update)
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let poiItem = marker.userData as? POIItem {
            NSLog("Did tap marker for cluster item \(poiItem.name)")
            let index = self.searchResult.index { (workspace) -> Bool in
                workspace.name == poiItem.name
            }
            self.collectionView.scrollToItem(at: IndexPath.init(row: index!, section: 0), at: .centeredHorizontally, animated: true)
        } else {
            NSLog("Did tap a normal marker")
        }
        return false
    }
}

extension WSWorkspaceListView : WSWorkspaceListViewProtocol {
    
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
    
    func updateWorkspace(_ workspaces: [WSWorkspace]) {
        self.workspaces = workspaces
        self.stopViewAnimation()
    }
    
    func updateLocation(_ lat : String, lon : String) {
        self.workspaceListItem = WSWorkspaceListItem(lat: lat, lon: lon, rad: self.workspaceListItem.rad, scale: self.workspaceListItem.scale)
    }
    
}

extension WSWorkspaceListView: UISearchBarDelegate {
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

extension WSWorkspaceListView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchResult.count > 0 ? self.searchResult.count : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:WSWorkspaceCollectionCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WSWorkspaceCollectionCell)
        let buttonObj = cell.getButton(WSWorkspaceCollectionCellUIControlTag.directionButton.rawValue)
        if let workspace = self.searchResult[safe : indexPath.row] {
            cell.configureCell(workspace)
            buttonObj.accessibilityIdentifier = "\(indexPath.row)"
            buttonObj.addTarget(self, action: #selector(self.showDirection(_:)), for: .touchUpInside)
            buttonObj.isHidden = false
        } else {
            buttonObj.isHidden = true
        }
        return cell
    }
    
}

extension WSWorkspaceListView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let workspace = self.searchResult[safe : indexPath.row] {
            let webVC = SwiftModalWebVC(pageURL: URL.init(string: workspace.cwUrl)!, theme: .dark, dismissButtonStyle: .arrow, sharingEnabled: false)
            self.present(webVC, animated: true, completion: {
                self.collectionView.scrollToItem(at: IndexPath.init(row: indexPath.row, section: 0), at: .centeredHorizontally, animated: true)
            })
        }
    }
}

extension WSWorkspaceListView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionViewCellWidth, height: self.collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension WSWorkspaceListView : TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


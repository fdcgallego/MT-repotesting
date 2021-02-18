//
//  ViewController.swift
//  Inspo
//
//  Created by FDC-Macmini06 on 1/28/21.
//

//HELLO WORLDDD
//ADDING LINES!!!

import UIKit
import Alamofire

class MainViewController: UIViewController {

    //If you see this comment, please revert
    @IBOutlet weak var collectionView: UICollectionView!

    let url = "https://machetalk.jp/mobile_api/viewer/room_list"
    
    var pageNumber:Int = 1

    let reuseIdentifier = "PerformerCollectionViewCell"
    let refreshControl = UIRefreshControl()
    
    var performer : [Performer] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: reuseIdentifier, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: reuseIdentifier)
        
        fetch(page : pageNumber)
        
        debugPrint()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        DispatchQueue.main.async { [self] in
            
            refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
            refreshDirection(isLandscape: self.view.frame.size.width > self.view.frame.size.height)
            
            debugPrint(self.view.frame.size.width > self.view.frame.size.height)
            scrollDirection(isLandscape: self.view.frame.size.width > self.view.frame.size.height)
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
//
//        debugPrint("Will transition to size \(size) from super view size \(view.frame.size)")
        DispatchQueue.main.async { [self] in
//            debugPrint("DispatchQueue")
//            debugPrint("Will transition to size \(size) from super view size \(view.frame.size)")
            scrollDirection(isLandscape: size.width >= size.height)
            refreshDirection(isLandscape: self.view.frame.size.width > self.view.frame.size.height)
            
        }
    }
}

// MARK: - Fetch
extension MainViewController {

    func fetch(page : Int) {
        
        let pageNum = String("\(page)")
        
        let parameters = [
            "idfa":"sample-idfa",
            "pagination": pageNum,
            "search_options": [
                "broadcast_list_type":"0",
                "broadcast_performer_name":"",
                "broadcast_performer_age_from": "",
                "broadcast_performer_age_to": ""
            ]
        ] as [String : Any]
        
        AF.request(url, method: .post, parameters: parameters).responseJSON{ (res) in
  
            guard let data = res.value as? [String: Any] else { return }
            let rooms = data["rooms"] as! [[String : Any]]
            
            for (value) in rooms {
                let perfInfo = value["performer_information"] as! [String : Any]
                
                self.performer.append(
                    Performer.init(
                        performerName: perfInfo["name"] as! String,
                        performerImage: perfInfo["image"] as! String,
                        performerAge : (perfInfo["age"] as? NSNumber ?? 0) as! Int,
                        performerOccupation: perfInfo["occupation"] as! String,
                        performerStrength: perfInfo["strength"] as! String,
                        performerRank: perfInfo["rank"] as Any,
                        performerLevel: perfInfo["level"] as Any,
                        performerArea: perfInfo["area"] as! String,
                        wasRecentOnline: perfInfo["was_recent_online_flg"] as! Bool,
                        isNewbie: perfInfo["show_newbie_mark_flg"] as! Bool
                    )
                )
            }
            
            
            self.collectionView.reloadData()
        }
        
    }
    
    func scrollDirection (isLandscape : Bool) {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.scrollDirection = isLandscape ? .horizontal : .vertical
        
        collectionView.alwaysBounceVertical.self = isLandscape ? false : true
    }
    
    @objc private func didPullToRefresh(_ sender: Any) {

        self.performer.removeAll()
        debugPrint("fetching")
        pageNumber = 1
        fetch(page: pageNumber)
        refreshControl.endRefreshing()
    }
    
    func refreshDirection (isLandscape : Bool){
//
        collectionView.refreshControl.self = isLandscape ? nil : refreshControl
        
//        collectionView.refreshControl = refreshControl
    }
}


// MARK: - Collection View Data Source
extension MainViewController: UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        debugPrint("Performer count: \(self.performer.count)")
        return self.performer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PerformerCollectionViewCell
        /*PerfomerPhotoCell*/
//        debugPrint("Performers:\(self.performer.count)")
//        debugPrint("IndexPath:\(indexPath.row)")
//        debugPrint("Performer[\(indexPath.row)]")
        if self.performer.count > 0 && indexPath.row < self.performer.count {
            cell.performer = Performer.init(performerName: self.performer[indexPath.row].performerName,
                                            performerImage: self.performer[indexPath.row].performerImage,
                                            performerAge: self.performer[indexPath.row].performerAge,
                                            performerOccupation: self.performer[indexPath.row].performerOccupation,
                                            performerStrength: self.performer[indexPath.row].performerStrength,
                                            performerRank: self.performer[indexPath.row].performerRank,
                                            performerLevel: self.performer[indexPath.row].performerLevel,
                                            performerArea: self.performer[indexPath.row].performerArea,
                                            wasRecentOnline: self.performer[indexPath.row].wasRecentOnline,
                                            isNewbie: self.performer[indexPath.row].isNewbie)
        }
        
        cell.roundedEdges()
        
        return cell

    }
    
}


// MARK: - Collection View Layout Delegate

extension MainViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var len : CGFloat = CGFloat()
        
        if self.view.frame.size.width > self.view.frame.size.height {
            len = (collectionView.frame.size.height - 26)/2
        } else {
            len = (collectionView.frame.size.width - 26)/2
        }
//        debugPrint("View :\(self.view.frame.size)")
//        debugPrint("Collection view :\(collectionView.frame.size)")
//        debugPrint("Length of cell :\(len)"
        
        return CGSize(width: len, height: len)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (indexPath.row == self.performer.count - 1) {
            
            pageNumber += 1
            fetch(page: pageNumber)
            
        }
    }
}

// MARK: - Extra Extensions and fucntions

extension UIView {
    
    func roundedEdges() {
        
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
    }
}

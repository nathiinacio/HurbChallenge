//
//  Feed.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 05/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.
//

import UIKit


class Feed: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, Requester {
    

    
    // MARK: - Initialization
    
    // MARK: Outlets
    @IBOutlet weak var collectionViewFeed: UICollectionView!
    
    @IBOutlet weak var searchLabel: UILabel!
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!

    
    // MARK: Variables
    
     private let refreshControl = UIRefreshControl()
     var activityView:UIActivityIndicatorView!
     var segmentedControl: CustomSegmentedContrl!
     var currentSegment:Int = 0
     var isFiltering:Bool = false
    
    /// The hotels or packages to appear in the collection view.
    
     var hotels: [Hotel] = []
     var packages: [Hotel] = []

    // MARK: - Methods
    
    // MARK: View Cicle
    
    override func viewDidLoad() {
        
        //Search bar rounded corners
        searchLabel.layer.cornerRadius = 15
        searchLabel.clipsToBounds = true
        searchLabel.layer.masksToBounds = true
        
        //Search Button alpha
        searchButton.alpha = 0
        searchButton.isEnabled = false
        
        //Serch Field Target
        searchField.addTarget(self, action: #selector(searchTaped), for: .allEvents)

        //Segmented control customization
        segmentedControl = CustomSegmentedContrl.init(frame: CGRect.init(x: 0, y: 440, width: self.view.frame.width, height: 45))
        segmentedControl.backgroundColor = .white
        segmentedControl.commaSeperatedButtonTitles = "Hotéis, Pacotes"
        segmentedControl.addTarget(self, action: #selector(onChangeOfSegment(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(segmentedControl)
        self.currentSegment = 0
        
        //Add constraints
        setUpSegmentedControlConstraints()
        
        //Refresh control customization
        refreshControl.tintColor = UIColor.palettePink
        
//        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        //Activity view customization
        activityView = UIActivityIndicatorView(style: .gray)
        activityView.color = UIColor.palettePink
        activityView.frame = CGRect(x: 0, y: 0, width: 300.0, height: 300.0)
        activityView.center = view.center
        activityView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        view.addSubview(activityView)
        activityView.startAnimating()
        
        collectionViewFeed.reloadData()
        setUpCollectionView()
        
        
        // chamada da funcao para ler o JSON
        DAO.instance.jsonReader(page: 1, requester: self, on: self)
    
    }
    
    
    // MARK: Readed JSON
    
    func readedData(result: [Result]) {
        DispatchQueue.main.async {
            self.collectionViewFeed.reloadData()
            self.activityView.stopAnimating()
        }
    }

    
    
    // MARK: CollectionView configuration
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if currentSegment == 0 {
            return DAO.instance.readedHotels.count
        } else {
            return DAO.instance.readedPackages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        
        if !DAO.instance.readedHotels.isEmpty{
            if currentSegment == 0 {
                let result = DAO.instance.readedHotels[indexPath.row]
                feedCell.populateHotel(from: result)
            } else {
                let result = DAO.instance.readedPackages[indexPath.row]
                feedCell.populatePackage(from: result)
                
            }
        }
        
        
        return feedCell
    }


    // MARK: Auxiliar
    @objc func searchTaped(sender: UITextField!) {
        if searchField.text != nil && searchField.text != ""{
            
            searchButton.alpha = 1
            searchButton.isEnabled = true
            
        }else{
            searchButton.alpha = 0
            searchButton.isEnabled = false
        }
    }
    
    
    func setUpCollectionView() {
        
        let nib = UINib.init(nibName: "CardCell", bundle: nil)
        
        collectionViewFeed.refreshControl = refreshControl
        collectionViewFeed.dataSource = self
        collectionViewFeed.delegate = self
        collectionViewFeed.allowsSelection = false
        collectionViewFeed.isUserInteractionEnabled = true
        collectionViewFeed.register(nib, forCellWithReuseIdentifier: "CardCell")
        
    }
    
    //segmented control adjustments
    @objc func onChangeOfSegment(_ sender: CustomSegmentedContrl) {
        self.currentSegment = sender.selectedSegmentIndex
        collectionViewFeed.reloadData()
        
    }
    
    private func setUpSegmentedControlConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 30),
            segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: collectionViewFeed.topAnchor, constant: -30),
            segmentedControl.heightAnchor.constraint(greaterThanOrEqualToConstant: 45)
            ])
    }

    //cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 357, height: 441)
}

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterScreen" {
            debugPrint("go to Filter")
            if let destinationVC = segue.destination as? Filter {
                
                if currentSegment == 0 {
                    
                    destinationVC.isHotelFilter = true
                    
                }else{
                     destinationVC.isHotelFilter = false
                    
                }
               
            }
        }
    }
    
    @objc private func refreshData(_ sender: Any) {
        DAO.instance.jsonReader(page: 1, requester: self, on: self)
        collectionViewFeed.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    
// MARK: Actions
    
    @IBAction func filterButton(_ sender: Any) {
        
         self.performSegue(withIdentifier: "filterScreen", sender: nil)
                
    }
    
    
    
    
}

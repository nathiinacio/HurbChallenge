//
//  Feed.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 05/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.
//

import UIKit


class Feed: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate, Requester {
    
    
    
    // MARK: - Initialization
    
    // MARK: Outlets
    @IBOutlet weak var collectionViewFeed: UICollectionView!
    
    @IBOutlet weak var searchLabel: UILabel!
    
    @IBOutlet weak var searchField: UITextField!
    
    // MARK: Variables
    
    private let refreshControl = UIRefreshControl()
    var activityView:UIActivityIndicatorView!
    var segmentedControl: CustomSegmentedContrl!
    var currentSegment:DataType = .hotel
    var isFiltering:Bool = false
    var filterByName:Bool { return (searchField.text?.count ?? 0) > 3}
    var filterByNameString:String {return searchField.text?.lowercased() ?? ""}
    
    
    ///The hotels or packages to appear in the collection view.
    var establishments = DAO.instance.establishments
    
    var dataSource:[DataType:[Result]] {
        if filterByName {
            var filteredData = establishments
            filteredData[.hotel] = filteredData[.hotel]?.filter{ $0.name.lowercased().contains(filterByNameString) }
            filteredData[.package] = filteredData[.package]?.filter{ $0.name.lowercased().contains(filterByNameString) }
            return filteredData
        } // else
        
        return establishments
    }
    
    // MARK: - Methods
    
    // MARK: View Cicle
    
    override func viewDidLoad() {
        
        searchField.addTarget(self, action: #selector(uptadeSearchBar), for: .editingChanged)
        searchField.delegate = self
    
        
        ///Search bar rounded corners
        searchLabel.layer.cornerRadius = 15
        searchLabel.clipsToBounds = true
        searchLabel.layer.masksToBounds = true
        
    
        ///Segmented control customization
        segmentedControl = CustomSegmentedContrl.init(frame: CGRect.init(x: 0, y: 440, width: self.view.frame.width, height: 45))
        segmentedControl.backgroundColor = .white
        segmentedControl.commaSeperatedButtonTitles = "Hotéis, Pacotes"
        segmentedControl.addTarget(self, action: #selector(onChangeOfSegment(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(segmentedControl)
        
        ///Add constraints
        setUpSegmentedControlConstraints()
        
        ///Refresh control customization
        refreshControl.tintColor = UIColor.palettePink
        
        //        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        ///Activity view customization
        activityView = UIActivityIndicatorView(style: .gray)
        activityView.color = UIColor.palettePink
        activityView.frame = CGRect(x: 0, y: 0, width: 300.0, height: 300.0)
        activityView.center = view.center
        activityView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        view.addSubview(activityView)
        activityView.startAnimating()
        
        collectionViewFeed.reloadData()
        setUpCollectionView()
     
        ///Function to read JSON
        DAO.instance.jsonReader(page: 1, requester: self, on: self)
        
    }
    
    
    
    //MARK: Readed JSON
    
    func readedData(establishments:[DataType:[Result]]) {
        self.establishments = establishments
        DispatchQueue.main.async {
            self.collectionViewFeed.reloadData()
            self.activityView.stopAnimating()
        }
    }
    
    
    
    //MARK: CollectionView configuration
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[currentSegment]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
  
        feedCell.populate(from: dataSource[currentSegment]![indexPath.row], for: currentSegment)

        return feedCell
    }
    
    
    //MARK: Auxiliar
    
    ///Colection view set up
    func setUpCollectionView() {
        
        let nib = UINib.init(nibName: "CardCell", bundle: nil)
        
        collectionViewFeed.refreshControl = refreshControl
        collectionViewFeed.dataSource = self
        collectionViewFeed.delegate = self
        collectionViewFeed.allowsSelection = false
        collectionViewFeed.isUserInteractionEnabled = true
        collectionViewFeed.register(nib, forCellWithReuseIdentifier: "CardCell")
        
    }
    
    ///Search Bar Clear Button
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        uptadeSearchBar()
        return true
    }
    
    ///Uptade Search Bar
    @objc func uptadeSearchBar(){
        if filterByName {
            collectionViewFeed.reloadData()
        }
    }
    
    ///Segmented control adjustments
    @objc func onChangeOfSegment(_ sender: CustomSegmentedContrl) {
        self.currentSegment = sender.selectedSegmentIndex == 0 ? .hotel : .package
        collectionViewFeed.reloadData()
        
    }
    
    
    
    ///Cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 357, height: 441)
    }
    
    ///Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterScreen" {
            debugPrint("go to Filter")
            if let destinationVC = segue.destination as? Filter {
                
                if currentSegment == .hotel {
                    
                    destinationVC.isHotelFilter = true
                    
                }else{
                    destinationVC.isHotelFilter = false
                    
                }
                
            }
        }
    }

    ///Refresh collection view content
    @objc private func refreshData(_ sender: Any) {
        DAO.instance.jsonReader(page: 1, requester: self, on: self)
        collectionViewFeed.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    // MARK: Constraints
    private func setUpSegmentedControlConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 30),
            segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: collectionViewFeed.topAnchor, constant: -30),
            segmentedControl.heightAnchor.constraint(greaterThanOrEqualToConstant: 45)
            ])
    }
    
    

    // MARK: Actions
    @IBAction func filterButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "filterScreen", sender: nil)
        
    }
    
    
}


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
    
    
    // MARK: Variables
    
     private let refreshControl = UIRefreshControl()
    
     var activityView:UIActivityIndicatorView!
    
     var segmentedControl: CustomSegmentedContrl!
    var currentSegment:Int = 0
    
    /// The hotels or packages to appear in the collection view.
    
    // var hotels: [Hotel] = []
    // var packages: [Hotel] = []

    // MARK: - Methods
    
    // MARK: View Cicle
    
    override func viewDidLoad() {
        
        // Search bar rounded corners
        searchLabel.layer.cornerRadius = 15
        searchLabel.clipsToBounds = true
        searchLabel.layer.masksToBounds = true

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
    
    func readedData(result: Hotel) {
        popula(hoteis: result)
    }
    
    func popula(hoteis: Hotel) {
        // aq vc coloca as coisa na celula
        // para acessar os hoteis:
        //        result.results[indice]
        //        oq for um [] tem q fazer um for ali dentro tb com o indice = count -1 :)
        
        // nao esquece de fazer um reload na tableview
    }
    
    
    // MARK: CollectionView configuration
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if currentSegment == 1 {
            return 4
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        
//        feedCell.type = .project
//        feedCell.project = projects[indexPath.item]
//        feedCell.showInfoProject()
        
        return feedCell
    }

    
    
    // MARK: Auxiliar
    func setUpCollectionView() {
        
        let nib = UINib.init(nibName: "CardCell", bundle: nil)
        
        collectionViewFeed.refreshControl = refreshControl
        collectionViewFeed.dataSource = self
        collectionViewFeed.delegate = self
        collectionViewFeed.allowsSelection = false
        collectionViewFeed.isUserInteractionEnabled = true
        collectionViewFeed.register(nib, forCellWithReuseIdentifier: "CardCell")
        
        activityView.stopAnimating()
        
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
        return CGSize(width: 357, height: 297)
}

// MARK: Actions
    
    @IBAction func filterButton(_ sender: Any) {
        
        
    }
    
    
}

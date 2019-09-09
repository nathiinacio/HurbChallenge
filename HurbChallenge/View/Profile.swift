//
//  Profile.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 05/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.
//

import UIKit
import Firebase

class Profile: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var profileCollectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    // MARK: Variables
    
    private let refreshControl = UIRefreshControl()
    
    var activityView:UIActivityIndicatorView!
    
    var segmentedControl: CustomSegmentedContrl!
    var currentSegment:Int = 0
    
    /// The hotels or packages to appear in the collection view.
    
    // var favorites: [Hotel] = []
  

    // MARK: - Methods
    
    // MARK: View Cicle
    override func viewDidLoad() {
        

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
        
        Auth.auth().currentUser?.reload()
        profileCollectionView.reloadData()
        setUpCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = AppSettings.displayName
       
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
        
        profileCollectionView.refreshControl = refreshControl
        profileCollectionView.dataSource = self
        profileCollectionView.delegate = self
        profileCollectionView.allowsSelection = false
        profileCollectionView.isUserInteractionEnabled = true
        profileCollectionView.register(nib, forCellWithReuseIdentifier: "CardCell")
        
        activityView.stopAnimating()
        
    }
    
    //segmented control adjustments
    @objc func onChangeOfSegment(_ sender: CustomSegmentedContrl) {
        self.currentSegment = sender.selectedSegmentIndex
        profileCollectionView.reloadData()
        
    }
    
    private func setUpSegmentedControlConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: favoriteLabel.bottomAnchor, constant: 30),
            segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: profileCollectionView.topAnchor, constant: -45),
            segmentedControl.heightAnchor.constraint(greaterThanOrEqualToConstant: 45)
            ])
    }
    
    //cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 357, height: 297)
    }
    
    
    // MARK: Actions
    @IBAction func exitButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Deseja mesmo sair?", message: "", preferredStyle: .alert)
        
        
        let ok = UIAlertAction(title: "Sim, desejo sair", style: .default, handler: { (action) -> Void in
            
            UserManager.instance.signOut(completion: { (error) in
                if error != nil {
                    debugPrint(#function, String(describing: error?.localizedDescription))
                } else {
                    self.performSegue(withIdentifier: "goToStart", sender: self)
                }
            })
            
        })
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .default ) { (action) -> Void in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(ok)
        alert.addAction(cancelar)
        self.present(alert, animated: true, completion: nil)
        alert.view.tintColor = UIColor.paletteBlue
        
    }
    
    
}

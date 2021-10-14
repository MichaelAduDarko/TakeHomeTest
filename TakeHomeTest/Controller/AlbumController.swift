//
//  AlbumController.swift
//  TakeHomeTest
//
//  Created by MICHAEL ADU DARKO on 10/12/21.

import UIKit

class AlbumController: UIViewController{
    lazy var data: [SearchItem] = []

    private let viewModel = ViewModel()
    
    //Mark:- Properties
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .backgroundColor
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
        
        return cv
    }()

    private let searchBar = UISearchBar()
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        configureCategoryVC()
        configureSearchController()

    }
    
    //MARK:- Helpers
    private func configureCategoryVC(){
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //NavigationBarTitle
        configureNavigationBar(withTitle: "Search", prefersLargeTitles: false)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Collectionview autolayouts
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    //SearchBarConiguration
    func configureSearchController(){
        searchBar.sizeToFit()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Your Music"
        
    }
    
}

//MARK:- Extension
extension AlbumController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width / 2) - 20
        return CGSize(width: width, height: width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.data = data[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchItem = data[indexPath.item]
        let categoryDetail = AlbumDetailsViewController(with: searchItem)
        self.navigationController?.pushViewController(categoryDetail, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}


// MARK: - SearchBar methods

extension AlbumController: UISearchBarDelegate , UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetSearchBar()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        resetSearchBar()

        viewModel.search(with: searchTerm) { [weak self] response in
            guard let self = self else { return }
                switch response {
                case .success(let result):
                    self.update(result)

                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }

    private func update(_ data: [SearchItem]){
        DispatchQueue.main.async {
            self.data = data
            self.collectionView.reloadData()
        }
    }

    private func resetSearchBar(){
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}


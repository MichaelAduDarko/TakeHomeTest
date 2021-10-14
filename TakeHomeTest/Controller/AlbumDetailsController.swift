//
//  AlbumDetailsController.swift
//  TakeHomeTest
//
//  Created by MICHAEL ADU DARKO on 10/12/21.
//

import UIKit

class AlbumDetailsViewController: UIViewController {
    private let searchItem: SearchItem

    init(with searchItem: SearchItem) {
        self.searchItem = searchItem
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        ImageLoader.shared.cancel()
    }

    private let imageBg: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return view
    }()
    
    private let nameTitle : CustomLabel = {
        let label =  CustomLabel( name: Font.Futura, fontSize: 22 , color: .systemPink)
        label.text = "Artist"
        return label
    }()
    
    private let artistName = CustomLabel( name: Font.AvenirNext, fontSize: 15 , color: .white)
    
    private let songTitle : CustomLabel = {
        let label = CustomLabel( name: Font.Futura, fontSize: 22 , color: .systemPink)
        label.text = "Album"
        return label
    }()
    
    private let songName = CustomLabel( name: Font.AvenirNext, fontSize: 15 , color: .white)
    
    private let countryTitle : CustomLabel = {
        let label = CustomLabel( name: Font.Futura, fontSize: 22 , color: .systemPink)
        label.text = "Country"
        return label
    }()
    
    private let countryName = CustomLabel( name: Font.AvenirNext, fontSize: 15 , color: .white)
    
    private let yearTitle : CustomLabel = {
        let label = CustomLabel( name: Font.Futura, fontSize: 22 , color: .systemPink)
        label.text = "Year"
        return label
    }()
    
    private let albumYear = CustomLabel( name: Font.AvenirNext, fontSize: 15 , color: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()

        artistName.text = searchItem.artistName
        songName.text = searchItem.collectionCensoredName
        countryName.text = searchItem.country
        albumYear.text = searchItem.releaseDate.formatted(date: .abbreviated, time: .omitted)
        if let imageURL = searchItem.artworkUrl60 {
            ImageLoader.shared.loadImage(from: imageURL, into: imageBg)
        }
    }
    
    private func configureUI(){
        view.backgroundColor = .backgroundColor
        configureNavigationBar(withTitle: "Music", prefersLargeTitles: true)
        
        let stackView = UIStackView(arrangedSubviews: [imageBg, nameTitle, artistName,
                                                       songTitle, songName, countryTitle,
                                                       countryName, yearTitle, albumYear])
        stackView.spacing = 5
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor, right: view.rightAnchor,
                         paddingTop: 15, paddingLeft: 10,paddingRight: 10)
        
        
    }
    
    
}

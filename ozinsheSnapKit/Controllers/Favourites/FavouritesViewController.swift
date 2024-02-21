//
//  FavouritesViewController.swift
//  ozinsheSnapKit
//
//  Created by Nuradil Serik on 05.02.2024.
//

import UIKit
import SnapKit

class FavouritesViewController: UIViewController {

    lazy var tableView: UITableView = { // lazy var is the variable that is going to be created at time when this exact variable is going to be used
        let tv = UITableView()
        
        tv.dataSource = self
        tv.delegate = self
        
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupUI()
    }
    
    
    func setupUI(){
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: Extension for TableView

extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MovieTableViewCell()
        
        return cell
        
    }
    
    func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
}

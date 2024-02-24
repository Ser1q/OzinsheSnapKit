//
//  MovieTableViewCell.swift
//  ozinsheSnapKit
//
//  Created by Nuradil Serik on 09.02.2024.
//

import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {

    let posterImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(){
        contentView.addSubview(posterImageView)
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(104)
            make.width.equalTo(71)
            
        }
        
    }
    
}

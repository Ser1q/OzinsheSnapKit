//
//  SlidesCell.swift
//  ozinsheSnapKit
//
//  Created by Nuradil Serik on 13.02.2024.
//

import UIKit
import SnapKit

class SlidesCell: UICollectionViewCell {
    //MARK: - Public
    func configure(image: UIImage, titleText: String, descriptionText: String){
        imageView.image = image
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private properties
    
    private let imageView = {
        let image = UIImageView()
        return image
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "WelcomeText")
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "DescriptionText")
        
        
        let attribute = NSAttributedString(string:"\(label)").withLineSpacing(6)
        label.attributedText = attribute
        
        return label
    }()
    
    let skipButton = {
        
        var button = UIButton(type: .custom)
        
        button.setTitle("Өткізу", for: .normal)
        button.setTitleColor(UIColor(named: "WelcomeText"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(named: "SkipButton")
       
        return button
    }()
    
    let nextButton = {
        
        var button = UIButton(type: .custom)
        
        button.setTitle("Әрі қарай", for: .normal)
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        
        
        return button
    }()
}

//MARK: - Private extensions
private extension SlidesCell{
    func initialize(){
        
        contentView.backgroundColor = UIColor(named: "BGOnBoarding")
        
        //MARK: ImageView
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView)
            make.height.equalTo(504)
        }
        
        //MARK: titleLabel
        contentView.addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp_bottomMargin).inset(2)
            make.leading.trailing.equalToSuperview()
        }
        
        //MARK: descriptionLabel
        contentView.addSubview(descriptionLabel)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 4
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-24)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        //MARK: skipButton
        contentView.addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(24)
            make.width.greaterThanOrEqualTo(70)
        }
        
        //MARK: nextButton
        contentView.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(38)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
    }
}

private extension NSAttributedString {
    func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: string.count))
        return NSAttributedString(attributedString: attributedString)
    }
}

//
//  OnBoardingViewController.swift
//  ozinsheSnapKit
//
//  Created by Nuradil Serik on 13.02.2024.
//

import UIKit
import SnapKit

class OnBoardingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
    }
    
    
    func updatePageControlUI(currentPageIndex: Int) {
        
        (0..<pageControl.numberOfPages).forEach { (index) in
            let activePageIconImage = UIImage(named: "PageControlRectangle")
            let otherPageIconImage = UIImage(named: "PageControlDot")
            let pageIcon = index == currentPageIndex ? activePageIconImage : otherPageIconImage
            pageControl.setIndicatorImage(pageIcon, forPage: index)
        }
        
    }
    
    //MARK: - Private properties
    private var collectionView: UICollectionView!
    
    private var pageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor(named: "PageControl")
        pageControl.currentPageIndicatorTintColor = UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1)
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        
        pageControl.setIndicatorImage(UIImage(named: "PageControlRectangle"), forPage: pageControl.currentPage)
        
        
        return pageControl
    }()
    
    private var currentPage = 0 {
        didSet{
            updatePageControlUI(currentPageIndex: currentPage)
            pageControl.currentPage = currentPage
        }
    }
    
    private var slidesArray:[[String]] = [
        ["firstSlide", "ÖZINŞE-ге қош келдің!", "Фильмдер, телехикаялар, ситкомдар,\n анимациялық жобалар, телебағдарламалар\n мен реалити-шоулар, аниме және тағы\n басқалары"],
        ["secondSlide", "ÖZINŞE-ге қош келдің!", "Кез келген құрылғыдан қара\nСүйікті фильміңді  қосымша төлемсіз\n телефоннан, планшеттен, ноутбуктан қара"],
        ["thirdSlide", "ÖZINŞE-ге қош келдің!", "Тіркелу оңай. Қазір тіркел де қалаған\n фильміңе қол жеткіз"]
        ]
    
}

//MARK: - Private methods
private extension OnBoardingViewController{
    func initialize(){
        view.backgroundColor = .bgOnBoarding
        //MARK: - CollectionView
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        
        collectionView.isPagingEnabled = true
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.register(SlidesCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        
        //MARK: - PageControl
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(dynamicValue(for: 118))
            make.centerX.equalToSuperview()
            make.height.equalTo(6)
        }
    }
    
    @objc func goToSignIn(){
        let signInVC = SignInViewController()
        navigationController?.show(signInVC, sender: self)
    }
    
}


//MARK: - UICollectionViewDataSource
extension OnBoardingViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slidesArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SlidesCell
        
        cell.configure(
            image: UIImage(named: slidesArray[indexPath.row][0])!,
            titleText: slidesArray[indexPath.row][1],
            descriptionText: slidesArray[indexPath.row][2]
        )
        
        
        if indexPath.row == 2{
            cell.skipButton.isHidden = true
        }

        
        if indexPath.row != 2{
            cell.nextButton.isHidden = true
        }
        
        
        cell.skipButton.addTarget(self, action: #selector(goToSignIn), for: .touchUpInside)
        
        cell.nextButton.addTarget(self, action: #selector(goToSignIn), for: .touchUpInside)
        
        return cell
    }
}

extension OnBoardingViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

private extension OnBoardingViewController{
    func dynamicValue(for size: CGFloat) -> CGFloat {
        let screenSize = UIScreen.main.bounds.size
        let baseScreenSize = CGSize(width: 375, height: 812)
        let scaleFactor = min(screenSize.width, screenSize.height) / min(baseScreenSize.width, baseScreenSize.height)
        
        return size * scaleFactor
    }
}


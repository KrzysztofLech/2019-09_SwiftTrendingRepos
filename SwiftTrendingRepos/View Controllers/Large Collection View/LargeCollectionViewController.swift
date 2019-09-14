//
//  LargeCollectionViewController.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 14/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

final class LargeCollectionViewController: UICollectionViewController {
    
    private enum Constants {
        static let lineSpacing: CGFloat = 10
        static let padding: CGFloat = 10
    }

    var data: [GithubRepoViewModel] = []
    weak var delegate: TableListViewControllerDelegate?

    private let imageService: ImageServiceProtocol
    
    init(imageService: ImageServiceProtocol = ImageService()) {
        self.imageService = imageService
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellAndNibName: LargeCollectionViewCell.toString())
        
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.scrollDirection = .horizontal
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
    }
}

extension LargeCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeCollectionViewCell.toString(), for: indexPath) as? LargeCollectionViewCell else { return UICollectionViewCell() }
        let cellData = data[indexPath.item]
        cell.configure(withData: cellData)
        imageService.getImage(url: cellData.avatarUrl) { image in
            cell.setupAvatarImage(image)
        }
        return cell
    }
}

extension LargeCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectedRepo(atIndex: indexPath)
    }
}

extension LargeCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - Constants.padding * 4,
                      height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: Constants.padding, bottom: 0, right: Constants.padding)
    }
}

extension LargeCollectionViewController {
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else { return }
        scrollToNearestVisibleCollectionViewCell()
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollToNearestVisibleCollectionViewCell()
    }
    
    private func scrollToNearestVisibleCollectionViewCell() {
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        let visibleCenterPositionOfScrollView = Float(collectionView.contentOffset.x + (collectionView.bounds.size.width / 2))
        var closestCellIndex: IndexPath?
        var closestDistance: Float = .greatestFiniteMagnitude
        
        collectionView.visibleCells.forEach {
            let cellWidth = $0.bounds.size.width
            let cellCenter = Float($0.frame.origin.x + cellWidth / 2)
            
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = collectionView.indexPath(for: $0)
            }
        }
        
        guard let indexItem = closestCellIndex?.item else { return }
        collectionView.scrollToItem(at: IndexPath(item: indexItem, section: 0), at: .centeredHorizontally, animated: true)
    }
}

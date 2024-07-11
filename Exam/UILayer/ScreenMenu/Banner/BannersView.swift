import UIKit

final class BannersView: UIView {
    
    private let scrollView = UIScrollView()
    private var currentCenterItemIndex: Int = 0
    private var viewModel: BannersViewModel
    private var autoScrollTimer: Timer?
    
    private let leftItemView = UIImageView()
    private let centerItemView = UIImageView()
    private let rightItemView = UIImageView()
    
    init(items: [UIImage?]) {
        self.viewModel = BannersViewModel(items: items)
        super.init(frame: .zero)
        self.setup()
        startAutoScroll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(self.scrollView)
        self.scrollView.decelerationRate = .fast
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.delegate = self
        
        let imageViews = [self.leftItemView, self.centerItemView, self.rightItemView]
        imageViews.forEach(self.scrollView.addSubview)
        
        self.updateImages()
    }
    
    // Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scrollView.frame = self.bounds
        
        let horizontalItemOffsetFromSuperView: CGFloat = 16.0
        let spaceBetweenItems: CGFloat = 8.0
        let itemWidth = self.frame.width - horizontalItemOffsetFromSuperView * 2
        let itemHeight: CGFloat = self.scrollView.frame.height
        
        var startX: CGFloat = 0.0
        
        let imageViews = [self.leftItemView, self.centerItemView, self.rightItemView]
        imageViews.forEach { view in
            view.frame.origin = CGPoint(x: startX, y: 0.0)
            view.frame.size = CGSize(width: itemWidth, height: itemHeight)
            startX += itemWidth + spaceBetweenItems
        }
        
        let viewsCount: CGFloat = 3.0
        let contentWidth: CGFloat = itemWidth * viewsCount + spaceBetweenItems * (viewsCount - 1.0)
        self.scrollView.contentSize = CGSize(width: contentWidth, height: self.frame.height)
        
        let inset = (self.frame.width - itemWidth) / 2.0
        self.scrollView.contentInset = UIEdgeInsets(top: 0.0, left: inset, bottom: 0.0, right: inset)
        
        centerScrollViewContent()
    }
    
    private func centerScrollViewContent() {
        self.scrollView.contentOffset.x = (self.scrollView.contentSize.width - self.scrollView.frame.width) / 2
    }
    
    private func updateImages() {
        let itemCount = viewModel.items.count
        guard itemCount > 0 else { return }
        
        let leftIndex = (currentCenterItemIndex - 1 + itemCount) % itemCount
        let rightIndex = (currentCenterItemIndex + 1) % itemCount
        
        leftItemView.image = viewModel.items[leftIndex]
        centerItemView.image = viewModel.items[currentCenterItemIndex]
        rightItemView.image = viewModel.items[rightIndex]
        
        centerScrollViewContent()
    }
    
    private func scrollToNearestItem() {
        let itemWidth = self.frame.width - self.scrollView.contentInset.left * 2
        let targetX = self.scrollView.contentOffset.x + itemWidth + 8
        
        UIView.animate(withDuration: 0.3, animations: {
            self.scrollView.contentOffset.x = targetX
        }) { _ in
            self.updateImages()
        }
    }
    
    private func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    private func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
    
    @objc private func autoScroll() {
        currentCenterItemIndex = (currentCenterItemIndex + 1) % viewModel.items.count
        scrollToNearestItem()
    }
    
    func nextItem() {
        currentCenterItemIndex = (currentCenterItemIndex + 1) % viewModel.items.count
        scrollToNearestItem()
    }

    func prevItem() {
        currentCenterItemIndex = (currentCenterItemIndex - 1 + viewModel.items.count) % viewModel.items.count
        scrollToNearestItem()
    }
}

extension BannersView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopAutoScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            startAutoScroll()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
         let targetIndex: Int
        
        if velocity.x > 0 {
            targetIndex = (currentCenterItemIndex + 1) % viewModel.items.count
        } else if velocity.x < 0 {
            targetIndex = (currentCenterItemIndex - 1 + viewModel.items.count) % viewModel.items.count
        } else {
            targetIndex = currentCenterItemIndex
        }
        
        currentCenterItemIndex = targetIndex
        updateImages()
        
        targetContentOffset.pointee.x = scrollView.contentSize.width / 2 - scrollView.bounds.width / 2
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateImages()
        startAutoScroll()
    }
}

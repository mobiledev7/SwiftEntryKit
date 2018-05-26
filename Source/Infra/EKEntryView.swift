//
//  EKEntryView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/15/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import QuickLayout

class EKEntryView: EKStyleView {
    
    struct Content {
        var view: UIView
        var attributes: EKAttributes
    }
    
    // MARK: Props
    private var content: Content!
    private lazy var contentView: UIView = {
        return UIView()
    }()
    
    var attributes: EKAttributes {
        return content.attributes
    }
    
    private lazy var contentContainerView: EKStyleView = {
        let contentContainerView = EKStyleView()
        self.addSubview(contentContainerView)
        contentContainerView.layoutToSuperview(axis: .vertically)
        contentContainerView.layoutToSuperview(axis: .horizontally)
        contentContainerView.clipsToBounds = true
        return contentContainerView
    }()

    // MARK: Setup
    override func layoutSubviews() {
        super.layoutSubviews()
        applyFrameStyle()
    }
    
    func setup(newEntry content: Content) {
        
        self.content = content

        setupContentView()
        applyDropShadow()
        applyBackgroundToContentView()
        applyFrameStyle()
    }
    
    func transform(to view: UIView) {
        
        let previousView = content.view
        content.view = view
        view.layoutIfNeeded()
        
        let previousHeight = set(.height, of: frame.height, priority: .must)
        let nextHeight = set(.height, of: view.frame.height, priority: .defaultLow)

        SwiftEntryKit.layoutIfNeeded()
        
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .layoutSubviews], animations: {
            
            previousHeight.priority = .defaultLow
            nextHeight.priority = .must
            
            previousView.alpha = 0

            SwiftEntryKit.layoutIfNeeded()
            
        }, completion: { (finished) in
            
            view.alpha = 0
            
            previousView.removeFromSuperview()
            
            previousHeight.isActive = false
            nextHeight.isActive = false
            
            self.setupContentView()
            
            UIView.animate(withDuration: 0.25, animations: {
                view.alpha = 1
            }, completion: { finished in
                
            })
        })
    }
    
    private func setupContentView() {
        contentView.addSubview(content.view)
        content.view.layoutToSuperview(axis: .horizontally)
        content.view.layoutToSuperview(axis: .vertically)
        
        contentContainerView.addSubview(contentView)
        contentView.fillSuperview()
        contentView.layoutToSuperview(axis: .vertically)
        contentView.layoutToSuperview(axis: .horizontally)
    }
    
    // Apply round corners
    private func applyFrameStyle() {
        guard !appliedStyle else {
            return
        }
        contentContainerView.applyFrameStyle(roundCorners: attributes.roundCorners, border: attributes.border)
    }
    
    // Apply drop shadow
    private func applyDropShadow() {
        switch attributes.shadow {
        case .active(with: let value):
            applyDropShadow(withOffset: value.offset, opacity: value.opacity, radius: value.radius, color: value.color)
        case .none:
            removeDropShadow()
        }
    }

    var backgroundView: UIView!
    
    // Apply background
    private func applyBackgroundToContentView() {
        
        let attributes = content.attributes
        
        let backgroundView = EKBackgroundView()
        backgroundView.background = attributes.entryBackground
        
        switch attributes.positionConstraints.safeArea {
        case .empty(fillSafeArea: let fillSafeArea) where fillSafeArea:
            insertSubview(backgroundView, at: 0)
            backgroundView.layoutToSuperview(axis: .horizontally)
            
            var topInset: CGFloat = 0
            var bottomInset: CGFloat = 0
            switch attributes.position {
            case .top:
                topInset = -EKWindowProvider.safeAreaInsets.top
            case .bottom, .center:
                bottomInset = EKWindowProvider.safeAreaInsets.bottom
            }
            
            backgroundView.layoutToSuperview(.top, offset: topInset)
            backgroundView.layoutToSuperview(.bottom, offset: bottomInset)
            
            if attributes.position.isBottom {
                applyFrameStyle(roundCorners: attributes.roundCorners, border: attributes.border)
            }

        default:
            contentView.insertSubview(backgroundView, at: 0)
            backgroundView.fillSuperview()
        }
        
        self.backgroundView = backgroundView
    }
}

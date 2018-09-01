//
//  AttributesCreation.swift
//  SwiftEntryKitDemo
//
//  Created by Daniel Huri on 5/18/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftEntryKit

class AttributesCreation: QuickSpec {

    override func spec() {
        describe("attributes creation") {
            testDisplayDuration()
            testWindowLevel()
            testPosition()
            testDisplayPriority()
        }
    }
    
    private func testDisplayPriority() {
        describe("its display priority") {
            var attributes: EKAttributes!

            beforeEach {
                attributes = EKAttributes()
            }
            
            it("is initialized with max display priority") {
                attributes.displayManner.priority = .max
                expect(attributes.displayManner.priority).to(equal(.max))
                expect(attributes.displayManner.priority.rawValue).to(equal(EKAttributes.DisplayManner.Priority.maxRawValue))
            }
            
            it("is initialized with high display priority") {
                attributes.displayManner.priority = .high
                expect(attributes.displayManner.priority).to(equal(.high))
                expect(attributes.displayManner.priority.rawValue).to(equal(EKAttributes.DisplayManner.Priority.highRawValue))
            }
            
            it("is initialized with high display priority") {
                attributes.displayManner.priority = .normal
                expect(attributes.displayManner.priority).to(equal(.normal))
                expect(attributes.displayManner.priority.rawValue).to(equal(EKAttributes.DisplayManner.Priority.normalRawValue))
            }
            
            it("is initialized with low display priority") {
                attributes.displayManner.priority = .low
                expect(attributes.displayManner.priority).to(equal(.low))
                expect(attributes.displayManner.priority.rawValue).to(equal(EKAttributes.DisplayManner.Priority.lowRawValue))
            }
            
            it("is initialized with min display priority") {
                attributes.displayManner.priority = .min
                expect(attributes.displayManner.priority).to(equal(.min))
                expect(attributes.displayManner.priority.rawValue).to(equal(EKAttributes.DisplayManner.Priority.minRawValue))
            }
            
            it("is initialized with custom display priority") {
                let custom1 = EKAttributes.DisplayManner.override(priority: .init(999))
                attributes.displayManner.priority = custom1.priority
                expect(attributes.displayManner.priority).to(equal(custom1.priority))
                expect(attributes.displayManner.priority.rawValue).to(equal(999))
                
                let custom2 = EKAttributes.DisplayManner.override(priority: .init(1))
                attributes.displayManner.priority = custom2.priority
                expect(attributes.displayManner.priority).to(equal(custom2.priority))
                expect(attributes.displayManner.priority.rawValue).to(equal(1))
                
                expect(custom2.priority).to(beLessThan(custom1.priority))
            }
        }
    }
    
    private func testPosition() {
        describe("its position") {
            var attributes: EKAttributes!
            
            beforeEach {
                attributes = EKAttributes()
            }
            
            it("is initialized as a top entry") {
                attributes.position = .top
                expect(attributes.position).to(equal(.top))
                expect(attributes.position.isTop).to(beTrue())
            }
            
            it("is initialized as a center entry") {
                attributes.position = .center
                expect(attributes.position).to(equal(.center))
                expect(attributes.position.isCenter).to(beTrue())
            }
            
            it("is initialized as a bottom entry") {
                attributes.position = .bottom
                expect(attributes.position).to(equal(.bottom))
                expect(attributes.position.isBottom).to(beTrue())
            }
        }
    }
    
    private func testDisplayDuration() {
        describe("its display duration") {
            var attributes: EKAttributes!
            var duration: EKAttributes.DisplayDuration!
            
            beforeEach {
                attributes = EKAttributes()
            }
            
            it("displays for infinite time") {
                duration = .infinity
                attributes.displayDuration = duration
                
                expect(attributes.displayDuration).to(equal(duration))
                expect(attributes.validateDisplayDuration).to(beTrue())
                expect(attributes.isValid).to(beTrue())
            }
            
            it("displays for a constant time") {
                duration = 1
                attributes.displayDuration = duration
                
                expect(attributes.displayDuration).to(equal(duration))
                expect(attributes.validateDisplayDuration).to(beTrue())
                expect(attributes.isValid).to(beTrue())
            }
        }
    }
    
    private func testWindowLevel() {
        describe("its window level") {
            
            var attributes: EKAttributes!
            var windowLevel: EKAttributes.WindowLevel!
            
            beforeEach {
                attributes = EKAttributes()
            }
            
            it("is has a normal level") {
                windowLevel = .normal
                attributes.windowLevel = windowLevel
                
                expect(attributes.windowLevel.value).to(equal(UIWindowLevelNormal))
                expect(attributes.validateWindowLevel).to(beTrue())
                expect(attributes.isValid).to(beTrue())
            }
            
            it("is has a status bar level") {
                windowLevel = .statusBar
                attributes.windowLevel = windowLevel
                
                expect(attributes.windowLevel.value).to(equal(UIWindowLevelStatusBar))
                expect(attributes.validateWindowLevel).to(beTrue())
                expect(attributes.isValid).to(beTrue())
            }
            
            it("is has an alerts level") {
                windowLevel = .alerts
                attributes.windowLevel = windowLevel
                
                expect(attributes.windowLevel.value).to(equal(UIWindowLevelAlert))
                expect(attributes.validateWindowLevel).to(beTrue())
                expect(attributes.isValid).to(beTrue())
            }
            
            it("is has a custom level") {
                let level: UIWindowLevel = 1
                windowLevel = .custom(level: level)
                attributes.windowLevel = windowLevel
                
                expect(attributes.windowLevel.value).to(equal(level))
                expect(attributes.validateWindowLevel).to(beTrue())
                expect(attributes.isValid).to(beTrue())
            }
            
            it("is cannot have negative level") {
                let level: UIWindowLevel = -1
                windowLevel = .custom(level: level)
                attributes.windowLevel = windowLevel
                
                expect(attributes.windowLevel.value).to(equal(level))
                expect(attributes.validateWindowLevel).to(beFalse())
                expect(attributes.isValid).to(beFalse())
            }
        }
    }
}

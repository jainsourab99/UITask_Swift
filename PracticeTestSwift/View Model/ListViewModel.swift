//
//  ListViewModel.swift
//  PracticeTestSwift
//
//  Created by Sourabh Jain on 13/12/24.
//

import Foundation

struct ListViewModel {
    static let shared = ListViewModel()
    private init () {}
    
    var listItems: [ListModel] = [
        ListModel(image: "image1", title: "Streamline Your Day", subTitle: "Simplify tasks and stay organized effortlessly."),
        ListModel(image: "image2", title: "Shop Smart, Live Better", subTitle: "Connecting local sellers with savvy shoppers."),
        ListModel(image: "image3", title: "Astrology, Redefined", subTitle: "Personalized insights for your cosmic journey."),
        ListModel(image: "image4", title: "Track Every Penny", subTitle: "Stay in control of your expenses, every day."),
        ListModel(image: "image5", title: "Plan Smarter", subTitle: "Get more done with an intuitive to-do list."),
        
        ListModel(image: "image1", title: "Secure Banking, Simplified", subTitle: "Innovative solutions for seamless transactions."),
        ListModel(image: "image2", title: "Your Design, Our Focus", subTitle: "Elevating user experiences through research-driven design."),
        ListModel(image: "image3", title: "Learn, Grow, Achieve", subTitle: "Master coding with tailored study plans."),
        ListModel(image: "image4", title: "From Cards to Actions", subTitle: "Transform interactions with dynamic UI components."),
        ListModel(image: "image5", title: "Future-Ready Apps", subTitle: "Empowering businesses with cutting-edge solutions."),
    ]
    
    let sliderImages = ["image1", "image2", "image3", "image4", "image5"]
}

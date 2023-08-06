//
//  AppIcons.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 30.09.2022.
//


import UIKit

final class AppIcons {
    
    enum iconsEnum {
        case i_placeholder
        case i_back_arrow
        case i_launch_image
        case i_onboarding_first
        case i_onboarding_second
        case i_onboarding_button
        case i_s1
        case i_s2
        case i_s3
        case i_s4
        case i_s5
        case i_planet
        case i_universe
        case i_heart
        case i_heart_like
        case i_episodes
        case i_characters
        case i_locations
        case i_favorites
        case i_empty_face
        case i_episodes_selected
        case i_characters_selected
        case i_locations_selected
        case i_favorites_selected
        case i_magnifying_glass
        
    }
    
    static func getIcon(_ type: iconsEnum) -> UIImage {
        switch type {
        case .i_empty_face: return UIImage(named: "i_empty_face")!
        case .i_back_arrow: return UIImage(named: "i_back_arrow")!
        case .i_launch_image: return UIImage(named: "i_launch_image")!
        case .i_onboarding_first: return UIImage(named: "i_onboarding_first")!
        case .i_onboarding_second: return UIImage(named: "i_onboarding_second")!
        case .i_onboarding_button: return UIImage(named: "i_onboarding_button")!
        case .i_s1: return UIImage(named: "i_s1")!
        case .i_s2: return UIImage(named: "i_s2")!
        case .i_s3: return UIImage(named: "i_s3")!
        case .i_s4: return UIImage(named: "i_s4")!
        case .i_s5: return UIImage(named: "i_s5")!
        case .i_planet: return UIImage(named: "i_planet")!
        case .i_universe: return UIImage(named: "i_universe")!
        case .i_heart: return UIImage(named: "i_heart")!
        case .i_heart_like: return UIImage(named: "i_heart_like")!
        case .i_episodes: return UIImage(named: "i_episodes")!
        case .i_characters: return UIImage(named: "i_characters")!
        case .i_locations: return UIImage(named: "i_locations")!
        case .i_favorites: return UIImage(named: "i_favorites")!
        case .i_episodes_selected: return UIImage(named: "i_episodes_selected")!
        case .i_characters_selected: return UIImage(named: "i_characters_selected")!
        case .i_locations_selected: return UIImage(named: "i_locations_selected")!
        case .i_favorites_selected: return UIImage(named: "i_favorites_selected")!
        case .i_magnifying_glass: return UIImage(named: "i_magnifying_glass")!
        case .i_placeholder: return UIImage(named: "i_placeholder")!
        }
    }
}

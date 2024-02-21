//
//  URLs.swift
//  ozinsheSnapKit
//
//  Created by Nuradil Serik on 20.02.2024.
//

import Foundation

class URLs{
    
    static let BASE_URL = "http://api.ozinshe.com/core/V1/"
    
    static let SIGN_IN_URL = "http://api.ozinshe.com/auth/V1/signin"
    static let SIGN_UP_URL = "http://api.ozinshe.com/auth/V1/signup"
    
    static let FAVORITE_URL = BASE_URL + "favorite/"
    static let CATEGORIES_URL = BASE_URL + "categories"
    static let MOVIES_BY_CATEGORY_URL = BASE_URL + "movies/page"
    static let SEARCH_MOVIES_URL = BASE_URL + "movies/search"
}

//
//  ComicModel.swift
//  MarvelDemo
//
//  Created by iMac on 06/09/21.
//

import Foundation
import ObjectMapper


class ComicModel: Mappable {
    
    var attributionHTML: String?
    var attributionText: String?
    var code: Int?
    var copyright: String?
    var data: DataObj?
    var etag: String?
    var status: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        attributionHTML <- map["attributionHTML"]
        attributionText <- map["attributionText"]
        code <- map["code"]
        copyright <- map["copyright"]
        data <- map["data"]
        etag <- map["etag"]
        status <- map["status"]
    }
    
}

class DataObj: Mappable {
    
    var count: Int?
    var limit: Int?
    var offset: Int?
    var results: [Result]?
    var total: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        limit <- map["limit"]
        offset <- map["offset"]
        results <- map["results"]
        total <- map["total"]
    }
    
}

class Result: Mappable {
    
    var characters: Character?
    var collectedIssues: [AnyObject]?
    var collections: [AnyObject]?
    var creators: Creator?
    var dates: [DateObj]?
    var descriptionField: String?
    var diamondCode: String?
    var digitalId: Int?
    var ean: String?
    var events: Event?
    var format: String?
    var id: Int?
    var images: [Image]?
    var isbn: String?
    var issn: String?
    var issueNumber: Int?
    var modified: String?
    var pageCount: Int?
    var prices: [Price]?
    var resourceURI: String?
    var series: Series?
    var stories: Story?
    var textObjects: [TextObject]?
    var thumbnail: Thumbnail?
    var title: String?
    var upc: String?
    var urls: [Url]?
    var variantDescription: String?
    var variants: [AnyObject]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        characters <- map["characters"]
        collectedIssues <- map["collectedIssues"]
        collections <- map["collections"]
        creators <- map["creators"]
        dates <- map["dates"]
        descriptionField <- map["description"]
        diamondCode <- map["diamondCode"]
        digitalId <- map["digitalId"]
        ean <- map["ean"]
        events <- map["events"]
        format <- map["format"]
        id <- map["id"]
        images <- map["images"]
        isbn <- map["isbn"]
        issn <- map["issn"]
        issueNumber <- map["issueNumber"]
        modified <- map["modified"]
        pageCount <- map["pageCount"]
        prices <- map["prices"]
        resourceURI <- map["resourceURI"]
        series <- map["series"]
        stories <- map["stories"]
        textObjects <- map["textObjects"]
        thumbnail <- map["thumbnail"]
        title <- map["title"]
        upc <- map["upc"]
        urls <- map["urls"]
        variantDescription <- map["variantDescription"]
        variants <- map["variants"]
    }
    
}


class Url: Mappable {
    
    var type: String?
    var url: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        url <- map["url"]
    }
    
}


class Thumbnail: Mappable {
    
    var strExtension: String?
    var path: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        strExtension <- map["extension"]
        path <- map["path"]
    }
    
    func getThumbnail() -> String {
        
        let imageString = (self.path ?? "") + "." + (self.strExtension ?? "")
        return imageString
    }
    
}


class TextObject: Mappable {
    
    var language: String?
    var text: String?
    var type: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        language <- map["language"]
        text <- map["text"]
        type <- map["type"]
    }
    
}

class Story: Mappable {
    
    var available: Int?
    var collectionURI: String?
    var items: [Item]?
    var returned: Int?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        available <- map["available"]
        collectionURI <- map["collectionURI"]
        items <- map["items"]
        returned <- map["returned"]
    }
    
}


class Item: Mappable {
    
    var name: String?
    var resourceURI: String?
    var type: String?
    var role: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        resourceURI <- map["resourceURI"]
        type <- map["type"]
        role <- map["role"]
    }
    
}

class Series: Mappable {
    
    var name: String?
    var resourceURI: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        resourceURI <- map["resourceURI"]
    }
    
}

class Price: Mappable {
    
    var price: Float?
    var type: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        price <- map["price"]
        type <- map["type"]
    }
    
}

class Image: Mappable {
    
    var strExtension: String?
    var path: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        strExtension <- map["extension"]
        path <- map["path"]
    }
    
}


class Event: Mappable {
    
    var available: Int?
    var collectionURI: String?
    var items: [AnyObject]?
    var returned: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        available <- map["available"]
        collectionURI <- map["collectionURI"]
        items <- map["items"]
        returned <- map["returned"]
    }
    
}

class DateObj: Mappable {
    
    var date: String?
    var type: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        date <- map["date"]
        type <- map["type"]
    }
    
}

class Creator: Mappable {
    
    var available: Int?
    var collectionURI: String?
    var items: [Item]?
    var returned: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        available <- map["available"]
        collectionURI <- map["collectionURI"]
        items <- map["items"]
        returned <- map["returned"]
    }
    
}

class Character: Mappable {
    
    var available: Int?
    var collectionURI: String?
    var items: [AnyObject]?
    var returned: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        available <- map["available"]
        collectionURI <- map["collectionURI"]
        items <- map["items"]
        returned <- map["returned"]
    }
    
}

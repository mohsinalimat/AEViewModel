//
//  MappableDataSource.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/9/17.
//  Copyright © 2017 AE. All rights reserved.
//

import AEViewModel
import Mappable

typealias MappableTable = MappableDataSource

struct MappableDataSource: DataSource, Mappable {
    
    // MARK: Types
    
    enum Key: String {
        case title
        case sections
    }
    
    // MARK: Table
    
    var title: String
    var sections: [Section]
    
    // MARK: Mappable
    
    init(map: [String : Any]) throws {
        title = try map.value(forKey: Key.title.rawValue)
        sections = try map.mappableArray(forKey: Key.sections.rawValue) as [MappableSection]
    }
    
}

struct MappableSection: Section, Mappable {
    
    // MARK: Types
    
    enum Key: String {
        case header
        case footer
        case items
    }
    
    // MARK: Section
    
    var header: String?
    var footer: String?
    var items: [Item]
    
    // MARK: Mappable
    
    init(map: [String : Any]) throws {
        header = try? map.value(forKey: Key.header.rawValue)
        footer = try? map.value(forKey: Key.footer.rawValue)
        items = try map.mappableArray(forKey: Key.items.rawValue) as [MappableItem]
    }
    
}

struct MappableItem: Item, Mappable {
    
    // MARK: Types
    
    enum Key: String {
        case id
        case data
    }
    
    // MARK: Item
    
    let identifier: String
    var data: ItemData?
    
    // MARK: Mappable
    
    init(map: [String : Any]) throws {
        identifier = try map.value(forKey: Key.id.rawValue)
        data = try? map.mappable(forKey: Key.data.rawValue) as MappableItemData
    }
    
}

struct MappableItemData: ItemData, Mappable {
    
    // MARK: Types
    
    enum Key: String {
        case title
        case detail
        case image
        case table
        case custom
    }
    
    // MARK: Model
    
    let title: String?
    let detail: String?
    let image: String?
    let submodel: ViewModel?
    let custom: [String : Any]?
    
    // MARK: Mappable
    
    init(map: [String : Any]) throws {
        title = try? map.value(forKey: Key.title.rawValue)
        detail = try? map.value(forKey: Key.detail.rawValue)
        image = try? map.value(forKey: Key.image.rawValue)
        submodel = try? map.mappable(forKey: Key.table.rawValue) as MappableDataSource
        custom = try? map.value(forKey: Key.custom.rawValue)
    }
    
}

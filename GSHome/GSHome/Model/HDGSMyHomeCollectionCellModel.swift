//
//  HDGSMyHomeCollectionCellModel.swift
//  GSHome
//
//  Created by lzh on 2021/5/13.
//

struct HDGSMyHomeCollectionCellModel {
    enum Badge {
        // 特价
        case specialOffer
        // 收费
        case charge
        // 限免
        case limitedFree
    }
    
    //  图片链接字符串
    var imageURL: String
    // 标题
    var title: String
    // 集数
    var episode: String
    // 详细描述
    var description: String?
    // 徽标
    var badge: Badge?
    
    var badgeImageName: String? {
        guard let badge = badge else { return nil }
        switch badge {
        case .specialOffer:
            return "common_price_special_new"
        case .charge:
            return "common_price_original_new"
        case .limitedFree:
            return "common_price_limitfree_new"
        }
    }
    
}

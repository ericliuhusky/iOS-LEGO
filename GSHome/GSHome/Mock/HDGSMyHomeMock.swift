//
//  HDGSMyHomeMock.swift
//  GSHome
//
//  Created by lzh on 2021/5/13.
//

import Foundation

class HDGSMyHomeMock {
    private var data = [[HDGSMyHomeCollectionCellModel]]()
    
    func refersh() -> [[HDGSMyHomeCollectionCellModel]] {
        data = [
            [
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "发明家奇奇", episode: "1集", badge: .specialOffer),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "我是兔--", episode: "1集", badge: .charge),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "闹闹别闹", episode: "1集"),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "安全警长多不拉多", episode: "1集", badge: .limitedFree),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "美人鱼公主梦幻奇缘", episode: "1集"),
                
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "发明家奇奇", episode: "1集", description: "小老鼠皮皮的成长故事", badge: .specialOffer),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "我是兔--", episode: "1集", description: "小老鼠皮皮的成长故事", badge: .charge),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "闹闹别闹", episode: "2集", description: "小老鼠皮皮的成长故事"),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "安全警长多不拉多", episode: "2集", description: "小老鼠皮皮的成长故事", badge: .limitedFree),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "美人鱼公主梦幻奇缘", episode: "2集", description: "小老鼠皮皮的成长故事"),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "发明家奇奇", episode: "2集", description: "小老鼠皮皮的成长故事", badge: .specialOffer),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "我是兔--", episode: "2集", description: "小老鼠皮皮的成长故事", badge: .charge)
            ],

            [
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "闹闹别闹", episode: "2集", description: "小老鼠皮皮的成长故事"),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "安全警长多不拉多", episode: "2集", description: "小老鼠皮皮的成长故事", badge: .limitedFree),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "美人鱼公主梦幻奇缘", episode: "2集", description: "小老鼠皮皮的成长故事"),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "发明家奇奇", episode: "2集", description: "小老鼠皮皮的成长故事", badge: .specialOffer),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "我是兔--", episode: "2集", description: "小老鼠皮皮的成长故事", badge: .charge),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "闹闹别闹", episode: "2集", description: "小老鼠皮皮的成长故事")
            ],
            [
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "安全警长多不拉多", episode: "2集", description: "小老鼠皮皮的成长故事", badge: .limitedFree),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "美人鱼公主梦幻奇缘", episode: "2集", description: "小老鼠皮皮的成长故事"),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "发明家奇奇", episode: "2集", description: "小老鼠皮皮的成长故事", badge: .specialOffer),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "我是兔--", episode: "2集", description: "小老鼠皮皮的成长故事", badge: .charge),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "闹闹别闹", episode: "2集", description: "小老鼠皮皮的成长故事"),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "安全警长多不拉多", episode: "2集", description: "小老鼠皮皮的成长故事", badge: .limitedFree),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "美人鱼公主梦幻奇缘", episode: "2集", description: "小老鼠皮皮的成长故事")
            ]
        ]
        return data
    }
    
    func loadMore() -> [[HDGSMyHomeCollectionCellModel]] {
        data += [
            [
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "新数据\(data.count)", episode: "2集", badge: .specialOffer),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "我是兔--", episode: "2集", badge: .charge),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "闹闹别闹", episode: "2集"),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "安全警长多不拉多", episode: "2集", badge: .limitedFree),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "美人鱼公主梦幻奇缘", episode: "2集"),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "新数据\(data.count)", episode: "2集", badge: .specialOffer),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "我是兔--", episode: "2集", badge: .charge),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "闹闹别闹", episode: "2集"),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "安全警长多不拉多", episode: "2集", badge: .limitedFree),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "美人鱼公主梦幻奇缘", episode: "2集")
            ],
            [
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "新数据\(data.count)", episode: "2集", badge: .specialOffer),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "我是兔--", episode: "2集", badge: .charge),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "闹闹别闹", episode: "2集"),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "安全警长多不拉多", episode: "2集", badge: .limitedFree),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "美人鱼公主梦幻奇缘", episode: "2集"),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "新数据\(data.count)", episode: "2集", badge: .specialOffer),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "我是兔--", episode: "2集", badge: .charge),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "闹闹别闹", episode: "2集"),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "安全警长多不拉多", episode: "2集", badge: .limitedFree),
                HDGSMyHomeCollectionCellModel(imageURL: "https://httpbin.org/image/png", title: "美人鱼公主梦幻奇缘", episode: "2集")
                
            ]
        ]
        return data
    }
}

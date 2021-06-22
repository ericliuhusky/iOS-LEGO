let SECOND: UInt64 = 1_000_000_000

// 异步函数定义
@available(macOS 999, *)
func hello(_ number: Int) async -> Int {
    await Task.sleep(SECOND)
    print("Hello Concurrency! \(number)")
    
    return number
}

// MARK: - 串行
@available(macOS 999, *)
func serial() async {
    print("串行", [String].init(repeating: "-", count: 100).joined(separator: ""))
    
    
    let n0 = await hello(0)
    let n1 = await hello(1)
    let n2 = await hello(2)
    
    print(n0 + n1 + n2)
    
    
    await withTaskGroup(of: Int.self) { group0 in
        
        group0.async {
            let n0 = await hello(0)
            await withTaskGroup(of: Int.self) { group1 in
                
                group1.async {
                    let n1 = await hello(1)
                    await withTaskGroup(of: Int.self) { group2 in
                        
                        group2.async {
                            let n2 = await hello(2)
                            return n2
                        }
                    }
                    return n1
                }
            }
            return n0
        }
    }
}

// MARK: - 并行
@available(macOS 999, *)
func parallel() async {
    print("并行", [String].init(repeating: "-", count: 100).joined(separator: ""))
    
    
    async let n3 = hello(3)
    async let n4 = hello(4)
    async let n5 = hello(5)
    
    print(await (n3 + n4 + n5))
    

    await withTaskGroup(of: Int.self) { group in
        group.async {
            let n = await hello(3)
            return n
        }
        group.async {
            let n = await hello(4)
            return n
        }
        group.async {
            let n = await hello(5)
            return n
        }
        
        print(await (group.next()! + group.next()! + group.next()!))
    }
    
    
    // 循环并行
    await withTaskGroup(of: Int.self) { group in
        for i in 0..<10 {
            group.async {
                let n = await hello(i)
                return n
            }
        }
        
        var sum = 0
        
        // 异步序列
        for await result in group {
            sum += result
        }
        
        print(sum)
    }
}

// MARK: - 群组
@available(macOS 999, *)
func group() async {
    print("群组", [String].init(repeating: "-", count: 100).joined(separator: ""))
    
    
    // 保证群组内的相对顺序，不保证群组间的顺序
    async let g0: Int = {
        let n0 = await hello(0)
        let n1 = await hello(1)
        let n2 = await hello(2)
        return n0 + n1 + n2
    }()
    
    async let g1: Int = {
        let n3 = await hello(3)
        let n4 = await hello(4)
        let n5 = await hello(5)
        return n3 + n4 + n5
    }()
    
    async let g2: Int = {
        let n6 = await hello(6)
        let n7 = await hello(7)
        let n8 = await hello(8)
        return n6 + n7 + n8
    }()
    
    print(await (g0 + g1 + g2))
    
    
    await withTaskGroup(of: Int.self) { group in
        group.async {
            let n0 = await hello(0)
            let n1 = await hello(1)
            let n2 = await hello(2)
            return n0 + n1 + n2
        }
        group.async {
            let n3 = await hello(3)
            let n4 = await hello(4)
            let n5 = await hello(5)
            return n3 + n4 + n5
        }
        group.async {
            let n6 = await hello(6)
            let n7 = await hello(7)
            let n8 = await hello(8)
            return n6 + n7 + n8
        }
        
        print(await (group.next()! + group.next()! + group.next()!))
    }
}

// MARK: - 数据竞争

var data = 0

// 参与者也是引用类型
actor SafeData {
    private(set) var data = 0
    
    func add(_ number: Int) {
        // 将可能引起数据竞争的逻辑放到参与者中
        
        self.data += number
    }
}

// 参与者不能放到async函数中初始化
let safeData = SafeData()

@available(macOS 999, *)
func dataRace() async {
    print("数据竞争", [String].init(repeating: "-", count: 100).joined(separator: ""))
    
    
    await withTaskGroup(of: Void.self) { group in
        for _ in 0..<10000 {
            group.async {
                data += 1
            }
        }
    }
    
    print(data)
    
    
    await withTaskGroup(of: Void.self) { group in
        for _ in 0..<10000 {
            group.async {
                await safeData.add(1)
            }
        }
    }
    
    print(await safeData.data)
}


@main
@available(macOS 999, *)
public struct Concurrency {
    static func main() async {
        
        
        await serial()

        await parallel()

        await group()

        await dataRace()

        
    }
}


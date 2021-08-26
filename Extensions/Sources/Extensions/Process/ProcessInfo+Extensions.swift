//
//  ProcessInfo+Extensions.swift
//  
//
//  Created by lzh on 2021/8/26.
//

import Foundation

/* 手动定义未能被Swift自动引入的过于复杂的C宏定义
 https://github.com/apple/darwin-xnu/blob/main/osfmk/mach/task_info.h
 #define TASK_VM_INFO_COUNT      ((mach_msg_type_number_t) \
             (sizeof (task_vm_info_data_t) / sizeof (natural_t)))
 #define MACH_TASK_BASIC_INFO_COUNT   \
             (sizeof(mach_task_basic_info_data_t) / sizeof(natural_t))
 https://github.com/apple/darwin-xnu/blob/main/osfmk/mach/thread_info.h
 #define THREAD_BASIC_INFO_COUNT   ((mach_msg_type_number_t) \
             (sizeof(thread_basic_info_data_t) / sizeof(natural_t)))
 */
fileprivate let TASK_VM_INFO_COUNT = mach_msg_type_number_t(MemoryLayout<task_vm_info_data_t>.size / MemoryLayout<natural_t>.size)
fileprivate let MACH_TASK_BASIC_INFO_COUNT = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info_data_t>.size / MemoryLayout<natural_t>.size)
fileprivate let THREAD_BASIC_INFO_COUNT = mach_msg_type_number_t(MemoryLayout<thread_basic_info_data_t>.size / MemoryLayout<natural_t>.size)


public extension ProcessInfo {
    /// 内存占用（单位字节byte）
    var memoryFootPrint: Int? {
        /* 内存占用实现参考
         https://github.com/WebKit/WebKit-http/blob/master/Source/WTF/wtf/cocoa/MemoryFootprintCocoa.cpp
         */
        var info = task_vm_info_data_t()
        var count = TASK_VM_INFO_COUNT
        
        let result = withUnsafeMutablePointer(to: &info) { infoPtr in
            infoPtr.withMemoryRebound(to: integer_t.self, capacity: Int(count)) { intPtr in
                task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), intPtr, &count)
            }
        }
        
        guard result == KERN_SUCCESS else { return nil }
        return Int(info.phys_footprint)
    }
    
    /// 常驻内存（单位字节byte）
    var memoryResident: Int? {
        var info = mach_task_basic_info_data_t()
        var count = MACH_TASK_BASIC_INFO_COUNT
        
        let result = withUnsafeMutablePointer(to: &info) { infoPtr in
            infoPtr.withMemoryRebound(to: integer_t.self, capacity: Int(count)) { intPtr in
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), intPtr, &count)
            }
        }
        
        guard result == KERN_SUCCESS else { return nil }
        return Int(info.resident_size)
    }
    
    /// CPU使用比例(0.0 ~ 1.0)
    var cpuUsageFraction: Double? {
        var threadArray: thread_act_array_t? = nil
        var threadCount = mach_msg_type_number_t(0)
        
        let threadResult = task_threads(mach_task_self_, &threadArray, &threadCount)

        guard threadResult == KERN_SUCCESS, let threadArray = threadArray else { return nil }
        
        defer {
            // 释放
            vm_deallocate(mach_task_self_, vm_address_t(bitPattern: threadArray), vm_size_t(MemoryLayout<thread_t>.size * Int(threadCount)))
        }
        
        var totalUsage: Int32 = 0
        
        for i in 0..<Int(threadCount) {
            var threadInfo = thread_basic_info_data_t()
            var threadInfoCount = THREAD_BASIC_INFO_COUNT
            
            let result = withUnsafeMutablePointer(to: &threadInfo) { infoPtr in
                infoPtr.withMemoryRebound(to: integer_t.self, capacity: Int(threadInfoCount)) { intPtr in
                    thread_info(threadArray[i], thread_flavor_t(THREAD_BASIC_INFO), intPtr, &threadInfoCount)
                }
            }
            
            guard result == KERN_SUCCESS else { return nil }
            
            if threadInfo.flags & TH_FLAGS_IDLE == 0 {
                totalUsage += threadInfo.cpu_usage
            }
        }

        return Double(totalUsage) / Double(TH_USAGE_SCALE)
    }
    
}

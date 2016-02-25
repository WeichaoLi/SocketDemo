//
//  Socket.swift
//  SocketDemo
//
//  Created by 李伟超 on 16/2/25.
//  Copyright © 2016年 LWC. All rights reserved.
//

import Foundation

@asmname("ytcpsocket_connect") func c_ytcpsocket_connect(host:UnsafePointer<Int8>,port:Int32,timeout:Int32) -> Int32
@asmname("test") func c_test(str: String)

class Socket: NSObject {
//    let a = socket
    class func description1() {
        c_test("134u5u4i54ifdsjfkdsj")
    }
}

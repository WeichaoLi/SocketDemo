//
//  Socket.swift
//  SocketDemo
//
//  Created by 李伟超 on 16/2/25.
//  Copyright © 2016年 LWC. All rights reserved.
//

import Foundation

//@asmname("ytcpsocket_connect") func c_ytcpsocket_connect(host:UnsafePointer<Int8>,port:Int32,timeout:Int32) -> Int32
//@asmname("test") func c_test(str: String)

enum AsyncUdpSocketFlags: Int {
    case kDidBind                    // If set, bind has been called.
    case kDidConnect                 // If set, connect has been called.
    case kSock4CanAcceptBytes        // If set, we know socket4 can accept bytes. If unset, it's unknown.
    case kSock6CanAcceptBytes        // If set, we know socket6 can accept bytes. If unset, it's unknown.
    case kSock4HasBytesAvailable     // If set, we know socket4 has bytes available. If unset, it's unknown.
    case kSock6HasBytesAvailable     // If set, we know socket6 has bytes available. If unset, it's unknown.
    case kForbidSendReceive          // If set, no new send or receive operations are allowed to be queued.
    case kCloseAfterSends            // If set, close as soon as no more sends are queued.
    case kCloseAfterReceives         // If set, close as soon as no more receives are queued.
    case kDidClose                   // If set, the socket has been closed, and should not be used anymore.
    case kDequeueSendScheduled       // If set, a maybeDequeueSend operation is already scheduled.
    case kDequeueReceiveScheduled    // If set, a maybeDequeueReceive operation is already scheduled.
    case kFlipFlop                   // Used to alternate between IPv4 and IPv6 sockets.
}

class AsyncSendPacket {
    var buffer: NSData!
    var address: NSData!
    var timeout: NSTimeInterval
    var tag: Int
    
    init(data: NSData, address: NSData, timeout: NSTimeInterval, tag: Int) {
        self.buffer = data
        self.address = address
        self.timeout = timeout
        self.tag = tag
    }
    
    deinit {
        buffer = nil
        address = nil
    }
}


class AsyncReceivePacket: NSObject {
    var timeout: NSTimeInterval
    var tag: Int
    var buffer: NSMutableData!
    var host: NSString!
    var port: UInt16!
    
    init(timeout: NSTimeInterval, tag: Int) {
        self.timeout = timeout
        self.tag = tag
    }
    
    deinit {
        buffer = nil
        host = nil
    }
}

class AsyncUdpSocket: NSObject {
    var theSocket4: CFSocketRef!
    var theSocket6: CFSocketRef!
    
    var theSource4: CFRunLoopSourceRef!
    var theSource6: CFRunLoopSourceRef!
    var theRunLoop: CFRunLoopRef!
    var theContext: CFSocketContext!
    
    var theSendQueue: NSMutableArray!
    var theCurrentSend: AsyncSendPacket!
    var theSendTimer: NSTimer!
    
    var theReceiveQueue: NSMutableArray!
    var theCurrentReceive: AsyncReceivePacket!
    var theReceiveTimer: NSTimer!
    
    var theDelegate: AnyObject!
    var theFlags: UInt16!
    
    var theUserData: Int!
    
    var cachedLocalHost: NSString!
    var cachedLocalPort: UInt16!
    
    var cachedConnectedHost: NSString!
    var cachedConnectedPort: UInt16!
    
    var maxReceiveBufferSize: UInt32!
    
    //
    let DEFAULT_MAX_RECEIVE_BUFFER_SIZE: UInt32 = 9216
    let SENDQUEUE_CAPACITY: Int = 5
    let RECEIVEQUEUE_CAPACITY: Int = 5
    
    init(delegate: AnyObject, userData: Int, enableIPv4: Bool, enableIPv6: Bool) {
        theDelegate = delegate
        theFlags = 0
        theUserData = userData
        maxReceiveBufferSize = DEFAULT_MAX_RECEIVE_BUFFER_SIZE
        
        theSendQueue = NSMutableArray(capacity: SENDQUEUE_CAPACITY)
        theCurrentSend = nil
        theSendTimer = nil
        
        theReceiveQueue = NSMutableArray(capacity: RECEIVEQUEUE_CAPACITY)
        theCurrentReceive = nil
        theSendTimer = nil
        
        theContext.version = 0
//        theContext.info = self
        theContext.retain = nil
        theContext.release = nil
        theContext.copyDescription = nil
        
        theSocket4 = nil
        theSocket6 = nil
        
        /*
        public func CFSocketCreate(allocator: CFAllocator!,
        _ protocolFamily: Int32,
        _ socketType: Int32,
        _ `protocol`: Int32,
        _ callBackTypes: CFOptionFlags,
        _ callout: CFSocketCallBack!,
        _ context: UnsafePointer<CFSocketContext>) -> CFSocket!
        */
        
        if enableIPv4 {
            theSocket4 = CFSocketCreate(
                kCFAllocatorDefault,
                PF_INET,
                SOCK_DGRAM,
                IPPROTO_UDP,
//                [CFSocketCallBackType.ReadCallBack.rawValue, CFSocketCallBackType.WriteCallBack.rawValue],
                kCFSocketAutomaticallyReenableReadCallBack | kCFSocketAutomaticallyReenableWriteCallBack,
                myCFSocketCallback,
                &theContext!)
        }
    }
    
    func doCFSocketCallback(CallBacktype type: CFSocketCallBackType, socket: CFSocketRef, address: NSData, data: UnsafePointer<Void>) {
        
    }
}

func myCFSocketCallback(_cfsocket: CFSocket!, _callBackType: CFSocketCallBackType, address: CFData!, data: UnsafePointer<Void>, info: UnsafeMutablePointer<Void>) -> Void {
    let theSocket: AsyncUdpSocket = UnsafeMutablePointer<AsyncUdpSocket>(info).memory
//    var theSocket: AsyncUdpSocket! = withUnsafeMutablePointer(&info) { (ptr:UnsafeMutablePointer<AsyncUdpSocket>) -> AsyncUdpSocket in
//        return ptr.memory
//    }
    theSocket.doCFSocketCallback(CallBacktype: _callBackType, socket: _cfsocket, address: address, data: data)
}

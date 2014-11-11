//
//  NSURL+NsLookUp.m
//  Utils
//
//  Created by Mykola Denysyuk on 11/11/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import "NSURL+NsLookUp.h"
#import <netdb.h>
#import <arpa/inet.h>

@implementation NSURL (NsLookUp)

- (NSString*)lookupHostIPAddressForURL:(NSURL*)url
{
    // Ask the unix subsytem to query the DNS
    struct hostent *remoteHostEnt = gethostbyname([[url host] UTF8String]);
    // Get address info from host entry
    struct in_addr *remoteInAddr = (struct in_addr *) remoteHostEnt->h_addr_list[0];
    // Convert numeric addr to ASCII string
    char *sRemoteInAddr = inet_ntoa(*remoteInAddr);
    // hostIP
    NSString* hostIP = [NSString stringWithUTF8String:sRemoteInAddr];
    return hostIP;
}

@end

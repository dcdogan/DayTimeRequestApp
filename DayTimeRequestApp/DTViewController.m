//
//  DTViewController.m
//  DayTimeRequestApp
//
//  Created by DoganCan on 9/27/13.
//  Copyright (c) 2013 Dogan Can Dogan. All rights reserved.
//

#import "DTViewController.h"
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <netdb.h>

@interface DTViewController ()

@end

@implementation DTViewController{
    
    int s, n;
    struct sockaddr_in sin;
    struct hostent *hptr;
    char msg[80];


}
@synthesize hostNameLabel = _hostNameLabel;
@synthesize displayTheTimeResponse = _displayTheTimeResponse;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sendTimeRequest:(id)sender {
    
    
    // create a socket
    if ( (s = socket(AF_INET, SOCK_STREAM, 0 ) ) < 0) {
        perror("socket");
        NSLog(@"Socket Error !!!");
    }
    
    // set protocol family to Internet
    sin.sin_family = AF_INET;
    
    // set port no
    sin.sin_port = htons(atoi("143"));
    
    // set host name
    if ( (hptr =  gethostbyname([_hostNameLabel.text UTF8String]) ) == NULL){
        NSLog(@"hostname error");
        [_displayTheTimeResponse setText:@"there is a problem in the server connection "];
    }else{
    memcpy( &sin.sin_addr, hptr->h_addr, hptr->h_length);
    

    // connect to the target host
    if (connect (s, (struct sockaddr *)&sin, sizeof(sin) ) < 0 ){
        perror("connect");
    }
    
    if ( ( n = recv(s, msg, sizeof(msg),0 ) ) <0) {
        perror("read");
    }
    // print message to screen
    NSLog(@"%d bytes: %s\n", n, msg);
    [_displayTheTimeResponse   setText: [NSString stringWithFormat:@"%d bytes: %s\n", n, msg]];
        
    // close connection, clean up socket
    if (close(s) < 0) {
        perror("close");
    }
    _displayTheTimeResponse.text = [_displayTheTimeResponse.text stringByAppendingString:@"Connection closed." ];
    }
}

- (IBAction)dismissKeyboardOnReturn:(id)sender {
    // dismiss keyboard when return
}
@end

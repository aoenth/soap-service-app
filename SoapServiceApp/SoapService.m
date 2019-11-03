//
//  SoapService.m
//  SoapService
//
//  Created by Kevin Peng on 2019-11-03.
//  Copyright © 2019 Kevin Peng. All rights reserved.
//

#import "SoapService.h"
@interface SoapService()

@property (strong, nonatomic) NSURLConnection *sessionconnection;
@property (nonatomic) NSMutableData *webResponseData;

@end

@implementation SoapService

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self callSoapWebservice];
    }
    return self;
}


#pragma mark SOAP Webservice Method

- (void) callSoapWebservice
{
    
    // Copy the REQUEST_XML here as follows:
    NSString *soapMessage = [NSString stringWithFormat:@
                             "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                             "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/"
                             " xmlns:tem=\"http://tempuri.org/\">"
                             "   <soapenv:Header/>"
                             "   <soapenv:Body>"
                             "      <tem:Add>"
                             "         <tem:intA>99999</tem:intA>"
                             "         <tem:intB>100001</tem:intB>"
                             "      </tem:Add>"
                             "   </soapenv:Body>"
                             "</soapenv:Envelope>"
    ];
    
    //Now create a request to the URL
    
    NSURL *url = [NSURL URLWithString:@"http://www.dneonline.com/calculator.asmx"]; // Copy here the URL
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    
    //add required headers to the request
    
    [theRequest addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://tempuri.org/Add" forHTTPHeaderField:@"SOAPAction"]; // copy here the SOAP_ACTION
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    
    [theRequest setHTTPMethod:@"POST"];
    
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    //initiate the request
    self.sessionconnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    
    if(self.sessionconnection)
    {
        self.webResponseData = [NSMutableData data] ;
    }
    else
    {
        NSLog(@"Connection is NULL");
    }
}

//Implement the connection delegate methods.
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.webResponseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.webResponseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Some error in your Connection. Please try again.");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    if(connection == self.sessionconnection)
    {
        NSString *theXML = [[NSString alloc] initWithBytes:
                            [self.webResponseData mutableBytes] length:[self.webResponseData length] encoding:NSUTF8StringEncoding];
        
        NSLog(@"my data is %@", theXML);
        
        //now parse the xml
        
    }
}
@end

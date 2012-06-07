//
//  AsyncImageDownloader.m
//
//  Created by Takuma Shimizu (hokuron) on 12/06/06.
//  Copyright (c) 2012年 co-tree. All rights reserved.
//

#import "AsyncImageDownloader.h"

@interface AsyncImageDownloader()

@property (strong, nonatomic) NSURLConnection *connection;

@end

@implementation AsyncImageDownloader

@synthesize connection = _connection;

@synthesize delegate = _delegate;
@synthesize imageURL = _imageURL;
@synthesize indexPath = _indexPath;

@synthesize receivedData = _receivedData;
@synthesize loadedImage = _loadedImage;

- (void)startDownload
{
	if (self.imageURL == nil ||
		self.indexPath == nil) {
		return;
	}
	
	NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	self.connection = conn;	
}

- (void)cancelDonwload
{
	[self.connection cancel];
	self.connection = nil;
	_receivedData = nil;
	_loadedImage = nil;
}

#pragma mark - NSURLConnection data delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	_receivedData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[_receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	_loadedImage = [UIImage imageWithData:self.receivedData];
	_receivedData = nil;
	self.connection = nil;
	
	[self.delegate asyncImageDownloaderDidLoad:self atIndexPath:self.indexPath];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	self.connection = nil;
	_receivedData = nil;
	_loadedImage = nil;
}

@end

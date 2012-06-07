//
//  AsyncImageDownloader.h
//
//  Created by Takuma Shimizu (hokuron) on 12/06/06.
//  Copyright (c) 2012年 co-tree. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AsyncImageDownloaderDelegate;

@interface AsyncImageDownloader : NSObject <NSURLConnectionDataDelegate>

// The following properties will be set before call the startDownload method.
@property (weak, nonatomic) id <AsyncImageDownloaderDelegate> delegate;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSIndexPath *indexPath;

// The following properties will be used to delegate after loading the image.
@property (strong, readonly, nonatomic) NSMutableData *receivedData;
@property (strong, readonly, nonatomic) UIImage *loadedImage;

- (void)startDownload;
- (void)cancelDonwload;

@end

@protocol AsyncImageDownloaderDelegate <NSObject>

- (void)asyncImageDownloaderDidLoad:(AsyncImageDownloader *)downloader atIndexPath:(NSIndexPath *)indexPath;

@end

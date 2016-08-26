//
//  Track.h
//  AssetTracker
//
//  Created by Erick Barbosa on 4/27/15.
//  Copyright (c) 2015 Erick_Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Track : NSManagedObject

@property (nonatomic, retain) NSString * assetName;
@property (nonatomic, retain) NSString * serialNumber;
@property (nonatomic, retain) NSString * macAddress;
@property (nonatomic, retain) NSString * cost;

@end

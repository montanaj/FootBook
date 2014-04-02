//
//  Profile.h
//  FootBook
//
//  Created by Claire Jencks on 4/2/14.
//  Copyright (c) 2014 Claire Jencks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Profile : NSManagedObject

@property (nonatomic, retain) NSNumber * friends;
@property (nonatomic, retain) NSString * hairyness;
@property (nonatomic, retain) NSNumber * numberOfToes;
@property (nonatomic, retain) NSNumber * shoeSize;
@property (nonatomic, retain) NSString * name;

@end

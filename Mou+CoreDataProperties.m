//
//  Mou+CoreDataProperties.m
//  Traveldiary
//
//  Created by 陳毅麟 on 2016/11/17.
//  Copyright © 2016年 Rin. All rights reserved.
//

#import "Mou+CoreDataProperties.h"

@implementation Mou (CoreDataProperties)

+ (NSFetchRequest<Mou *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Mou"];
}

@dynamic mouinfo;

@end

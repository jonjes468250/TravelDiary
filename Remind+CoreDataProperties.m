//
//  Remind+CoreDataProperties.m
//  Traveldiary
//
//  Created by 陳毅麟 on 2016/11/17.
//  Copyright © 2016年 Rin. All rights reserved.
//

#import "Remind+CoreDataProperties.h"

@implementation Remind (CoreDataProperties)

+ (NSFetchRequest<Remind *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Remind"];
}

@dynamic remindinfo;
@dynamic time;

@end

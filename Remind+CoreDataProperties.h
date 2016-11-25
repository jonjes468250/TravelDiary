//
//  Remind+CoreDataProperties.h
//  Traveldiary
//
//  Created by 陳毅麟 on 2016/11/17.
//  Copyright © 2016年 Rin. All rights reserved.
//

#import "Remind+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Remind (CoreDataProperties)

+ (NSFetchRequest<Remind *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *remindinfo;
@property (nullable, nonatomic, copy) NSDate *time;

@end

NS_ASSUME_NONNULL_END

//
//  Mou+CoreDataProperties.h
//  Traveldiary
//
//  Created by 陳毅麟 on 2016/11/17.
//  Copyright © 2016年 Rin. All rights reserved.
//

#import "Mou+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Mou (CoreDataProperties)

+ (NSFetchRequest<Mou *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *mouinfo;

@end

NS_ASSUME_NONNULL_END

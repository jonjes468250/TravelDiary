//
//  Diary+CoreDataProperties.h
//  Traveldiary
//
//  Created by 陳毅麟 on 2016/11/17.
//  Copyright © 2016年 Rin. All rights reserved.
//

#import "Diary+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Diary (CoreDataProperties)

+ (NSFetchRequest<Diary *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *adress;
@property (nullable, nonatomic, copy) NSString *text;
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END

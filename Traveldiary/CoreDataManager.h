//
//  CoreDataManager.h
//  HelloCoreDataManager
//
//  Created by 陳毅麟 on 2016/10/5.
//  Copyright © 2016年 Rin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
typedef void (^SaveCompletion)(BOOL success);

@interface CoreDataManager : NSObject

-(instancetype) initWithModel:(NSString*)modelName
                   dbFileName:(NSString*)dbName
                dbFilePathURL:(NSURL*)dbFilePathURL
                      sortKey:(NSString*)sortKey
                   entityName:(NSString*)entityName;
-(NSInteger) count;
-(void)saveContextWithCompletion:(SaveCompletion)completion;

-(void) deleteItem: (NSManagedObject*)item;
-(NSManagedObject*) getByIndex:(NSInteger) index;
-(NSManagedObject*) createItem;
-(NSArray*)searchFor:(NSString*)keyword atField:(NSString*)field;


@end

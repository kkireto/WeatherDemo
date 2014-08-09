//
//  JSONManager.h
//
//  Created by Kireto on 5/23/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONManager : NSObject

+ (id)valueForKey:(NSString*)keyString withType:(Class)classType fromDictionary:(NSDictionary*)dictionary;
+ (NSUInteger)integerValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary;
+ (double)doubleValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary;
+ (int)intValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary;
+ (BOOL)boolValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary;
+ (NSString*)stringValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary;
+ (NSString*)stringPhoneValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary;
+ (NSString*)stringValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary withFailValue:(NSString*)failValue;
+ (NSString*)resourceStringValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary;
+ (NSArray*)arrayValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary;
+ (NSDictionary*)dictValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary;
+ (NSDate*)dateValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary;
+ (NSDate*)dateValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary withDateFormatter:(NSDateFormatter*)dateFormat;
+ (NSDate*)dateValueFromTimeIntervalForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary;

@end

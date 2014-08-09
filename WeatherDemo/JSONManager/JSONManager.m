//
//  JSONManager.m
//
//  Created by Kireto on 5/23/14.
//  Copyright (c) 2014 No Name. All rights reserved.
//

#import "JSONManager.h"

@implementation JSONManager

+ (id)valueForKey:(NSString*)keyString withType:(Class)classType fromDictionary:(NSDictionary*)dictionary {
    id retValue;
    if ([dictionary valueForKey:keyString] && [[dictionary valueForKey:keyString] isKindOfClass:[classType class]]) {
        retValue = [dictionary objectForKey:keyString];
    }
    return retValue;
}

+ (NSUInteger)integerValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary {
    NSUInteger retValue = 0;
    if ([dictionary valueForKey:keyString] && [dictionary valueForKey:keyString] != [NSNull null]) {
        retValue = [[dictionary objectForKey:keyString] longValue];
    }
    return retValue;
}

+ (double)doubleValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary {
    NSTimeInterval retValue = 0;
    if ([dictionary valueForKey:keyString] && [dictionary valueForKey:keyString] != [NSNull null]) {
        retValue = [[dictionary objectForKey:keyString] doubleValue];
    }
    return retValue;
}

+ (int)intValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary {
    int retValue = 0;
    if ([dictionary valueForKey:keyString] && [dictionary valueForKey:keyString] != [NSNull null]) {
        retValue = [[dictionary objectForKey:keyString] intValue];
    }
    return retValue;
}

+ (BOOL)boolValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary {
    BOOL retValue = NO;
    if ([dictionary valueForKey:keyString] && [dictionary valueForKey:keyString] != [NSNull null]) {
        retValue = [[dictionary objectForKey:keyString] boolValue];
    }
    return retValue;
}

+ (NSString*)stringValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary {
    NSString *retValue = @"";
    if ([dictionary valueForKey:keyString] && [[dictionary valueForKey:keyString] isKindOfClass:[NSString class]]) {
        retValue = [dictionary objectForKey:keyString];
    }
    return retValue;
}

+ (NSString*)stringPhoneValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary {
    NSString *retValue = @"";
    if ([dictionary valueForKey:keyString] && [[dictionary valueForKey:keyString] isKindOfClass:[NSString class]]) {
        retValue = [dictionary objectForKey:keyString];
        if ([retValue hasPrefix:@"389"]) {
            retValue = [retValue substringFromIndex:3];
            retValue = [NSString stringWithFormat:@"0%@", retValue];
        }
        else if ([retValue hasPrefix:@"+389"]) {
            retValue = [retValue substringFromIndex:4];
            retValue = [NSString stringWithFormat:@"0%@", retValue];
        }
        else if ([retValue hasPrefix:@"00389"]) {
            retValue = [retValue substringFromIndex:5];
            retValue = [NSString stringWithFormat:@"0%@", retValue];
        }
    }
    return retValue;
}

+ (NSString*)stringValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary withFailValue:(NSString*)failValue {
    NSString *retValue = failValue;
    if ([dictionary valueForKey:keyString] && [[dictionary valueForKey:keyString] isKindOfClass:[NSString class]]) {
        retValue = [dictionary objectForKey:keyString];
    }
    return retValue;
}

+ (NSString*)resourceStringValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary {
    NSString *retValue = @"";
    if ([dictionary valueForKey:keyString] && [[dictionary valueForKey:keyString] isKindOfClass:[NSString class]]) {
//        retValue = [Globals checkSanityForURLstring:[dictionary objectForKey:keyString]];
    }
    return retValue;
}

+ (NSArray*)arrayValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary {
    NSArray *retValue;
    if ([dictionary valueForKey:keyString] && [[dictionary valueForKey:keyString] isKindOfClass:[NSArray class]]) {
        retValue = [dictionary objectForKey:keyString];
    }
    return retValue;
}

+ (NSDictionary*)dictValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary {
    NSDictionary *retValue;
    if ([dictionary valueForKey:keyString] && [[dictionary valueForKey:keyString] isKindOfClass:[NSDictionary class]]) {
        retValue = [dictionary objectForKey:keyString];
    }
    return retValue;
}

+ (NSDate*)dateValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary {
    NSDate *retValue;
    NSString *dateString = [JSONManager stringValueForKey:keyString fromDictionary:dictionary];
    if (dateString) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
        retValue = [dateFormat dateFromString:dateString];
        dateFormat = nil;
    }
    return retValue;
}

+ (NSDate*)dateValueForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary withDateFormatter:(NSDateFormatter*)dateFormat {
    NSDate *retValue;
    NSString *dateString = [JSONManager stringValueForKey:keyString fromDictionary:dictionary];
    if (dateString) {
        retValue = [dateFormat dateFromString:dateString];
    }
    return retValue;
}

+ (NSDate*)dateValueFromTimeIntervalForKey:(NSString*)keyString fromDictionary:(NSDictionary*)dictionary {
    NSDate *retValue;
    NSTimeInterval timeInterval = [JSONManager doubleValueForKey:keyString fromDictionary:dictionary];
    if (timeInterval > 0) {
        retValue = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    }
    return retValue;
}

@end

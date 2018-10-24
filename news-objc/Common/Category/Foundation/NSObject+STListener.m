//
//  NSObject+STListener.m
//  news-objc
//
//  Created by stlndm on 2018/10/18.
//  Copyright © 2018 stlndm. All rights reserved.
//

#import "NSObject+STListener.h"
#import <objc/message.h>

@implementation NSObject (Listener)
- (NSArray *)st_allPropertyKey {
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableArray *propertyNames = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        [propertyNames addObject:propertyName];
    }
    free(properties);
    return propertyNames.copy;
}

- (NSArray *)st_allPropertValue {
    return [self st_allPropertys].allValues.copy;
}

- (NSArray *)st_allMethods {
    unsigned int outCount = 0;
    Method *methods = class_copyMethodList([self class], &outCount);
    NSMutableArray *methodNames = [NSMutableArray arrayWithCapacity:outCount];
    for (int i = 0; i < outCount; ++i) {
        Method method = methods[i];
        SEL methodSEL = method_getName(method);
        const char *name = sel_getName(methodSEL);
        NSString *methodName = [NSString stringWithUTF8String:name];
        [methodNames addObject:methodName];
    }
    free(methods);
    return methodNames.copy;
}

- (NSDictionary *)st_allPropertys {
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id propertyValue = [self valueForKey:propertyName];
        if (propertyValue && propertyValue != nil) {
            [resultDict setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    return resultDict.copy;
}
@end

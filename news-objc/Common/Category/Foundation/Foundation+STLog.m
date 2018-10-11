

#import <Foundation/Foundation.h>

@implementation NSDictionary (Log)
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString* str = [NSMutableString string];
    [str appendString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
        [obj isKindOfClass:[NSString class]] ? [str appendFormat:@"\t\"%@\": \"%@\",\n", key, obj] : [str appendFormat:@"\t\"%@\": %@,\n", key, obj];
    }];
    [str appendString:@"}"];
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length != 0) {
        [str deleteCharactersInRange:range];
    }

    return str;
}
@end

@implementation NSArray (Log)
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString* str = [NSMutableString string];
    [str appendString:@"[\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    [str appendString:@"]"];
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length != 0) {
        [str deleteCharactersInRange:range];
    }
    return str;
}
@end
 

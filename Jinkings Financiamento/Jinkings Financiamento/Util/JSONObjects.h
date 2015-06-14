//
//

#import <Foundation/Foundation.h>

@interface NSData(JSONObjects)

- (id)objectFromJSONData;

@end

@interface NSString(JSONObjects)

- (id)objectFromJSONString;
+ (id) objectFromFile:(NSString*) path;
- (NSString *)JSONString;
- (NSData *)JSONData;

@end


@interface NSDictionary(JSONObjects)


- (NSString *)JSONString;
- (NSData *)JSONData;

@end

@interface NSArray(JSONObjects)


- (NSString *)JSONString;
- (NSData *)JSONData;

@end

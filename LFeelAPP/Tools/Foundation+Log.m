//
//
//  Created by huangyibiao on 15/12/29.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//


@implementation NSArray (HYBUnicodeReadable)

#if DEBUG
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
  NSMutableString *desc = [NSMutableString string];
  
  NSMutableString *tabString = [[NSMutableString alloc] initWithCapacity:level];
  for (NSUInteger i = 0; i < level; ++i) {
    [tabString appendString:@"\t"];
  }
  
  NSString *tab = @"";
  if (level > 0) {
    tab = tabString;
  }
  [desc appendString:@"\t(\n"];
  
  for (id obj in self) {
    if (![obj respondsToSelector:@selector(description)]) {
      continue;
    }
    
    if ([obj isKindOfClass:[NSDictionary class]]
        || [obj isKindOfClass:[NSArray class]]
        || [obj isKindOfClass:[NSSet class]]) {
      NSString *str = [((NSDictionary *)obj) descriptionWithLocale:locale indent:level + 1];
      [desc appendFormat:@"%@\t%@,\n", tab, str];
    } else if ([obj isKindOfClass:[NSString class]]) {
      [desc appendFormat:@"%@\t\"%@\",\n", tab, obj];
    } else {
      @try {
        [desc appendFormat:@"%@\t%@,\n", tab, obj];
      } @catch (NSException *exception) {
        
      } @finally {
        
      }
    }
  }
  
  [desc appendFormat:@"%@)", tab];
  
  return desc;
}
#endif

@end


@implementation NSDictionary (HYBUnicodeReadable)

#if DEBUG
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *desc = [NSMutableString string];
    
    NSMutableString *tabString = [[NSMutableString alloc] initWithCapacity:level];
    for (NSUInteger i = 0; i < level; ++i) {
        [tabString appendString:@"\t"];
    }
    
    NSString *tab = @"";
    if (level > 0) {
        tab = tabString;
    }
    
    [desc appendString:@"\t{\n"];
    
    // 遍历数组,self就是当前的数组
    for (id key in self.allKeys) {
        id obj = [self objectForKey:key];
        
        if (![obj respondsToSelector:@selector(description)]) {
            continue;
        }
        
        if ([obj isKindOfClass:[NSString class]]) {
            [desc appendFormat:@"%@\t%@ = \"%@\",\n", tab, key, obj];
        } else if ([obj isKindOfClass:[NSArray class]]
                   || [obj isKindOfClass:[NSDictionary class]]
                   || [obj isKindOfClass:[NSSet class]]) {
            [desc appendFormat:@"%@\t%@ = %@,\n", tab, key, [obj descriptionWithLocale:locale indent:level + 1]];
        } else {
            @try {
                [desc appendFormat:@"%@\t%@ = %@,\n", tab, key, obj];
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
        }
    }
    
    [desc appendFormat:@"%@}", tab];
    
    return desc;
}
#endif

@end

//
//  NSDictionary+Log.m
//  01-掌握-多值参数和中文输出
//

#import <Foundation/Foundation.h>

// 重写系统的打印方法，
// 需要知道的是NSDictionary和NSArray各自都有打印方法
// 也就是说，你重写了NSArray打印重写方法，打印NSArray对象才会执行重写的方法

// 如果是通过子类来重写父类系统的方法，那么使用的时候就需要导入这个子类
// 但是通过类别重写系统方法，就不需要import导入，因为系统中导入了已经有了同名的被重写的方法了，系统会优先加载类别里的重写的方法，连.h声明文件都可以不用了，因为系统中已经有.h声明文件

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale

{
    
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"{\n"];
    
    // 遍历字典的所有键值对
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
        
    }];
    
    [str appendString:@"}"];
    
    // 查出最后一个,的范围
    
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    
    if (range.length) {
        
        // 删掉最后一个,
        
        [str deleteCharactersInRange:range];
        
    }
    
    return str;
    
}

@end

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale

{
    
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"[\n"];
    
    // 遍历数组的所有元素
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [str appendFormat:@"%@,\n", obj];
        
    }];
    
    [str appendString:@"]"];
    
    // 查出最后一个,的范围
    
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    
    if (range.length) {
        
        // 删掉最后一个,
        
        [str deleteCharactersInRange:range];
        
    }
    
    return str;
    
}
@end

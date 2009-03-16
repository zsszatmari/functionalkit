#import "FKP1.h"

@interface FKP1 (FKP1Private)
- (FKP1 *)initWith_1:(id)new_1;
@end

@implementation FKP1

@synthesize _1;

+ (FKP1 *)p1With_1:(id)_1 {
    return [[[FKP1 alloc] initWith_1:_1] autorelease];
}

- (void) dealloc {
    [_1 release];
    [super dealloc];
}

#pragma mark Private methods.
- (id)initWith_1:(id)new_1 {
    if (self = [super init]) {
        _1 = [new_1 retain];
    }
    return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"<%s: _1=%@>", class_getName([self class]), _1];
}

@end

#import "FKOption.h"

@implementation FKNone
@end

@interface FKSome (FKSomePrivate)
- (FKSome *)initWithSome:(id)someObject;
@end

@implementation FKSome

- (id)some {
    return someObject;
}

- (void) dealloc {
    [someObject release];
    [super dealloc];
}

#pragma mark Private methods.
- (FKSome *)initWithSome:(id)newSomeObject {
    if (self = [super init]) {
        someObject = [newSomeObject retain];
    }
    return self;
}

@end

@implementation FKOption

+ (FKOption *)fromNil:(id)maybeNil {
    return maybeNil == nil ? [FKOption none] : [FKOption some:maybeNil];
}

+ (FKOption *)fromNil:(id)maybeNil ofType:(Class)cls {
	//TODO add bind and re-use fromNil
	return (maybeNil != nil && [maybeNil isKindOfClass:cls]) ? [FKOption some:maybeNil] : [FKOption none];
}

+ (FKOption *)none {
    return [[[FKNone alloc] init] autorelease];
}

+ (FKOption *)some:(id)someObject {
    return [[[FKSome alloc] initWithSome:someObject] autorelease];
}

- (BOOL)isNone {
    return [self isKindOfClass:[FKNone class]];
}

- (BOOL)isSome {
    return [self isKindOfClass:[FKSome class]];
}

- (id)some {
    return nil;
}

- (FKOption *)orElse:(FKOption *)other {
    return [self isSome] ? self : other;
}

- (id)orSome:(id)some {
    return [self isSome] ? [self some] : some;
}

- (FKOption *)mapWithSelector:(SEL)selector {
	return [self isSome] && [[self some] respondsToSelector:selector] ? [FKOption some:[[self some] performSelector:selector]] : self;
}

- (FKOption *)mapWithSelector:(SEL)selector onObject:(id)object {
	return [self isSome] && [object respondsToSelector:selector] ? [FKOption some:[object performSelector:selector withObject:[self some]]] : self;
}

- (FKOption *)map:(id <FKFunction>)f {
	return [self isSome] ? [FKOption some:[f :[self  some]]] : self;
}

@end

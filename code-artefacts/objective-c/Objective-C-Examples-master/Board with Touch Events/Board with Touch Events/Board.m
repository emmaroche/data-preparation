//
//  Board.m
//  Board with Touch Events
//
//  Created by Carlos on 06/04/14.
//  Copyright (c) 2014 Carlos Butron. All rights reserved.
//

#import "Board.h"
#import "Line.h"

@interface Board()
{
    CGPoint start;
    CGPoint end;
    NSMutableArray * _lines;
}

@property (readonly,getter = lines ) NSMutableArray * lines;

@end

@implementation Board
@synthesize lines;

- (IBAction)delete:(id)sender 
{
    //reload view deleting all lines
    [self.lines removeAllObjects];
    
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (NSMutableArray *)lineas
{
    if (_lines == nil) {
        _lines = [NSMutableArray new];
    }
    return _lines;
}

- (void)drawRect:(CGRect)rect 
{
    //draw all lines in NSMutableArray. red color. size 3
    CGContextRef contexto = UIGraphicsGetCurrentContext();
    UIColor *rojo = [UIColor redColor];
    CGContextSetStrokeColorWithColor(contexto, rojo.CGColor);
    CGContextSetLineWidth(contexto, 3);

    for (int i = 0; i < _lines.count; i++) {
        Line * line = [self.lineas objectAtIndex:i];
        //NSLog(@"drawrect  %f, %f, %f, %f", line.points.origin.x, line.points.origin.y, line.points.size.width, line.points.size.height);
        CGContextMoveToPoint(contexto, line.points.origin.x, line.points.origin.y);
        CGContextAddLineToPoint(contexto, line.points.size.width, line.points.size.height);
        CGContextStrokePath(contexto);
    }

    CGContextStrokePath(contexto);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    //update start and end
    UITouch *touch = [touches anyObject];
    start = [touch previousLocationInView:self];
    end = [touch locationInView:self];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
    //add coordinates of movement to NSMutableArray lines with class Line
    //update start and end
    //reload view
    UITouch * touch = [touches anyObject];
    start = [touch previousLocationInView:self];
    end = [touch locationInView:self];
    Line * line = [[Line alloc] initWithRect:CGRectMake(start.x, start.y, end.x, end.y)];
    // NSLog(@"touchesmoved   %f, %f, %f, %f", start.x, start.y, end.x, end.y);
    [self.lineas addObject: line];
    start.x = end.x;
    start.y = end.y;
    
    [self setNeedsDisplay];
}

@end

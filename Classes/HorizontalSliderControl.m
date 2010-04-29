/*
 * Copyright 2010, Andreas Kompanez
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "HorizontalSliderControl.h"

static int const kScrollViewTag = 10;
static int const kOverlayViewTag = 20;

@interface HorizontalSliderControl ()

- (void)_initViews;

- (UIImage *)_createOverlayImage;

@end



@implementation HorizontalSliderControl

@synthesize delegate;
@synthesize value;


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		value = 1;
		[self _initViews];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	CGPoint point = [scrollView contentOffset];
	float offset = (point.x / 60.0f);
	int selected = ((offset - (int)offset) > 0.5) ? ceil(offset): floor(offset);
	
	[scrollView scrollRectToVisible:CGRectMake(selected * 60.0f, 0.0f, 320.0f, 60.0f) animated:YES];
	if (value != (selected + 1)) {
		value = selected + 1;
		[delegate horizontalSliderControlValueChanged:value];
	}
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
	[scrollView setContentOffset:scrollView.contentOffset animated:YES];
}


#pragma mark Private methods

- (void) _initViews
{
	[self setBackgroundColor:[UIColor whiteColor]];
	
	CGRect bounds = [self bounds];
	
	//  Scroll-View init
	UIScrollView *sView = [[UIScrollView alloc] initWithFrame:bounds];
	sView.showsHorizontalScrollIndicator = NO;
	sView.bounces = NO;
	sView.tag = kScrollViewTag;
	sView.decelerationRate = UIScrollViewDecelerationRateNormal;
	sView.delegate = self;
	UIImage *counterImage = [UIImage imageNamed:@"counter2.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:counterImage];
	[imageView setBackgroundColor:[UIColor clearColor]];
	[sView setContentSize:CGSizeMake(620.0f, bounds.size.height)];
	[sView addSubview:imageView];
	
	[self addSubview:sView];
	[sView release];
	
	// Overlay View init
	UIImageView *overlayImageView = [[UIImageView alloc] initWithImage:[self _createOverlayImage]];
	overlayImageView.tag = kOverlayViewTag;
	[overlayImageView setBackgroundColor:[UIColor clearColor]];
	
	[self addSubview:overlayImageView];	
	[overlayImageView release];	
}

- (UIImage *)_createOverlayImage
{
	UIImage *overlayImage;
	CGRect bounds = [self bounds];
	
	UIGraphicsBeginImageContext(bounds.size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(context, 1.5f);
	CGContextSetStrokeColorWithColor(context , [[UIColor grayColor] CGColor]);
	CGContextMoveToPoint(context, 0.0f, 0.0f);
	CGContextAddLineToPoint(context, bounds.size.width, 0.0f);
	CGContextStrokePath(context);
	
	CGContextMoveToPoint(context, 0.0f, bounds.size.height);
	CGContextAddLineToPoint(context, bounds.size.width, bounds.size.height);
	CGContextStrokePath(context);
	
	// Shadow
	UIImage *shadowImage = [UIImage imageNamed:@"shadow.png"];
	[shadowImage drawAtPoint:CGPointMake(0.0f, 0.0f)];
	
	// Pointer
	UIImage *pointerImage = [UIImage imageNamed:@"point.png"];
	CGPoint center = [self center];
	[pointerImage drawAtPoint:CGPointMake((center.x - ([pointerImage size].width / 2)), 0.0f)];
	
	overlayImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return overlayImage;
}

#pragma mark -
#pragma mark dealloc

- (void)dealloc {
	delegate = nil;
	
    [super dealloc];
}


@end

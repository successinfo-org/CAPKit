//
//  VideoWidget.m
//  BookShelf
//
//  Created by Sam Chang on 1/26/14.
//  Copyright (c) 2014 Jian-Guo Hu. All rights reserved.
//

#import "VideoWidget.h"

CGFloat kMovieViewOffsetX = 20.0;
CGFloat kMovieViewOffsetY = 20.0;

@interface VideoWidget ()

@property (nonatomic, assign) BOOL idleTimerDisabled;

@end

@implementation VideoWidget

static int idleTimerDisabledCount;

+(void)initialize{
    idleTimerDisabledCount = 0;
}

+(void)load {
    [WidgetMap bind: @"video" withModelClassName: @"VideoM" withWidgetClassName: @"VideoWidget"];
}

- (void) stopIdleTimer {
    if (!_idleTimerDisabled) {
        _idleTimerDisabled = YES;

        idleTimerDisabledCount++;
        if (idleTimerDisabledCount > 0) {
            [UIApplication sharedApplication].idleTimerDisabled = YES;
//            NSLog(@"idleTimerDisabled = YES");
        }
    }
}

- (void) startIdleTimer {
    if (_idleTimerDisabled) {
        _idleTimerDisabled = NO;

        idleTimerDisabledCount--;
        if (idleTimerDisabledCount <= 0) {
            [UIApplication sharedApplication].idleTimerDisabled = NO;
//            NSLog(@"idleTimerDisabled = NO");
        }
    }
}

-(UIView *)innerView{
    return _view;
}

-(void)onCreateView{
    _view = [[UIView alloc] initWithFrame: [self getActualCurrentRect]];

    [self reloadSrc];
}

-(void)setViewFrame:(CGRect)rect{
    [super setViewFrame: rect];
    
    self.moviePlayerController.view.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
}

- (void) onBackend {
    [super onBackend];
    
    [self removeMovieNotificationHandlers];
}

- (void) onDestroy {
    [super onDestroy];
    
    [self removeMovieNotificationHandlers];
    self.moviePlayerController = nil;

    [self startIdleTimer];
}

- (void) setSrc: (NSString *) src{
    self.model.src = src;
    
    [self reload];
}

- (NSString *) getSrc{
    return self.model.src;
}

- (void) setCurrentPlaybackTime: (NSTimeInterval) value {
    self.moviePlayerController.currentPlaybackTime = value;
}

- (NSTimeInterval) getCurrentPlaybackTime{
    return self.moviePlayerController.currentPlaybackTime;
}

- (NSTimeInterval) getDuration {
    return self.moviePlayerController.duration;
}

- (NSTimeInterval) getPlayableDuration {
    return self.moviePlayerController.playableDuration;
}

- (void) setCurrentPlaybackRate: (float) value {
    self.moviePlayerController.currentPlaybackRate = value;
}

- (float) getCurrentPlaybackRate{
    return self.moviePlayerController.currentPlaybackRate;
}

- (void) setFullscreen: (NSNumber *) value {
    [self.moviePlayerController setFullscreen: [value boolValue] animated: YES];
}

- (void)seekingForward{
    [self.moviePlayerController beginSeekingForward];
}

- (void)seekingBackward{
    [self.moviePlayerController beginSeekingBackward];
}

- (void)endSeeking{
    [self.moviePlayerController endSeeking];
}

- (void) play{
    [OSUtils runBlockOnMain:^{
        [self.moviePlayerController play];
        [self stopIdleTimer];
    }];
}

- (void) pause{
    [OSUtils runBlockOnMain:^{
        [self.moviePlayerController pause];
        [self startIdleTimer];
    }];
}

- (void) stop{
    [OSUtils runBlockOnMain:^{
        [self.moviePlayerController stop];
        [self startIdleTimer];
    }];
}

- (void) setScalingMode: (NSString *) scalingMode{
    [self.model parseScalingMode: scalingMode];
    
    [self reload];
}

- (NSString *) getScalingMode{
    return [self.model scalingModeName];
}

- (void) setControlStyle: (NSString *) controlStyle{
    [self.model parseControlStyle: controlStyle];
    
    [self reload];
}

- (NSString *) getControlStyle{
    return [self.model controlStyleName];
}

- (void) setRepeatMode: (NSString *) repeatMode{
    [self.model parseRepeatMode: repeatMode];
    
    [self reload];
}

- (NSString *) getRepeatMode{
    return [self.model repeatModeName];
}

- (void) setSourceType: (NSString *) sourceType{
    [self.model parseSourceType: sourceType];
    
    [self reload];
}

- (NSString *) getSourceType{
    return [self.model sourceTypeName];
}

- (void) setAllowsAirPlay: (NSNumber *) allowsAirPlay{
    if ([allowsAirPlay respondsToSelector: @selector(boolValue)]) {
        self.model.allowsAirPlay = [allowsAirPlay boolValue];
        
        [self reload];
    }
}

- (BOOL) getAllowsAirPlay{
    return self.model.allowsAirPlay;
}

- (void) setOnloadstate: (LuaFunction *) func{
    if ([func isKindOfClass: [LuaFunction class]]) {
        self.model.onloadstate = func;
    }
}

- (LuaFunction *) getOnloadstate{
    return self.model.onloadstate;
}

- (void) setOnplaybackfinish: (LuaFunction *) func{
    if ([func isKindOfClass: [LuaFunction class]]) {
        self.model.onplaybackfinish = func;
    }
}

- (LuaFunction *) getOnplaybackfinish{
    return self.model.onplaybackfinish;
}

- (void) setOnplaybackstate: (LuaFunction *) func{
    if ([func isKindOfClass: [LuaFunction class]]) {
        self.model.onplaybackstate = func;
    }
}

- (LuaFunction *) getOnplaybackstate{
    return self.model.onplaybackstate;
}

- (void) setOnpreparedtoplay: (LuaFunction *) func{
    if ([func isKindOfClass: [LuaFunction class]]) {
        self.model.onpreparedtoplay = func;
    }
}

- (LuaFunction *) getOnpreparedtoplay{
    return self.model.onpreparedtoplay;
}

- (void) reloadSrc{
    NSURL *url = [self.pageSandbox resolveFile: self.model.src];
    if ([url isFileURL]) {
        [self createAndConfigurePlayerWithURL: url sourceType: MPMovieSourceTypeFile];
    } else {
        MPMovieSourceType movieSourceType = self.model.sourceType;
        if ([[url pathExtension] compare:@"m3u8" options: NSCaseInsensitiveSearch] == NSOrderedSame) {
            movieSourceType = MPMovieSourceTypeStreaming;
        }
        [self createAndConfigurePlayerWithURL: url sourceType: movieSourceType];
    }
}

-(void)onReload{
    [super onReload];
    
    APPLY_DIRTY_MODEL_PROP(scalingMode, self.moviePlayerController.scalingMode);
    APPLY_DIRTY_MODEL_PROP(controlStyle, self.moviePlayerController.controlStyle);
    APPLY_DIRTY_MODEL_PROP(repeatMode, self.moviePlayerController.repeatMode);
    APPLY_DIRTY_MODEL_PROP(allowsAirPlay, self.moviePlayerController.allowsAirPlay);
    
    APPLY_DIRTY_MODEL_PROP_DO(src, {
        [self reloadSrc];
    });
}

#pragma mark Create and Play Movie URL

-(void)createAndConfigurePlayerWithURL:(NSURL *)movieURL sourceType:(MPMovieSourceType)sourceType
{
    if (!self.moviePlayerController) {
        self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
        self.moviePlayerController.controlStyle = self.model.controlStyle;
        self.moviePlayerController.scalingMode = self.model.scalingMode;
        self.moviePlayerController.repeatMode = self.model.repeatMode;
        self.moviePlayerController.allowsAirPlay = self.model.allowsAirPlay;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadStateDidChange:)
                                                     name:MPMoviePlayerLoadStateDidChangeNotification
                                                   object: self.moviePlayerController];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object: self.moviePlayerController];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                     name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                   object: self.moviePlayerController];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackStateDidChange:)
                                                     name:MPMoviePlayerPlaybackStateDidChangeNotification
                                                   object: self.moviePlayerController];
        
        [self.view addSubview: self.moviePlayerController.view];
        self.moviePlayerController.view.frame = CGRectMake(0, 0, [self getActualCurrentRect].size.width, [self getActualCurrentRect].size.height);
    }
    
    if (self.moviePlayerController) {
        [self.moviePlayerController setContentURL: movieURL];
        [self.moviePlayerController setMovieSourceType: sourceType];
    }
}

#pragma mark Movie Notification Handlers

-(LuaTable *)toLuaTable{
    LuaTable *tb = [super toLuaTable];
    
    [tb.map setValue: [NSNumber numberWithInt: MPMovieLoadStateUnknown] forKey: @"LoadStateUnknown"];
    [tb.map setValue: [NSNumber numberWithInt: MPMovieLoadStatePlayable] forKey: @"LoadStatePlayable"];
    [tb.map setValue: [NSNumber numberWithInt: MPMovieLoadStatePlaythroughOK] forKey: @"LoadStatePlaythroughOK"];
    [tb.map setValue: [NSNumber numberWithInt: MPMovieLoadStatePlaythroughOK] forKey: @"StatePlaythroughOK"];
    [tb.map setValue: [NSNumber numberWithInt: MPMovieLoadStateStalled] forKey: @"LoadStateStalled"];
    
    [tb.map setValue: [NSNumber numberWithInt: MPMoviePlaybackStateStopped] forKey: @"PlaybackStateStopped"];
    [tb.map setValue: [NSNumber numberWithInt: MPMoviePlaybackStatePlaying] forKey: @"PlaybackStatePlaying"];
    [tb.map setValue: [NSNumber numberWithInt: MPMoviePlaybackStatePaused] forKey: @"PlaybackStatePaused"];
    [tb.map setValue: [NSNumber numberWithInt: MPMoviePlaybackStateInterrupted] forKey: @"PlaybackStateInterrupted"];
    [tb.map setValue: [NSNumber numberWithInt: MPMoviePlaybackStateSeekingForward] forKey: @"PlaybackStateSeekingForward"];
    [tb.map setValue: [NSNumber numberWithInt: MPMoviePlaybackStateSeekingBackward] forKey: @"PlaybackStateSeekingBackward"];
    
    [tb.map setValue: [NSNumber numberWithInt: MPMovieFinishReasonPlaybackEnded] forKey: @"FinishReasonPlaybackEnded"];
    [tb.map setValue: [NSNumber numberWithInt: MPMovieFinishReasonPlaybackError] forKey: @"FinishReasonPlaybackError"];
    [tb.map setValue: [NSNumber numberWithInt: MPMovieFinishReasonUserExited] forKey: @"FinishReasonUserExited"];
    
    return tb;
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    NSNumber *reason = [[notification userInfo] objectForKey: MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    if (self.model.onplaybackfinish) {
        [self.model.onplaybackfinish executeWithoutReturnValue: self, reason, [notification userInfo], nil];
    } else {
        NSLog(@"Unhandled Event, %@", notification);
    }

    [self startIdleTimer];
}

- (void)loadStateDidChange:(NSNotification *)notification
{
	MPMoviePlayerController *player = notification.object;
	MPMovieLoadState loadState = player.loadState;
    
    if (self.model.onloadstate) {
        [self.model.onloadstate executeWithoutReturnValue: self, [NSNumber numberWithInt: loadState], nil];
    } else {
        NSLog(@"Unhandled Event, %@", notification);
    }
}

- (void) moviePlayBackStateDidChange:(NSNotification*)notification
{
	MPMoviePlayerController *player = notification.object;
    if (self.model.onplaybackstate) {
        [self.model.onplaybackstate executeWithoutReturnValue: self, [NSNumber numberWithInt: player.playbackState], nil];
    } else {
        NSLog(@"Unhandled Event, %@", notification);
    }

    switch (player.playbackState) {
        case MPMoviePlaybackStateStopped:
        case MPMoviePlaybackStatePaused:
        case MPMoviePlaybackStateInterrupted:
            [self startIdleTimer];
            break;

        default:
            [self stopIdleTimer];
            break;
    }
}

- (void) mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
	MPMoviePlayerController *player = notification.object;
    if (self.model.onpreparedtoplay) {
        [self.model.onpreparedtoplay executeWithoutReturnValue: self, [NSNumber numberWithBool: player.isPreparedToPlay], nil];
    } else {
        NSLog(@"Unhandled Event, %@", notification);
    }
}

#pragma mark Remove Movie Notification Handlers

-(void)removeMovieNotificationHandlers {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object: self.moviePlayerController];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object: self.moviePlayerController];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification object: self.moviePlayerController];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object: self.moviePlayerController];
}

@end

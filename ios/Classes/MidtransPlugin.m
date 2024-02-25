#import "MidtransPlugin.h"
#import <MidtransKit/MidtransKit.h>

@interface MidtransPlugin () <MidtransUIPaymentViewControllerDelegate>

@end

@implementation MidtransPlugin
FlutterMethodChannel* channel;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  channel = [FlutterMethodChannel
             methodChannelWithName:@"midtrans_plugin"
             binaryMessenger:[registrar messenger]];
  MidtransPlugin* instance = [[MidtransPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"initialize" isEqualToString:call.method]){
    [self initializeWithCall:call result:result];
  } else if ([@"startPayment" isEqualToString:call.method]){
    [self startPaymentWithCall:call result:result];
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

- (UIViewController *) rootViewController {
  return [UIApplication sharedApplication].keyWindow.rootViewController;
}

- (void)initializeWithCall:(FlutterMethodCall*)call result:(FlutterResult)result{
  @try {
    NSString *merchantUrl = call.arguments[@"merchantUrl"];
    NSString *merchantClientKey = call.arguments[@"merchantClientKey"];
    BOOL enableLog = [call.arguments[@"enableLog"] boolValue];
    
    // initialize Midtrans
    [[MidtransConfig shared]setClientKey:merchantClientKey environment:MidtransServerEnvironmentSandbox merchantServerURL:merchantUrl];
    
    // enable logger for debugging purpose
    if(enableLog){
      [[MidtransNetworkLogger shared]startLogging];
    }
    
    result(@(YES));
  } @catch (NSException *exception) {
    NSLog(@"initialize error: %@", exception);
    result(@(NO));
  }
  
}

-(void)startPaymentWithCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  @try {
    //get transactionDetails json
    NSDictionary *transactionDetailsJson = [call.arguments objectForKey:@"transactionDetails"];
    MidtransCurrency currency = MidtransCurrencyIDR;
    if(!transactionDetailsJson){
      @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"TransactionDetails must not be null" userInfo:nil];
    }
    if (![transactionDetailsJson[@"currency"] isEqualToString:@"IDR"]) {
      currency = MidtransCurrencySGD;
    }
    
    //get itemDetails json
    NSArray *itemDetailJsonList = [call.arguments objectForKey:@"itemDetails"];
    if (!itemDetailJsonList || ![itemDetailJsonList isKindOfClass:[NSArray class]] || itemDetailJsonList.count == 0) {
      @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"ItemDetails must be a non-empty array of dictionaries" userInfo:nil];
    }
    
    //create object transactionDetails
    MidtransTransactionDetails *transactionDetails = [[MidtransTransactionDetails alloc]initWithOrderID:transactionDetailsJson[@"orderId"] andGrossAmount:transactionDetailsJson[@"grossAmount"] andCurrency:currency];
    
    //create object itemDetails
    NSMutableArray *itemDetails = [NSMutableArray array];
    for (NSDictionary *itemDetailJson in itemDetailJsonList) {
      MidtransItemDetail *itemDetail = [[MidtransItemDetail alloc]initWithItemID:itemDetailJson[@"id"] name:itemDetailJson[@"name"] price:itemDetailJson[@"price"] quantity:itemDetailJson[@"quantity"]];
      [itemDetails addObject:itemDetail];
    }
    
    [[MidtransMerchantClient shared]requestTransactionTokenWithTransactionDetails:transactionDetails itemDetails:itemDetails customerDetails:nil completion:^(MidtransTransactionTokenResponse *token, NSError *error){
      
      if (token) {
        NSLog(@"Token accuired: %@", token);
        
        MidtransUIPaymentViewController *vc = [[MidtransUIPaymentViewController alloc]initWithToken:token];
        vc.paymentDelegate = self;
        [[self rootViewController] presentViewController:vc animated:YES completion:nil];
        result(nil);
        return;
      }
      
      NSLog(@"Error found %@", error);
      FlutterError *flutterError = [FlutterError errorWithCode:@"InvalidToken" message:@"Token is null" details:nil];
      result(flutterError);
    }];
  } @catch (NSException *exception) {
    NSLog(@"startPayment error: %@", exception);
    FlutterError *flutterError = [FlutterError errorWithCode:@"Exception" message:exception.reason details:nil];
    result(flutterError);
  }
}

- (void) onTransactionFinishedWithResult:(MidtransTransactionResult *)result canceled:(BOOL) isCanceled error:(NSError *) error {
  NSMutableDictionary *arguments = [NSMutableDictionary dictionary];
  
  arguments[@"isCanceled"] = @(isCanceled);
  
  if (result) {
    arguments[@"statusMessage"] = result.statusMessage;
    arguments[@"paymentType"] = result.paymentType;
    arguments[@"transactionStatus"] = result.transactionStatus;
    arguments[@"transactionId"] = result.transactionId;
    arguments[@"orderId"] = result.orderId;
  }else if (error){
    arguments[@"statusMessage"] = @("paymentFailed");
    arguments[@"isFailed"] = @(YES);
  }
  
  [channel invokeMethod:@"onTransactionResult" arguments:arguments];
}

#pragma mark - MidtransUIPaymentViewControllerDelegate

- (void)paymentViewController:(MidtransUIPaymentViewController *)viewController paymentDeny:(MidtransTransactionResult *)result {
  NSLog(@"paymentDenied: %@", result);
  [self onTransactionFinishedWithResult:result canceled:NO error:nil];
}

- (void)paymentViewController:(MidtransUIPaymentViewController *)viewController paymentFailed:(NSError *)error {
  NSLog(@"paymentFailed: %@", error);
  [self onTransactionFinishedWithResult:nil canceled:NO error:error];
}

- (void)paymentViewController:(MidtransUIPaymentViewController *)viewController paymentPending:(MidtransTransactionResult *)result {
  NSLog(@"paymentPending: %@", result);
  [self onTransactionFinishedWithResult:result canceled:NO error:nil];
}

- (void)paymentViewController:(MidtransUIPaymentViewController *)viewController paymentSuccess:(MidtransTransactionResult *)result {
  NSLog(@"paymentSuccess: %@", result);
  [self onTransactionFinishedWithResult:result canceled:NO error:nil];
}

- (void)paymentViewController_paymentCanceled:(MidtransUIPaymentViewController *)viewController {
  NSLog(@"paymentCanceled");
  [self onTransactionFinishedWithResult:nil canceled:YES error:nil];
  
}

@end

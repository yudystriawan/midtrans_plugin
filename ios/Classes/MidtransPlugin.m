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
    NSString *callbackSchemeUrl = call.arguments[@"gopayCallbackUrl"];
    NSString *shopeePayCallbackUrl = call.arguments[@"shopeePayCallbackUrl"];
    NSDictionary *permataVaJson = [call.arguments objectForKey:@"permataVa"];
    NSDictionary *bcaVaJson = [call.arguments objectForKey:@"bcaVa"];
    NSDictionary *bniVaJson = [call.arguments objectForKey:@"bniVa"];
    NSString *paymentTypeConfig = [call.arguments objectForKey:@"peymentTypeConfig"];
    
    
    // initialize Midtrans
    NSLog(@"[initialize] initializing with clientKey:%@ and merchantUrl:%@.", merchantClientKey, merchantUrl);
    [[MidtransConfig shared]setClientKey:merchantClientKey environment:MidtransServerEnvironmentSandbox merchantServerURL:merchantUrl];
    
    // enable logger for debugging purpose
    if (enableLog) {
      NSLog(@"[initialize] enabling log.");
      [[MidtransNetworkLogger shared]startLogging];
    }
    
    if (callbackSchemeUrl) {
      NSLog(@"[initialize] setup callbackSchemeUrl.");
      CONFIG.callbackSchemeURL = callbackSchemeUrl;
    }
    
    if (shopeePayCallbackUrl) {
      NSLog(@"[initialize] setup shopeePayCallbackUrl.");
      CONFIG.shopeePayCallbackURL = shopeePayCallbackUrl;
    }
    
    if (permataVaJson) {
      NSLog(@"[initialize] setup custom permata VA.");
      
      NSString *vaNumber = [permataVaJson objectForKey:@"vaNumber"];
      NSString *recipientname = [permataVaJson objectForKey:@"recipientName"];
      
      CONFIG.customPermataVANumber = vaNumber;
      CONFIG.customPermataVARecipientName = recipientname;
    }
    
    if (bcaVaJson) {
      NSLog(@"[initialize] setup custom BCA VA.");
      
      NSString *vaNumber = [bcaVaJson objectForKey:@"vaNumber"];
      NSString *subCompanyCode = [bcaVaJson objectForKey:@"subCompanyCode"];
      
      CONFIG.customBCAVANumber = vaNumber;
      CONFIG.customBCASubcompanyCode = subCompanyCode;
    }
    
    if (bniVaJson) {
      NSLog(@"[initialize] setup custom BNI VA.");
      
      NSString *vaNumber = [bniVaJson objectForKey:@"vaNumber"];
      
      CONFIG.customBNIVANumber = vaNumber;
    }
    
    CC_CONFIG.setDefaultCreditSaveCardEnabled = YES;
    if (paymentTypeConfig) {
      NSLog(@"[initialize] setup paymentType:%@", paymentTypeConfig);
      
      CC_CONFIG.paymentType =[paymentTypeConfig isEqualToString:@"oneClickPayment"] ? MTCreditCardPaymentTypeOneclick : MTCreditCardPaymentTypeTwoclick;
      CC_CONFIG.saveCardEnabled = YES;
      CC_CONFIG.authenticationType = [paymentTypeConfig isEqualToString:@"oneClickPayment"] ? MTAuthenticationType3DS : MTAuthenticationTypeNone;
    } else {
      CC_CONFIG.paymentType = MTCreditCardPaymentTypeNormal;
      CC_CONFIG.authenticationType = MTAuthenticationTypeNone;
    }
    
    result(@(YES));
  } @catch (NSException *exception) {
    NSLog(@"[initialize] an error occured: %@", exception);
    result(@(NO));
  }
  
}

-(void)startPaymentWithCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  @try {
    
    //get transactionDetails json
    NSMutableDictionary *transactionDetailsJson = [call.arguments objectForKey:@"transactionDetails"];
    if(!transactionDetailsJson){
      @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"TransactionDetails must not be null" userInfo:nil];
    }
    
    //create object transactionDetails
    NSLog(@"[startPayment] initialized transactionDetails");
    MidtransTransactionDetails *transactionDetails = [[MidtransTransactionDetails alloc]initWithOrderID:transactionDetailsJson[@"orderId"]
                                                                                         andGrossAmount:transactionDetailsJson[@"grossAmount"]
                                                                                            andCurrency:MidtransCurrencyIDR];
    
    
    //get itemDetails json
    NSArray *itemDetailJsonList = [call.arguments objectForKey:@"itemDetails"];
    NSMutableArray *itemDetails = [NSMutableArray array];
    
    if (itemDetailJsonList && ([itemDetailJsonList isKindOfClass:[NSArray class]] || itemDetailJsonList.count > 0)) {
      //create object itemDetails
      NSLog(@"[startPayment] initialized itemDetails");
      for (NSDictionary *itemDetailJson in itemDetailJsonList) {
        MidtransItemDetail *itemDetail = [[MidtransItemDetail alloc]initWithItemID:itemDetailJson[@"id"]
                                                                              name:itemDetailJson[@"name"]
                                                                             price:itemDetailJson[@"price"]
                                                                          quantity:itemDetailJson[@"quantity"]];
        itemDetail.imageURL = itemDetailJson[@"imageUrl"];
        [itemDetails addObject:itemDetail];
      }
    }
    
    // Create customer details
    NSDictionary *customerDetailsJson = [call.arguments objectForKey:@"customerDetails"];
    MidtransCustomerDetails *customerDetails = nil;
    
    if (customerDetailsJson) {
      NSLog(@"[startPayment] initialized customerDetails");
      NSString *const countryCode = @"IDN";
      
      NSDictionary *billingAddressJson = [customerDetailsJson objectForKey:@"billingAddress"];
      NSDictionary *shippingAddressJson = [customerDetailsJson objectForKey:@"shippingAddress"];
      
      MidtransAddress *billingAddress = [MidtransAddress new];
      MidtransAddress *shippingAddress = [MidtransAddress new];
      
      if (billingAddressJson) {
        NSLog(@"[startPayment] initialized billingAddress");
        billingAddress = [MidtransAddress addressWithFirstName:billingAddressJson[@"firstName"]
                                                      lastName:billingAddressJson[@"lastName"]
                                                         phone:billingAddressJson[@"phone"]
                                                       address:billingAddressJson[@"address"]
                                                          city:billingAddressJson[@"city"]
                                                    postalCode:billingAddressJson[@"postalCode"]
                                                   countryCode:countryCode];
      }
      
      if (shippingAddressJson) {
        NSLog(@"[startPayment] initialized shippingAddress");
        shippingAddress = [MidtransAddress addressWithFirstName:shippingAddressJson[@"firstName"]
                                                       lastName:shippingAddressJson[@"lastName"]
                                                          phone:shippingAddressJson[@"phone"]
                                                        address:shippingAddressJson[@"address"]
                                                           city:shippingAddressJson[@"city"]
                                                     postalCode:shippingAddressJson[@"postalCode"]
                                                    countryCode:countryCode];
      }
      
      customerDetails = [[MidtransCustomerDetails new] initWithFirstName:customerDetailsJson[@"firstName"]
                                                                  lastName:customerDetailsJson[@"lastName"]
                                                                     email:customerDetailsJson[@"email"]
                                                                     phone:customerDetailsJson[@"phone"]
                                                           shippingAddress:shippingAddress
                                                            billingAddress:billingAddress];
    }

    
    // get expiry
    NSDictionary *expiryJson = [call.arguments objectForKey:@"expiry"];
    NSDate *startTime = nil;
    NSNumber *duration = nil;
    NSString *unit = nil;
    
    MidtransTransactionExpire *expiry = nil;
    
    if (expiryJson) {
      startTime = [expiryJson objectForKey:@"startTime"];
      duration = [expiryJson objectForKey:@"duration"];
      unit = [expiryJson objectForKey:@"unit"];
      
      NSLog(@"[startPayment] initialized expireTime with startTime:%@ duration:%@ unit:%@", startTime, duration, unit);
      
      NSDictionary *unitMapping = @{
        @"minutes": @(MindtransTimeUnitTypeMinutes),
        @"hours": @(MindtransTimeUnitTypeHours),
        @"days": @(MindtransTimeUnitTypeDays)
      };
      
      expiry = [[MidtransTransactionExpire alloc] initWithExpireTime:startTime
                                                      expireDuration:[duration integerValue]
                                                        withUnitTime:[unitMapping[unit] integerValue]];
    }
    
    NSLog(@"[startPayment] requestTransaction\ntransactionDetails:%@\nitemDetails:%@\ncustomerDetails:%@\nexpireTime:%@",
          transactionDetails,
          itemDetails,
          customerDetails,
          expiry);
    [[MidtransMerchantClient shared]requestTransactionTokenWithTransactionDetails:transactionDetails
                                                                      itemDetails:itemDetails
                                                                  customerDetails:customerDetails
                                                                      customField:nil
                                                                        binFilter:nil
                                                               blacklistBinFilter:nil
                                                            transactionExpireTime:expiry
                                                                       completion:^(MidtransTransactionTokenResponse *token, NSError *error){
      
      if (token) {
        NSLog(@"[startPayment] Token accuired: %@", token);
        
        MidtransUIPaymentViewController *vc = [[MidtransUIPaymentViewController alloc]initWithToken:token];
        vc.paymentDelegate = self;
        [[self rootViewController] presentViewController:vc animated:YES completion:nil];
        result(nil);
        return;
      }
      
      NSLog(@"[startPayment] token is null %@", error);
      FlutterError *flutterError = [FlutterError errorWithCode:@"InvalidToken" message:@"Token is null" details:nil];
      result(flutterError);
    }];
  } @catch (NSException *exception) {
    NSLog(@"[startPayment] an error occured: %@", exception);
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

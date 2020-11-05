/* 
  Order.md
  

  Created by Admin on 10/26/20.
  
*/

Initializes SDK

Initialize TamaraCheckout before using it:
```swift
TamaraCheckout(endpoint: String, token: String)
```

AUTH_TOKEN : "xxxxxx"

ENDPOINT: https://api-staging.tamara.co
```swift
//Handle redirect
TamaraMerchantURL(success: String,failure: String,cancel: String,notification: String)
 ```
Sets up order
Set customer's information:
```swift
let consumer = TamaraConsumer (
        firstName: String,
        lastName: String,
        phoneNumber: String,
        email: String,
        nationalID: String,
        dateOfBirth: String?,
        isFirstOrder: Bool?
    )
```
 

Add Item with its price, tax and discount:
```swift
TamaraItem(
      referenceID: UUID().uuidString,
      type: "Digital",
      name: item.name,
      sku: item.sku,
      quantity: 1,
      unitPrice: TamaraAmount(amount: String(format:"%f", item.price), currency: currency),
     discountAmount: TamaraAmount(amount: String(format:"%f", 0.0), currency: currency),
     taxAmount: TamaraAmount(amount: String(format:"%f", item.tax), currency: currency),
     totalAmount: TamaraAmount(amount: String(format:"%f", item.total), currency: currency)
)
```

Set shipping address and billing address:
```swift
let shippingAddress = TamaraAddress(
        firstName: String,
        lastName: String,
        line1: String,
        line2: String,
        region: String,
        city: String,
        countryCode: String,
        phoneNumber: String
    )
let billingAddress = TamaraAddress(
        firstName: String,
        lastName: String,
        line1: String,
        line2: String,
        region: String,
        city: String,
        countryCode: String,
        phoneNumber: String
```
Set shipping fee:
```swift
TamaraAmount (amount: String, currency: String)
```
 
Set discount (optional):
```swift
TamaraAmount (amount: String, currency: String)
```

Processes to Tamara payment page using:
```swift
func processCheckout(body: TamaraCheckoutRequestBody, checkoutComplete: @escaping (_ checkoutUrl: String) -> Void, checkoutFailed: @escaping (_ error: Error) -> Void)
```

 
Body request
```swift
let requestBody = TamaraCheckoutRequestBody(
            orderReferenceID: UUID().uuidString,
            totalAmount: totalAmountObject,
            description: "description",
            countryCode: countryCode,
            paymentType: "PAY_BY_LATER",
            locale: "en-US",
            items: itemList,
            consumer: consumer,
            billingAddress: billingAddress,
            shippingAddress: shippingAddress,
            discount: nil,
            taxAmount: taxAmountObject,
            shippingAmount: shippingAmountObject,
            merchantURL: merchantUrl,
            platform: "iOS",
            isMobile: true,
            riskAssessment: nil
        )
```        

Processing checkout and handle data returned from the SDK
```swift
tamaraCheckout.processCheckout(body: requestBody, checkoutComplete: { (checkoutUrl) in
          //TODO: Handler successful case

        }, checkoutFailed: { (error) in
          //TODO: Handler failed case

            print(error)
        })
```


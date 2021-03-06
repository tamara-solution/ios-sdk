# Tamara Example App

## Overview

This is an application to demo Tamara workflow for iOS

## 1. Install dependencies

* Install Cocoapods (https://cocoapods.org)
* Run following command to install latest SDK

  ```
  pod install
  ```
* To update the SDK, kindly run

  ```
  pod update
  ```
## 2. Run project

* Open `Example.xcworkspace`
* Build, run and enjoy

## 3. Develop

### 3.1 Workflow

The example app need to do these following tasks:

- Collect order data, send to Tamara API to create an order and get `checkout_url`
  - If success, then open `checkout_url` in a webview (within the app).
  - If fail, alert to user the failure reason.
- In case user finish all steps, and confirmed order, then trigger `checkoutComplete` callback function.
- In case user failed to complete checkout, or they press cancel / close the browser, then trigger `checkoutFailed` callback function.
- It's up to what the business want, the `checkoutComplete` and `checkoutFailed` could be customized.

Enough talking. Let's start coding!


### 3.1. Initializes SDK

Initialize TamaraCheckout before using it:
```swift
let tamaraCheckout = TamaraCheckout(endpoint: String, token: String)
```

`token`: The merchant authentication token we provided before, or you can re-generate via our partner portal.

`endpoint`:
* For sandbox environment https://api-sandbox.tamara.co
* For production environment https://api.tamara.co

### 3.2. Prepare the payload

First, the order need customer's information:
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

Then order item list:
```swift
let itemList = [
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
]
```

Do not forget shipping address and billing address:
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
)
```

Also order shipping fee and tax amount:
```swift
let shippingAmountObject = TamaraAmount(amount: String, currency: String)

let taxAmountObject = TamaraAmount(amount: String, currenct: string)
```

And discount (optional):
```swift
let discountObject = TamaraAmount(amount: String, currency: String)
```

Please keep in mind that we will need your callback URL so we could call your API and inform in case an order is success / or failed on our side, so don't forget to provide callback URLs:

```swift
let merchantUrl = TamaraMerchantURL(success: String, failure: String, cancel: String, notification: String)
 ```

Finally, build the payload:

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
    discount: discountObject,
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
tamaraCheckout.processCheckout(body: requestBody, checkoutComplete: { (checkoutSuccess) in
  //TODO: Handler successful case

}, checkoutFailed: { (checkoutError) in
  //TODO: Handler failed case
  //Can get error message using checkoutError.message
})
```

That's all! Congratulation!



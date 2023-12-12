## Tarama Pay SDK's requirements
To intergrate Tamara Pay SDK to your app, you need AUTH_TOKEN, API_URL and your server NOTIFICATION_WEBHOOK_URL:
```
let API_URL = "https://api-sandbox.tamara.co/"

let AUTH_TOKEN ="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

let NOTIFICATION_WEB_HOOK_URL = "https://your.site/pushnotification"

let PUBLISH_KEY = "e3eo6279-90c2-4239-b4e2-2c91bpodisjd"

let NOTIFICATION_TOKEN = "dede4a2-5f57-475e-a384-9o d9b8a803487"

val isSandbox: sandbox/production account
if sandbox account: isSandbox = true
if production account: isSandbox = false
```

## Initializes SDK
Initialize TamaraPayment before using it:
```
TamaraPayment.initialize(AUTH_TOKEN, API_URL, NOTIFICATION_WEB_HOOK_URL, PUBLISH_KEY, NOTIFICATION_TOKEN, isSandbox)
```

## Create and pay order
Before adding order's information, create Order by call this method with referenceOrderId and description.
RefId is your unique id of your order.
```
TamaraPayment.createOrder(referenceOrderId, description)
```

### These informations are mandatory:

Set customer's information:
```
TamaraPayment.setCustomerInfo(firstName, lastName,
            phoneNumber, email, isFirstOrder)
```

Set payment type (optional: default: PAY_BY_INSTALMENTS):
```
TamaraPayment.setPaymentType(paymentType)
```

Add Item with its price, tax and discount:
```
TamaraPayment.addItem(name, referenceId ,sku, type, unitPrice,
                    taxAmount ,discountAmount, quantity)
```

Set shipping address and billing address:
```
TamaraPayment.setShippingAddress(firstName,lastName, phone,
                    addressLine1, addressLine2, country, region, city)
TamaraPayment.setBillingAddress(firstName,lastName, phone,
                    addressLine1, addressLine2, country, region, city)
```

Set shipping fee:
```
TamaraPayment.setShippingAmount(shippingFee)
```

Set discount (optional):
```
TamaraPayment.setDiscount(discount, name)
```

Set instalments:
```
TamaraPayment.setInstalments(instalments)
```

Processes to Tamara payment page using:
```
TamaraPayment.startPayment()
```

## Order detail
Get order detail
param mandatory: orderId
```
TamaraPayment.getOrderDetail(orderId)
```
Example:
Response:
```
OrderDetail(billingAddress=AddressDetail(firstName=Mona, lastName=Lisa, phoneNumber=966502223337, line1=3764 Al Urubah Rd, line2=, countryCode=SA, region=As Sulimaniyah, city=Riyadh), consumer=ConsumerDetail(firstName=Mona, lastName=Lisa, phoneNumber=966502223333, email=user@example.com, isFirstOrder=true, dateOfBirth=2023-04-14, nationalId=), countryCode=SA, description=Description, status=expired, discount=null, items=[ItemDetail(name=Lego City 8601, referenceId=123456_item, sku=SA-12436, unitPrice=AmountDetail(amount=50.0, currency=SAR), quantity=1, discountAmount=AmountDetail(amount=25.0, currency=SAR), taxAmount=AmountDetail(amount=10.0, currency=SAR), totalAmount=AmountDetail(amount=35.0, currency=SAR), imageUrl=, itemUrl=), ItemDetail(name=Batman, referenceId=123457_item, sku=SA-12437, unitPrice=AmountDetail(amount=75.0, currency=SAR), quantity=1, discountAmount=AmountDetail(amount=25.0, currency=SAR), taxAmount=AmountDetail(amount=10.0, currency=SAR), totalAmount=AmountDetail(amount=60.0, currency=SAR), imageUrl=, itemUrl=), ItemDetail(name=Spider man, referenceId=123458_item, sku=SA-12438, unitPrice=AmountDetail(amount=25.0, currency=SAR), quantity=1, discountAmount=AmountDetail(amount=5.0, currency=SAR), taxAmount=AmountDetail(amount=10.0, currency=SAR), totalAmount=AmountDetail(amount=30.0, currency=SAR), imageUrl=, itemUrl=), ItemDetail(name=Thor, referenceId=123459_item, sku=SA-12439, unitPrice=AmountDetail(amount=200.0, currency=SAR), quantity=1, discountAmount=AmountDetail(amount=25.0, currency=SAR), taxAmount=AmountDetail(amount=10.0, currency=SAR), totalAmount=AmountDetail(amount=185.0, currency=SAR), imageUrl=, itemUrl=), ItemDetail(name=Iron man, referenceId=123460_item, sku=SA-12460, unitPrice=AmountDetail(amount=500.0, currency=SAR), quantity=1, discountAmount=AmountDetail(amount=0.0, currency=SAR), taxAmount=AmountDetail(amount=10.0, currency=SAR), totalAmount=AmountDetail(amount=510.0, currency=SAR), imageUrl=, itemUrl=)], locale=en-US, merchantUrl=MerchantUrlDetail(notification=tamara://checkout/notification, cancel=tamara://checkout/cancel, failure=tamara://checkout/failure, success=tamara://checkout/success), orderReferenceId=123, orderId=9af217f1-9e4a-400e-9e06-2b7f4f40687e, orderNumber=123, paymentType=PAY_BY_INSTALMENTS, shippingAddress=AddressDetail(firstName=Mona, lastName=Lisa, phoneNumber=966502223337, line1=3764 Al Urubah Rd, line2=, countryCode=SA, region=As Sulimaniyah, city=Riyadh), shippingAmount=AmountDetail(amount=20.0, currency=SAR), taxAmount=AmountDetail(amount=50.0, currency=SAR), totalAmount=AmountDetail(amount=840.0, currency=SAR), capturedAmount=AmountDetail(amount=0.0, currency=SAR), refundedAmount=AmountDetail(amount=0.0, currency=SAR), canceledAmount=AmountDetail(amount=0.0, currency=SAR), paidAmount=AmountDetail(amount=0.0, currency=SAR), walletPrepaidAmount=AmountDetail(amount=0.0, currency=SAR), platform=Android, settlementStatus=, storeCode=, createdAt=2023-04-14T16:49:59+00:00, isMobile=true, processing=false, instalments=3)
```

## Authorise order
Merchant will be required to call the Authorize API the order after receiving the notification from Tamara about the order being 'Approved'.
Authorise order by call this method with orderId.
param mandatory: orderId
```
TamaraPayment.authoriseOrder(orderId)
```
Example:
Response:
```
AuthoriseOrder(orderId=9af217f1-9e4a-400e-9e06-2b7f4f40687e, status=authorised, orderExpiryTime="2019-08-24T14:15:22Z", paymentType="PAY_BY_INSTALMENTS",
autoCaptured=false)
```

## Cancel order
Merchant will be required to call the Cancel in case the order has been cancelled either by the customer or merchant before the order shipment.
Note: Need call authorise order method before call cancel order
Cancel order reference by call this method with orderId and jsonData.

param mandatory: orderId
jsonData: use library convert class CancelOrder to json (Gson)
```
class CancelOrder (
     @SerializedName("discount_amount") var discountAmount: Amount? = null,
    var items: ArrayList<'Item'> = arrayListOf(),
    @SerializedName("shipping_amount") var shippingAmount: Amount? = null,
    @SerializedName("tax_amount") var taxAmount: Amount? = null,
    @SerializedName("total_amount") var totalAmount: Amount? = null
)
```
class Amount(
    var amount: Double = 0.0, // 50.00
    var currency: String? = "" // SAR
)
class Item(
    var name: String = "", // Lego City 8601
    @SerializedName("reference_id") var referenceId: String = "", // 123456
    var sku: String = "", // SA-12436
    var type: String = "", // SA-12436
    @SerializedName("unit_price") var unitPrice: Amount? = null,
    var quantity: Int = 0, // 1
    @SerializedName("discount_amount") var discountAmount: Amount? = null,
    @SerializedName("tax_amount") var taxAmount: Amount? = null,
    @SerializedName("total_amount") var totalAmount:Amount? = null,
    @SerializedName("image_url") var imageUrl: String? = null,
    @SerializedName("item_url") var itemUrl: String? = null
)
```
TamaraPayment.cancelOrder(orderId, jsonData)
```
Example:
Response:
```
Response:
CancelOrderResponse(captureId=5ed77aa5-0c93-4f0d-8435-fb91f5939a82, orderId=9af217f1-9e4a-400e-9e06-2b7f4f40687e)
```

## Update order reference
In case Merchant creates the order after it is authorised (i.e. confirmation of successful payment) then the Update order should be used to update the Order ID.
Update order reference by call this method with orderId and orderReference.

param mandatory: orderId, orderReference
```
TamaraPayment.updateOrderReference(orderId, orderReference)
```
Example:
```
Response:
OrderReference(message=Order reference id was updated successfully)
```

## Capture a payment
Merchants can partially or fully capture an order after the order is shipped to the customer depending on partial shipment or full shipment.
Note: Need call authorise order method before call capture a payment
Cancel order reference by call this method with orderId and jsonData.

param mandatory: orderId
jsonData: use library convert class CancelOrder to json (Gson)

```
class CapturePaymentRequest(
    @SerializedName("order_id") var orderId: String? = null,
    @SerializedName("billing_address") var billingAddress: Address? = null,
    @SerializedName("discount_amount") var discountAmount: Amount? = null,
    var items: ArrayList<Item> = arrayListOf(),
    @SerializedName("shipping_address") var shippingAddress: Address? = null,
    @SerializedName("shipping_amount") var shippingAmount: Amount? = null,
    @SerializedName("tax_amount") var taxAmount: Amount? = null,
    @SerializedName("total_amount") var totalAmount: Amount? = null,
    @SerializedName("shipping_info") var shippingInfo: ShippingInfo? = null
)
```
class Address(
    @SerializedName("first_name") var firstName: String = "",
    @SerializedName("last_name") var lastName: String = "",
    @SerializedName("phone_number") var phoneNumber: String = "",
    var line1: String = "",
    var line2: String = "",
    @SerializedName("country_code") var countryCode: String = "",
    var region: String = "",
    var city: String = ""
)

class ShippingInfo (
    @SerializedName("shipped_at") var shippedAt: String? = "",
    @SerializedName("shipping_company") var shippingCompany: String? = "",
    @SerializedName("tracking_number") var trackingNumber: String? = "",
    @SerializedName("tracking_url") var trackingUrl: String? = ""
)
Amount(
    var amount: Double = 0.0, // 50.00
    var currency: String? = "" // SAR
)
```
TamaraPayment.getCapturePayment(this, jsonData)
```
Example:
Response:
```
CapturePayment(captureId=5ed77aa5-0c93-4f0d-8435-fb91f5939a82, orderId=9af217f1-9e4a-400e-9e06-2b7f4f40687e)
```

## Refunds
Cancel order reference by call this method with orderId and jsonData.
Note: Need call authorise order method before call Refunds

param mandatory: orderId
jsonData: use library convert class CancelOrder to json (Gson)
```
class PaymentRefund (
    @SerializedName("comment") var comment: String? = null,
    @SerializedName("total_amount") var totalAmount: EAmount? = null
)
```
class Amount(
    var amount: Double = 0.0, // 50.00
    var currency: String? = "" // SAR
)
```
TamaraPayment.refunds(orderId, jsonData)
```
Example:
Response:
```
RefundsResponse(captureId=5ed77aa5-0c93-4f0d-8435-fb91f5939a82, orderId=9af217f1-9e4a-400e-9e06-2b7f4f40687e,refundId=0a17d40a-6180-4f4b-ba7c-498ae79e30dc,comment=Refund)
```

## Render widget cart page
Render widget cart page reference by call this method with language, country, publicKey, amount.
param mandatory: language, country, publicKey, amount

```
TamaraPayment.renderWidgetCartPage(language, country, publicKey, amount)
```
Example:
Response:
```
CartPage(script=<script>
        window.tamaraWidgetConfig = {
            lang: "en",
            country: "SA",
            publicKey: "d36c6279-90c2-4239-b4e2-2c91bfda0fe4"
        }
      </script>
      <script defer type="text/javascript" src="https://cdn-sandbox.tamara.co/widget-v2/tamara-widget.js"></script>

      
      <tamara-widget type="tamara-summary" amount="250.0" inline-type="3"></tamara-widget>, url=https://cdn-sandbox.tamara.co/widget-v2/tamara-widget.html?lang=en&public_key=d36c6279-90c2-4239-b4e2-2c91bfda0fe4&country=SA&amount=250.0&inline_type=3)
```
## Render widget product
Render widget product reference by call this method with language, country, publicKey, amount.
param mandatory: language, country, publicKey, amount

```
TamaraPayment.renderWidgetProduct(language, country, publicKey, amount)
```
Example:
Response:
```
Product(script=<script>
        window.tamaraWidgetConfig = {
            lang: "en",
            country: "SA",
            publicKey: "d36c6279-90c2-4239-b4e2-2c91bfda0fe4"
        }
      </script>
      <script defer type="text/javascript" src="https://cdn-sandbox.tamara.co/widget-v2/tamara-widget.js"></script>

      
      <tamara-widget type="tamara-summary" amount="250.0" inline-type="3"></tamara-widget>, url=https://cdn-sandbox.tamara.co/widget-v2/tamara-widget.html?lang=en&public_key=d36c6279-90c2-4239-b4e2-2c91bfda0fe4&country=SA&amount=250.0&inline_type=2)
```	
@file:Suppress("NAME_SHADOWING")

package com.deytri.midtrans_plugin

import android.app.Activity
import android.app.Activity.RESULT_OK
import android.content.Context
import android.content.Intent
import androidx.activity.ComponentActivity
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import com.midtrans.sdk.uikit.api.model.Address
import com.midtrans.sdk.uikit.api.model.Authentication
import com.midtrans.sdk.uikit.api.model.BankTransferRequest
import com.midtrans.sdk.uikit.api.model.CreditCard
import com.midtrans.sdk.uikit.api.model.CustomerDetails
import com.midtrans.sdk.uikit.api.model.Expiry
import com.midtrans.sdk.uikit.api.model.GopayPaymentCallback
import com.midtrans.sdk.uikit.api.model.ItemDetails
import com.midtrans.sdk.uikit.api.model.PaymentCallback
import com.midtrans.sdk.uikit.api.model.SnapTransactionDetail
import com.midtrans.sdk.uikit.api.model.TransactionResult
import com.midtrans.sdk.uikit.external.UiKitApi
import com.midtrans.sdk.uikit.internal.util.UiKitConstants
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** MidtransPlugin */
class MidtransPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
	/// The MethodChannel that will the communication between Flutter and native Android
	///
	/// This local reference serves to register the plugin with the Flutter Engine and unregister it
	/// when the Flutter Engine is detached from the Activity
	private lateinit var channel: MethodChannel
	private lateinit var context: Context
	private lateinit var launcher: ActivityResultLauncher<Intent>

	private var activity: Activity? = null

	private var gopayCallbackUrl: String? = null
	private var shopeeCallbackUrl: String? = null

	private var permataVa: BankTransferRequest? = null
	private var bcaVa: BankTransferRequest? = null
	private var bniVa: BankTransferRequest? = null
	private var creditcardOptions: CreditCard? = null


	override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
		channel = MethodChannel(flutterPluginBinding.binaryMessenger, "midtrans_plugin")
		channel.setMethodCallHandler(this)
		context = flutterPluginBinding.applicationContext
	}

	override fun onMethodCall(call: MethodCall, result: Result) {
		when (call.method) {
			"initialize" -> initialize(call, result)
			"startPayment" -> startPayment(call, result)
			else -> result.notImplemented()
		}
	}

	override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
		channel.setMethodCallHandler(null)
	}

	override fun onAttachedToActivity(binding: ActivityPluginBinding) {
		activity = binding.activity

		launcher = (activity as ComponentActivity).registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
			if (result.resultCode == RESULT_OK) {
				val transactionResult = result.data?.getParcelableExtra<TransactionResult>(UiKitConstants.KEY_TRANSACTION_RESULT)

				val arguments = mutableMapOf<String, Any?>()
				if (transactionResult != null) {
					arguments["statusMessage"] = transactionResult.message
					arguments["transactionId"] = transactionResult.transactionId
					arguments["paymentType"] = transactionResult.paymentType
					arguments["transactionStatus"] = transactionResult.status

					if (transactionResult.status == "canceled") {
						arguments["isCanceled"] = true
					}
				}

				channel.invokeMethod("onTransactionResult", arguments)
			}
		}
	}

	override fun onDetachedFromActivityForConfigChanges() {
		channel.setMethodCallHandler(null)
	}

	override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
		activity = binding.activity as FlutterActivity
	}

	override fun onDetachedFromActivity() {
		channel.setMethodCallHandler(null)
	}

	private fun initialize(call: MethodCall, result: Result) {
		try {
			val clientKey: String = call.argument<String>("merchantClientKey")!!
			val baseUrl: String = call.argument<String>("merchantUrl")!!
			val enableLog: Boolean = call.argument<Boolean>("enableLog") ?: false
			val gopayCallbackUrl: String? = call.argument<String>("gopayCallbackUrl")
			val shopeeCallbackUrl: String? = call.argument<String>("shopeeCallbackUrl")
			val permataVa: Map<String, Any>? = call.argument("permataVa")
			val bcaVa: Map<String, Any>? = call.argument("bcaVa")
			val bniVa: Map<String, Any>? = call.argument("bniVa")
			val paymentTypeConfig: String? = call.argument("paymentTypeConfig")

			gopayCallbackUrl?.let {
				this.gopayCallbackUrl = it
			}

			shopeeCallbackUrl?.let {
				this.shopeeCallbackUrl = it
			}

			permataVa?.let {
				val vaNumber: String = it["vaNumber"] as String
				val recipientName: String? = it["recipientName"] as String?
				this.permataVa = BankTransferRequest(vaNumber, null, null, recipientName)
			}

			bcaVa?.let {
				val vaNumber: String = it["vaNumber"] as String
				val subCompanyCode: String? = it["subCompanyCode"] as String?
				this.bcaVa = BankTransferRequest(vaNumber, null, subCompanyCode, null)
			}

			bniVa?.let {
				val vaNumber: String = it["vaNumber"] as String
				this.bniVa = BankTransferRequest(vaNumber, null, null, null)
			}

			paymentTypeConfig?.let {
				creditcardOptions = CreditCard(saveCard = true)

				if (it == "oneClickPayment") {
					creditcardOptions = CreditCard(saveCard = true, authentication = Authentication.AUTH_3DS)
				}
			}

			UiKitApi.Builder()
					.withMerchantClientKey(clientKey)
					.withContext(context)
					.withMerchantUrl(baseUrl)
					.enableLog(enableLog)
					.build()

			result.success(true)
		} catch (e: Exception) {
			result.error("InternalError", "Cannot initialize", e)
		}
	}

	private fun startPayment(call: MethodCall, result: Result) {
		try {
			val transactionDetailsJson = call.argument<Map<String, Any>>("transactionDetails")
					?: return result.error("InvalidArgs", "transactionDetails must not null", null)

			val itemDetailsJson = call.argument<List<Map<String, Any>>>("itemDetails")
					?: return result.error("InvalidArgs", "itemDetails must not null", null)

			val customerDetailsJson = call.argument<Map<String, Any>?>("customerDetails")
			val expiryJson = call.argument<Map<String, Any>?>("expiry")

			val transactionDetails = SnapTransactionDetail(
					orderId = transactionDetailsJson["orderId"] as String,
					grossAmount = transactionDetailsJson["grossAmount"] as Double,
					currency = "IDR",
			)
			val itemDetails = itemDetailsJson.map { json ->
				ItemDetails(
						id = json["id"] as String?,
						price = json["price"] as Double,
						quantity = json["quantity"] as Int,
						name = json["name"] as String,
				)
			}

			val customerDetails = customerDetailsJson?.let {
				val firstName: String? = it["firstName"] as String?
				val lastName: String? = it["lastName"] as String?
				val email: String? = it["email"] as String?
				val phone: String? = it["phone"] as String?

				val billingAddress: Address? = (it["billingAddress"] as Map<*, *>?)?.let { json ->
					val firstName: String? = json["firstName"] as String?
					val lastName: String? = json["lastName"] as String?
					val phone: String? = json["phone"] as String?
					val address: String? = json["address"] as String?
					val city: String? = json["city"] as String?
					val postalCode: String? = json["postalCode"] as String?
					Address(firstName, lastName, address, city, postalCode, phone, "IDN")
				}

				val shippingAddress: Address? = (it["billingAddress"] as Map<*, *>?)?.let { json ->
					val firstName: String? = json["firstName"] as String?
					val lastName: String? = json["lastName"] as String?
					val phone: String? = json["phone"] as String?
					val address: String? = json["address"] as String?
					val city: String? = json["city"] as String?
					val postalCode: String? = json["postalCode"] as String?
					Address(firstName, lastName, address, city, postalCode, phone, "IDN")
				}

				CustomerDetails(null, firstName, lastName, email, phone, shippingAddress, billingAddress)
			}

			val expiry = expiryJson?.let {
				val startTime = it["startTime"] as String
				val unit = when (it["unit"] as String) {
					"minutes" -> Expiry.UNIT_MINUTE
					"hours" -> Expiry.UNIT_HOUR
					else -> Expiry.UNIT_DAY
				}

				val duration = it["duration"] as Int

				Expiry(startTime, unit, duration)
			}


			var gopayPaymentCallback: GopayPaymentCallback? = null
			gopayCallbackUrl?.let {
				gopayPaymentCallback = GopayPaymentCallback(it)
			}

			var shoppePaymentCallback: PaymentCallback? = null
			shopeeCallbackUrl?.let {
				shoppePaymentCallback = PaymentCallback(it)
			}

			var permataVa: BankTransferRequest? = null
			this.permataVa?.let {
				permataVa = it
			}

			var bcaVa: BankTransferRequest? = null
			this.bcaVa?.let {
				bcaVa = it
			}

			var bniVa: BankTransferRequest? = null
			this.bniVa?.let {
				bniVa = it
			}

			activity?.let {
				UiKitApi.getDefaultInstance().startPaymentUiFlow(
						activity = it,
						launcher = launcher,
						transactionDetails = transactionDetails,
						itemDetails = itemDetails,
						customerDetails = customerDetails,
						gopayCallback = gopayPaymentCallback,
						shopeepayCallback = shoppePaymentCallback,
						permataVa = permataVa,
						bcaVa = bcaVa,
						bniVa = bniVa,
						snapTokenExpiry = expiry
				)

				result.success(null)

			} ?: result.error("ACTIVITY_NULL", "Activity is null", null)

		} catch (e: Exception) {
			result.error("InternalError", "Cannot start payment", e)
		}
	}
}

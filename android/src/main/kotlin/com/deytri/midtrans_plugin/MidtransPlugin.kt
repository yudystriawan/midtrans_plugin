package com.deytri.midtrans_plugin

import android.app.Activity
import android.app.Activity.RESULT_OK
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import com.midtrans.sdk.uikit.api.model.ItemDetails
import com.midtrans.sdk.uikit.api.model.SnapTransactionDetail
import com.midtrans.sdk.uikit.api.model.TransactionResult
import com.midtrans.sdk.uikit.api.model.UiKitSetting
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

	@Suppress("DEPRECATION")
	override fun onAttachedToActivity(binding: ActivityPluginBinding) {
		activity = binding.activity

		launcher = (activity as ComponentActivity).registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
			if (result?.resultCode == RESULT_OK) {
				result.data?.let {
					val transactionResult = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
						it.getParcelableExtra(UiKitConstants.KEY_TRANSACTION_RESULT, TransactionResult::class.java)
					} else {
						it.getParcelableExtra(UiKitConstants.KEY_TRANSACTION_RESULT)
					}
					Log.d("[Transaction Result]", "${transactionResult?.transactionId.let { id -> "TransactionID: $id" }} ${transactionResult?.status}")
					val arguments = mapOf("message" to transactionResult?.message, "paymentType" to transactionResult?.paymentType, "status" to transactionResult?.status, "transactionId" to transactionResult?.transactionId)
					channel.invokeMethod("transactionResult", arguments)
				}
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

			if (clientKey.isBlank() || baseUrl.isBlank()) {
				result.error("InvalidArgs", "clientKey or baseUrl must not empty.", "client key or baseUrl is empty")
				return
			}

			UiKitApi.Builder()
					.withMerchantClientKey(clientKey)
					.withContext(context)
					.withMerchantUrl(baseUrl)
					.enableLog(enableLog)
					.build()

			setCustomSetting()

			result.success(true)
		} catch (e: Exception) {
			result.error("InternalError", "Cannot initialize", e)
		}
	}

	private fun setCustomSetting() {
		val uiKitSetting: UiKitSetting = UiKitApi.getDefaultInstance().uiKitSetting
		uiKitSetting.saveCardChecked = true
	}

	private fun startPayment(call: MethodCall, result: Result) {
		try {
			val transactionDetailsJson = call.argument<Map<String, Any>>("transactionDetails")
					?: return result.error("InvalidArgs", "transactionDetails must not null", null)

			val itemDetailsJson = call.argument<List<Map<String, Any>>>("itemDetails")
					?: return result.error("InvalidArgs", "itemDetails must not null", null)

			val transactionDetails = SnapTransactionDetail(
					orderId = transactionDetailsJson["orderId"] as String,
					grossAmount = transactionDetailsJson["grossAmount"] as Double,
					currency = transactionDetailsJson["currency"] as String,
			)
			val itemDetails = itemDetailsJson.map { json ->
				ItemDetails(
						id = json["id"] as String?,
						price = json["price"] as Double,
						quantity = json["quantity"] as Int,
						name = json["name"] as String,
				)
			}

			activity?.let { currentActivity ->
				UiKitApi.getDefaultInstance().startPaymentUiFlow(
						activity = currentActivity,
						launcher = launcher,
						transactionDetails = transactionDetails,
						itemDetails = itemDetails,
				)

				result.success(null)

			} ?: result.error("ACTIVITY_NULL", "Activity is null", null)

		} catch (e: Exception) {
			result.error("InternalError", "Something went wrong", e)
		}
	}
}

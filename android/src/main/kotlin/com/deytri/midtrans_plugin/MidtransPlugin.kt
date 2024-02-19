package com.deytri.midtrans_plugin

import android.app.Activity
import android.app.Activity.RESULT_OK
import android.content.Context
import android.content.Intent
import android.util.Log
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContract
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.os.LocaleListCompat
import com.midtrans.sdk.uikit.external.UiKitApi
import com.midtrans.sdk.uikit.api.model.CustomColorTheme
import com.midtrans.sdk.uikit.api.model.ItemDetails
import com.midtrans.sdk.uikit.api.model.SnapTransactionDetail
import com.midtrans.sdk.uikit.api.model.TransactionResult
import com.midtrans.sdk.uikit.api.model.UiKitSetting
import com.midtrans.sdk.uikit.internal.util.UiKitConstants
import com.midtrans.sdk.uikit.internal.util.UiKitConstants.STATUS_CANCELED
import com.midtrans.sdk.uikit.internal.util.UiKitConstants.STATUS_FAILED
import com.midtrans.sdk.uikit.internal.util.UiKitConstants.STATUS_INVALID
import com.midtrans.sdk.uikit.internal.util.UiKitConstants.STATUS_PENDING
import com.midtrans.sdk.uikit.internal.util.UiKitConstants.STATUS_SUCCESS
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener
import java.util.UUID


/** MidtransPlugin */
class MidtransPlugin : FlutterPlugin, MethodCallHandler, ActivityAware, ActivityResultListener {
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

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity

        binding.addActivityResultListener(this)

        launcher = (activity as ComponentActivity).registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
            if (result?.resultCode == RESULT_OK) {
                result.data?.let {
                    val transactionResult = it.getParcelableExtra<TransactionResult>(UiKitConstants.KEY_TRANSACTION_RESULT)
                    Toast.makeText(context, "${transactionResult?.transactionId}", Toast.LENGTH_LONG).show()
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
        val clientKey: String = "SB-Mid-client-V8p1M-DRoTXmhvsz"
        val baseUrl: String = "https://midtrans-server.web.app/api/"

        UiKitApi.Builder()
                .withMerchantClientKey(clientKey)
                .withContext(context)
                .withMerchantUrl(baseUrl)
                .enableLog(true)
                .withColorTheme(CustomColorTheme("#FFE51255", "#B61548", "#FFE51255"))
                .build()

        setCustomSetting()

        result.success(true)
    }

    private fun setCustomSetting() {
        val uiKitSetting: UiKitSetting = UiKitApi.getDefaultInstance().uiKitSetting
        uiKitSetting.saveCardChecked = true
    }

    private fun startPayment(call: MethodCall, result: Result) {
        activity?.let { currentActivity ->
            val itemDetails = listOf<ItemDetails>(ItemDetails("Test_01", 1.0, 1, "Product Test"))

            UiKitApi.getDefaultInstance().startPaymentUiFlow(
                    activity = currentActivity,
                    launcher = launcher,
                    transactionDetails = SnapTransactionDetail(UUID.randomUUID().toString(), 1.0, "IDR"),
                    itemDetails = itemDetails,
            )

            result.success(null)

        } ?: result.error("ACTIVITY_NULL", "Activity is null", null)

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (resultCode == RESULT_OK) {
            val transactionResult = data?.getParcelableExtra<TransactionResult>(
                    UiKitConstants.KEY_TRANSACTION_RESULT
            )
            if (transactionResult != null) {
                when (transactionResult.status) {
                    STATUS_SUCCESS -> {
                        Log.d("[Transaction Result]", "${transactionResult.status}: ${transactionResult.transactionId}")
                        Toast.makeText(context, "Transaction Finished. ID: " + transactionResult.transactionId, Toast.LENGTH_LONG).show()
                    }

                    STATUS_PENDING -> {
                        Log.d("[Transaction Result]", "${transactionResult.status}: ${transactionResult.transactionId}")
                        Toast.makeText(context, "Transaction Pending. ID: " + transactionResult.transactionId, Toast.LENGTH_LONG).show()
                    }

                    STATUS_FAILED -> {
                        Log.d("[Transaction Result]", "${transactionResult.status}: ${transactionResult.transactionId}")

                        Toast.makeText(context, "Transaction Failed. ID: " + transactionResult.transactionId, Toast.LENGTH_LONG).show()
                    }

                    STATUS_CANCELED -> {
                        Log.d("[Transaction Result]", "${transactionResult.status}: ${transactionResult.transactionId}")

                        Toast.makeText(context, "Transaction Cancelled", Toast.LENGTH_LONG).show()
                    }

                    STATUS_INVALID -> {
                        Log.d("[Transaction Result]", "${transactionResult.status}: ${transactionResult.transactionId}")

                        Toast.makeText(context, "Transaction Invalid. ID: " + transactionResult.transactionId, Toast.LENGTH_LONG).show()
                    }

                    else -> {
                        Log.d("[Transaction Result]", "${transactionResult.status}: ${transactionResult.transactionId}")

                        Toast.makeText(context, "Transaction ID: " + transactionResult.transactionId + ". Message: " + transactionResult.status, Toast.LENGTH_LONG).show()
                    }
                }
            } else {
                Log.d("[Transaction Result]", "Transaction Invalid")
                Toast.makeText(context, "Transaction Invalid", Toast.LENGTH_LONG).show()
            }
        }
        return true;
    }

}

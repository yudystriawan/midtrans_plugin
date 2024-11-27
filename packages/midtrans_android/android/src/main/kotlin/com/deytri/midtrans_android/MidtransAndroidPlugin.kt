package com.deytri.midtrans_android

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.IntentCompat.getParcelableExtra
import com.deytri.midtrans_android.models.MidtransConfig
import com.google.gson.Gson
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

/** MidtransAndroidPlugin */
class MidtransAndroidPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var launcher: ActivityResultLauncher<Intent>
    private lateinit var activity: Activity

    private val gson: Gson = Gson()

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "midtrans_plugin")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "initialize" -> initialize(call, result)
            "checkout" -> checkout(call, result)
            else -> result.notImplemented()
        }
    }

    private fun checkout(call: MethodCall, result: Result) {
        try {
            val snapToken: String = call.argument<String>("snapToken")!!
            print(snapToken)
            UiKitApi.getDefaultInstance().startPaymentUiFlow(activity, launcher, snapToken)
        } catch (e: Exception) {
            result.error("Internal Error", e.message, e)
        }
    }

    private fun initialize(call: MethodCall, result: Result) {
        try {
            val json = gson.toJson(call.argument<Map<String, Any>>("config"))

            val config: MidtransConfig =
                gson.fromJson(json, MidtransConfig::class.java)

            UiKitApi.Builder()
                .withMerchantClientKey(config.clientKey)
                .withContext(context)
                .withMerchantUrl(config.baseUrl)
                .enableLog(config.enableLog)
                .build()

            result.success(null)

        } catch (e: Exception) {
            result.error("Internal Error", e.message, e)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity

        launcher =
            (activity as ComponentActivity).registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
                if (result.resultCode == Activity.RESULT_OK) {
                    result.data?.let {
                        val response = getParcelableExtra(
                            it,
                            UiKitConstants.KEY_TRANSACTION_RESULT,
                            TransactionResult::class.java
                        )
                        Toast.makeText(
                            context,
                            "${response?.transactionId} ${response?.status}",
                            Toast.LENGTH_SHORT
                        ).show()
                        channel.invokeMethod("onSuccess", response)
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
}

package com.deytri.midtrans_android

import android.content.Context
import androidx.annotation.NonNull
import com.google.gson.Gson
import com.midtrans.sdk.uikit.external.UiKitApi

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.withContext

/** MidtransAndroidPlugin */
class MidtransAndroidPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "midtrans_plugin")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "initialize" -> initialize(call, result)
            else -> result.notImplemented()
        }
    }

    private fun initialize(call: MethodCall, result: Result) {
        try {
            val config: MidtransConfig =
                Gson().fromJson(call.argument<String>("config"), MidtransConfig::class.java)

            UiKitApi.Builder()
                .withMerchantClientKey(config.clientKey)
                .withContext(context)
                .withMerchantUrl(config.baseUrl)
                .enableLog(config.enableLog)
                .build()
            
        } catch (e: Exception) {
            result.error("Internal Error", e.message, e)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}

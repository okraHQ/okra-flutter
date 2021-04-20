package com.example.okra_widget

import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import com.example.okra_widget.interfaces.BankServices
import com.example.okra_widget.models.IntentData
import com.example.okra_widget.services.USSDActionDeterminer
import com.example.okra_widget.services.USSDActionDeterminerImpl
import com.example.okra_widget.utils.BankUtils
import com.example.okra_widget.utils.PaymentUtils
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.hover.sdk.api.Hover
import com.hover.sdk.permissions.PermissionHelper
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener
import io.flutter.plugin.common.PluginRegistry.Registrar
import org.json.JSONArray
import org.json.JSONObject
import java.lang.reflect.Type


/** OkraWidgetPlugin */
class OkraWidgetPlugin: FlutterPlugin, MethodCallHandler,ActivityAware,ActivityResultListener {
  private lateinit var context: Context
  private lateinit var activity: Activity
  private var activityPluginBinding: ActivityPluginBinding? = null
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var ussdActionDeterminer: USSDActionDeterminer? = null
  var generalmapOkraOptions: MutableMap<String, Any>? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "okra_widget")
    channel.setMethodCallHandler(this)


  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity;
    binding.addActivityResultListener(this)
    ussdActionDeterminer = USSDActionDeterminerImpl(activity)
  }
  override fun onDetachedFromActivity() {
    activityPluginBinding?.removeActivityResultListener(this)
    activityPluginBinding = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }
  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

    when(call.method){
      "getPlatformVersion" -> result.success("New Android Channel 30")
      "testFunction" -> result.success("Test Function")
      "initOptions" -> {
        val options:String  = call.argument("text") ?: ""
        val type: Type = object : TypeToken<MutableMap<String, Any>>() {}.type
        val myMap: MutableMap<String, Any> = Gson().fromJson(options, type)
        println("HERE IS THE MAP $myMap")
        generalmapOkraOptions = myMap
        result.success(null)
      }
      "initHover" ->{
        Hover.initialize(activity)
        result.success(null)
      }
      "permissionOn" -> {
        var value = false
        val permission:String  = call.argument("text") ?: ""
        when (permission) {
          "message", "messages" -> {
            value = PermissionHelper(context).hasSmsPerm()
            result.success(value)
          }
          "accessibility" -> {
            val ph = PermissionHelper(context)
            value = ph.hasAccessPerm() && ph.hasBasicPerms() && ph.hasPhonePerm() && ph.hasOverlayPerm()
            result.success(value)

          }
          else -> result.success(false)
        }
      }
      "switchPermissionOn" -> {
        val permission:String  = call.argument("text") ?: ""
        val ph = PermissionHelper(context)
        if (permission == "message" || permission == "messages") {
          if (!ph.hasBasicPerms()) {
            ph.requestBasicPerms(activity, 1)
          }
          if (!ph.hasPhonePerm()) {
            ph.requestPhone(activity, 1)
          }
        } else {
          if (!ph.hasAccessPerm()) {
            ph.requestAccessPerm()
          }
          if (!ph.hasOverlayPerm()) {
            ph.requestOverlayPerm()
          }
        }
        result.success(null)
      }
      "openUSSD" -> {
        val json:String = call.argument("text") ?: ""
        try {
          val jsonObject = JSONObject(json)
          val payment = if (jsonObject.has("payment")) jsonObject.getString("payment") else "false"
          val options  =  try {
            if (jsonObject.has("options")) jsonObject.getJSONObject("options").toString() else ""
          }catch (ex:Exception){
            ""
          }
          val bankSlug = jsonObject.getJSONObject("bank").getString("slug")
          val bgColor = jsonObject.getJSONObject("bank").getString("bg")
          val accentColor = jsonObject.getJSONObject("bank").getString("accent")
          val buttonColor = jsonObject.getJSONObject("bank").getString("button")
          val pin = if (jsonObject.has("pin")) if (jsonObject.getString("pin").trim { it <= ' ' }.isEmpty()) "" else jsonObject.getString("pin") else ""
          val nuban = if (jsonObject.has("account")) jsonObject.getJSONObject("account").getString("number").trim { it <= ' ' } else ""
          val recordId = if (jsonObject.has("record")) jsonObject.getString("record") else ""
          val bankServices: BankServices = BankUtils.getBankImplementation(bankSlug)
          PaymentUtils.currentBankService = bankServices
          PaymentUtils.lastPaymentAction = false
          PaymentUtils.paymentConfirmed = true
          PaymentUtils.bankSlug = bankSlug
          PaymentUtils.bgColor = bgColor
          PaymentUtils.accentColor = accentColor
          PaymentUtils.options = options
          PaymentUtils.buttonColor = buttonColor
          PaymentUtils.pin = pin
          PaymentUtils.nuban = nuban
          PaymentUtils.recordId = recordId
          result.success(null)
          BankUtils.fireIntent(activity, bankServices.getActionByIndex(1), IntentData(bankSlug, recordId, pin, nuban, json, bgColor, accentColor, buttonColor, payment, options))
        } catch (e: Exception) {
          e.printStackTrace()
          result.success(null)
        }
      }
      "startUSSDPayment" -> {
        val json:String = call.argument("text") ?: ""
        try {
          PaymentUtils.startPayment(json, activity)
        } catch (ex: Exception) {
          println(ex)
        }
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onActivityResult(
          requestCode: Int,
          resultCode: Int,
          data: Intent
  ): Boolean {
    // React to activity result and if request code == ResultActivity.REQUEST_CODE
    println("ON ACTIVITY RESULT CALLED --- $data")
    return when (resultCode) {
      Activity.RESULT_OK -> {
        generalmapOkraOptions?.let { ussdActionDeterminer?.onUSDDResultReceived(data, it) }
        true
      }
      else -> false
    }
  }
}
fun JSONObject.toMap(): Map<String, *> = keys().asSequence().associateWith {
  when (val value = this[it])
  {
    is JSONArray ->
    {
      val map = (0 until value.length()).associate { Pair(it.toString(), value[it]) }
      JSONObject(map).toMap().values.toList()
    }
    is JSONObject -> value.toMap()
    JSONObject.NULL -> null
    else            -> value
  }
}

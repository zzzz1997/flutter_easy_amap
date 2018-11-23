package com.zzapp.fluttereasyamap

import android.util.Log
import com.amap.api.location.AMapLocation
import com.amap.api.location.AMapLocationClient
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterEasyAmapPlugin (registrar: Registrar) : MethodCallHandler {

    private val TAG = "FlutterEasyAmapPlugin"

    private var aMapLocationClient: AMapLocationClient? = null

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "flutter_easy_amap")
            channel.setMethodCallHandler(FlutterEasyAmapPlugin(registrar))
        }
    }

    init {
        aMapLocationClient = AMapLocationClient(registrar.context())
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getLocation" -> getLocation(result)
            else -> result.notImplemented()
        }
    }

    private fun getLocation(result: Result) {
        aMapLocationClient!!.startLocation()
        aMapLocationClient!!.setLocationListener {
            if (it != null) {
                Log.e(TAG, it.toString())
                result.success(getLocationInfo(it))
                aMapLocationClient!!.stopLocation()
            }
        }
    }

    private fun getLocationInfo(aMapLocation: AMapLocation) : Map<String, String> {
        val map = HashMap<String, String>()
        map["province"] = aMapLocation.province
        map["city"] = aMapLocation.city
        map["district"] = aMapLocation.district
        map["address"] = aMapLocation.address
        return map
    }
}

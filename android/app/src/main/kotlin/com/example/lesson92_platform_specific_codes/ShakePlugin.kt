package com.example.lesson92_platform_specific_codes

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.plugin.common.EventChannel
import kotlin.math.sqrt
import io.flutter.embedding.engine.plugins.FlutterPlugin

class ShakePlugin : FlutterPlugin, EventChannel.StreamHandler, SensorEventListener {
    private lateinit var eventChannel: EventChannel 
    private lateinit var sensorManager: SensorManager
    private var eventSink: EventChannel.EventSink? = null


   // Plugin Flutter engine-ga biriktirilganda chaqiriladi
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        // EventChannel-ni yaratamiz va StreamHandler-ni o'rnatamiz
        eventChannel = EventChannel(binding.binaryMessenger, "uz.najottalim.platform/shake")
        eventChannel.setStreamHandler(this)
        // SensorManager-ni olish
        sensorManager = binding.applicationContext.getSystemService(Context.SENSOR_SERVICE) as SensorManager
    }

    // Plugin Flutter engine-dan ajratilganda chaqiriladi
    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        // StreamHandler-ni o'chiramiz
        eventChannel.setStreamHandler(null)
    }

    // Flutter tomonidan stream tinglashni boshlash uchun chaqiriladi
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        // Akselerometr sensorini ro'yxatdan o'tkazamiz
        sensorManager.registerListener(
            this,
            sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER),
            SensorManager.SENSOR_DELAY_NORMAL
        )
    }

    // Flutter tomonidan stream tinglashni to'xtatish uchun chaqiriladi
    override fun onCancel(arguments: Any?) {
        // Sensor tinglashni to'xtatamiz va eventSink-ni tozalaymiz
        sensorManager.unregisterListener(this)
        eventSink = null
    }

    // Sensor aniqligidagi o'zgarishlarni kuzatish uchun (bu misolda ishlatilmaydi)
    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}

    // Sensor qiymatlari o'zgarganda chaqiriladi
    override fun onSensorChanged(event: SensorEvent?) {
        if (event?.sensor?.type == Sensor.TYPE_ACCELEROMETER) {
            val x = event.values[0]
            val y = event.values[1]
            val z = event.values[2]
            // Umumiy tezlanishni hisoblaymiz
            val acceleration = sqrt(x * x + y * y + z * z) - SensorManager.GRAVITY_EARTH
            // Agar tezlanish belgilangan chegaradan oshsa, silkitish sifatida qaraymiz
            if (acceleration > SHAKE_THRESHOLD) {
                eventSink?.success("shake")
            }
        }
    }

    companion object {
        // Silkitish sifatida qaralishi uchun kerak bo'lgan minimal tezlanish
        private const val SHAKE_THRESHOLD = 11.0
    }

}
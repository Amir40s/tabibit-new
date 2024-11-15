package com.tabibinet.tabibinet_project

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import android.content.Context
import android.media.AudioManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterFragmentActivity(){

    private val CHANNEL = "audio_output"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "setAudioOutput") {
                val type = call.argument<String>("type")
                setAudioOutput(type)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun setAudioOutput(type: String?) {
        val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
        when (type) {
            "earpiece" -> audioManager.isSpeakerphoneOn = false // Switch to earpiece
            "speaker" -> audioManager.isSpeakerphoneOn = true // Switch to loudspeaker
        }
    }
}

package com.example.clarity_mirror;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;


import java.util.Objects;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodChannel;
public class MainActivity extends FlutterActivity/* implements FlutterPlugin */{

    String CHANNEL = "camera_ai_channel";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        flutterEngine
                .getPlatformViewsController()
                .getRegistry()
//                .registerViewFactory("camera_module", new NativeViewFactory(new SplashScreenActivity()));
                .registerViewFactory("camera_module", new NativeViewFactory());
//        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler((call, result) -> {
            if (Objects.equals(call.method, "openAICamera")) {
                // Call your native Android method here
                // For example: nativeMethodImplementation()
                Log.d("Native method", "Native method invoked from flutter code");
                Intent intent = new Intent(this, SplashScreenActivity.class);
                startActivity(intent);
//                result.success("you can access native result from here");
            } else {
                result.notImplemented();
            }
        });
    }

/*    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        binding.getPlatformViewRegistry().registerViewFactory("activity1", new NativeViewFactory());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    }*/
}

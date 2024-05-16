package com.example.clarity_mirror;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class CmFlutterEngine {
    public static FlutterEngine cachedFlutterEngine;

    public static MethodChannel createMethodChannel(String channelId) {
        if (cachedFlutterEngine != null && cachedFlutterEngine.getDartExecutor() != null) {
            return new MethodChannel(cachedFlutterEngine.getDartExecutor(), channelId);
        }
        return null;
    }

    public static void setCachedFlutterEngine(FlutterEngine engine) {
        cachedFlutterEngine = engine;
    }

    public static FlutterEngine getCachedFlutterEngine() {
        return cachedFlutterEngine;
    }
}


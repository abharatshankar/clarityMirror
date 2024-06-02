package com.example.clarity_mirror;

import io.flutter.plugin.common.MethodChannel;

public class CallMethodChannelHelper {
    private static MethodChannel channel;

    public static void setMethodChannel(MethodChannel methodChannel) {
        channel = methodChannel;
    }

    public static void notifySuccess(String imagePath) {
        if (channel != null) {
            channel.invokeMethod("onCaptureSuccess", imagePath);
        }
    }
}

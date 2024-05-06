package com.example.clarity_mirror;

import android.Manifest;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.multidex.MultiDex;

import org.btbp.btbplibrary.AppConfig;
import org.btbp.btbplibrary.BTBP;
import org.btbp.btbplibrary.LicenseError;
import org.btbp.btbplibrary.Utilities.AppConfigKeys;
import org.btbp.btbplibrary.Utilities.SharedPreferenceKeys;
import org.btbp.btbplibrary.Utilities.SharedPreferenceUtils;
import org.btbp.btbplibrary.Utilities.Utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import License.LicenseInfo;
import io.github.inflationx.calligraphy3.CalligraphyConfig;
import io.github.inflationx.calligraphy3.CalligraphyInterceptor;
import io.github.inflationx.viewpump.ViewPump;
import io.github.inflationx.viewpump.ViewPumpContextWrapper;

public class ExistingActivityLayout {
    public static View createView(Context context) {
        LayoutInflater inflater = LayoutInflater.from(context);
        View view = inflater.inflate(R.layout.splash_screen_main, null, false);
        // Additional initialization or setup here
        Intent i = new Intent(context, SplashScreenActivity.class);
        context.startActivity(i);
        return view;
    }
}

package com.example.clarity_mirror;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.Toast;

public class CustomActivityLayout extends FrameLayout {
    public CustomActivityLayout(Context context) {
        super(context);
        LayoutInflater.from(context).inflate(R.layout.custom, this, true);

        Button button = findViewById(R.id.my_button);
        button.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                // Handle button click
                Intent intent = new Intent(context, SplashScreenActivity.class);
                context.startActivity(intent);
            }
        });
    }
}

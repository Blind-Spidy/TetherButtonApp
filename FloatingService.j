package com.example.tetherbutton;

import android.app.Service;
import android.content.ComponentName;
import android.content.Intent;
import android.graphics.PixelFormat;
import android.os.Build;
import android.os.IBinder;
import android.view.Gravity;
import android.view.WindowManager;
import android.widget.ImageView;

public class FloatingService extends Service {

    WindowManager wm;
    ImageView button;

    @Override
    public void onCreate() {
        super.onCreate();

        button = new ImageView(this);
        button.setImageResource(R.drawable.ic_tether); // add this icon in res/drawable

        WindowManager.LayoutParams params = new WindowManager.LayoutParams(
                WindowManager.LayoutParams.WRAP_CONTENT,
                WindowManager.LayoutParams.WRAP_CONTENT,
                Build.VERSION.SDK_INT >= Build.VERSION_CODES.O ?
                        WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY :
                        WindowManager.LayoutParams.TYPE_PHONE,
                WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE,
                PixelFormat.TRANSLUCENT
        );
        params.gravity = Gravity.CENTER;

        button.setOnClickListener(v -> {
            Intent intent = new Intent();
            intent.setComponent(new ComponentName("com.android.settings", "com.android.settings.TetherSettings"));
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
        });

        wm = (WindowManager) getSystemService(WINDOW_SERVICE);
        wm.addView(button, params);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        wm.removeView(button);
    }

    @Override
    public IBinder onBind(Intent intent) { return null; }
}

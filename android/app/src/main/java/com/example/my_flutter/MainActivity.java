package com.example.my_flutter;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
// add this 
import android.view.WindowManager.LayoutParams;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    // add this
    getWindow().addFlags(LayoutParams.FLAG_SECURE);
  }
}

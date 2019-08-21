package com.aim.view;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.aim.R;
import com.aim.extras.Constant;
import com.aim.location.GpsTracker;

public class LocationActivity extends AppCompatActivity {

    Button getLocationBtn;

    private GpsTracker gpsTracker;
    private TextView textView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_location);


        // edit text

        getLocationBtn = findViewById(R.id.getLocationBtn);
        textView = findViewById(R.id.textView);

        try {
            if (ContextCompat.checkSelfPermission(getApplicationContext(), android.Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED ) {
                ActivityCompat.requestPermissions(this, new String[]{android.Manifest.permission.ACCESS_FINE_LOCATION}, 101);
            }
        } catch (Exception e){
            e.printStackTrace();
        }

        getLocationBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                gpsTracker = new GpsTracker(LocationActivity.this);
                if(gpsTracker.canGetLocation()){
                    double latitude = gpsTracker.getLatitude();
                    double longitude = gpsTracker.getLongitude();
//                    textView.setText(""+latitude+","+longitude);

                    if (latitude != 0.0){
                        Constant.defaultLatLng aa = new Constant.defaultLatLng(latitude,longitude) ;
                        Intent i=new Intent(LocationActivity.this,MainActivity.class);
                        startActivity(i);
                    }

                }
                else
          {
                    gpsTracker.showSettingsAlert();
                }

            }
        });

    }

    /*public void getLocation(View view){
        gpsTracker = new GpsTracker(LocationActivity.this);
        if(gpsTracker.canGetLocation()){
            double latitude = gpsTracker.getLatitude();
            double longitude = gpsTracker.getLongitude();
            tvLatitude.setText(String.valueOf(latitude));
            tvLongitude.setText(String.valueOf(longitude));
        }else{
            gpsTracker.showSettingsAlert();
        }
    }*/

}

package com.genn.info.tech.Activity;

import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.app.DatePickerDialog;
import android.app.ProgressDialog;
import android.app.TimePickerDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.os.AsyncTask;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Editable;
import android.text.Html;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.TimePicker;
import android.widget.Toast;

import com.genn.info.tech.Adapter.GatePassAppointmentAdapter;
import com.genn.info.tech.Config.ConnectionClass;
import com.genn.info.tech.Email.SendMail;
import com.genn.info.tech.Model.VisitorModel;
import com.genn.info.tech.R;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.text.DecimalFormat;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class PendingActivity extends AppCompatActivity {

    //    Listview visitor_recycler;
    ListView pending_listView;
    List<VisitorModel> pendingModel;
    SwipeRefreshLayout listViewPendingSwipeRefresh;

    SimpleAdapter ADAhere;
    ConnectionClass connectionClass;

    TextView noDataFound;
    List<Map<String,String>> MyData;

    AlertDialog alert;

    Connection connect;
    PreparedStatement stmt;
    ResultSet rs;
    ArrayAdapter<String> spinnerArrayAdapter;

    Spinner reject_reasonSpinner;
    int reasonID;
    String reasonTxt;

    // Date
    private final Calendar calendar = Calendar.getInstance();
    private Calendar calendar1;
    private final String dateFormat = "yyyy/MM/dd";
    private int mYear, mMonth, mDay, mHour, mMinute;
    String fromDate,toDate;
    int newHourOfDay;
    int newMinute;

    private int currentHour;
    private int currentMinutes;

    String UserId,Username,EmpNo,usertype,DeptId,Admobileno,Ademail,Pcode;
    String IsHod;

    String re_fromDate,re_toDate,re_noDays,re_time;

    ArrayList<String> permissionList;
    ArrayList<String> permissionListID;

    String com,depart_ID,Visitor_ID,VisitorComp_ID,visNa,Appdate,Todate,Noofdays,Apptime,purpose,sdept,Noofper,Permhrs;
    String Ismobile,Islaptop,Iscab,Isother,Otherdesc,Status;

    Boolean isMob=false,isLab=false,isCab=false,isOther=false;
    String currentDatetime;
    AlertDialog reschedule_dialog;

    String lastID,isSms,isMail;

    ArrayList<String> commonMobileList;
    ArrayList<String> commonMailList;

    DecimalFormat precision;
    double permitHours;
    String plantcode;

    List<HashMap<String, String>> pendingList = new ArrayList<HashMap<String, String>>();

    String qur_Id="",qur_Plantcode="",qur_Sdeptid="",qur_sdept="",qur_Vcompid="",qur_visCom="",qur_VId="",qur_Vpurid="",qur_pur="",qur_Appdate="",qur_Todate="";
    String qur_Noofdays="",qur_Apptime="",qur_Status="",qur_Permhrs="",qur_Noofper="",qur_Otherdesc="";
    String qur_Ismobile,qur_Islaptop,qur_Iscab,qur_Isother;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pending);

        connectionClass = new ConnectionClass();
        permissionList = new ArrayList<String>();
        permissionListID = new ArrayList<String>();

        Intent i = getIntent();
        UserId = i.getStringExtra("UserId");
        Username = i.getStringExtra("Username");
        EmpNo = i.getStringExtra("EmpNo");
        usertype = i.getStringExtra("usertype");
        DeptId = i.getStringExtra("DeptId");
        Admobileno = i.getStringExtra("Admobileno");
        Ademail = i.getStringExtra("Ademail");
        Pcode = i.getStringExtra("Pcode");
        IsHod = i.getStringExtra("IsHod");

        commonMobileList = new ArrayList<>();
        commonMailList = new ArrayList<>();

        precision = new DecimalFormat("0.00");

        checkMailORSms();

        listViewPendingSwipeRefresh = findViewById(R.id.listViewPendingSwipeRefresh);
        pending_listView = findViewById(R.id.pending_listView);

        noDataFound = findViewById(R.id.noDataFound);

        shuf
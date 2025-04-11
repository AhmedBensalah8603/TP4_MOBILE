package com.example.tp4;

import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import androidx.appcompat.app.AppCompatActivity;
import java.util.ArrayList;

public class ListeActivity extends AppCompatActivity {
    ListView listView;
    DBHelper db;
    ArrayAdapter<String> adapter;
    ArrayList<String> taskList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_liste);

        listView = findViewById(R.id.listView);
        db = new DBHelper(this);
        taskList = db.getAllTasks();

        adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, taskList);
        listView.setAdapter(adapter);
    }
}

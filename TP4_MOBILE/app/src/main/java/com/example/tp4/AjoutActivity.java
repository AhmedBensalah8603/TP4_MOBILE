package com.example.tp4;

import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;

public class AjoutActivity extends AppCompatActivity {
    EditText editTextTask;
    Button btnAdd;
    DBHelper db;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ajout);

        editTextTask = findViewById(R.id.editTextTask);
        btnAdd = findViewById(R.id.btnAdd);
        db = new DBHelper(this);

        btnAdd.setOnClickListener(v -> {
            String task = editTextTask.getText().toString();
            if (!task.isEmpty()) {
                db.addTask(task);
                Toast.makeText(this, "Tâche ajoutée", Toast.LENGTH_SHORT).show();
                editTextTask.setText("");
            }
        });
    }
}

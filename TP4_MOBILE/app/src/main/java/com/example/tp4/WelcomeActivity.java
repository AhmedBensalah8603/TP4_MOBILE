package com.example.tp4;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;

public class WelcomeActivity extends AppCompatActivity {
    EditText editTextName;
    Button btnSave;
    SharedPreferences preferences;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_welcome);

        editTextName = findViewById(R.id.editTextName);
        btnSave = findViewById(R.id.btnSave);

        preferences = getSharedPreferences("UserPrefs", MODE_PRIVATE);
        String savedName = preferences.getString("username", "");

        if (!savedName.isEmpty()) {
            Toast.makeText(this, "Bienvenue " + savedName, Toast.LENGTH_LONG).show();
            startActivity(new Intent(this, MainActivity.class));
            finish();
        }

        btnSave.setOnClickListener(v -> {
            String name = editTextName.getText().toString();
            preferences.edit().putString("username", name).apply();
            Toast.makeText(this, "Bienvenue " + name, Toast.LENGTH_SHORT).show();
            startActivity(new Intent(this, MainActivity.class));
            finish();
        });
    }
}

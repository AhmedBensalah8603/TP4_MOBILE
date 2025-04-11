package com.example.tp4;
import com.example.tp4.R;

import android.annotation.SuppressLint;
import android.os.Bundle;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;

import androidx.appcompat.widget.Toolbar; // Ajoute cette ligne en haut

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar); // Nécessaire pour afficher le menu
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main_menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int itemId = item.getItemId();

        if (itemId == R.id.menu_add) {
            startActivity(new Intent(this, AjoutActivity.class));
            return true;
        } else if (itemId == R.id.menu_list) {
            startActivity(new Intent(this, ListeActivity.class));
            return true;
        } else if (itemId == R.id.menu_reset) {
            SharedPreferences preferences = getSharedPreferences("UserPrefs", MODE_PRIVATE);
            preferences.edit().clear().apply();
            Toast.makeText(this, "Nom utilisateur réinitialisé", Toast.LENGTH_SHORT).show();
            startActivity(new Intent(this, WelcomeActivity.class));
            finish();
            return true;
        } else {
            return super.onOptionsItemSelected(item);
        }
    }

}

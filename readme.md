# Task Manager App

**Task Manager** est une application Android simple permettant aux utilisateurs d’ajouter, visualiser et gérer leurs tâches, avec un système de sauvegarde de nom d'utilisateur via `SharedPreferences` et un stockage local en base de données SQLite.

## 📱 Fonctionnalités

- Enregistrement du nom de l'utilisateur (avec `SharedPreferences`)
- Interface de bienvenue personnalisée
- Ajout de nouvelles tâches dans une base de données SQLite
- Affichage de la liste des tâches via une `ListView`
- Réinitialisation du nom d'utilisateur
- Navigation facile via un menu

## 🏗️ Architecture de l'application

- `WelcomeActivity.java` : écran de bienvenue pour enregistrer le nom d'utilisateur
- `MainActivity.java` : écran principal avec menu de navigation
- `AjoutActivity.java` : interface pour ajouter une tâche
- `ListeActivity.java` : affichage de la liste des tâches enregistrées
- `DBHelper.java` : gestion de la base de données SQLite

## 🧱 Technologies utilisées

- **Java** (Android SDK)
- **SQLite** (via `SQLiteOpenHelper`)
- **SharedPreferences** (pour la gestion du nom utilisateur)
- **Layouts XML** : design simple et clair avec `LinearLayout`

## 📂 Structure des fichiers

com.example.taskmanager/
│
├── WelcomeActivity.java       # Écran de bienvenue avec enregistrement du nom
├── MainActivity.java          # Activité principale avec menu
├── AjoutActivity.java         # Écran pour ajouter une tâche
├── ListeActivity.java         # Écran pour afficher les tâches
├── DBHelper.java              # Classe de gestion de la base de données SQLite
│
├── res/
│   ├── layout/
│   │   ├── activity_welcome.xml   # Layout pour WelcomeActivity
│   │   ├── activity_main.xml      # Layout pour MainActivity
│   │   ├── activity_ajout.xml     # Layout pour AjoutActivity
│   │   └── activity_liste.xml     # Layout pour ListeActivity
│   │
│   └── menu/
│       └── main_menu.xml          # Menu de navigation dans MainActivity


## ▶️ Comment l'exécuter

1. Ouvrir le projet avec **Android Studio**.
2. Lancer un **émulateur** ou connecter un **appareil Android physique**.
3. Cliquer sur **Run**.

## 📸 Demo

https://drive.google.com/file/d/1VAIwzG13Vz_jPaV87vFpIwulDRafrrB0/view

## 📝 Auteurs

- Développé par Ahmed Bensalah



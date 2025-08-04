# Jeevan-Setu
An AI-powered ecosystem that transforms blood donation into a reliable lifeline for Thalassemia patients.

---

### 🚨 Prototype Notice

This is a **prototype** created for a hackathon. It is designed to demonstrate the core concept and user interface of the Jeevan-Setu platform. The backend is a mock server that provides pre-written data, and the AI logic is simulated.

---

### ✨ Live Demo

*[A live version of this prototype can be viewed here: (Link to your deployed web app would go here)]*

---

### 🚀 How to Run Locally

To run this project on your local machine, you need to start two components: the **Backend Server** and the **Frontend Web App**.

#### 1. Start the Backend Server

The backend is a simple Python server that provides mock data to the frontend.

1.  **Navigate to the backend folder:**
    ```bash
    cd path/to/your/backend_server
    ```
2.  **Run the Python server:**
    ```bash
    python main.py
    ```
3.  You should see the message `Serving at port 8000`. Keep this terminal window open.

#### 2. Run the Frontend Web App

The frontend is a Flutter web application.

1.  **Navigate to the Flutter project folder:**
    ```bash
    cd path/to/your/jeevan_setu
    ```
2.  **Ensure dependencies are installed:**
    ```bash
    flutter pub get
    ```
3.  **Run the app in Chrome:**
    ```bash
    flutter run -d chrome
    ```
4.  The application will automatically open in a new Chrome window.

**Important:** For the web version to connect to the backend, the `apiUrl` variable in `lib/main.dart` must be set to `http://localhost:8000`.

---

### 🛠️ Technology Stack

* **Frontend:** Flutter Web
* **Backend (Mock Server):** Python (using only standard libraries like `http.server`)
* **Core Language:** Dart
* **Conceptual AI Model:** Gradient Boosting (XGBoost) using Python, Scikit-learn, Pandas (Simulated in this prototype)
<img width="1920" height="1080" alt="Screenshot (217)" src="https://github.com/user-attachments/assets/b4e3a994-b4e5-4c33-a74c-3e56371e9bed" />

---

### 💡 Project Concept

Jeevan-Setu addresses the critical unreliability in the blood supply chain for Thalassemia patients. It moves away from a reactive, emergency-based system to a **proactive, predictive, and community-driven model**.
<img width="1920" height="1080" alt="Screenshot (220)" src="https://github.com/user-attachments/assets/402aca70-5e53-4022-b0d0-aaaa31133970" />

#### Key Features:

* **Pr![Uploading Screenshot (220).png…]()
oactive Matching:** An AI engine (simulated here) predicts blood demand and donor availability to connect donors with patients *before* a crisis occurs.
* **"Warrior Pods":** The platform creates hyperlocal communities of donors linked to specific patients or treatment centers, fostering a sense of direct impact and responsibility.
* **Gamified Donor Journey:** To encourage recurring donations, donors earn badges and can track their impact (e.g., "You have supported Anjali's treatment for 6 months").
* **Dual Dashboards:** The prototype showcases two distinct user experiences:
    1.  A calming, reassuring dashboard for the **Patient's Family**.
    2.  An engaging, motivating dashboard for the **Donor**.

<img width="1920" height="1080" alt="Screenshot (221)" src="https://github.com/user-attachments/assets/00ac654f-17f4-421d-b450-ed43cfc412c3" />

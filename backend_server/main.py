# main.py - Your Mock Backend for Jeevan-Setu (using only standard libraries)

import http.server
import socketserver
import json
import logging

# --- This section acts as our "Fake Database" ---
mock_patient_data = {
    "1": {
        "patientName": "Anjali Sharma",
        "nextTransfusionDate": "2025-08-15",
        "hospitalName": "Apollo Hospital, Jubilee Hills",
        "podName": "Apollo Jubilee Warriors",
        "podStatus": "Strong (12/15 Active)",
        "statusMessage": "Confirmed. Donors are being arranged."
    }
}

mock_donor_data = {
    "101": {
        "donorName": "Rohan",
        "greeting": "Your Pod needs you!",
        "isEligible": True,
        "livesSaved": 6,
        "donationCount": 2,
        "podNews": "A child in your pod has a transfusion scheduled for Aug 15th. Your A+ blood can make a difference."
    }
}

# --- This is our custom request handler that processes requests from the app ---
class JeevanSetuHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        """Handles all GET requests from the Flutter app."""
        logging.warning(f"Request received for path: {self.path}")

        # Set headers for all responses
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        # Add CORS headers to allow connection from the app in development
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()

        # Determine which data to send based on the URL path requested by the app
        response_data = {}
        if self.path == '/patients/1':
            response_data = mock_patient_data.get("1", {})
        elif self.path == '/donors/101':
            response_data = mock_donor_data.get("101", {})
        elif self.path == '/donors/match':
            # This simulates the AI finding the best donor
            response_data = {"best_match_donor_id": "101"}
        elif self.path == '/':
            response_data = {"Project": "Jeevan-Setu Mock Backend (Standard Library)"}

        # Convert the Python dictionary to a JSON string and then to bytes to send it
        response_bytes = json.dumps(response_data).encode('utf-8')
        self.wfile.write(response_bytes)

# --- Instructions to Run This Server ---
# 1. Save this code in a file named 'main.py' on your computer.
# 2. Open your terminal (like Command Prompt or PowerShell).
# 3. Navigate to the folder where you saved the file using the 'cd' command.
# 4. Run the command: python main.py  (or python3 main.py)
# 5. The server will start running on http://127.0.0.1:8000
# 6. Keep this terminal window open while you run the Flutter app.

PORT = 8000

# This line starts the server and keeps it running
with socketserver.TCPServer(("", PORT), JeevanSetuHandler) as httpd:
    print(f"Serving at port {PORT}")
    print("You can now run your Flutter app.")
    httpd.serve_forever()

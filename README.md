# VITALIS HEALTH SUPPORT v2.4
### *"YOUR HEALTH. OUR PRIORITY. STAY HEALTHY STAY STRONG"*

An ultra-sleek, aggressive/tactical warrior-themed health application built to match the high-octane aesthetic of the reference artwork.

---

## ⚡ Key Highlights & Features

1. **Authentication Gateway (First Screen)**:
   - Secured terminal with pre-filled default access code: `test1`.
   - Direct button to access the app or clear/re-enter code.
   - Built-in validation with tactile sound feedback and warning animations.
   - Feature preview cards: Consult Doctors, Track Your Health, Medication Reminders, Warrior Wellness.

2. **Main Hub & Health Overview (Exact Poster Layout)**:
   - **Personalized Header**: *"Good day, Warrior [Name]!"* with custom callsign/avatar.
   - **Health Overview Rings**:
     - ❤️ **Heart Rate**: 72 bpm (Normal Range) with pulsating indicator
     - 🩸 **SpO₂**: 98% (Optimal Blood Oxygen)
     - 🌡️ **Body Temp**: 36.6°C (Normal)
     - 🩺 **Blood Pressure**: 120/80 mmHg
   - **Real-Time Animated ECG Monitor**: Canvas-rendered P-Q-R-S-T cardio wave with leading spark synchronized to heart rate.
   - **Red Call-To-Action Banner**: *"Book a Consultation - Talk to a licensed doctor"*.
   - **Quad Grid Quick Actions**: My Records, Medications, Health Tips, Register / Profile.

3. **High-Precision Biometric Pulse & PPG Scanner**:
   - **Dual Precision Diagnostics**:
     - 📸 **Optical Camera PPG (Photoplethysmography)**: Uses real-time camera stream analysis to detect hemoglobin absorbance and pulsatile blood volume changes across capillary beds.
     - 👆 **Tactile Pulse / Tap Sensor**: Real-time R-R interval analysis ($t_{i+1} - t_i$) with millisecond timestamp precision and artifact filtering.
     - ⚡ **Auto 10s Multi-Phase Scan**: 4-phase clinical analysis (Baseline Absorption, Pulsatile Extraction, Motion Filtering, Spectral RMSSD & SpO₂).
   - **Detailed Physiological Telemetry**:
     - Pulse Rate (BPM) with dynamic cardiac rhythm categorization (Sinus Rhythm, Athletic Bradycardia, Tachycardia)
     - Heart Rate Variability (**HRV RMSSD in ms**) for autonomic/parasympathetic recovery
     - Estimated **$SpO_2$ (%)** and **R-R Interval (ms)**
     - Signal Quality & Confidence Index (up to 99.4%)
   - **Live Pulse Waveform Oscilloscope**: Real-time canvas rendering dichrotic notch arterial pulse waves.
   - **1-Click Commit**: Instantly record scan results to the Health Dossier and Overview Dials.
   - **Logbook History**: Chronological table of all recorded readings with status badges (Optimal / Normal / Warning).

4. **Patient / Warrior Registration**:
   - Register Call-sign & Avatar (⚔️, ⚡, 🥊, 🛡️, 🦅, 🐺).
   - Personal vitals & medical parameters: Age, Gender, Blood Type, Weight, Emergency Contacts, Allergies, Fitness Goal.
   - Saves to `localStorage` and updates the app header and dashboard greeting immediately.

5. **Medication & Hydration Tracker**:
   - Active dosage reminders (e.g., Omega-3, Zinc & D3, Magnesium) with one-click "Take Now" checkboxes.
   - Add new medication modal with dosage and schedule.
   - 3,000 mL **Hydration Combat Tank** with quick-add buttons (+250 mL, +500 mL, Reset).

6. **Tactical Audio FX (Web Audio API)**:
   - Built-in sound synthesizer for cybernetic clicks, unlock chimes, heart monitor pulses, and error beeps.
   - Toggle button at top to switch sound effects ON/OFF.

7. **PWA Installability & Standalone App**:
   - **Install Button on First Screen**: Prominently located directly below the access code terminal.
   - **Desktop & Mobile PWA**: Compliant Web App Manifest (`manifest.webmanifest`) with 192px and 512px icons.
   - **1-Click Native Installation**: Triggers browser's native install prompt on Chrome, Edge, and Android.
   - **Guided Install Modal**: Clear step-by-step instructions for iPhone/iPad Safari and manual browser installation.
   - **Header Shortcut**: Fast install icon located directly in the dashboard header.

8. **100% Offline Capability**:
   - **Service Worker (`sw.js`)**: Pre-caches the entire application shell, styles, icons, and logic.
   - **Stale-While-Revalidate Caching**: Instant offline loading with background cache refreshment.
   - **Local Database Persistence**: All vitals, medications, hydration, and profile data persist offline in `localStorage`.
   - **Offline Mode Indicator**: Real-time banner and toast alerts indicating local database operation when offline.

9. **Responsive Display Fit (Desktop & Cellphone Screen)**:
   - **Desktop Screen Mode**: Expansive widescreen console with a 2-column gateway terminal and multi-column dashboard grid.
   - **Cellphone Screen Mode**: 100% viewport adaptation (no fake phone bezels, no double scrollbars, safe-area inset aware).
   - **Interactive Viewport Switcher**: Toggle easily between "Desktop Fit" and "Phone Frame" mockup on desktop screens.

---

## 🚀 How to Run

You can run this application in two simple ways:

### Option 1: Direct File Opening
Double-click `index.html` in any modern web browser (Chrome, Edge, Firefox, Brave, Safari).

### Option 2: Local Web Server
If you prefer running via HTTP:
```bash
node server.js
```
Open **`http://localhost:5173`** in your browser.

---

## 🔑 Default Credentials
- **Access Code**: `test1` (Pre-filled on page load)

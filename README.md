# UnderstandMe — Hackathon Starter

A beginner-friendly demo scaffold for The Digital Minds. It includes:

- Temporary QR-linked accessibility profile (random token, expiry, revocation).
- A staff-view page that opens directly from a QR link without a login screen.
- Browser text-to-speech for the profile and a fictional invoice.
- A fictional bill-reading demo; the “payment” button does not move money.
- Hospital communication report form for patients who cannot speak, with accessible phrase tiles, optional keyboard/speech input, report review, text-to-speech playback, and a FastAPI endpoint that saves demo reports to SQLite.
- Live webcam hand-landmark tracking through MediaPipe Hands (the camera does **not** automatically translate ISL semantics yet; a trained sign classifier must be added and evaluated).
- A simple medicine reminder form (prototype only; it does not send notifications or give medical advice).
- Test checklist, test report template, and demo script in `docs/`.

> **Demo safety:** Use fictional data only. This is not production-ready, not a real payment system, and not a medical reminder service. Anyone with an active QR link can open the linked demo profile until it expires or is revoked. Use HTTPS and a security review before any real deployment.

## 1. Project folders

```text
UnderstandMe-Starter/
├── frontend/             # React + Vite interface
├── backend/              # FastAPI API
├── docs/                 # test checklist, report, demo script
├── .gitignore
└── README.md
```

## 2. Start the backend (Windows)

Open **Command Prompt** in the `UnderstandMe-Starter` folder, then run:

```bat
cd backend
py -m venv .venv
.venv\Scripts\activate
py -m pip install -r requirements.txt
py -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Keep this terminal open. Visit `http://127.0.0.1:8000/health` to check the API. The response should be `{"status":"ok"}`.

If `py` is not recognized, use `python` in its place.

## 3. Start the frontend

Open a **second** Command Prompt in the project folder:

```bat
cd frontend
npm install
npm run dev -- --host 0.0.0.0
```

Open the URL Vite shows (usually `http://localhost:5173`). Keep this terminal open too.

## 4. Test on two devices using the same Wi-Fi

1. On the laptop, open Command Prompt and run `ipconfig`.
2. Find the active Wi-Fi adapter's **IPv4 Address** (example only: `192.168.1.15`). Do not use that example unless it is actually your IP.
3. On your phone, open `http://YOUR-LAPTOP-IP:5173` (replace the address).
4. Create a fictional profile. In the “QR link base URL” field, enter `http://YOUR-LAPTOP-IP:5173` before creating it, or update the field and create a new profile.
5. Scan the QR from another device. Do not use `localhost` in a QR URL for a phone; `localhost` means the phone itself.
6. The phone must be on the same trusted Wi-Fi. If Windows Firewall asks, allow Python/Node on your **private network**. Do not disable the firewall globally.
7. If the API cannot be reached from the phone, confirm the backend is running and that the URL uses the laptop IPv4 address. Your Wi-Fi may isolate devices from each other.

The app chooses the API host from the current page hostname, so opening the frontend using the laptop IP makes the API request use that same IP on port 8000. For this local demo, both devices should use HTTP on the same trusted Wi-Fi only. For public access, deploy the frontend and backend with HTTPS and configure the API URL appropriately.

## 5. Hospital report and sign-language demo

1. Start both backend and frontend using the commands above.
2. Open **Hospital Report**. For laptop camera testing, use `http://localhost:5173` or `http://127.0.0.1:5173`; camera permission on a phone usually requires HTTPS.
3. Click **Start camera & hand tracking** and allow webcam access. If the MediaPipe CDN cannot load, the phrase tiles still work.
4. Tap accessible phrases such as “I have pain”, “I have fever”, or “I need a doctor”. These are fallback text inputs, not sign predictions.
5. Review the message, select urgency, enter optional details, choose **Read report aloud**, then **Confirm & submit report**. The backend saves it to the local SQLite demo database and returns a report ID.
6. Explain this safety limitation to judges: the camera detects hands and draws landmarks, but it does not yet infer the meaning of a patient's ISL gestures. Do not describe this build as a completed automatic ISL translator.
7. Use only fictional data. The report API is intentionally unauthenticated for local hackathon demonstration and is **not safe for real patient data or public deployment** without authentication/authorisation, encryption, auditing, access limits, retention controls, and a privacy/clinical review.

### ISL dataset choice

For hospital vocabulary, a dedicated emergency ISL dataset is more relevant to training than starting only with greetings: the published emergency-sign dataset covers **accident, call, doctor, help, hot, lose, pain, and thief** across 824 sample videos. Dataset page: https://data.mendeley.com/datasets/2vfdm42337/1. Paper/dataset description: https://pmc.ncbi.nlm.nih.gov/articles/PMC7378574/. The INCLUDE/INCLUDE-50 dataset remains useful for broader isolated ISL vocabulary: https://huggingface.co/datasets/ai4bharat/INCLUDE. The videos are not included in this starter ZIP; verify the dataset licence and give proper attribution before using or redistributing clips.

## 6. What to demo

1. Create a profile with made-up data and an expiry time.
2. Show the QR link and open it on a second device.
3. Press **Read profile aloud** (browser speech support is required; the device may need its volume enabled).
4. Revoke the token from the creator screen, then refresh the staff page. Access should be denied.
5. Open **Accessible bill** and read the fictional invoice aloud. Press the demo payment button and explain that no payment occurs.
6. Open **Medicine reminder** and save a reminder to show the interface only; it does not generate an operating-system notification.
7. Complete `docs/TEST-CHECKLIST.md` and record actual results in `docs/TEST-REPORT.md`.

## 7. Common commands

Frontend production build:

```bat
cd frontend
npm run build
```

Backend tests (when dependencies are installed):

```bat
cd backend
.venv\Scripts\activate
py -m pytest -q
```

## 8. GitHub and four-person workflow

Create one repository on GitHub, for example `UnderstandMe`. From this project folder:

```bat
git init
git add .
git status
git commit -m "Create UnderstandMe demo starter"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/UnderstandMe.git
git push -u origin main
```

Replace `YOUR-USERNAME` with your GitHub username. Run `git remote -v` first if this folder is already connected to a repository; do not add a second origin. Invite the other three members as collaborators in the repository settings.

Suggested split:
- **Harish (integration):** keep `main` working, review/merge pull requests, run final demo.
- **Mohnish (backend/security):** review token expiry/revocation and add API tests in `backend/`.
- **Shabarish (accessibility UI):** improve the voice controls and keyboard accessibility in `frontend/src/App.jsx`.
- **Sathesh (QA/demo):** run the checklist, record actual outcomes, improve `docs/TEST-REPORT.md` and `docs/DEMO-SCRIPT.md`.

Each teammate should create a separate branch, commit, push, and open a pull request. Avoid editing the same file at the same time. Merge only after running the app and checking the changes.


## Multilingual hospital report (updated)

The hospital-report screen includes translated core labels and symptom phrase tiles for English, Tamil, Hindi, Telugu, Malayalam, Bengali, Kannada, Marathi, Gujarati, Punjabi, Odia, Assamese, and Urdu. The language selector also includes Sanskrit and an “Other / type language” option. For “Other”, the patient can enter the language name and type their message in that language; the app preserves that text. Browser speech recognition and text-to-speech support depend on the browser, installed language packs, and device. They are not guaranteed for every language.

Important scope note: the camera currently tracks hand landmarks using MediaPipe; it does not yet translate arbitrary ISL signs into medical text. The quick phrase buttons are a multilingual fallback, not AI-recognised signs. A trained and validated ISL recognition model is still required. This demo is not a medical device and must use fictional data only.

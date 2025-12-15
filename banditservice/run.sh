#!/bin/bash
set -e

# Create venv if it doesn't exist
if [ ! -d "venv" ]; then
    python3 -m venv venv
fi

# Activate venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Initialize database
python init_bandit.py

# Run service
uvicorn main:app --reload --port 8000

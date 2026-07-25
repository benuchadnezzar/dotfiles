#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///
"""
Email a file (typically a PDF) as an attachment to a Kindle "Send to Kindle"
address, using SMTP + recipient settings read from a .env file.

Usage:
    uv run send_to_kindle.py <path-to-file> [--env .env]

Required keys in .env:
    KINDLE_EMAIL   - your Send-to-Kindle address (e.g. yourname_ab12cd@kindle.com)
    SMTP_HOST      - e.g. smtp.gmail.com
    SMTP_PORT      - e.g. 587 (defaults to 587 if omitted)
    SMTP_USER      - the SMTP account username
    SMTP_PASS      - the SMTP account password / app password

Optional:
    SMTP_FROM      - "From" address if different from SMTP_USER

Note: Amazon only accepts mail from senders on your account's approved
sender list (Manage Your Content and Devices > Preferences > Personal
Document Settings). Add SMTP_FROM (or SMTP_USER, if SMTP_FROM is unset)
there once, or the email will silently be dropped by Amazon.
"""
from __future__ import annotations

import argparse
import mimetypes
import smtplib
import sys
from email.message import EmailMessage
from pathlib import Path


def load_env(env_path: Path) -> dict[str, str]:
    values: dict[str, str] = {}
    if not env_path.exists():
        return values
    for raw_line in env_path.read_text().splitlines():
        line = raw_line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, _, value = line.partition("=")
        values[key.strip()] = value.strip().strip('"').strip("'")
    return values


def send_file(file_path: Path, env: dict[str, str]) -> None:
    kindle_email = env.get("KINDLE_EMAIL")
    smtp_host = env.get("SMTP_HOST")
    smtp_port = int(env.get("SMTP_PORT", "587"))
    smtp_user = env.get("SMTP_USER")
    smtp_pass = env.get("SMTP_PASS")
    from_addr = env.get("SMTP_FROM") or smtp_user

    required = {
        "KINDLE_EMAIL": kindle_email,
        "SMTP_HOST": smtp_host,
        "SMTP_USER": smtp_user,
        "SMTP_PASS": smtp_pass,
    }
    missing = [key for key, value in required.items() if not value]
    if missing:
        print(
            f"Missing required .env values: {', '.join(missing)}. "
            "See .env.example for the full list.",
            file=sys.stderr,
        )
        sys.exit(1)

    if not file_path.exists():
        print(f"File not found: {file_path}", file=sys.stderr)
        sys.exit(1)

    msg = EmailMessage()
    msg["Subject"] = file_path.stem
    msg["From"] = from_addr
    msg["To"] = kindle_email
    msg.set_content(f"Attached: {file_path.name}")

    mime_type, _ = mimetypes.guess_type(file_path.name)
    maintype, subtype = (mime_type or "application/pdf").split("/", 1)
    msg.add_attachment(
        file_path.read_bytes(),
        maintype=maintype,
        subtype=subtype,
        filename=file_path.name,
    )

    with smtplib.SMTP(smtp_host, smtp_port) as server:
        server.starttls()
        server.login(smtp_user, smtp_pass)
        server.send_message(msg)

    print(f"Sent {file_path.name} to {kindle_email}")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("file_path", type=Path, help="Path to the file to send")
    parser.add_argument("--env", type=Path, default=Path(".env"), help="Path to .env file")
    args = parser.parse_args()

    env = load_env(args.env)
    send_file(args.file_path, env)


if __name__ == "__main__":
    main()

from typing import Optional
from pydantic import EmailStr
from fastapi_mail import FastMail, MessageSchema, ConnectionConfig, MessageType

from ..config import settings # Use .. to go up one level to the backend package root
from ..auth import CODE_EXPIRY_MINUTES # Assuming auth.py is in the same directory level as services/

conf = ConnectionConfig(
    MAIL_USERNAME=settings.MAIL_USERNAME,
    MAIL_PASSWORD=settings.MAIL_PASSWORD,
    MAIL_FROM=settings.MAIL_FROM,
    MAIL_PORT=settings.MAIL_PORT,
    MAIL_SERVER=settings.MAIL_SERVER,
    MAIL_STARTTLS=settings.MAIL_STARTTLS,
    MAIL_SSL_TLS=settings.MAIL_SSL_TLS,
    USE_CREDENTIALS=True,
    VALIDATE_CERTS=True,
)


async def send_email_async(
    subject: str, 
    recipient_to: EmailStr, 
    body_html: Optional[str] = None,
    body_text: Optional[str] = None,
):
    if not settings.MAIL_USERNAME or not settings.MAIL_PASSWORD or not settings.MAIL_SERVER:
        print(f"MAIL settings not configured. Email not sent. To: {recipient_to}, Subject: {subject}")
        print(f"Body HTML: {body_html}")
        print(f"Body Text: {body_text}")
        return

    message = MessageSchema(
        subject=subject,
        recipients=[recipient_to],
        body=body_html if body_html else body_text,
        subtype=MessageType.html if body_html else MessageType.plain,
    )

    fm = FastMail(conf)
    try:
        await fm.send_message(message)
        print(f"Email sent to {recipient_to} with subject: {subject}")
    except Exception as e:
        print(f"Failed to send email to {recipient_to}: {e}")

async def send_2fa_login_email(email_to: EmailStr, code: str):
    project_name = "Sportify App"
    subject = f"[{project_name}] Your 2FA Login Code"
    
    body_html = f"""
    <html>
        <body>
            <p>Hello,</p>
            <p>Your 2FA login code for {project_name} is: <strong>{code}</strong></p>
            <p>This code will expire in {CODE_EXPIRY_MINUTES} minutes.</p>
            <p>If you did not request this, please ignore this email.</p>
        </body>
    </html>
    """
    body_text = f"Hello,\nYour 2FA login code for {project_name} is: {code}\nThis code will expire in {CODE_EXPIRY_MINUTES} minutes.\nIf you did not request this, please ignore this email."

    await send_email_async(subject=subject, recipient_to=email_to, body_html=body_html, body_text=body_text)

async def send_password_reset_email(email_to: EmailStr, code: str):
    project_name = "Sportify App"
    subject = f"[{project_name}] Your Password Reset Code"
    
    body_html = f"""
    <html>
        <body>
            <p>Hello,</p>
            <p>You requested a password reset for your account with {project_name}.</p>
            <p>Your password reset code is: <strong>{code}</strong></p>
            <p>This code will expire in {CODE_EXPIRY_MINUTES} minutes.</p>
            <p>If you did not request a password reset, please ignore this email.</p>
        </body>
    </html>
    """
    body_text = f"Hello,\nYou requested a password reset for {project_name}. Your code is: {code}\nThis code will expire in {CODE_EXPIRY_MINUTES} minutes.\nIf you didn't request this, ignore this email."

    await send_email_async(subject=subject, recipient_to=email_to, body_html=body_html, body_text=body_text)

# Note: The current smtplib implementation is blocking. 
# In a FastAPI async context, it's better to run blocking IO in a thread pool:
# import asyncio
# loop = asyncio.get_event_loop()
# await loop.run_in_executor(None, blocking_smtp_function, args...)
# Or use an async-native email library like aiosmtplib.
# For now, this will print to console if not configured or raise error.

# Further refinement: Consider using a proper HTML templating engine (e.g., Jinja2)
# for more complex email bodies if needed, instead of f-strings with HTML.
# from jinja2 import Environment, FileSystemLoader
# mail_templates_env = Environment(loader=FileSystemLoader('backend/templates/email'))
# def render_email_template(template_name: str, context: Dict) -> str:
#    template = mail_templates_env.get_template(template_name)
#    return template.render(context) 
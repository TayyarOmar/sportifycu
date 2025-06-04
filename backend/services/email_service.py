from typing import Optional
from pydantic import EmailStr
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

from ..config import settings # Use .. to go up one level to the backend package root

async def send_email_async(
    subject: str, 
    recipient_to: EmailStr, 
    body_html: Optional[str] = None,
    body_text: Optional[str] = None,
    # environment: Settings = Depends(get_settings) # If using FastAPI DI for settings
):
    if not settings.MAIL_USERNAME or not settings.MAIL_PASSWORD or not settings.MAIL_SERVER:
        print(f"MAIL settings not configured. Email not sent. To: {recipient_to}, Subject: {subject}")
        print(f"Body HTML: {body_html}")
        print(f"Body Text: {body_text}")
        return

    message = MIMEMultipart("alternative")
    message["From"] = settings.MAIL_FROM
    message["To"] = recipient_to
    message["Subject"] = subject

    if body_text:
        message.attach(MIMEText(body_text, "plain"))
    if body_html:
        message.attach(MIMEText(body_html, "html"))

    try:
        # Using asyncio.to_thread for smtplib if in an async context, or run smtplib directly
        # For simplicity here, direct smtplib call (consider threading for non-blocking in async app)
        # NOTE FOR PRODUCTION: smtplib is a blocking library. In an async application like FastAPI,
        # blocking I/O operations should be run in a separate thread pool to avoid stalling the event loop.
        # Consider using `await asyncio.to_thread(server.sendmail, ...)` for Python 3.9+
        # or an async-native email library like `aiosmtplib` or `fastapi-mail`.
        if settings.MAIL_SSL_TLS:
            context = smtplib.ssl.create_default_context()
            server = smtplib.SMTP_SSL(settings.MAIL_SERVER, settings.MAIL_PORT, context=context)
        else:
            server = smtplib.SMTP(settings.MAIL_SERVER, settings.MAIL_PORT)
        
        if settings.MAIL_STARTTLS:
            server.starttls()
        
        server.login(settings.MAIL_USERNAME, settings.MAIL_PASSWORD)
        server.sendmail(settings.MAIL_FROM, recipient_to, message.as_string())
        server.quit()
        print(f"Email sent to {recipient_to} with subject: {subject}")
    except Exception as e:
        print(f"Failed to send email to {recipient_to}: {e}")

# Example email templates (can be more sophisticated using Jinja2)
async def send_2fa_login_email(email_to: EmailStr, token: str):
    project_name = "Sportify App"
    subject = f"[{project_name}] Your 2FA Login Link"
    # Frontend URL should be configurable
    link = f"http://localhost:3000/verify-2fa?token={token}" # Example frontend URL
    
    body_html = f"""\
    <html>
        <body>
            <p>Hello,</p>
            <p>Please click the link below to complete your login for {project_name}:</p>
            <p><a href="{link}">Complete Login</a></p>
            <p>This link will expire in {settings.ACCESS_TOKEN_EXPIRE_MINUTES} minutes.</p>
            <p>If you did not request this, please ignore this email.</p>
        </body>
    </html>
    """
    body_text = f"Hello,\nPlease use the following link to complete your login for {project_name}: {link}\nThis link will expire in {settings.ACCESS_TOKEN_EXPIRE_MINUTES} minutes.\nIf you did not request this, please ignore this email."

    await send_email_async(subject=subject, recipient_to=email_to, body_html=body_html, body_text=body_text)

async def send_password_reset_email(email_to: EmailStr, token: str):
    project_name = "Sportify App"
    subject = f"[{project_name}] Your Password Reset Link"
    link = f"http://localhost:3000/reset-password-confirm?token={token}" # Example frontend URL
    
    body_html = f"""\
    <html>
        <body>
            <p>Hello,</p>
            <p>You requested a password reset for your account with {project_name}.</p>
            <p>Please click the link below to set a new password:</p>
            <p><a href="{link}">Reset Password</a></p>
            <p>This link will expire in {settings.ACCESS_TOKEN_EXPIRE_MINUTES} minutes.</p>
            <p>If you did not request a password reset, please ignore this email.</p>
        </body>
    </html>
    """
    body_text = f"Hello,\nYou requested a password reset for {project_name}. Use this link: {link}\nThis link will expire in {settings.ACCESS_TOKEN_EXPIRE_MINUTES} minutes.\nIf you didn't request this, ignore this email."

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
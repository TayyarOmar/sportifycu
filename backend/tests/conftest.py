import pytest
import os
import tempfile
from unittest.mock import patch

@pytest.fixture(scope="session", autouse=True)
def setup_test_environment():
    """Setup test environment with temporary database"""
    # Create a temporary database file for testing
    test_db_fd, test_db_path = tempfile.mkstemp(suffix='.json')
    os.close(test_db_fd)
    
    # Patch the database URL for testing
    with patch('backend.config.settings.DATABASE_URL', test_db_path):
        yield
    
    # Cleanup
    try:
        os.unlink(test_db_path)
    except OSError:
        pass

@pytest.fixture(autouse=True)
def mock_email_settings():
    """Mock email settings to prevent actual email sending during tests"""
    with patch('backend.config.settings.MAIL_USERNAME', 'test@example.com'), \
         patch('backend.config.settings.MAIL_PASSWORD', 'testpassword'), \
         patch('backend.config.settings.MAIL_SERVER', 'smtp.test.com'):
        yield

@pytest.fixture(autouse=True)
def mock_google_api():
    """Mock Google API key to prevent actual API calls during tests"""
    with patch('backend.config.settings.GOOGLE_API_KEY', 'test_api_key'):
        yield 
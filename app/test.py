import unittest
import os
from datetime import datetime
from pytz import timezone
from main import app


class TestApp(unittest.TestCase):

    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_web_page_served_correctly(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)

    def test_date_correct(self):
        response = self.app.get('/')
        datetime_str = response.data.decode('utf-8').split('current local date and time: ')[1].split('<')[0]
        self.assertTrue(datetime_str.strip())
        current_datetime = datetime.now(timezone('Asia/Jerusalem')).strftime("%Y-%m-%d %H:%M")
        self.assertEqual(datetime_str, current_datetime)


if __name__ == '__main__':
    app_url = os.getenv("APP_URL")

    if not app_url:
        print("Please set the APP_URL environment variable with your app's URL.")
    else:
        app.config['SERVER_NAME'] = app_url

        unittest.main()

""" Locators for demoqa web tests. """
# Radio Button Page
ELEMENT_BY_ID = "xpath://*[@id='{text}']/following-sibling::label"
SUCCESS_TEXT = "css:.text-success"

# Login page
INPUT_USERNAME = "css:#userName"
INPUT_PASSWORD = "xpath://*[@id='password']"
BUTTON_LOGIN = "xpath://button[@id='login']"
ERROR_MESSAGE_PAGE = "xpath://p[text()='Invalid username or password!']"

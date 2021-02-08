from AppiumLibrary import AppiumLibrary
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn


class Appium_Extended:
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.appium: AppiumLibrary = BuiltIn().get_library_instance('AppiumLibrary')

    @keyword(name="Push File To Device")
    def push_file_to_device(self, destination_path: str, base64data: str = None, source_path: str = None):
        driver = self.appium._current_application()
        driver.push_file(destination_path, base64data, source_path)

    @keyword(name='ADB Shell')
    def adb_shell(self, shell_string: str):
        driver = self.appium._current_application()
        driver.execute_script('mobile: shell', {
            'command': shell_string,
        })
import sys
import configparser
from PyQt6.QtCore import QSize, Qt
from PyQt6.QtWidgets import QApplication, QMainWindow, QPushButton, QLineEdit, QLabel, QMessageBox, QDialog
from visitor import visitor_widget
from admin import admin_widget


class MainWindow(QDialog):
    def __init__(self):
        super().__init__()
        self.admin_window = None
        self.vistor_window = None
        self.config_file = 'config.ini'

        self.button1 = QPushButton('Log in as an administrator', self)
        self.button1.setGeometry(100, 50, 200, 25)
        self.button1.clicked.connect(self.the_button_was_clicked)

        button2 = QPushButton('Log in as an visitor', self)
        button2.setGeometry(100, 100, 200, 25)
        button2.clicked.connect(self.enter_visitor)

        self.password_label = QLabel('Password:', self)
        self.password_label.setGeometry(100, 200, 100, 30)
        self.password_label.hide()

        self.password_input = QLineEdit(self)
        self.password_input.setPlaceholderText('Enter password')
        self.password_input.setGeometry(160, 200, 100, 30)
        self.password_input.hide()

        self.login_label = QLabel('Login:', self)
        self.login_label.setGeometry(100, 150, 100, 30)
        self.login_label.hide()

        self.login_input = QLineEdit(self)
        self.login_input.setPlaceholderText('Enter login')

        self.login_input.setGeometry(160, 150, 100, 30)
        self.login_input.hide()

        self.show_password_btn = QPushButton('.', self)
        self.show_password_btn.clicked.connect(self.toggle_password_echo)
        self.show_password_btn.setGeometry(260, 200, 32, 32)
        self.show_password_btn.hide()

        self.login_button = QPushButton('Log in', self)
        self.login_button.setGeometry(170, 240, 70, 45)
        self.login_button.clicked.connect(self.authentication)
        self.login_button.hide()

        self.setFixedSize(QSize(400, 300))
        self.setWindowTitle('Authentication widget')

    def toggle_password_echo(self):
        if self.password_input.echoMode() == QLineEdit.EchoMode.Password:
            self.password_input.setEchoMode(QLineEdit.EchoMode.Normal)
        else:
            self.password_input.setEchoMode(QLineEdit.EchoMode.Password)

    def the_button_was_clicked(self):
        self.login_label.show()
        self.login_input.show()
        self.password_label.show()
        self.password_input.show()
        self.show_password_btn.show()
        self.login_button.show()
        self.password_input.setEchoMode(QLineEdit.EchoMode.Password)

    def auth_error(self):
        dlg = QMessageBox(self)
        dlg.setWindowTitle("Ошибка входа!")
        dlg.setText("Вы допустили ошибку в вводе логина/пароля, пожалуйста, попробуйте ещё раз!")
        dlg.exec()

        # if button == QMessageBox.StandardButton.Ok:
        #     print("OK!")

    def validate_info(self, login, password):
        config = configparser.ConfigParser()
        config.read(self.config_file)

        real_p = config.get('admin', 'password')
        real_l = config.get('admin', 'login')
        return (login == real_l and password == real_p)

    def authentication(self):
        login = self.login_input.text()
        password = self.password_input.text()
        if self.validate_info(login, password):
            self.admin_window = admin_widget()
            self.admin_window.show()
            self.accept()
        else:
            self.auth_error()

    def enter_visitor(self):
        self.vistor_window = visitor_widget()
        self.vistor_window.show()
        self.accept()


if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec())

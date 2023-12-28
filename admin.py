from PyQt6.QtCore import QSize, Qt
from PyQt6.QtWidgets import QApplication, QMainWindow, QPushButton, QLineEdit, QLabel, QMessageBox, QDialog, QVBoxLayout


class admin_widget(QDialog):
    def __init__(self):
        super().__init__()
        self.setWindowTitle('Администратор')
        admin_button = QPushButton('Войти как администратор')
        # admin_button.clicked.connect(self.open_admin_window)
        layout = QVBoxLayout(self)
        layout.addWidget(admin_button)


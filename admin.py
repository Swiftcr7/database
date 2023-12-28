import configparser
import random

import psycopg2
from PyQt6.QtCore import QSize, Qt
from PyQt6.QtGui import QFont
from PyQt6.QtWidgets import (QPushButton, QLineEdit,
                             QLabel, QMessageBox,
                             QDialog, QVBoxLayout, QHBoxLayout, QComboBox,
                             QCalendarWidget, QMainWindow, QTableWidget, QTableWidgetItem)


def connection(config_file):
    config = configparser.ConfigParser()
    config.read(config_file)
    conn = psycopg2.connect(user=config.get("databaseN", "username"),
                            password=str(config.get("databaseN", "password")),
                            host=config.get("databaseN", "host"),
                            port=config.get("databaseN", "port"),
                            database=config.get("databaseN", "database"))
    return conn


class admin_widget(QDialog):
    def __init__(self):
        super().__init__()
        self.setWindowTitle('Администратор')
        self.setFixedSize(QSize(700, 600))
        self.connect = connection('config.ini')
        self.cursor = self.connect.cursor()
        self.observe = None
        self.current_func = 'ADD'

        self.title_label = QLabel('Панель администратора', self)
        self.title_label.setFont(QFont("Arial", 14, weight=QFont.Weight.Bold))
        self.title_label.setAlignment(Qt.AlignmentFlag.AlignHCenter)
        self.title_label.setStyleSheet('margin-top: 30px; margin-bottom: 80px;')

        button_width = 200
        button_height = 80
        self.register_button = QPushButton('Зарегистрировать рейс', self)
        self.register_button.setFont(QFont("Arial", 10, weight=QFont.Weight.Bold))
        self.register_button.setFixedSize(QSize(button_width, button_height))
        self.register_button.setCheckable(True)
        self.register_button.setStyleSheet(
            """
            QPushButton:hover {
                background-color: lightgrey;
                border: 1px solid black;
                border-radius: 5px;
            }
            QPushButton:checked {
                background-color: lightyellow;
                border: 1px solid black;
                border-radius: 5px;
            }
            """)
        self.register_button.clicked.connect(lambda: self.func_click('ADD'))
        self.remove_button = QPushButton('Аннулировать рейс', self)
        self.remove_button.setFont(QFont("Arial", 10, weight=QFont.Weight.Bold))
        self.remove_button.setFixedSize(QSize(button_width, button_height))
        self.remove_button.setCheckable(True)
        self.remove_button.setStyleSheet(
            """
            QPushButton:hover {
                background-color: lightgrey;
                border: 1px solid black;
                border-radius: 5px;
            }
            QPushButton:checked {
                background-color: lightyellow;
                border: 1px solid black;
                border-radius: 5px;
            }
            """)
        self.remove_button.clicked.connect(lambda: self.func_click('RMV'))
        self.tech_button = QPushButton('Техническое обслуживание', self)
        self.tech_button.setFont(QFont("Arial", 10, weight=QFont.Weight.Bold))
        self.tech_button.setFixedSize(QSize(button_width, button_height))
        self.tech_button.setCheckable(True)
        self.tech_button.setStyleSheet(
            """
            QPushButton:hover {
                background-color: lightgrey;
                border: 1px solid black;
                border-radius: 5px;
            }
            QPushButton:checked {
                background-color: lightyellow;
                border: 1px solid black;
                border-radius: 5px;
            }
            """)
        self.tech_button.clicked.connect(lambda: self.func_click('TECH'))
        self.observe_button = QPushButton('Просмотреть расписание', self)
        self.observe_button.setFont(QFont("Arial", 10, weight=QFont.Weight.Bold))
        self.observe_button.setFixedSize(QSize(button_width, button_height))
        self.observe_button.setCheckable(True)
        self.observe_button.setStyleSheet(
            """
            QPushButton:hover {
                background-color: lightgrey;
                border: 1px solid black;
                border-radius: 5px;
            }
            QPushButton:checked {
                background-color: lightyellow;
                border: 1px solid black;
                border-radius: 5px;
            }
            """)
        self.observe_button.clicked.connect(lambda: self.func_click('SHOW'))

        self.func_box = QVBoxLayout()
        self.func_box.setAlignment(Qt.AlignmentFlag.AlignHCenter)
        self.func_box.setSpacing(30)
        self.func_box.setContentsMargins(20, 0, 0, 0)
        self.func_box.addWidget(self.register_button)
        self.func_box.addWidget(self.remove_button)
        # self.func_box.addWidget(self.tech_button)   # not used
        self.tech_button.hide()
        self.func_box.addWidget(self.observe_button)

        self.departure_label = QLabel('Откуда', self)
        self.departure_label.setFont(QFont("Arial", 10))
        self.departure_label.setAlignment(Qt.AlignmentFlag.AlignLeft)
        self.departure_label.setStyleSheet('margin-left: 5px;')
        self.cursor.execute(f'SELECT DISTINCT rs.city FROM schedule_train.railway_station rs')
        available_cities = self.cursor.fetchall()
        self.departure_combobox = QComboBox(self)
        self.departure_combobox.addItems(c[0] for c in available_cities)
        self.departure_combobox.setFixedSize(QSize(200, 50))
        self.departure_combobox.setPlaceholderText('Откуда')
        self.departure_combobox.currentIndexChanged.connect(
            lambda index, combo_box=self.departure_combobox: self.city_changed(index, combo_box))
        self.departure_railway_combobox = QComboBox(self)
        self.departure_railway_combobox.setFixedSize(QSize(200, 50))
        self.departure_railway_combobox.setPlaceholderText('Вокзал')
        self.departure_railway_combobox.setEnabled(False)
        self.d_combobox_box = QHBoxLayout()
        self.d_combobox_box.setAlignment(Qt.AlignmentFlag.AlignVCenter)
        self.d_combobox_box.setSpacing(5)
        self.d_combobox_box.addWidget(self.departure_combobox)
        self.d_combobox_box.addWidget(self.departure_railway_combobox)
        self.departure_date = QLineEdit(self)
        self.departure_date.setPlaceholderText('Дата отправления')
        self.departure_date.setFixedSize(QSize(200, 50))
        self.departure_time = QLineEdit(self)
        self.departure_time.setPlaceholderText('Время отправления')
        self.departure_time.setFixedSize(QSize(200, 50))
        self.d_datetime_box = QHBoxLayout()
        self.d_datetime_box.setAlignment(Qt.AlignmentFlag.AlignVCenter)
        self.d_datetime_box.setSpacing(5)
        self.d_datetime_box.addWidget(self.departure_date)
        self.d_datetime_box.addWidget(self.departure_time)
        # ---
        self.arrival_label = QLabel('Куда', self)
        self.arrival_label.setFont(QFont("Arial", 10))
        self.arrival_label.setAlignment(Qt.AlignmentFlag.AlignLeft)
        self.arrival_label.setStyleSheet('margin-left: 5px;')
        self.arrival_combobox = QComboBox(self)
        self.arrival_combobox.addItems(c[0] for c in available_cities)
        self.arrival_combobox.setFixedSize(QSize(200, 50))
        self.arrival_combobox.setPlaceholderText('Куда')
        self.arrival_combobox.currentIndexChanged.connect(
            lambda index, combo_box=self.arrival_combobox: self.city_changed(index, combo_box))
        self.arrival_railway_combobox = QComboBox(self)
        self.arrival_railway_combobox.setFixedSize(QSize(200, 50))
        self.arrival_railway_combobox.setPlaceholderText('Вокзал')
        self.arrival_railway_combobox.setEnabled(False)
        self.a_combobox_box = QHBoxLayout()
        self.a_combobox_box.setAlignment(Qt.AlignmentFlag.AlignVCenter)
        self.a_combobox_box.setSpacing(5)
        self.a_combobox_box.addWidget(self.arrival_combobox)
        self.a_combobox_box.addWidget(self.arrival_railway_combobox)
        self.arrival_date = QLineEdit(self)
        self.arrival_date.setPlaceholderText('Дата прибытия')
        self.arrival_date.setFixedSize(QSize(200, 50))
        self.arrival_time = QLineEdit(self)
        self.arrival_time.setPlaceholderText('Время прибытия')
        self.arrival_time.setFixedSize(QSize(200, 50))
        self.a_datetime_box = QHBoxLayout()
        self.a_datetime_box.setAlignment(Qt.AlignmentFlag.AlignVCenter)
        self.a_datetime_box.setSpacing(5)
        self.a_datetime_box.addWidget(self.arrival_date)
        self.a_datetime_box.addWidget(self.arrival_time)
        self.execute_button = QPushButton('Выполнить', self)
        self.execute_button.setFont(QFont("Arial", 12, weight=QFont.Weight.Bold))
        self.execute_button.setFixedSize(QSize(410, 50))
        self.execute_button.setStyleSheet(f'background-color: lightgrey')
        self.execute_button.clicked.connect(self.execute_func)
        self.execute_button.setEnabled(False)

        self.departure_calendar = QCalendarWidget(self)
        self.departure_calendar.setGeometry(self.departure_date.pos().x(),
                                            self.departure_date.pos().y(),
                                            200, 200)
        self.departure_calendar.hide()
        self.departure_date.mousePressEvent = lambda event, date=self.departure_date: (
            self.show_calendar(event, date))
        self.departure_calendar.clicked.connect(lambda: self.set_date(self.departure_calendar))
        self.arrival_calendar = QCalendarWidget(self)
        self.arrival_calendar.setGeometry(self.arrival_date.mapToGlobal(self.arrival_date.pos()).x(),
                                          self.arrival_date.mapToGlobal(self.arrival_date.pos()).y(),
                                          200, 200)
        self.arrival_calendar.hide()
        self.arrival_date.mousePressEvent = lambda event, date=self.arrival_date: (
            self.show_calendar(event, date))
        self.arrival_calendar.clicked.connect(lambda: self.set_date(self.arrival_calendar))

        self.input_box = QVBoxLayout()
        self.input_box.setSpacing(20)
        self.input_box.setAlignment(Qt.AlignmentFlag.AlignHCenter)
        self.input_box.addWidget(self.departure_label)
        self.input_box.addItem(self.d_combobox_box)
        self.input_box.addItem(self.d_datetime_box)
        self.input_box.addWidget(self.arrival_label)
        self.input_box.addItem(self.a_combobox_box)
        self.input_box.addItem(self.a_datetime_box)
        self.input_box.addWidget(self.execute_button)
        self.input_box.addStretch(0)

        self.workspace_box = QHBoxLayout()
        self.workspace_box.setAlignment(Qt.AlignmentFlag.AlignVCenter)
        self.workspace_box.addItem(self.func_box)
        self.workspace_box.addItem(self.input_box)

        self.main_box = QVBoxLayout()
        self.main_box.setAlignment(Qt.AlignmentFlag.AlignHCenter)
        self.main_box.addWidget(self.title_label)
        self.main_box.addItem(self.workspace_box)
        self.main_box.addStretch(0)
        self.setLayout(self.main_box)

    def city_changed(self, index, source):
        if source is self.departure_combobox:
            target = self.departure_railway_combobox
        else:
            target = self.arrival_railway_combobox
        target.clear()
        city = source.itemText(index)
        self.cursor.execute(f"SELECT DISTINCT rs.name_railway_station FROM schedule_train.railway_station rs WHERE rs.city = '{city}'")
        stations = self.cursor.fetchall()
        target.setEnabled(True)
        target.addItems(s[0] for s in stations)

    def show_calendar(self, e, date):
        if date == self.departure_date:
            target = self.departure_calendar
            self.arrival_calendar.hide()
        else:
            target = self.arrival_calendar
            self.departure_calendar.hide()
        target.setGeometry(date.pos().x(),
                           date.pos().y() - 20,
                           200, 200)
        target.show()
        target.raise_()

    def mousePressEvent(self, e):
        self.arrival_calendar.hide()
        self.departure_calendar.hide()

    def set_date(self, source):
        selected_date = source.selectedDate()
        if source == self.departure_calendar:
            target = self.departure_date
        else:
            target = self.arrival_date
        target.setText(selected_date.toString('yyyy-MM-dd'))
        source.hide()

    def func_click(self, status):
        if status == 'SHOW':
            self.execute_button.setEnabled(False)
            self.observe = Observe()
            self.observe.show()
        else:
            self.execute_button.setEnabled(True)
        if status != 'ADD':
            self.register_button.setChecked(False)
        if status != 'RMV':
            self.remove_button.setChecked(False)
        if status != 'TECH':
            self.tech_button.setChecked(False)
        if status != 'SHOW':
            self.observe_button.setChecked(False)
        self.current_func = status

    def execute_func(self):
        try:

            self.cursor.execute(
                f"SELECT DISTINCT r.railway_station_id FROM schedule_train.railway_station r WHERE r.name_railway_station = '{self.departure_railway_combobox.itemText(self.departure_railway_combobox.currentIndex())}'")
            departure_station_id = self.cursor.fetchone()[0]

            self.cursor.execute(
                f"SELECT DISTINCT r.railway_station_id FROM schedule_train.railway_station r WHERE r.name_railway_station = '{self.arrival_railway_combobox.itemText(self.arrival_railway_combobox.currentIndex())}'")
            arrival_station_id = self.cursor.fetchone()[0]

            match self.current_func:
                case 'ADD':
                    voyage_number = (self.departure_combobox.itemText(self.departure_combobox.currentIndex())[0]
                                     + '-' + str(random.randint(1000, 9999)) + '-'
                                     + self.arrival_combobox.itemText(self.arrival_combobox.currentIndex())[0])
                    voyage_name = (self.departure_combobox.itemText(self.departure_combobox.currentIndex())
                                   + ' - '
                                   + self.arrival_combobox.itemText(self.arrival_combobox.currentIndex()))
                    self.cursor.execute("SELECT t.train_id FROM schedule_train.train t ORDER BY t.train_id ASC")
                    tmp = [i[0] for i in self.cursor.fetchall()]
                    train_id = tmp[random.randint(0, len(tmp) - 1)]
                    self.cursor.execute("SELECT c.composition_wagons_id FROM schedule_train.composition_wagons c ORDER BY c.composition_wagons_id ASC")
                    tmp = [i[0] for i in self.cursor.fetchall()]
                    composition_wagon_id = tmp[random.randint(0, len(tmp) - 1)]
                    self.cursor.execute("SELECT c.carrier_id FROM schedule_train.carrier c ORDER BY c.carrier_id ASC")
                    tmp = [i[0] for i in self.cursor.fetchall()]
                    carrier_id = tmp[random.randint(0, len(tmp) - 1)]

                    self.cursor.execute(f"INSERT INTO schedule_train.voage (number_voage, name_voage, train_id, composition_wagons_id, carrier_id) VALUES ('{voyage_number}', '{voyage_name}', '{train_id}', '{composition_wagon_id}', '{carrier_id}')")
                    self.connect.commit()

                    self.cursor.execute(f"SELECT DISTINCT v.voage_id FROM schedule_train.voage v WHERE number_voage = '{voyage_number}' AND name_voage = '{voyage_name}'")
                    voyage_id = self.cursor.fetchone()[0]

                    self.cursor.execute(
                        f"INSERT INTO schedule_train.schedule (departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) VALUES ('{departure_station_id}', '{arrival_station_id}', '{self.departure_date.text()}', '{self.arrival_date.text()}', '{0}', '{voyage_id}', '{self.departure_time.text()}', '{self.arrival_time.text()}')")
                    self.connect.commit()
                    self.show_box('Успешно!', 'Успешная регистрация рейса!')

                case 'RMV':
                    self.cursor.execute(f"DELETE FROM schedule_train.schedule s WHERE departure_station_id = '{departure_station_id}' AND arrival_station_id = '{arrival_station_id}' AND departure_date = '{self.departure_date.text()}' AND arrival_date = '{self.arrival_date.text()}' AND departure_time = '{self.departure_time.text()}' AND arrival_time = '{self.arrival_time.text()}'")
                    self.connect.commit()
                    self.show_box('Успешно!', 'Успешное аннулирование рейса!')
                case _:
                    self.show_box('Ошибка!', 'Что-то пошло не так!')

        except Exception as ex:
            self.show_box('Ошибка!', 'Что-то пошло не так!')

    def show_box(self, title, message):
        cancel_dialog = QMessageBox(self)
        cancel_dialog.setWindowTitle(title)
        cancel_dialog.setText(message)
        cancel_dialog.exec()


class Observe(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle('Расписание рейсов')
        self.setFixedSize(QSize(850, 600))
        self.connect = connection('config.ini')
        self.cursor = self.connect.cursor()

        self.cursor.execute(f"SELECT * FROM schedule_train.schedule s")
        data = self.cursor.fetchall()

        self.data_table = QTableWidget(self)
        self.data_table.setFixedSize(QSize(850, 600))
        self.data_table.setColumnCount(9)
        self.data_table.setHorizontalHeaderLabels(
            ['Id', 'Отправление', 'Прибытие', 'Дата отправления',
             'Дата прибытия', 'Задержка', 'Id маршрута',
             'Время отправления', 'Время прибытия']
        )
        self.data_table.setRowCount(len(data))
        self.data_table.resizeColumnsToContents()
        for column in range(self.data_table.columnCount()):
            self.data_table.horizontalHeaderItem(column).setTextAlignment(Qt.AlignmentFlag.AlignCenter)
        for i, row in enumerate(data):
            (sch_id, departure_id, arrival_id, departure_date,
             arrival_date, delay, voyage_id, departure_time, arrival_time) = tuple(str(d) for d in row)
            self.cursor.execute(f"SELECT rs.name_railway_station, rs.city FROM schedule_train.railway_station rs WHERE rs.railway_station_id = {departure_id}")
            tmp = self.cursor.fetchone()
            departure_name = f'{tmp[0]} ({tmp[1]})'

            self.cursor.execute(f"SELECT rs.name_railway_station, rs.city FROM schedule_train.railway_station rs WHERE rs.railway_station_id = {arrival_id}")
            tmp = self.cursor.fetchone()
            arrival_name = f'{tmp[0]} ({tmp[1]})'

            tmp = QTableWidgetItem(sch_id)
            tmp.setTextAlignment(Qt.AlignmentFlag.AlignCenter)
            self.data_table.setItem(i, 0, tmp)
            tmp = QTableWidgetItem(departure_name)
            tmp.setTextAlignment(Qt.AlignmentFlag.AlignCenter)
            self.data_table.setItem(i, 1, tmp)
            tmp = QTableWidgetItem(arrival_name)
            tmp.setTextAlignment(Qt.AlignmentFlag.AlignCenter)
            self.data_table.setItem(i, 2, tmp)
            tmp = QTableWidgetItem(departure_date)
            tmp.setTextAlignment(Qt.AlignmentFlag.AlignCenter)
            self.data_table.setItem(i, 3, tmp)
            tmp = QTableWidgetItem(arrival_date)
            tmp.setTextAlignment(Qt.AlignmentFlag.AlignCenter)
            self.data_table.setItem(i, 4, tmp)
            tmp = QTableWidgetItem(delay)
            tmp.setTextAlignment(Qt.AlignmentFlag.AlignCenter)
            self.data_table.setItem(i, 5, tmp)
            tmp = QTableWidgetItem(voyage_id)
            tmp.setTextAlignment(Qt.AlignmentFlag.AlignCenter)
            self.data_table.setItem(i, 6, tmp)
            tmp = QTableWidgetItem(departure_time)
            tmp.setTextAlignment(Qt.AlignmentFlag.AlignCenter)
            self.data_table.setItem(i, 7, tmp)
            tmp = QTableWidgetItem(arrival_time)
            tmp.setTextAlignment(Qt.AlignmentFlag.AlignCenter)
            self.data_table.setItem(i, 8, tmp)

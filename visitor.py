import sys
import configparser
from PyQt6.QtCore import QSize, Qt
from PyQt6.QtGui import QFont, QIcon
from PyQt6.QtWidgets import QApplication, QMainWindow, QPushButton, QLineEdit, QLabel, QMessageBox, QDialog, \
    QVBoxLayout, QWidget, QGridLayout, QCalendarWidget, QComboBox, QTableWidget, QTableWidgetItem
import psycopg2
import datetime


class visitor_widget(QMainWindow):
    def __init__(self):
        super().__init__()
        self.in_city = None
        self.from_city = None
        self.direction = None
        self.voage_button = None
        self.voage_input = None
        self.voage_label = None
        self.schedule_train_button = None
        self.schedule_train_label = None
        self.choose_railway_station = None
        self.schedule_label = None
        self.city_button = None
        self.city_input = None
        self.time = None
        self.city = None
        self.calendar = None
        self.find_button = None
        self.search_input_data = None
        self.search_input_where = None
        self.search_input_where_from = None
        self.label = None
        self.cursor = None
        config_file = 'config.ini'
        self.connection(config_file)
        self.interface()

    def connection(self, config_file):
        config = configparser.ConfigParser()
        config.read(config_file)
        conn = psycopg2.connect(user=config.get("databaseN", "username"),
                                password=str(config.get("databaseN", "password")),
                                host=config.get("databaseN", "host"),
                                port=config.get("databaseN", "port"),
                                database=config.get("databaseN", "database"))
        self.cursor = conn.cursor()

    def interface(self):
        self.setFixedSize(QSize(700, 600))
        self.setWindowTitle('Посетитель')

        self.label = QLabel('Расписание пригородных и межгородских поездов', self)
        self.label.setFont(QFont("Arial", 14, weight=QFont.Weight.Bold))
        self.label.setGeometry(100, 25, 500, 30)

        self.search_input_where_from = QLineEdit(self)
        self.search_input_where_from.setPlaceholderText('Город откуда')
        self.search_input_where_from.setGeometry(40, 75, 200, 40)

        self.search_input_where = QLineEdit(self)
        self.search_input_where.setPlaceholderText('Город куда')
        self.search_input_where.setGeometry(240, 75, 200, 40)

        self.search_input_data = QLineEdit(self)
        self.search_input_data.setPlaceholderText('Дата')
        self.search_input_data.setGeometry(440, 75, 150, 40)

        self.find_button = QPushButton("Найти", self)
        self.find_button.setGeometry(590, 75, 75, 40)
        self.find_button.setStyleSheet('background-color: yellow')
        self.find_button.clicked.connect(self.open_schedule)

        self.calendar = QCalendarWidget(self)
        self.calendar.setGeometry(450, 125, 200, 200)
        self.calendar.hide()
        self.search_input_data.mousePressEvent = self.show_calendar
        self.calendar.clicked.connect(self.set_date)

        self.city = QLabel('Москва', self)
        self.city.setGeometry(40, 150, 170, 50)
        self.city.mousePressEvent = self.show_city
        self.city.setStyleSheet("QLabel:hover {color: blue;}")
        self.city.setFont(QFont("Arial", 14))

        weakday = {"0": "Понедельник",
                   "1": "Вторник",
                   "2": "Среда",
                   "3": "Четверг",
                   "4": "Пятница",
                   "5": "Суббота",
                   "6": "Воскресенье"}
        weekday_number = datetime.datetime.today().weekday()
        self.time = QLabel(
            str(datetime.datetime.now().replace(second=0, microsecond=0)) + ", " + weakday[str(weekday_number)], self)
        self.time.setGeometry(40, 170, 200, 50)

        self.city_input = QLineEdit(self)
        self.city_input.setPlaceholderText('Город')
        self.city_input.setGeometry(180, 160, 100, 30)
        self.city_input.hide()

        self.city_button = QPushButton("Сменить", self)
        self.city_button.setStyleSheet('background-color: yellow')
        self.city_button.setGeometry(280, 160, 70, 30)
        self.city_button.clicked.connect(self.city_button_behavior)
        self.city_button.hide()

        text = "Расписание в городе " + self.city.text()
        self.schedule_label = QLabel(text, self)
        self.schedule_label.setGeometry(40, 220, 400, 30)
        self.schedule_label.setFont(QFont("Arial", 14))

        self.choose_railway_station = QComboBox(self)
        self.choose_railway_station.setGeometry(40, 280, 180, 30)
        self.cursor.execute(
            f"SELECT rs.name_railway_station FROM schedule_train.railway_station rs WHERE rs.city = '{self.city.text()}'")
        choose = self.cursor.fetchall()
        ch = [str(i[0]) for i in choose]
        self.choose_railway_station.addItems(list(ch))

        self.schedule_train_label = QLabel('Вокзал', self)
        self.schedule_train_label.setGeometry(40, 250, 150, 30)
        self.schedule_train_label.setFont(QFont("Arial", 10))

        self.schedule_train_button = QPushButton(self)
        self.schedule_train_button.setGeometry(220, 279, 55, 32)
        self.schedule_train_button.setIcon(QIcon('search.png'))
        self.schedule_train_button.clicked.connect(self.open_schedule_railway_station)



        self.voage_label = QLabel('Найти рейс', self)
        self.voage_label.setGeometry(400, 220, 100, 30)
        self.voage_label.setFont(QFont("Arial", 14))

        self.voage_input = QLineEdit(self)
        self.voage_input.setGeometry(400, 260, 180, 34)
        self.voage_input.setPlaceholderText('Поиск рейса')

        self.voage_button = QPushButton(self)
        self.voage_button.setGeometry(580, 260, 55, 36)
        self.voage_button.setIcon(QIcon('search.png'))

        self.direction = QLabel('Популярные направления', self)
        self.direction.setGeometry(400, 315, 200, 30)
        self.direction.setFont(QFont("Arial", 12))

        self.from_city = QLabel(f'Из города {self.city.text()}', self)
        self.from_city.setGeometry(370, 350, 150, 30)
        self.from_city.setFont(QFont("Arial", 11, weight=QFont.Weight.Bold))

        self.in_city = QLabel(f'В город {self.city.text()}', self)
        self.in_city.setGeometry(530, 350, 150, 30)
        self.in_city.setFont(QFont("Arial", 11, weight=QFont.Weight.Bold))

        self.cursor.execute(f"SELECT DISTINCT rs2.city FROM schedule_train.railway_station rs1, schedule_train.schedule sc,\
        schedule_train.railway_station rs2 WHERE sc.departure_station_id = rs1.railway_station_id AND  rs1.city = '{self.city.text()}' AND sc.arrival_station_id = rs2.railway_station_id")
        city_in = self.cursor.fetchall()
        self.city_in_array = []
        for i in range(5):
            if len(city_in) >= i + 1:
                self.label = QLabel(f'В {city_in[i][0]}', self)
                self.label.setGeometry(370, 390 + 30 * i, 120, 15)
                self.label.setStyleSheet("QLabel:hover {color: blue;}")
                self.label.mousePressEvent = lambda checked, btn_number = i + 1: self.chpo(btn_number)
                self.city_in_array.append(self.label)
            else:
                self.label = QLabel(f'В ', self)
                self.label.setGeometry(370, 390 + 30 * i, 120, 15)
                self.label.setStyleSheet("QLabel:hover {color: blue;}")
                self.label.mousePressEvent = lambda checked, btn_number=i + 1: self.chpo(btn_number)
                self.city_in_array.append(self.label)
                self.label.hide()

        self.cursor.execute(f"SELECT DISTINCT rs2.city FROM schedule_train.railway_station rs1, schedule_train.schedule sc,\
        schedule_train.railway_station rs2 WHERE sc.arrival_station_id = rs1.railway_station_id AND  rs1.city = '{self.city.text()}' AND sc.departure_station_id = rs2.railway_station_id")
        city_from = self.cursor.fetchall()
        self.city_from_array = []
        for i in range(5):
            if len(city_from) >= i + 1:
                self.label1 = QLabel(f'Из {city_from[i][0]}', self)
                self.label1.setGeometry(530, 390 + 30 * i, 150, 15)
                self.label1.setStyleSheet("QLabel:hover {color: blue;}")
                self.label1.mousePressEvent = lambda checked, btn_number=i + 1: self.chpo(btn_number)
                self.city_from_array.append(self.label1)
            else:
                self.label1 = QLabel(f'Из ', self)
                self.label1.setGeometry(530, 390 + 30 * i, 150, 15)
                self.label1.setStyleSheet("QLabel:hover {color: blue;}")
                self.label1.mousePressEvent = lambda checked, btn_number=i + 1: self.chpo(btn_number)
                self.city_from_array.append(self.label1)
                self.label1.hide()


    def open_schedule_railway_station(self):
        print(self.choose_railway_station.currentText())

        if self.choose_railway_station.currentText() != "":
            self.railway_station = shedule_railway_station_widget(self.choose_railway_station.currentText(), self.city.text())
            self.railway_station.show()
        else:
            self.auth_error()

    def show_calendar(self, event):
        self.calendar.show()
        self.calendar.raise_()
        # self.voage_label.hide()
        # self.voage_input.hide()

    def chpo(self, k):
        print(k)

    def set_date(self):
        selected_date = self.calendar.selectedDate()
        self.search_input_data.setText(selected_date.toString('yyyy-MM-dd'))
        self.calendar.hide()
        self.voage_input.show()
        self.voage_label.show()

    def mousePressEvent(self, e):
        self.voage_input.show()
        self.voage_label.show()
        self.calendar.hide()
        self.city_input.hide()
        self.city_button.hide()

    def show_city(self, event):
        self.city_input.show()
        self.city_button.show()

    def search_function(self):
        print("chpo")

    def city_button_behavior(self):
        if self.city_input.text() == '':
            self.city_input.hide()
            self.city_button.hide()
            return
        self.city.setText(self.city_input.text())
        text = "Расписание в городе " + self.city.text()
        self.schedule_label.setText(text)
        self.from_city.setText(f'Из {self.city.text()}')
        self.in_city.setText(f'В {self.city.text()}')
        self.cursor.execute(
            f"SELECT rs.name_railway_station FROM schedule_train.railway_station rs WHERE rs.city = '{self.city.text()}'")
        choose = self.cursor.fetchall()
        ch = [str(i[0]) for i in choose]
        self.choose_railway_station.clear()
        self.choose_railway_station.addItems(list(ch))
        self.cursor.execute(f"SELECT DISTINCT rs2.city FROM schedule_train.railway_station rs1, schedule_train.schedule sc,\
                schedule_train.railway_station rs2 WHERE sc.departure_station_id = rs1.railway_station_id AND  rs1.city \
                = '{self.city.text()}' AND sc.arrival_station_id = rs2.railway_station_id")
        city_in = self.cursor.fetchall()
        print(city_in)
        # if len(city_in) == len(self.city_in_array):
        #     for i in range(len(city_in)):
        #         self.city_in_array[i].clear()
        #         self.city_in_array[i].setText(f"В {city_in[i][0]}")
        #         if i > 4:
        #             break
        # elif len(city_in) > len(self.city_in_array):
        #     for i in range(len(city_in)):
        #         self.city_in_array[i].clear()
        #         self.city_in_array[i].setText(f"В {city_in[i][0]}")
        #         if i > 4:
        #             break
        for i in range(5):
            if len(city_in) >= i + 1:
                print(1)
                self.city_in_array[i].clear()
                self.city_in_array[i].setText(f"В {city_in[i][0]}")
                self.city_in_array[i].show()
            else:
                print(2)
                self.city_in_array[i].hide()
        self.cursor.execute(f"SELECT DISTINCT rs2.city FROM schedule_train.railway_station rs1, schedule_train.schedule sc,\
                schedule_train.railway_station rs2 WHERE sc.arrival_station_id = rs1.railway_station_id AND  rs1.city = '{self.city.text()}' AND sc.departure_station_id = rs2.railway_station_id")
        city_from = self.cursor.fetchall()
        print(city_from)
        for i in range(5):
            if len(city_from) >= i + 1:
                print(1)
                self.city_from_array[i].clear()
                self.city_from_array[i].setText(f"Из {city_from[i][0]}")
                self.city_from_array[i].show()
            else:
                print(2)
                self.city_from_array[i].hide()

        self.city_input.hide()
        self.city_button.hide()

    def open_schedule(self):
        self.cursor.execute("SELECT DISTINCT rs.city FROM schedule_train.railway_station rs")
        c = self.cursor.fetchall()
        city = [c[i][0] for i in range(len(c))]
        if self.search_input_where_from.text() in city and self.search_input_where.text() in city:
            self.schedule_window = shedule_widget(self.search_input_where_from.text(), self.search_input_where.text(),
                                                  self.search_input_data.text())
            self.schedule_window.show()
        else:
            self.auth_error()

    # def open_railway_station(self):


    def auth_error(self):
        dlg = QMessageBox(self)
        dlg.setWindowTitle("Ошибка ввода!")
        dlg.setText("Вы допустили ошибку в вводе города откуда или куда едите, пожалуйста, попробуйте ещё раз!")
        dlg.exec()


class shedule_widget(QMainWindow):
    def __init__(self, city_from, city_in, dat):
        super().__init__()
        self.setWindowTitle('Расписание')
        self.setFixedSize(QSize(700, 600))
        config_file = 'config.ini'
        self.connection(config_file)
        self.cursor.execute(f"SELECT rs.name_railway_station, rs1.name_railway_station, sc.departure_date, sc.departure_time, vg.number_voage,\
        sc.arrival_date, sc.arrival_time, cr.name_carrier, tr.name_train FROM schedule_train.railway_station rs, schedule_train.railway_station rs1,\
        schedule_train.schedule sc, schedule_train.carrier cr, schedule_train.train tr, schedule_train.voage vg WHERE sc.departure_station_id = rs.railway_station_id AND sc.arrival_station_id = rs1.railway_station_id\
        AND rs.city = '{city_from}' AND rs1.city = '{city_in}' AND sc.voage_id = vg.voage_id AND vg.carrier_id = cr.carrier_id AND vg.train_id = tr.train_id and sc.departure_date = '{dat}'")
        chpo = self.cursor.fetchall()
        print(chpo)
        if len(chpo) == 0:
            return
        print(str(chpo[0][2]) + ", " + str(chpo[0][3]))
        sc = []
        for i in chpo:
            f = (i[8], ) + (i[7],) + (i[4],) + (city_from + ", " + i[0],) + (city_in + ", " + i[1],) + (str(i[2]) + ", " + str(i[3]), ) + (str(i[5]) + ", " + str(i[6]), )
            sc.append(f)
        print(sc)

        self.label = QLabel(f"Расписание поездов из {city_from} в {city_in} за {dat}", self)
        self.label.setFont(QFont("Arial", 14, weight=QFont.Weight.Bold))
        self.label.setGeometry(100, 25, 600, 30)
        self.tableWidget = QTableWidget(self)
        self.tableWidget.setGeometry(0, 80, 700, 520)

        self.tableWidget.setColumnCount(7)
        self.tableWidget.setHorizontalHeaderLabels(
            ['Поезд', 'Перевозчик', 'Номер рейса', 'Откуда', 'Куда', 'Время отправления',  'Время прибытия'])
        self.tableWidget.setRowCount(len(sc))
        for i, (train, carrier, voage, from_, in_, date_from, date_in) in enumerate(sc):
            self.tableWidget.setItem(i, 0, QTableWidgetItem(train))
            self.tableWidget.setItem(i, 1, QTableWidgetItem(carrier))
            self.tableWidget.setItem(i, 3, QTableWidgetItem(from_))
            self.tableWidget.setItem(i, 4, QTableWidgetItem(in_))
            self.tableWidget.setItem(i, 5, QTableWidgetItem(date_from))
            self.tableWidget.setItem(i, 6, QTableWidgetItem(date_in))
            self.tableWidget.setItem(i, 2, QTableWidgetItem(voage))
            print(carrier)
            self.cursor.execute(f"SELECT cr.inn, cr.director, cr.legal_address FROM schedule_train.carrier cr \
            WHERE cr.name_carrier = '{carrier}'")
            car = self.cursor.fetchall()
            item = self.tableWidget.item(i, 1)
            item.setToolTip(f'Информация о перевозчике {carrier}\nINN: {car[0][0]}\nФИО директора: {car[0][1]}\nЮридический адресс: {car[0][2]}')
            self.tableWidget.item(i, 0)
            self.cursor.execute(f"SELECT tr.name_train, tr.hours_in_operation, man.manufacturer_name,\
            (cm.compartment_wagon_number * wg1.number_seats) , (cm.reserved_seat_number * wg.number_seats) \
            FROM schedule_train.train tr, schedule_train.manufacturer man, \
            schedule_train.composition_wagons cm, schedule_train.wagon wg, schedule_train.voage vg, schedule_train.wagon wg1\
            WHERE tr.number_train = '2056' AND man.manufacturer_id = tr.manufacturer_id\
            AND vg.number_voage = 'М-777-Т' AND vg.composition_wagons_id = cm.composition_wagons_id AND\
            cm.composition_wagons_type_id = wg1.wagon_id AND cm.reserved_seat_type_id = wg.wagon_id")
            tr = self.cursor.fetchall()
            item2 = self.tableWidget.item(i, 0)
            item2.setToolTip(f"Название поезда {tr[0][0]}\nЧасав в эксплуатации {tr[0][1]}\nПроизводитель {tr[0][2]}\nКоличе"
                             f"ство мест купе {tr[0][3]}\nКоличество мест плацкарт {tr[0][4]}")
            self.tableWidget.item(i, 0)



    def connection(self, config_file):
        config = configparser.ConfigParser()
        config.read(config_file)
        conn = psycopg2.connect(user=config.get("databaseN", "username"),
                                password=str(config.get("databaseN", "password")),
                                host=config.get("databaseN", "host"),
                                port=config.get("databaseN", "port"),
                                database=config.get("databaseN", "database"))
        self.cursor = conn.cursor()

class shedule_railway_station_widget(QMainWindow):
    def __init__(self, name_railway_station, city):
        super().__init__()
        self.setWindowTitle('Расписание')
        self.setFixedSize(QSize(700, 600))
        config_file = 'config.ini'
        self.connection(config_file)
        print(name_railway_station)
        self.label = QLabel(f"Расписание поездов в городе {city} \n    на вокзале {name_railway_station}", self)
        self.label.setFont(QFont("Arial", 14, weight=QFont.Weight.Bold))
        self.label.setGeometry(170, 25, 600, 60)
        self.depart_button = QPushButton("Отправляются", self)
        self.depart_button.setGeometry(180, 100, 170, 30)
        self.depart_button.setCheckable(True)
        self.depart_button.setChecked(True)
        self.cursor.execute(f"SELECT rs.name_railway_station, rs1.name_railway_station, sc.departure_date, sc.departure_time, vg.number_voage,\
        sc.arrival_date, sc.arrival_time, cr.name_carrier, tr.name_train FROM schedule_train.railway_station rs, schedule_train.railway_station rs1,\
        schedule_train.schedule sc, schedule_train.carrier cr, schedule_train.train tr, schedule_train.voage vg WHERE sc.departure_station_id = rs.railway_station_id AND sc.arrival_station_id = rs1.railway_station_id\
        AND rs.name_railway_station = '{name_railway_station}' AND sc.voage_id = vg.voage_id AND vg.carrier_id = cr.carrier_id AND vg.train_id = tr.train_id ")
        chpo = self.cursor.fetchall()
        print(chpo)
        if len(chpo) == 0:
            return
        print(str(chpo[0][2]) + ", " + str(chpo[0][3]))
        sc = []
        for i in chpo:
            f = (i[8],) + (i[7],) + (i[4],) + (i[0],) + (i[1],) + (
            str(i[2]) + ", " + str(i[3]),) + (str(i[5]) + ", " + str(i[6]),)
            sc.append(f)
        print(sc)

        self.label = QLabel(f"Расписание поездов из города {city} с вокзала {name_railway_station}", self)
        self.label.setFont(QFont("Arial", 14, weight=QFont.Weight.Bold))
        self.label.setGeometry(100, 140, 600, 30)
        self.tableWidget = QTableWidget(self)
        self.tableWidget.setGeometry(0, 200, 700, 520)

        self.tableWidget.setColumnCount(7)
        self.tableWidget.setHorizontalHeaderLabels(
            ['Поезд', 'Перевозчик', 'Номер рейса', 'Откуда', 'Куда', 'Время отправления', 'Время прибытия'])
        self.tableWidget.setRowCount(len(sc))
        for i, (train, carrier, voage, from_, in_, date_from, date_in) in enumerate(sc):
            self.tableWidget.setItem(i, 0, QTableWidgetItem(train))
            self.tableWidget.setItem(i, 1, QTableWidgetItem(carrier))
            self.tableWidget.setItem(i, 3, QTableWidgetItem(from_))
            self.tableWidget.setItem(i, 4, QTableWidgetItem(in_))
            self.tableWidget.setItem(i, 5, QTableWidgetItem(date_from))
            self.tableWidget.setItem(i, 6, QTableWidgetItem(date_in))
            self.tableWidget.setItem(i, 2, QTableWidgetItem(voage))
            print(carrier)
            self.cursor.execute(f"SELECT cr.inn, cr.director, cr.legal_address FROM schedule_train.carrier cr \
                    WHERE cr.name_carrier = '{carrier}'")
            car = self.cursor.fetchall()
            item = self.tableWidget.item(i, 1)
            item.setToolTip(
                f'Информация о перевозчике {carrier}\nINN: {car[0][0]}\nФИО директора: {car[0][1]}\nЮридический адресс: {car[0][2]}')
            self.tableWidget.item(i, 0)
            self.cursor.execute(f"SELECT tr.name_train, tr.hours_in_operation, man.manufacturer_name,\
                    (cm.compartment_wagon_number * wg1.number_seats) , (cm.reserved_seat_number * wg.number_seats)\
                    FROM schedule_train.train tr, schedule_train.manufacturer man,\
                    schedule_train.composition_wagons cm, schedule_train.wagon wg, schedule_train.voage vg, schedule_train.wagon wg1\
                    WHERE tr.train_id = vg.train_id AND man.manufacturer_id = tr.manufacturer_id\
                    AND vg.number_voage = '{voage}' AND vg.composition_wagons_id = cm.composition_wagons_id AND\
                    cm.composition_wagons_type_id = wg1.wagon_id AND cm.reserved_seat_type_id = wg.wagon_id ")
            tr = self.cursor.fetchall()
            item2 = self.tableWidget.item(i, 0)
            item2.setToolTip(
                f"Название поезда {tr[0][0]}\nЧасав в эксплуатации {tr[0][1]}\nПроизводитель {tr[0][2]}\nКоличе"
                f"ство мест купе {tr[0][3]}\nКоличество мест плацкарт {tr[0][4]}")
            self.tableWidget.item(i, 0)


        self.depart_button.clicked.connect(self.schedule_depart)
        #self.depart_button.clicked.connect(self.city_button_behavior)



        self.arrive_button = QPushButton("Прибывают", self)
        self.arrive_button.setGeometry(348, 100, 170, 30)
        self.arrive_button.setCheckable(True)


        self.arrive_button.clicked.connect(self.schedule_arrive)




    def schedule_depart(self):
        self.depart_button.setChecked(True)
        self.arrive_button.setChecked(False)

        print("fklkf")

    def schedule_arrive(self):
        self.depart_button.setChecked(False)
        self.arrive_button.setChecked(True)

        print("fmc")




    def connection(self, config_file):
        config = configparser.ConfigParser()
        config.read(config_file)
        conn = psycopg2.connect(user=config.get("databaseN", "username"),
                                password=str(config.get("databaseN", "password")),
                                host=config.get("databaseN", "host"),
                                port=config.get("databaseN", "port"),
                                database=config.get("databaseN", "database"))
        self.cursor = conn.cursor()
def main():
    app = QApplication(sys.argv)
    window = visitor_widget()
    window.show()
    sys.exit(app.exec())


if __name__ == '__main__':
    main()

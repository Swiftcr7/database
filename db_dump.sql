--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

-- Started on 2023-12-28 03:14:50

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 8 (class 2615 OID 16446)
-- Name: schedule_train; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA schedule_train;


ALTER SCHEMA schedule_train OWNER TO postgres;

--
-- TOC entry 7 (class 2615 OID 16399)
-- Name: train_schedule; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA train_schedule;


ALTER SCHEMA train_schedule OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 235 (class 1259 OID 16499)
-- Name: carrier; Type: TABLE; Schema: schedule_train; Owner: postgres
--

CREATE TABLE schedule_train.carrier (
    carrier_id bigint NOT NULL,
    name_carrier text NOT NULL,
    inn text NOT NULL,
    director text NOT NULL,
    legal_address text NOT NULL
);


ALTER TABLE schedule_train.carrier OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16498)
-- Name: carrier_carrier_id_seq; Type: SEQUENCE; Schema: schedule_train; Owner: postgres
--

ALTER TABLE schedule_train.carrier ALTER COLUMN carrier_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schedule_train.carrier_carrier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 16464)
-- Name: composition_wagons; Type: TABLE; Schema: schedule_train; Owner: postgres
--

CREATE TABLE schedule_train.composition_wagons (
    composition_wagons_id bigint NOT NULL,
    number_wagons bigint NOT NULL,
    compartment_wagon_number bigint,
    reserved_seat_number bigint,
    composition_wagons_type_id bigint,
    reserved_seat_type_id bigint
);


ALTER TABLE schedule_train.composition_wagons OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16463)
-- Name: composition_wagons_composition_wagons_id_seq; Type: SEQUENCE; Schema: schedule_train; Owner: postgres
--

ALTER TABLE schedule_train.composition_wagons ALTER COLUMN composition_wagons_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schedule_train.composition_wagons_composition_wagons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 16448)
-- Name: manufacturer; Type: TABLE; Schema: schedule_train; Owner: postgres
--

CREATE TABLE schedule_train.manufacturer (
    manufacturer_id bigint NOT NULL,
    manufacturer_name text NOT NULL,
    "INN" text NOT NULL,
    director_name text NOT NULL,
    legal_address text NOT NULL
);


ALTER TABLE schedule_train.manufacturer OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16447)
-- Name: manufacturer_manufacturer_id_seq; Type: SEQUENCE; Schema: schedule_train; Owner: postgres
--

ALTER TABLE schedule_train.manufacturer ALTER COLUMN manufacturer_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schedule_train.manufacturer_manufacturer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 237 (class 1259 OID 16524)
-- Name: railway_station; Type: TABLE; Schema: schedule_train; Owner: postgres
--

CREATE TABLE schedule_train.railway_station (
    railway_station_id bigint NOT NULL,
    name_railway_station text NOT NULL,
    city text NOT NULL,
    number_of_path bigint NOT NULL,
    number_of_employment bigint NOT NULL
);


ALTER TABLE schedule_train.railway_station OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16523)
-- Name: railway_station_railway_station_id_seq; Type: SEQUENCE; Schema: schedule_train; Owner: postgres
--

ALTER TABLE schedule_train.railway_station ALTER COLUMN railway_station_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schedule_train.railway_station_railway_station_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 239 (class 1259 OID 16532)
-- Name: schedule; Type: TABLE; Schema: schedule_train; Owner: postgres
--

CREATE TABLE schedule_train.schedule (
    schedule_id bigint NOT NULL,
    departure_station_id bigint NOT NULL,
    arrival_station_id bigint NOT NULL,
    departure_date date NOT NULL,
    arrival_date date NOT NULL,
    delay bigint,
    voage_id bigint NOT NULL,
    departure_time time without time zone NOT NULL,
    arrival_time time without time zone NOT NULL
);


ALTER TABLE schedule_train.schedule OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16531)
-- Name: schedule_schedule_id_seq; Type: SEQUENCE; Schema: schedule_train; Owner: postgres
--

ALTER TABLE schedule_train.schedule ALTER COLUMN schedule_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schedule_train.schedule_schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 16480)
-- Name: train; Type: TABLE; Schema: schedule_train; Owner: postgres
--

CREATE TABLE schedule_train.train (
    train_id bigint NOT NULL,
    number_train text NOT NULL,
    name_train text NOT NULL,
    date_last_service date NOT NULL,
    hours_in_operation bigint NOT NULL,
    manufacturer_id bigint NOT NULL
);


ALTER TABLE schedule_train.train OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16479)
-- Name: train_train_id_seq; Type: SEQUENCE; Schema: schedule_train; Owner: postgres
--

ALTER TABLE schedule_train.train ALTER COLUMN train_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schedule_train.train_train_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 16493)
-- Name: voage; Type: TABLE; Schema: schedule_train; Owner: postgres
--

CREATE TABLE schedule_train.voage (
    voage_id bigint NOT NULL,
    number_voage text NOT NULL,
    name_voage text NOT NULL,
    train_id bigint NOT NULL,
    composition_wagons_id bigint NOT NULL,
    carrier_id bigint NOT NULL
);


ALTER TABLE schedule_train.voage OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16492)
-- Name: voage_voage_id_seq; Type: SEQUENCE; Schema: schedule_train; Owner: postgres
--

ALTER TABLE schedule_train.voage ALTER COLUMN voage_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schedule_train.voage_voage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 16456)
-- Name: wagon; Type: TABLE; Schema: schedule_train; Owner: postgres
--

CREATE TABLE schedule_train.wagon (
    wagon_id bigint NOT NULL,
    name_wagon text NOT NULL,
    type_wagon text NOT NULL,
    number_seats bigint NOT NULL,
    load_capacity bigint NOT NULL
);


ALTER TABLE schedule_train.wagon OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16455)
-- Name: wagon_wagon_id_seq; Type: SEQUENCE; Schema: schedule_train; Owner: postgres
--

ALTER TABLE schedule_train.wagon ALTER COLUMN wagon_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schedule_train.wagon_wagon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16420)
-- Name: railway_station; Type: TABLE; Schema: train_schedule; Owner: postgres
--

CREATE TABLE train_schedule.railway_station (
    id_railway_station bigint NOT NULL,
    name_railway_station text NOT NULL,
    city text NOT NULL,
    number_of_path integer NOT NULL,
    number_of_employees integer NOT NULL
);


ALTER TABLE train_schedule.railway_station OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16423)
-- Name: railway_station_id_railway_station_seq; Type: SEQUENCE; Schema: train_schedule; Owner: postgres
--

ALTER TABLE train_schedule.railway_station ALTER COLUMN id_railway_station ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME train_schedule.railway_station_id_railway_station_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16400)
-- Name: schedule; Type: TABLE; Schema: train_schedule; Owner: postgres
--

CREATE TABLE train_schedule.schedule (
    id_schedule bigint NOT NULL,
    departure_date date NOT NULL,
    arrival_date date NOT NULL,
    deparature_time time without time zone NOT NULL,
    arrival_time time with time zone NOT NULL,
    delay time with time zone,
    railway_station_id bigint,
    voyage_id bigint,
    arrival_reilway_station_id bigint
);


ALTER TABLE train_schedule.schedule OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16403)
-- Name: schedule_id_schedule_seq; Type: SEQUENCE; Schema: train_schedule; Owner: postgres
--

ALTER TABLE train_schedule.schedule ALTER COLUMN id_schedule ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME train_schedule.schedule_id_schedule_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16409)
-- Name: train; Type: TABLE; Schema: train_schedule; Owner: postgres
--

CREATE TABLE train_schedule.train (
    id_train bigint NOT NULL,
    name_train text NOT NULL,
    "manufacturer's_name" text NOT NULL,
    date_of_manufacture date,
    date_maintanance date
);


ALTER TABLE train_schedule.train OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16412)
-- Name: train_id_train_seq; Type: SEQUENCE; Schema: train_schedule; Owner: postgres
--

ALTER TABLE train_schedule.train ALTER COLUMN id_train ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME train_schedule.train_id_train_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4935 (class 0 OID 16499)
-- Dependencies: 235
-- Data for Name: carrier; Type: TABLE DATA; Schema: schedule_train; Owner: postgres
--

INSERT INTO schedule_train.carrier (carrier_id, name_carrier, inn, director, legal_address) OVERRIDING SYSTEM VALUE VALUES (1, 'ПассажирЭкспресс', '456789012', 'Ольга Николаева Баранова', 'ул. Советская, 12, г.Таганрог');
INSERT INTO schedule_train.carrier (carrier_id, name_carrier, inn, director, legal_address) OVERRIDING SYSTEM VALUE VALUES (2, 'БыстрыйПоезд', '789012345', 'Владимир Андреевич Ильин', 'г.Москва, пр. Победы, 40');
INSERT INTO schedule_train.carrier (carrier_id, name_carrier, inn, director, legal_address) OVERRIDING SYSTEM VALUE VALUES (3, 'УдобныеПеревозки', '567890123', 'Марина Никитовна Смирнова', 'г.Дзержинск, ул. Фрунзе, 8');
INSERT INTO schedule_train.carrier (carrier_id, name_carrier, inn, director, legal_address) OVERRIDING SYSTEM VALUE VALUES (4, 'ЭлегантныйВагон', '901234567', 'Дмитрий Николаевич Васильев', 'г. Казань, пр. Космонавтов, 18');
INSERT INTO schedule_train.carrier (carrier_id, name_carrier, inn, director, legal_address) OVERRIDING SYSTEM VALUE VALUES (5, 'КомфортПоезд', '234567890', 'Екатерина Павловна Морозова', 'г. Оренбург, ул. Ленинская, 22');


--
-- TOC entry 4929 (class 0 OID 16464)
-- Dependencies: 229
-- Data for Name: composition_wagons; Type: TABLE DATA; Schema: schedule_train; Owner: postgres
--

INSERT INTO schedule_train.composition_wagons (composition_wagons_id, number_wagons, compartment_wagon_number, reserved_seat_number, composition_wagons_type_id, reserved_seat_type_id) OVERRIDING SYSTEM VALUE VALUES (1, 10, 3, 7, 2, 1);
INSERT INTO schedule_train.composition_wagons (composition_wagons_id, number_wagons, compartment_wagon_number, reserved_seat_number, composition_wagons_type_id, reserved_seat_type_id) OVERRIDING SYSTEM VALUE VALUES (2, 12, 5, 7, 3, 5);
INSERT INTO schedule_train.composition_wagons (composition_wagons_id, number_wagons, compartment_wagon_number, reserved_seat_number, composition_wagons_type_id, reserved_seat_type_id) OVERRIDING SYSTEM VALUE VALUES (3, 11, 2, 9, 2, 4);
INSERT INTO schedule_train.composition_wagons (composition_wagons_id, number_wagons, compartment_wagon_number, reserved_seat_number, composition_wagons_type_id, reserved_seat_type_id) OVERRIDING SYSTEM VALUE VALUES (4, 9, 3, 6, 2, 4);
INSERT INTO schedule_train.composition_wagons (composition_wagons_id, number_wagons, compartment_wagon_number, reserved_seat_number, composition_wagons_type_id, reserved_seat_type_id) OVERRIDING SYSTEM VALUE VALUES (5, 14, 5, 9, 3, 1);


--
-- TOC entry 4925 (class 0 OID 16448)
-- Dependencies: 225
-- Data for Name: manufacturer; Type: TABLE DATA; Schema: schedule_train; Owner: postgres
--

INSERT INTO schedule_train.manufacturer (manufacturer_id, manufacturer_name, "INN", director_name, legal_address) OVERRIDING SYSTEM VALUE VALUES (3, 'ПоездСтройИнк', '987654321', 'Анна Сидорова', 'г. Москва, пр. Рельсовый, 5');
INSERT INTO schedule_train.manufacturer (manufacturer_id, manufacturer_name, "INN", director_name, legal_address) OVERRIDING SYSTEM VALUE VALUES (4, 'ТрансПоездКомплект', '567890123', 'Петр Петров', 'г. Москва, пер. Вагонный, 10');
INSERT INTO schedule_train.manufacturer (manufacturer_id, manufacturer_name, "INN", director_name, legal_address) OVERRIDING SYSTEM VALUE VALUES (5, 'РельсТрансПром', '345678901	', 'Елена Николаева', 'г.Москва, наб. Поездная, 3');
INSERT INTO schedule_train.manufacturer (manufacturer_id, manufacturer_name, "INN", director_name, legal_address) OVERRIDING SYSTEM VALUE VALUES (6, 'ЭкспрессПоездГрупп', '789012345', 'Алексей Михайлов', 'г.Москва, ул. Транспортная, 7
');
INSERT INTO schedule_train.manufacturer (manufacturer_id, manufacturer_name, "INN", director_name, legal_address) OVERRIDING SYSTEM VALUE VALUES (2, 'Железнодорожные мастерские "Скорость"', '123456789', 'Иван Иванов', 'г.Москва, ул. Путевая, 1');


--
-- TOC entry 4937 (class 0 OID 16524)
-- Dependencies: 237
-- Data for Name: railway_station; Type: TABLE DATA; Schema: schedule_train; Owner: postgres
--

INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (1, 'Центральный', 'Москва', 12, 150);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (2, 'Новый', 'Таганрог', 5, 60);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (3, 'Главный', 'Санкт-Петербург', 10, 120);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (4, 'Южный', 'Ростов-на-Дону', 8, 100);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (5, 'Ярославль-главный', 'Ярославль', 9, 90);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (6, 'Дзержинск-главный', 'Дзержинск', 6, 70);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (7, 'Казань-пассажирский', 'Казань', 7, 80);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (8, 'Старый', 'Таганрог', 6, 70);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (11, 'Ярославский', 'Москва', 11, 170);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (12, 'Белорусский', 'Москва', 14, 200);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (13, 'Казанский', 'Москва', 12, 155);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (14, 'Казань-2', 'Казань', 7, 75);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (15, 'Ростов-западный', 'Ростов-на-Дону', 7, 80);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (16, 'Ростов-2', 'Ростов-на-Дону', 6, 65);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (17, 'Ярославль-московский', 'Ярославль', 9, 85);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (18, 'Витебский', 'Санкт-Петербург', 14, 190);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (19, 'Балтийский', 'Санкт-Петербург', 12, 175);
INSERT INTO schedule_train.railway_station (railway_station_id, name_railway_station, city, number_of_path, number_of_employment) OVERRIDING SYSTEM VALUE VALUES (20, 'Варшавский', 'Санкт-Петербург', 11, 165);


--
-- TOC entry 4939 (class 0 OID 16532)
-- Dependencies: 239
-- Data for Name: schedule; Type: TABLE DATA; Schema: schedule_train; Owner: postgres
--

INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (2, 1, 2, '2023-12-20', '2023-12-21', 0, 1, '10:00:00', '12:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (3, 1, 7, '2023-12-21', '2023-12-22', 10, 2, '21:00:00', '10:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (4, 3, 6, '2023-12-22', '2023-12-23', 5, 3, '14:00:00', '10:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (5, 1, 5, '2023-12-23', '2023-12-23', 0, 4, '15:00:00', '20:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (6, 4, 5, '2023-12-24', '2023-12-25', 20, 5, '12:00:00', '08:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (7, 1, 7, '2023-12-22', '2023-12-23', 5, 2, '21:00:00', '10:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (8, 1, 2, '2023-12-22', '2023-12-23', 5, 1, '10:00:00', '12:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (9, 3, 6, '2023-12-23', '2023-12-24', 20, 3, '14:00:00', '10:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (10, 1, 5, '2023-12-24', '2023-12-24', 0, 4, '15:00:00', '20:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (11, 4, 5, '2023-12-26', '2023-12-27', 20, 5, '12:00:00', '08:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (12, 11, 6, '2023-12-20', '2023-12-20', 0, 6, '12:00:00', '16:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (13, 12, 15, '2023-12-20', '2023-12-21', 5, 7, '13:00:00', '08:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (14, 8, 13, '2023-12-20', '2023-12-21', 0, 8, '12:00:00', '10:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (15, 18, 1, '2023-12-21', '2023-12-22', 0, 9, '17:00:00', '05:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (16, 14, 12, '2023-12-21', '2023-12-22', 0, 10, '19:00:00', '07:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (17, 16, 13, '2023-12-21', '2023-12-22', 5, 11, '15:00:00', '11:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (18, 19, 17, '2023-12-21', '2023-12-22', 10, 12, '20:00:00', '12:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (19, 2, 20, '2023-12-21', '2023-12-22', 15, 13, '06:00:00', '17:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (20, 5, 3, '2023-12-22', '2023-12-23', 0, 14, '21:00:00', '16:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (21, 16, 18, '2023-12-22', '2023-12-23', 5, 15, '19:00:00', '21:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (22, 8, 14, '2023-12-22', '2023-12-23', 5, 16, '12:00:00', '16:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (23, 5, 8, '2023-12-22', '2023-12-23', 0, 17, '08:00:00', '14:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (24, 6, 2, '2023-12-23', '2023-12-24', 0, 18, '10:00:00', '10:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (25, 6, 4, '2023-12-23', '2023-12-24', 5, 19, '11:00:00', '12:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (26, 18, 15, '2023-12-23', '2023-12-24', 0, 20, '09:00:00', '14:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (27, 7, 5, '2023-12-23', '2023-12-24', 0, 21, '12:00:00', '01:00:00');
INSERT INTO schedule_train.schedule (schedule_id, departure_station_id, arrival_station_id, departure_date, arrival_date, delay, voage_id, departure_time, arrival_time) OVERRIDING SYSTEM VALUE VALUES (28, 14, 19, '2023-12-23', '2023-12-24', 5, 22, '11:00:00', '10:00:00');


--
-- TOC entry 4931 (class 0 OID 16480)
-- Dependencies: 231
-- Data for Name: train; Type: TABLE DATA; Schema: schedule_train; Owner: postgres
--

INSERT INTO schedule_train.train (train_id, number_train, name_train, date_last_service, hours_in_operation, manufacturer_id) OVERRIDING SYSTEM VALUE VALUES (1, '1001', 'Сапсан', '2022-11-25', 500, 2);
INSERT INTO schedule_train.train (train_id, number_train, name_train, date_last_service, hours_in_operation, manufacturer_id) OVERRIDING SYSTEM VALUE VALUES (3, '2056', 'Стриж', '2023-07-28', 430, 5);
INSERT INTO schedule_train.train (train_id, number_train, name_train, date_last_service, hours_in_operation, manufacturer_id) OVERRIDING SYSTEM VALUE VALUES (4, '3010', 'Ласточка', '2021-11-30', 300, 3);
INSERT INTO schedule_train.train (train_id, number_train, name_train, date_last_service, hours_in_operation, manufacturer_id) OVERRIDING SYSTEM VALUE VALUES (5, '4123', 'Экспресс', '2023-11-01', 600, 5);
INSERT INTO schedule_train.train (train_id, number_train, name_train, date_last_service, hours_in_operation, manufacturer_id) OVERRIDING SYSTEM VALUE VALUES (6, '5005', 'Рапида', '2023-07-29', 350, 4);


--
-- TOC entry 4933 (class 0 OID 16493)
-- Dependencies: 233
-- Data for Name: voage; Type: TABLE DATA; Schema: schedule_train; Owner: postgres
--

INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (1, 'М-777-Т', 'Москва - Таганрог', 3, 2, 3);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (2, 'М-3152-К', 'Москва - Казань', 1, 1, 1);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (3, 'Ст-126521-Д', 'Санкт-Петербург - Дзержинск', 5, 4, 4);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (4, 'М-5676-Яр', 'Москва - Ярославль', 4, 3, 5);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (5, 'Р-33444-Я', 'Ростов-на-дону-Ярославль', 6, 2, 2);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (6, 'М-037-Д', 'Москва - Дзержинск', 5, 1, 5);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (7, 'М-3463-Р', 'Москва - Ростов-на-дону', 1, 3, 2);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (8, 'Т-4432-М', 'Таганрог - Москва', 3, 2, 3);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (9, 'Ст-8732-М', 'Санкт-Петербург - Москва', 5, 1, 4);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (11, 'Р-3343-М
', 'Ростов-на-Дону - Москва', 1, 3, 1);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (10, 'К-3433-М', 'Казань - Москва', 4, 4, 2);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (12, 'Ст-5432-Я', 'Санкт-Петербург - Ярославль', 5, 4, 1);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (13, 'Т-4352-Ст', 'Таганрог - Санкт-Петербург', 3, 2, 5);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (14, 'Я-3524-Ст', 'Ярославль - Санкт-Петербург', 1, 3, 3);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (15, 'Р-2345-Ст', 'Ростов-на-Дону - Санкт-Петербург', 6, 4, 1);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (16, 'Т-9677-К', 'Таганрог-Казань', 6, 4, 2);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (17, 'Я-6755-Т', 'Ярославль-Таганрог', 5, 3, 4);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (18, 'Д-55767-Т', 'Дзержинск-Таганрог', 1, 1, 1);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (19, 'Д-5677-Р', 'Дзержинск - Ростов-на-Дону', 6, 3, 2);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (20, 'Ст-5652-Р', 'Санкт-Петербург - Ростов-на-Дону', 5, 4, 5);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (21, 'Л-56798-Я', 'Казань - Ярославль', 6, 3, 5);
INSERT INTO schedule_train.voage (voage_id, number_voage, name_voage, train_id, composition_wagons_id, carrier_id) OVERRIDING SYSTEM VALUE VALUES (22, 'К-4375-Ст', 'Казань - Санкт-Петербург', 5, 4, 2);


--
-- TOC entry 4927 (class 0 OID 16456)
-- Dependencies: 227
-- Data for Name: wagon; Type: TABLE DATA; Schema: schedule_train; Owner: postgres
--

INSERT INTO schedule_train.wagon (wagon_id, name_wagon, type_wagon, number_seats, load_capacity) OVERRIDING SYSTEM VALUE VALUES (1, 'Вагон №124412', 'Плацкартный', 50, 20);
INSERT INTO schedule_train.wagon (wagon_id, name_wagon, type_wagon, number_seats, load_capacity) OVERRIDING SYSTEM VALUE VALUES (2, 'Вагон №2325', 'купе', 45, 17);
INSERT INTO schedule_train.wagon (wagon_id, name_wagon, type_wagon, number_seats, load_capacity) OVERRIDING SYSTEM VALUE VALUES (3, 'Вагон №345354', 'купе', 40, 15);
INSERT INTO schedule_train.wagon (wagon_id, name_wagon, type_wagon, number_seats, load_capacity) OVERRIDING SYSTEM VALUE VALUES (4, 'Вагон №42142', 'Плацкартный', 60, 25);
INSERT INTO schedule_train.wagon (wagon_id, name_wagon, type_wagon, number_seats, load_capacity) OVERRIDING SYSTEM VALUE VALUES (5, 'Вагон №53235', 'Плацкартный', 65, 27);


--
-- TOC entry 4922 (class 0 OID 16420)
-- Dependencies: 222
-- Data for Name: railway_station; Type: TABLE DATA; Schema: train_schedule; Owner: postgres
--

INSERT INTO train_schedule.railway_station (id_railway_station, name_railway_station, city, number_of_path, number_of_employees) OVERRIDING SYSTEM VALUE VALUES (1, 'New train station', 'Taganrog', 5, 100);
INSERT INTO train_schedule.railway_station (id_railway_station, name_railway_station, city, number_of_path, number_of_employees) OVERRIDING SYSTEM VALUE VALUES (2, 'Kazan-1', 'Kazan', 7, 300);
INSERT INTO train_schedule.railway_station (id_railway_station, name_railway_station, city, number_of_path, number_of_employees) OVERRIDING SYSTEM VALUE VALUES (3, 'Kazansky Railway Station', 'Moscow', 10, 400);
INSERT INTO train_schedule.railway_station (id_railway_station, name_railway_station, city, number_of_path, number_of_employees) OVERRIDING SYSTEM VALUE VALUES (4, 'Yaroslavl main', 'Yaroslavl', 6, 250);
INSERT INTO train_schedule.railway_station (id_railway_station, name_railway_station, city, number_of_path, number_of_employees) OVERRIDING SYSTEM VALUE VALUES (5, 'Dzerzhinsk railway station', 'Dzerzhinsk', 4, 75);


--
-- TOC entry 4918 (class 0 OID 16400)
-- Dependencies: 218
-- Data for Name: schedule; Type: TABLE DATA; Schema: train_schedule; Owner: postgres
--

INSERT INTO train_schedule.schedule (id_schedule, departure_date, arrival_date, deparature_time, arrival_time, delay, railway_station_id, voyage_id, arrival_reilway_station_id) OVERRIDING SYSTEM VALUE VALUES (1, '2023-01-08', '2023-02-08', '13:30:00', '08:00:00+03', NULL, 1, 4, 3);
INSERT INTO train_schedule.schedule (id_schedule, departure_date, arrival_date, deparature_time, arrival_time, delay, railway_station_id, voyage_id, arrival_reilway_station_id) OVERRIDING SYSTEM VALUE VALUES (2, '2023-10-24', '2023-10-24', '06:30:00', '18:45:00+03', '01:20:00+03', 5, 1, 4);
INSERT INTO train_schedule.schedule (id_schedule, departure_date, arrival_date, deparature_time, arrival_time, delay, railway_station_id, voyage_id, arrival_reilway_station_id) OVERRIDING SYSTEM VALUE VALUES (3, '2023-08-03', '2023-08-04', '12:30:00', '10:00:00+03', NULL, 1, 4, 2);
INSERT INTO train_schedule.schedule (id_schedule, departure_date, arrival_date, deparature_time, arrival_time, delay, railway_station_id, voyage_id, arrival_reilway_station_id) OVERRIDING SYSTEM VALUE VALUES (5, '2023-02-19', '2023-02-19', '01:00:00', '17:00:00+03', NULL, 1, 3, 3);
INSERT INTO train_schedule.schedule (id_schedule, departure_date, arrival_date, deparature_time, arrival_time, delay, railway_station_id, voyage_id, arrival_reilway_station_id) OVERRIDING SYSTEM VALUE VALUES (6, '2023-07-07', '2023-07-08', '12:00:00', '14:00:00+03', '02:00:00+03', 2, 5, 1);
INSERT INTO train_schedule.schedule (id_schedule, departure_date, arrival_date, deparature_time, arrival_time, delay, railway_station_id, voyage_id, arrival_reilway_station_id) OVERRIDING SYSTEM VALUE VALUES (7, '2023-10-10', '2023-10-10', '00:00:00', '17:00:00+03', NULL, 4, 2, 5);
INSERT INTO train_schedule.schedule (id_schedule, departure_date, arrival_date, deparature_time, arrival_time, delay, railway_station_id, voyage_id, arrival_reilway_station_id) OVERRIDING SYSTEM VALUE VALUES (8, '2023-11-11', '2023-12-11', '08:00:00', '10:00:00+03', NULL, 3, 1, 2);
INSERT INTO train_schedule.schedule (id_schedule, departure_date, arrival_date, deparature_time, arrival_time, delay, railway_station_id, voyage_id, arrival_reilway_station_id) OVERRIDING SYSTEM VALUE VALUES (9, '2023-01-01', '2023-01-02', '03:00:00', '18:00:00+03', '07:00:00+03', 1, 2, 3);
INSERT INTO train_schedule.schedule (id_schedule, departure_date, arrival_date, deparature_time, arrival_time, delay, railway_station_id, voyage_id, arrival_reilway_station_id) OVERRIDING SYSTEM VALUE VALUES (10, '2023-06-12', '2023-06-13', '10:00:00', '17:00:00+03', NULL, 5, 4, 3);
INSERT INTO train_schedule.schedule (id_schedule, departure_date, arrival_date, deparature_time, arrival_time, delay, railway_station_id, voyage_id, arrival_reilway_station_id) OVERRIDING SYSTEM VALUE VALUES (11, '2021-08-17', '2021-08-18', '01:00:00', '23:00:00+03', NULL, 3, 2, 1);


--
-- TOC entry 4920 (class 0 OID 16409)
-- Dependencies: 220
-- Data for Name: train; Type: TABLE DATA; Schema: train_schedule; Owner: postgres
--

INSERT INTO train_schedule.train (id_train, name_train, "manufacturer's_name", date_of_manufacture, date_maintanance) OVERRIDING SYSTEM VALUE VALUES (1, 'Sapsan', 'RGD', NULL, NULL);
INSERT INTO train_schedule.train (id_train, name_train, "manufacturer's_name", date_of_manufacture, date_maintanance) OVERRIDING SYSTEM VALUE VALUES (2, 'Swallow', 'RGD', NULL, NULL);
INSERT INTO train_schedule.train (id_train, name_train, "manufacturer's_name", date_of_manufacture, date_maintanance) OVERRIDING SYSTEM VALUE VALUES (3, 'Ivan Paristy', 'RGD', NULL, NULL);
INSERT INTO train_schedule.train (id_train, name_train, "manufacturer's_name", date_of_manufacture, date_maintanance) OVERRIDING SYSTEM VALUE VALUES (4, 'Hogwarts Express', 'The world of magic and sorcery', NULL, NULL);
INSERT INTO train_schedule.train (id_train, name_train, "manufacturer's_name", date_of_manufacture, date_maintanance) OVERRIDING SYSTEM VALUE VALUES (5, 'Orient Express', 'Agata Kristi ', NULL, NULL);


--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 234
-- Name: carrier_carrier_id_seq; Type: SEQUENCE SET; Schema: schedule_train; Owner: postgres
--

SELECT pg_catalog.setval('schedule_train.carrier_carrier_id_seq', 5, true);


--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 228
-- Name: composition_wagons_composition_wagons_id_seq; Type: SEQUENCE SET; Schema: schedule_train; Owner: postgres
--

SELECT pg_catalog.setval('schedule_train.composition_wagons_composition_wagons_id_seq', 5, true);


--
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 224
-- Name: manufacturer_manufacturer_id_seq; Type: SEQUENCE SET; Schema: schedule_train; Owner: postgres
--

SELECT pg_catalog.setval('schedule_train.manufacturer_manufacturer_id_seq', 6, true);


--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 236
-- Name: railway_station_railway_station_id_seq; Type: SEQUENCE SET; Schema: schedule_train; Owner: postgres
--

SELECT pg_catalog.setval('schedule_train.railway_station_railway_station_id_seq', 20, true);


--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 238
-- Name: schedule_schedule_id_seq; Type: SEQUENCE SET; Schema: schedule_train; Owner: postgres
--

SELECT pg_catalog.setval('schedule_train.schedule_schedule_id_seq', 28, true);


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 230
-- Name: train_train_id_seq; Type: SEQUENCE SET; Schema: schedule_train; Owner: postgres
--

SELECT pg_catalog.setval('schedule_train.train_train_id_seq', 6, true);


--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 232
-- Name: voage_voage_id_seq; Type: SEQUENCE SET; Schema: schedule_train; Owner: postgres
--

SELECT pg_catalog.setval('schedule_train.voage_voage_id_seq', 22, true);


--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 226
-- Name: wagon_wagon_id_seq; Type: SEQUENCE SET; Schema: schedule_train; Owner: postgres
--

SELECT pg_catalog.setval('schedule_train.wagon_wagon_id_seq', 5, true);


--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 223
-- Name: railway_station_id_railway_station_seq; Type: SEQUENCE SET; Schema: train_schedule; Owner: postgres
--

SELECT pg_catalog.setval('train_schedule.railway_station_id_railway_station_seq', 5, true);


--
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 219
-- Name: schedule_id_schedule_seq; Type: SEQUENCE SET; Schema: train_schedule; Owner: postgres
--

SELECT pg_catalog.setval('train_schedule.schedule_id_schedule_seq', 11, true);


--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 221
-- Name: train_id_train_seq; Type: SEQUENCE SET; Schema: train_schedule; Owner: postgres
--

SELECT pg_catalog.setval('train_schedule.train_id_train_seq', 5, true);


--
-- TOC entry 4758 (class 2606 OID 16503)
-- Name: carrier carrier_pkey; Type: CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.carrier
    ADD CONSTRAINT carrier_pkey PRIMARY KEY (carrier_id);


--
-- TOC entry 4752 (class 2606 OID 16468)
-- Name: composition_wagons composition_wagons_pkey; Type: CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.composition_wagons
    ADD CONSTRAINT composition_wagons_pkey PRIMARY KEY (composition_wagons_id);


--
-- TOC entry 4748 (class 2606 OID 16452)
-- Name: manufacturer manufacturer_pkey; Type: CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.manufacturer
    ADD CONSTRAINT manufacturer_pkey PRIMARY KEY (manufacturer_id);


--
-- TOC entry 4760 (class 2606 OID 16528)
-- Name: railway_station railway_station_pkey; Type: CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.railway_station
    ADD CONSTRAINT railway_station_pkey PRIMARY KEY (railway_station_id);


--
-- TOC entry 4762 (class 2606 OID 16536)
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (schedule_id);


--
-- TOC entry 4754 (class 2606 OID 16484)
-- Name: train train_pkey; Type: CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.train
    ADD CONSTRAINT train_pkey PRIMARY KEY (train_id);


--
-- TOC entry 4756 (class 2606 OID 16497)
-- Name: voage voage_pkey; Type: CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.voage
    ADD CONSTRAINT voage_pkey PRIMARY KEY (voage_id);


--
-- TOC entry 4750 (class 2606 OID 16460)
-- Name: wagon wagon_pkey; Type: CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.wagon
    ADD CONSTRAINT wagon_pkey PRIMARY KEY (wagon_id);


--
-- TOC entry 4746 (class 2606 OID 16428)
-- Name: railway_station railway_station_pkey; Type: CONSTRAINT; Schema: train_schedule; Owner: postgres
--

ALTER TABLE ONLY train_schedule.railway_station
    ADD CONSTRAINT railway_station_pkey PRIMARY KEY (id_railway_station);


--
-- TOC entry 4742 (class 2606 OID 16408)
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: train_schedule; Owner: postgres
--

ALTER TABLE ONLY train_schedule.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (id_schedule);


--
-- TOC entry 4744 (class 2606 OID 16417)
-- Name: train train_pkey; Type: CONSTRAINT; Schema: train_schedule; Owner: postgres
--

ALTER TABLE ONLY train_schedule.train
    ADD CONSTRAINT train_pkey PRIMARY KEY (id_train);


--
-- TOC entry 4772 (class 2606 OID 16538)
-- Name: schedule arrival_station_fkey; Type: FK CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.schedule
    ADD CONSTRAINT arrival_station_fkey FOREIGN KEY (arrival_station_id) REFERENCES schedule_train.railway_station(railway_station_id) NOT VALID;


--
-- TOC entry 4769 (class 2606 OID 16518)
-- Name: voage carrier_fkey; Type: FK CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.voage
    ADD CONSTRAINT carrier_fkey FOREIGN KEY (carrier_id) REFERENCES schedule_train.carrier(carrier_id) NOT VALID;


--
-- TOC entry 4766 (class 2606 OID 16469)
-- Name: composition_wagons compartament_wagon_type_fkey; Type: FK CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.composition_wagons
    ADD CONSTRAINT compartament_wagon_type_fkey FOREIGN KEY (composition_wagons_type_id) REFERENCES schedule_train.wagon(wagon_id) NOT VALID;


--
-- TOC entry 4770 (class 2606 OID 16513)
-- Name: voage composition_wagons_fkey; Type: FK CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.voage
    ADD CONSTRAINT composition_wagons_fkey FOREIGN KEY (composition_wagons_id) REFERENCES schedule_train.composition_wagons(composition_wagons_id) NOT VALID;


--
-- TOC entry 4773 (class 2606 OID 16543)
-- Name: schedule departure_station_fkey; Type: FK CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.schedule
    ADD CONSTRAINT departure_station_fkey FOREIGN KEY (departure_station_id) REFERENCES schedule_train.railway_station(railway_station_id) NOT VALID;


--
-- TOC entry 4768 (class 2606 OID 16487)
-- Name: train manufacturer_fkey; Type: FK CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.train
    ADD CONSTRAINT manufacturer_fkey FOREIGN KEY (manufacturer_id) REFERENCES schedule_train.manufacturer(manufacturer_id) NOT VALID;


--
-- TOC entry 4767 (class 2606 OID 16474)
-- Name: composition_wagons reserved_seat_fkey; Type: FK CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.composition_wagons
    ADD CONSTRAINT reserved_seat_fkey FOREIGN KEY (reserved_seat_type_id) REFERENCES schedule_train.wagon(wagon_id) NOT VALID;


--
-- TOC entry 4771 (class 2606 OID 16508)
-- Name: voage train_fkey; Type: FK CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.voage
    ADD CONSTRAINT train_fkey FOREIGN KEY (train_id) REFERENCES schedule_train.train(train_id) NOT VALID;


--
-- TOC entry 4774 (class 2606 OID 16548)
-- Name: schedule voage_fkey; Type: FK CONSTRAINT; Schema: schedule_train; Owner: postgres
--

ALTER TABLE ONLY schedule_train.schedule
    ADD CONSTRAINT voage_fkey FOREIGN KEY (voage_id) REFERENCES schedule_train.voage(voage_id) NOT VALID;


--
-- TOC entry 4763 (class 2606 OID 16441)
-- Name: schedule railway_station_arrival_fkey; Type: FK CONSTRAINT; Schema: train_schedule; Owner: postgres
--

ALTER TABLE ONLY train_schedule.schedule
    ADD CONSTRAINT railway_station_arrival_fkey FOREIGN KEY (arrival_reilway_station_id) REFERENCES train_schedule.railway_station(id_railway_station) NOT VALID;


--
-- TOC entry 4764 (class 2606 OID 16431)
-- Name: schedule railway_station_fkey; Type: FK CONSTRAINT; Schema: train_schedule; Owner: postgres
--

ALTER TABLE ONLY train_schedule.schedule
    ADD CONSTRAINT railway_station_fkey FOREIGN KEY (railway_station_id) REFERENCES train_schedule.railway_station(id_railway_station) NOT VALID;


--
-- TOC entry 4765 (class 2606 OID 16436)
-- Name: schedule train_fkey; Type: FK CONSTRAINT; Schema: train_schedule; Owner: postgres
--

ALTER TABLE ONLY train_schedule.schedule
    ADD CONSTRAINT train_fkey FOREIGN KEY (voyage_id) REFERENCES train_schedule.train(id_train) NOT VALID;


-- Completed on 2023-12-28 03:14:51

--
-- PostgreSQL database dump complete
--


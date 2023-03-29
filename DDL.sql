CREATE TABLE Users (
    User_ID SERIAL PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email_Address VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20) NOT NULL UNIQUE,
    Image bytea,
    Registration_Time TIMESTAMP NOT NULL DEFAULT NOW(),
    Subscription_Type VARCHAR(20) NOT NULL CHECK (
        Subscription_Type IN ('monthly', 'half-yearly', 'yearly')
    ),
    Subscription_Status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE Instructor (
    ID_Instructor SERIAL PRIMARY KEY,
    Image bytea,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Specialty VARCHAR(50) NOT NULL CHECK (
        Specialty IN (
            'yoga',
            'pilates',
            'personal training',
            'cardio',
            'Strength and endurance training'
        )
    ),
    Schedule_Start TIME NOT NULL CHECK (
        Schedule_Start >= '06:00'
        AND Schedule_Start <= '12:00'
    ),
    Schedule_End TIME NOT NULL CHECK (
        Schedule_End >= '16:00'
        AND Schedule_End <= '22:00'
    )
);

CREATE TABLE Class (
    Class_ID SERIAL PRIMARY KEY,
    ID_Instructor INTEGER REFERENCES Instructor(ID_Instructor) ON DELETE CASCADE ON UPDATE CASCADE,
    Name VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL CHECK (
        Category IN (
            'yoga',
            'pilates',
            'personal training',
            'cardio',
            'Strength and endurance training'
        )
    ),
    Description TEXT,
    Class_Time_Start TIME NOT NULL CHECK (
        Class_Time_Start >= '06:00'
        AND Class_Time_Start <= '22:00'
    ),
    Class_Time_Finish TIME NOT NULL CHECK (
        Class_Time_Finish >= '06:00'
        AND Class_Time_Finish <= '22:00'
    ),
    Maximum_Class_Capacity INTEGER NOT NULL,
    Difficulty_Level VARCHAR(20) NOT NULL CHECK (
        Difficulty_Level IN ('beginner', 'intermediate', 'advanced')
    )
);
CREATE TABLE Booking (
    Booking_ID SERIAL PRIMARY KEY,
    Booking_Day VARCHAR(10) NOT NULL CHECK (Booking_Day IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')),
    Booking_Time_Start TIME NOT NULL CHECK (
        Booking_Time_Start >= '06:00'
        AND Booking_Time_Start <= '22:00'
    ),
    Booking_Time_Finish TIME NOT NULL CHECK (
        Booking_Time_Finish >= '06:00'
        AND Booking_Time_Finish <= '22:00'
    ),
    STATUS VARCHAR(20) NOT NULL CHECK (STATUS IN ('confirmed', 'on_hold', 'canceled')),
    User_ID INTEGER REFERENCES Users(User_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Class_ID INTEGER REFERENCES Class(Class_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Payment (
    Payment_ID SERIAL PRIMARY KEY,
    User_ID INTEGER REFERENCES Users(User_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    Date_Of_Payment DATE NOT NULL,
    Amount NUMERIC(10, 2) NOT NULL,
    Subscription_Type VARCHAR(20) NOT NULL CHECK (
        Subscription_Type IN ('monthly', 'half-yearly', 'yearly')
    ),
    Payment_Status VARCHAR(20) NOT NULL CHECK (
        Payment_Status IN ('paid', 'pending', 'rejected')
    ),
    Payment_Method_Used VARCHAR(50) NOT NULL CHECK (
        Payment_Method_Used IN ('cash', 'credit card', 'bank transfer')
    )
);

-- Inserts

TRUNCATE Users RESTART IDENTITY CASCADE;


INSERT INTO Users (First_Name, Last_Name, Email_Address, Phone, Image, Registration_Time, Subscription_Type, Subscription_Status) VALUES ('John', 'Doe', 'johndoe@example.com', '+1 (555) 123-4567', NULL, '2023-03-01 11:02:30.963', 'monthly', TRUE);
INSERT INTO Users (First_Name, Last_Name, Email_Address, Phone, Image, Registration_Time, Subscription_Type, Subscription_Status) VALUES ('Jane', 'Smith', 'janesmith@example.com', '+1 (555) 987-6543',  NULL, '2019-01-27 06:05:10.315', 'yearly', TRUE);
INSERT INTO Users (First_Name, Last_Name, Email_Address, Phone, Image, Registration_Time, Subscription_Type, Subscription_Status) VALUES ('Robert', 'Johnson', 'robertjohnson@example.com', '+1 (555) 555-5555', NULL, '2022-07-13 19:43:51.204','half-yearly', FALSE);
INSERT INTO Users (First_Name, Last_Name, Email_Address, Phone, Image, Registration_Time, Subscription_Type, Subscription_Status) VALUES ('Maria', 'Gonzalez', 'mariagonzalez@example.com', '+1 (555) 563-6589',  NULL, '2023-03-28 15:30:00', 'monthly', TRUE);

TRUNCATE Instructor RESTART IDENTITY CASCADE;

INSERT INTO Instructor (Image, First_Name, Last_Name, Specialty, Schedule_Start, Schedule_End)
VALUES (NULL, 'Marta', 'García', 'yoga', '08:00', '16:00');

INSERT INTO Instructor (Image, First_Name, Last_Name, Specialty, Schedule_Start, Schedule_End)
VALUES (NULL, 'Juan', 'Pérez', 'cardio', '11:00', '18:00');

INSERT INTO Instructor (Image, First_Name, Last_Name, Specialty, Schedule_Start, Schedule_End)
VALUES (NULL, 'Sofía', 'Martínez', 'Strength and endurance training', '10:00', '16:00');

INSERT INTO Instructor (Image, First_Name, Last_Name, Specialty, Schedule_Start, Schedule_End)
VALUES (NULL, 'Pedro', 'López', 'personal training', '11:00', '20:00');

INSERT INTO Class (ID_Instructor, Name, Category, Description, Class_Time_Start, Class_Time_Finish, Maximum_Class_Capacity, Difficulty_Level)
VALUES (1, 'Hatha Yoga', 'yoga', 'A gentle and slower-paced yoga class that focuses on breathing and basic yoga poses.', '08:00:00', '09:00:00', 10, 'intermediate');
INSERT INTO Class (ID_Instructor, Name, Category, Description, Class_Time_Start, Class_Time_Finish, Maximum_Class_Capacity, Difficulty_Level)
VALUES (2, 'Mat Pilates', 'pilates', 'A class that focuses on strengthening the core and improving posture through controlled movements and breathing.', '11:00:00', '12:00:00', 8, 'advanced');
INSERT INTO Class (ID_Instructor, Name, Category, Description, Class_Time_Start, Class_Time_Finish, Maximum_Class_Capacity, Difficulty_Level)
VALUES (3, 'HIIT Training', 'personal training', 'A high-intensity interval training class that involves short bursts of intense exercises followed by short periods of rest.', '07:00:00', '08:00:00', 6, 'advanced');
INSERT INTO Class (ID_Instructor, Name, Category, Description, Class_Time_Start, Class_Time_Finish, Maximum_Class_Capacity, Difficulty_Level)
VALUES (4, 'Spin Class', 'cardio', 'An indoor cycling class that simulates an outdoor bike ride and focuses on improving cardiovascular fitness.', '17:00:00', '18:00:00', 15, 'intermediate');
INSERT INTO Class (ID_Instructor, Name, Category, Description, Class_Time_Start, Class_Time_Finish, Maximum_Class_Capacity, Difficulty_Level)
VALUES (3, 'HIIT', 'cardio', 'High Intensity Interval Training', '19:30', '20:30', 20, 'advanced');

INSERT INTO Booking (Booking_Day, Booking_Time_Start, Booking_Time_Finish, STATUS, User_ID, Class_ID)
VALUES ('Wednesday', '14:00', '16:00', 'confirmed', 1, 4);
INSERT INTO Booking (Booking_Day, Booking_Time_Start, Booking_Time_Finish, STATUS, User_ID, Class_ID)
VALUES ('Saturday', '10:00', '11:30', 'on_hold', 2, 1);
INSERT INTO Booking (Booking_Day, Booking_Time_Start, Booking_Time_Finish, STATUS, User_ID, Class_ID)
VALUES ('Thursday', '18:00', '19:30', 'confirmed', 3, 2);
INSERT INTO Booking (Booking_Day, Booking_Time_Start, Booking_Time_Finish, STATUS, User_ID, Class_ID)
VALUES ('Monday', '08:00', '09:00', 'canceled', 4, 3);
INSERT INTO Booking (Booking_Day, Booking_Time_Start, Booking_Time_Finish, STATUS, User_ID, Class_ID)
VALUES ('Sunday', '20:00', '21:00', 'on_hold', 2, 5);


INSERT INTO Payment (User_ID, Date_Of_Payment, Amount, Subscription_Type, Payment_Status, Payment_Method_Used)
VALUES (1, '2023-03-05', 50.00, 'monthly', 'paid', 'cash');
INSERT INTO Payment (User_ID, Date_Of_Payment, Amount, Subscription_Type, Payment_Status, Payment_Method_Used)
VALUES (3, '2023-02-01', 600.00, 'yearly', 'paid', 'bank transfer');
INSERT INTO Payment (User_ID, Date_Of_Payment, Amount, Subscription_Type, Payment_Status, Payment_Method_Used)
VALUES (4, '2023-03-15', 40.00, 'monthly', 'pending', 'cash');
INSERT INTO Payment (User_ID, Date_Of_Payment, Amount, Subscription_Type, Payment_Status, Payment_Method_Used)
VALUES (2, '2023-01-20', 500.00, 'yearly', 'rejected', 'credit card');
INSERT INTO Payment (User_ID, Date_Of_Payment, Amount, Subscription_Type, Payment_Status, Payment_Method_Used)
VALUES (1, '2023-04-01', 100.00, 'half-yearly', 'paid', 'credit card');

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Management System</title>

    <style>
        body {
            margin: 0;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background:
                linear-gradient(135deg, #e3f2fd, #ede7f6),
                repeating-linear-gradient(
                    0deg,
                    rgba(255,255,255,0.35),
                    rgba(255,255,255,0.35) 1px,
                    transparent 1px,
                    transparent 40px
                ),
                repeating-linear-gradient(
                    90deg,
                    rgba(255,255,255,0.35),
                    rgba(255,255,255,0.35) 1px,
                    transparent 1px,
                    transparent 40px
                );
            min-height: 100vh;
        }

        .container {
            max-width: 1100px;
            margin: 60px auto;
            background: #ffffff;
            border-radius: 18px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.12);
            padding: 45px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 45px;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .logo {
            width: 64px;
            height: 64px;
            background: linear-gradient(135deg, #3f51b5, #2196f3);
            color: #fff;
            font-size: 30px;
            font-weight: bold;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .title h1 {
            margin: 0;
            font-size: 32px;
            color: #1a237e;
        }

        .title p {
            margin: 6px 0 0;
            color: #555;
            font-size: 15px;
        }

        .status {
            background: #e8f0fe;
            color: #1a73e8;
            padding: 10px 16px;
            border-radius: 22px;
            font-size: 14px;
            font-weight: 500;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 32px;
        }

        .card {
            border: 1px solid #e0e0e0;
            border-radius: 16px;
            padding: 30px;
            position: relative;
            background: linear-gradient(180deg, #ffffff, #f9fbff);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 18px 35px rgba(63,81,181,0.15);
        }

        .card h3 {
            margin-top: 0;
            font-size: 22px;
            color: #283593;
        }

        .card p {
            color: #555;
            line-height: 1.6;
            font-size: 15px;
        }

        .card a {
            text-decoration: none;
            color: #1a73e8;
            font-weight: 600;
        }

        .badge {
            position: absolute;
            top: -12px;
            right: -12px;
            background: linear-gradient(135deg, #4caf50, #2e7d32);
            color: #fff;
            padding: 7px 14px;
            border-radius: 20px;
            font-size: 12px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.15);
        }

        .footer {
            margin-top: 45px;
            display: flex;
            justify-content: space-between;
            color: #666;
            font-size: 14px;
            border-top: 1px solid #eee;
            padding-top: 18px;
        }
    </style>
</head>

<body>

<div class="container">

    <!-- Header -->
    <div class="header">
        <div class="header-left">
            <div class="logo">🎓</div>
            <div class="title">
                <h1>Student Management System</h1>
                <p>Manage student records, courses, attendance and performance.</p>
            </div>
        </div>
        <div class="status">● Live Student Panel</div>
    </div>

    <!-- Cards -->
    <div class="cards">

        <!-- Add Student -->
        <div class="card">
            <span class="badge">New</span>
            <h3>Add New Student</h3>
            <p>
                Register a new student with personal details, course information,
                enrollment number and academic year.
            </p>
            <a href="addMedicine.jsp">Go to form →</a>
        </div>

        <!-- View Students -->
        <div class="card">
            <h3>View / Manage Students</h3>
            <p>
                Browse student records, update details, manage attendance,
                view marks and remove inactive students.
            </p>
            <a href="viewMedicines.jsp">Open records →</a>
        </div>

    </div>

    <!-- Footer -->
    <div class="footer">
        <p>Tip: Always verify student enrollment number before updating records.</p>
        <p>Student Management System • JSP | JDBC | MySQL</p>
    </div>

</div>

</body>
</html>

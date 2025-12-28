<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Medical Store Inventory</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
        }

        body {
            min-height: 100vh;
            background: radial-gradient(circle at top left, #e0f2fe 0, #f9fafb 40%, #e5f6ff 100%);
            color: #0f172a;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .app-wrapper {
            width: 100%;
            max-width: 900px;
            padding: 24px;
        }

        .card {
            background: #ffffff;
            border-radius: 18px;
            box-shadow: 0 12px 30px rgba(15, 23, 42, 0.12);
            padding: 28px 32px 32px;
            border: 1px solid rgba(148, 163, 184, 0.25);
        }

        .header {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 20px;
        }

        .logo-pill {
            width: 52px;
            height: 52px;
            border-radius: 18px;
            background: linear-gradient(135deg, #0ea5e9, #22c55e);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #f9fafb;
            font-size: 26px;
            font-weight: 600;
            box-shadow: 0 10px 25px rgba(34, 197, 94, 0.35);
        }

        .title-group h1 {
            font-size: 26px;
            font-weight: 600;
            color: #0f172a;
        }

        .title-group p {
            font-size: 13px;
            color: #64748b;
            margin-top: 2px;
        }

        .pill-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 11px;
            padding: 4px 10px;
            border-radius: 999px;
            background: #ecfeff;
            color: #0891b2;
            border: 1px solid #a5f3fc;
            margin-left: auto;
        }

        .pill-dot {
            width: 8px;
            height: 8px;
            border-radius: 999px;
            background: #22c55e;
            box-shadow: 0 0 0 4px rgba(34, 197, 94, 0.25);
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 18px;
            margin-top: 10px;
        }

        .nav-card {
            border-radius: 16px;
            border: 1px solid rgba(148, 163, 184, 0.35);
            padding: 18px 18px 20px;
            background: linear-gradient(135deg, #ffffff, #f9fafb);
            position: relative;
            overflow: hidden;
            transition: transform 0.18s ease, box-shadow 0.18s ease, border-color 0.18s ease;
            cursor: pointer;
        }

        .nav-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(15, 23, 42, 0.18);
            border-color: #0ea5e9;
        }

        .nav-icon {
            width: 32px;
            height: 32px;
            border-radius: 11px;
            background: #eff6ff;
            color: #1d4ed8;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            margin-bottom: 10px;
        }

        .nav-title {
            font-size: 15px;
            font-weight: 600;
            color: #0f172a;
            margin-bottom: 4px;
        }

        .nav-desc {
            font-size: 12px;
            color: #6b7280;
            margin-bottom: 10px;
        }

        .nav-link {
            font-size: 12px;
            font-weight: 500;
            color: #0369a1;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .nav-link span {
            font-size: 14px;
        }

        .corner-tag {
            position: absolute;
            right: -22px;
            top: 10px;
            background: linear-gradient(135deg, #0ea5e9, #22c55e);
            color: #f9fafb;
            font-size: 10px;
            padding: 3px 28px;
            transform: rotate(35deg);
            box-shadow: 0 8px 20px rgba(14, 165, 233, 0.4);
        }

        .footer {
            margin-top: 18px;
            font-size: 11px;
            color: #94a3b8;
            display: flex;
            justify-content: space-between;
        }

        .footer strong {
            color: #64748b;
        }
    </style>
</head>
<body>
<div class="app-wrapper">
    <div class="card">
        <div class="header">
            <div class="logo-pill">Rx</div>
            <div class="title-group">
                <h1>Medical Store Inventory</h1>
                <p>Monitor stock, expiry and daily sales for your pharmacy.</p>
            </div>
            <div class="pill-badge">
                <div class="pill-dot"></div>
                Live Inventory Panel
            </div>
        </div>

        <div class="grid">
            <div class="nav-card" onclick="location.href='addMedicine.jsp'">
                <div class="corner-tag">New</div>
                <div class="nav-icon">＋</div>
                <div class="nav-title">Add New Medicine</div>
                <div class="nav-desc">
                    Register fresh stock with company, batch, price and expiry details.
                </div>
                <a class="nav-link" href="addMedicine.jsp">
                    Go to form <span>→</span>
                </a>
            </div>

            <div class="nav-card" onclick="location.href='viewMedicines.jsp'">
                <div class="nav-icon">📋</div>
                <div class="nav-title">View / Manage Medicines</div>
                <div class="nav-desc">
                    Browse inventory, update quantities, record sales and delete expired items.
                </div>
                <a class="nav-link" href="viewMedicines.jsp">
                    Open inventory <span>→</span>
                </a>
            </div>
        </div>

        <div class="footer">
            <span><strong>Tip:</strong> Always verify expiry while selling medicines.</span>
            <span>Medical Store Inventory • JSP | JDBC | MySQL</span>
        </div>
    </div>
</div>
</body>
</html>
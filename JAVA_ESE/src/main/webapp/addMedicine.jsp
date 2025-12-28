<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String message = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name        = request.getParameter("name");
        String company     = request.getParameter("company");
        String batchNo     = request.getParameter("batchNo");
        String quantityStr = request.getParameter("quantity");
        String priceStr    = request.getParameter("unitPrice");
        String expiryDate  = request.getParameter("expiryDate");

        if (name != null && quantityStr != null && priceStr != null && expiryDate != null) {
            int qty = Integer.parseInt(quantityStr);
            double price = Double.parseDouble(priceStr);

            Connection con = null;
            PreparedStatement ps = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/medstore_db?useSSL=false&serverTimezone=UTC",
                        "root",          // <- apna user
                        "Om@231312"  // <- apna password
                );

                String sql = "INSERT INTO medicines(name, company, batch_no, quantity, unit_price, expiry_date) " +
                        "VALUES (?, ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, company);
                ps.setString(3, batchNo);
                ps.setInt(4, qty);
                ps.setDouble(5, price);
                ps.setString(6, expiryDate);

                int rows = ps.executeUpdate();
                message = (rows > 0) ? "Medicine added successfully." : "Failed to add medicine.";
            } catch (Exception e) {
                e.printStackTrace();
                message = "Error: " + e.getMessage();
            } finally {
                if (ps != null) try { ps.close(); } catch (Exception ignored) {}
                if (con != null) try { con.close(); } catch (Exception ignored) {}
            }
        }
    }
%>
<html>
<head>
    <title>Add Medicine</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        *{box-sizing:border-box;margin:0;padding:0;font-family:'Poppins',sans-serif;}
        body{
            min-height:100vh;
            background:radial-gradient(circle at top left,#e0f2fe 0,#f9fafb 40%,#e5f6ff 100%);
            display:flex;align-items:center;justify-content:center;color:#0f172a;
        }
        .wrapper{width:100%;max-width:960px;padding:24px;}
        .card{
            background:#fff;border-radius:18px;padding:26px 30px 30px;
            box-shadow:0 12px 30px rgba(15,23,42,.12);
            border:1px solid rgba(148,163,184,.25);
        }
        .top-bar{display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;}
        .title{font-size:22px;font-weight:600;}
        .subtitle{font-size:13px;color:#64748b;}
        .nav-links a{
            font-size:12px;text-decoration:none;margin-left:10px;
            color:#0369a1;font-weight:500;
        }
        .form-grid{
            display:grid;
            grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
            gap:16px;margin-top:18px;
        }
        .field label{
            font-size:12px;color:#475569;margin-bottom:4px;display:block;
        }
        .field input{
            width:100%;padding:8px 10px;border-radius:10px;
            border:1px solid #cbd5e1;font-size:13px;
            outline:none;transition:border-color .18s,box-shadow .18s;
        }
        .field input:focus{
            border-color:#0ea5e9;
            box-shadow:0 0 0 1px rgba(14,165,233,.35);
        }
        .btn-row{margin-top:20px;display:flex;justify-content:flex-end;}
        .btn-primary{
            border:none;border-radius:999px;padding:9px 24px;font-size:13px;
            background:linear-gradient(135deg,#0ea5e9,#22c55e);
            color:#f9fafb;font-weight:500;cursor:pointer;
            box-shadow:0 8px 18px rgba(14,165,233,.45);
        }
        .badge{
            font-size:11px;padding:4px 10px;border-radius:999px;
            background:#ecfeff;border:1px solid #a5f3fc;color:#0891b2;
        }
        .message{
            margin-top:10px;font-size:12px;
            padding:8px 10px;border-radius:10px;
        }
        .message.success{background:#ecfdf5;color:#15803d;border:1px solid #bbf7d0;}
        .message.error{background:#fef2f2;color:#b91c1c;border:1px solid #fecaca;}
    </style>
</head>
<body>
<div class="wrapper">
    <div class="card">
        <div class="top-bar">
            <div>
                <div class="title">Add New Medicine</div>
                <div class="subtitle">Register incoming stock with all essential details.</div>
            </div>
            <div class="nav-links">
                <span class="badge">Inventory Module</span>
                <a href="index.jsp">Dashboard</a>
                <a href="viewMedicines.jsp">View Inventory</a>
            </div>
        </div>

        <% if (message != null) { %>
        <div class="message <%= message.startsWith("Error") || message.startsWith("Failed") ? "error" : "success" %>">
            <%= message %>
        </div>
        <% } %>

        <form method="post" action="addMedicine.jsp">
            <div class="form-grid">
                <div class="field">
                    <label>Medicine Name *</label>
                    <input type="text" name="name" required>
                </div>
                <div class="field">
                    <label>Company</label>
                    <input type="text" name="company">
                </div>
                <div class="field">
                    <label>Batch Number</label>
                    <input type="text" name="batchNo">
                </div>
                <div class="field">
                    <label>Quantity *</label>
                    <input type="number" name="quantity" min="1" required>
                </div>
                <div class="field">
                    <label>Unit Price (₹) *</label>
                    <input type="number" step="0.01" name="unitPrice" required>
                </div>
                <div class="field">
                    <label>Expiry Date *</label>
                    <input type="date" name="expiryDate" required>
                </div>
            </div>

            <div class="btn-row">
                <button type="submit" class="btn-primary">Save Medicine</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
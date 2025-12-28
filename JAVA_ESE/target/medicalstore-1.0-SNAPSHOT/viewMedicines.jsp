<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String action = request.getParameter("action");
    String msg = null;

    Class.forName("com.mysql.cj.jdbc.Driver");
    String url  = "jdbc:mysql://localhost:3306/medstore_db?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC";
    String user = "root";
    String pass = "Om@231312";

    // DELETE
    if ("delete".equals(action)) {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            try (Connection con = DriverManager.getConnection(url, user, pass);
                 PreparedStatement ps = con.prepareStatement("DELETE FROM medicines WHERE id=?")) {
                ps.setInt(1, id);
                int rows = ps.executeUpdate();
                msg = rows > 0 ? "Medicine deleted." : "Delete failed.";
            } catch (Exception e) {
                e.printStackTrace();
                msg = "Error: " + e.getMessage();
            }
        }
    }

    // SELL
    if ("sell".equals(action)) {
        String idStr  = request.getParameter("id");
        String qtyStr = request.getParameter("sellQty");
        if (idStr != null && qtyStr != null) {
            int id = Integer.parseInt(idStr);
            int sellQty = Integer.parseInt(qtyStr);
            Connection con = null;
            try {
                con = DriverManager.getConnection(url, user, pass);
                con.setAutoCommit(false);

                int currentQty = 0;
                double price   = 0;

                try (PreparedStatement ps1 =
                             con.prepareStatement("SELECT quantity, unit_price FROM medicines WHERE id=?")) {
                    ps1.setInt(1, id);
                    try (ResultSet rs = ps1.executeQuery()) {
                        if (rs.next()) {
                            currentQty = rs.getInt("quantity");
                            price = rs.getDouble("unit_price");
                        }
                    }
                }

                if (sellQty <= 0 || sellQty > currentQty) {
                    msg = "Invalid quantity!";
                } else {
                    try (PreparedStatement ps2 =
                                 con.prepareStatement("UPDATE medicines SET quantity = quantity - ? WHERE id=?")) {
                        ps2.setInt(1, sellQty);
                        ps2.setInt(2, id);
                        ps2.executeUpdate();
                    }
                    double total = price * sellQty;
                    try (PreparedStatement ps3 =
                                 con.prepareStatement("INSERT INTO sales(medicine_id, quantity, total_amount) VALUES (?,?,?)")) {
                        ps3.setInt(1, id);
                        ps3.setInt(2, sellQty);
                        ps3.setDouble(3, total);
                        ps3.executeUpdate();
                    }
                    con.commit();
                    msg = "Sale recorded. Total Amount = ₹ " + total;
                }
            } catch (Exception e) {
                e.printStackTrace();
                msg = "Error: " + e.getMessage();
                if (con != null) try { con.rollback(); } catch (Exception ignored) {}
            } finally {
                if (con != null) try { con.setAutoCommit(true); con.close(); } catch (Exception ignored) {}
            }
        }
    }

    Connection conList = null;
    PreparedStatement psList = null;
    ResultSet rsList = null;
    try {
        conList = DriverManager.getConnection(url, user, pass);
        psList = conList.prepareStatement("SELECT * FROM medicines ORDER BY expiry_date, name");
        rsList = psList.executeQuery();
%>
<html>
<head>
    <title>Medicine Inventory</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        *{box-sizing:border-box;margin:0;padding:0;font-family:'Poppins',sans-serif;}
        body{
            min-height:100vh;
            background:radial-gradient(circle at top left,#e0f2fe 0,#f9fafb 40%,#e5f6ff 100%);
            display:flex;align-items:center;justify-content:center;color:#0f172a;
        }
        .wrapper{width:100%;max-width:1100px;padding:24px;}
        .card{
            background:#fff;border-radius:18px;padding:24px 26px 28px;
            box-shadow:0 12px 30px rgba(15,23,42,.12);
            border:1px solid rgba(148,163,184,.25);
        }
        .top-bar{display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;}
        .title{font-size:22px;font-weight:600;}
        .subtitle{font-size:13px;color:#64748b;}
        .nav-links a{
            font-size:12px;text-decoration:none;margin-left:10px;
            color:#0369a1;font-weight:500;
        }
        .message{
            margin:10px 0;font-size:12px;padding:8px 10px;border-radius:10px;
        }
        .message.success{background:#ecfdf5;color:#15803d;border:1px solid #bbf7d0;}
        .message.error{background:#fef2f2;color:#b91c1c;border:1px solid #fecaca;}
        table{
            width:100%;border-collapse:collapse;margin-top:10px;font-size:12px;
        }
        thead{
            background:linear-gradient(135deg,#0ea5e9,#22c55e);
            color:#f9fafb;
        }
        th,td{
            padding:8px 8px;
            border-bottom:1px solid #e5e7eb;
            text-align:left;
        }
        tbody tr:nth-child(even){background:#f9fafb;}
        tbody tr:hover{background:#e0f2fe;}
        .badge-exp{
            font-size:10px;padding:2px 6px;border-radius:999px;
            background:#fef3c7;color:#b45309;
        }
        .btn-link{
            font-size:11px;border:none;background:none;
            color:#dc2626;text-decoration:underline;cursor:pointer;
        }
        .sell-form{
            display:flex;align-items:center;gap:4px;
        }
        .sell-form input[type=number]{
            width:60px;padding:3px 5px;border-radius:8px;
            border:1px solid #cbd5e1;font-size:11px;
        }
        .sell-btn{
            border:none;border-radius:999px;padding:4px 10px;
            font-size:11px;background:#0ea5e9;color:#f9fafb;
            cursor:pointer;
        }
    </style>
</head>
<body>
<div class="wrapper">
    <div class="card">
        <div class="top-bar">
            <div>
                <div class="title">Inventory Overview</div>
                <div class="subtitle">Track current stock, expiry and record counter sales.</div>
            </div>
            <div class="nav-links">
                <a href="index.jsp">Dashboard</a>
                <a href="addMedicine.jsp">Add Medicine</a>
            </div>
        </div>

        <% if (msg != null) { %>
        <div class="message <%= msg.startsWith("Error") || msg.startsWith("Invalid") || msg.startsWith("Delete failed") ? "error" : "success" %>">
            <%= msg %>
        </div>
        <% } %>

        <table>
            <thead>
            <tr>
                <th>#</th>
                <th>Medicine</th>
                <th>Company</th>
                <th>Batch</th>
                <th>quantity</th>
                <th>Unit Price (₹)</th>
                <th>Expiry</th>
                <th>Delete</th>
                <th>Sell</th>
            </tr>
            </thead>
            <tbody>
            <%
                java.time.LocalDate today = java.time.LocalDate.now();
                while (rsList.next()) {
                    int id = rsList.getInt("id");
                    int qty = rsList.getInt("quantity");
                    java.sql.Date expDateSql = rsList.getDate("expiry_date");
                    java.time.LocalDate expDate = expDateSql != null ? expDateSql.toLocalDate() : null;
                    boolean nearExpiry = expDate != null && !expDate.isBefore(today) &&
                            !expDate.isAfter(today.plusDays(30));
            %>
            <tr>
                <td><%= id %></td>
                <td><%= rsList.getString("name") %></td>
                <td><%= rsList.getString("company") %></td>
                <td><%= rsList.getString("batch_no") %></td>
                <td><%= qty %></td>
                <td><%= rsList.getDouble("unit_price") %></td>
                <td>
                    <%= expDate %>
                    <% if (expDate != null && expDate.isBefore(today)) { %>
                    <span class="badge-exp">Expired</span>
                    <% } else if (nearExpiry) { %>
                    <span class="badge-exp">Expiring soon</span>
                    <% } %>
                </td>
                <td>
                    <a class="btn-link"
                       href="viewMedicines.jsp?action=delete&id=<%= id %>"
                       onclick="return confirm('Delete this medicine record?');">
                        Delete
                    </a>
                </td>
                <td>
                    <form class="sell-form" action="viewMedicines.jsp" method="get">
                        <input type="hidden" name="action" value="sell">
                        <input type="hidden" name="id" value="<%= id %>">
                        <input type="number" name="sellQty" min="1" max="<%= qty %>" required>
                        <button type="submit" class="sell-btn">Sell</button>
                    </form>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>

<%
    } finally {
        if (rsList != null) try { rsList.close(); } catch (Exception ignored) {}
        if (psList != null) try { psList.close(); } catch (Exception ignored) {}
        if (conList != null) try { conList.close(); } catch (Exception ignored) {}
    }
%>
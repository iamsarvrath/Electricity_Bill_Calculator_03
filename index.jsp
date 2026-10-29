<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String unitsInput = request.getParameter("units");
    String error = null;
    Double bill = null;

    if (unitsInput != null) {
        try {
            double units = Double.parseDouble(unitsInput);

            if (Double.isNaN(units) || Double.isInfinite(units) || units < 0) {
                error = "Please enter a valid non-negative number of units.";
            } else if (units <= 50) {
                bill = units * 3.50;
            } else if (units <= 150) {
                bill = (50 * 3.50) + ((units - 50) * 4.00);
            } else if (units <= 250) {
                bill = (50 * 3.50) + (100 * 4.00) + ((units - 150) * 5.20);
            } else {
                bill = (50 * 3.50) + (100 * 4.00) + (100 * 5.20) + ((units - 250) * 6.50);
            }
        } catch (NumberFormatException exception) {
            error = "Please enter a valid number of units.";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electricity Bill Calculator</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <main class="page">
        <section class="calculator">
            <p class="eyebrow">Monthly electricity estimate</p>
            <h1>Electricity Bill Calculator</h1>
            <p class="intro">Enter the number of units used to get your estimated bill.</p>

            <form method="post" class="bill-form">
                <label for="units">Units consumed</label>
                <div class="input-row">
                    <input type="number" id="units" name="units" min="0" step="0.01"
                           placeholder="For example, 180"
                           value="<%= unitsInput == null ? "" : unitsInput %>" required>
                    <button type="submit">Calculate</button>
                </div>
            </form>

            <% if (error != null) { %>
                <p class="message error"><%= error %></p>
            <% } else if (bill != null) { %>
                <div class="result">
                    <span>Estimated bill</span>
                    <strong>Rs. <%= String.format("%.2f", bill) %></strong>
                    <small>for <%= unitsInput %> units</small>
                </div>
            <% } %>

            <div class="slabs">
                <h2>Tariff details</h2>
                <div class="slab"><span>First 50 units</span><b>Rs. 3.50 / unit</b></div>
                <div class="slab"><span>Next 100 units</span><b>Rs. 4.00 / unit</b></div>
                <div class="slab"><span>Next 100 units</span><b>Rs. 5.20 / unit</b></div>
                <div class="slab"><span>Above 250 units</span><b>Rs. 6.50 / unit</b></div>
            </div>
        </section>
    </main>
</body>
</html>

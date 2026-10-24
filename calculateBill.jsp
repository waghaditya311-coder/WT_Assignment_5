<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat" %>
<%
    // Read parameters from form submission
    String consumerName = request.getParameter("consumerName");
    String consumerNo = request.getParameter("consumerNo");
    String meterNo = request.getParameter("meterNo");
    int prevReading = Integer.parseInt(request.getParameter("prevReading"));
    int currReading = Integer.parseInt(request.getParameter("currReading"));
    String category = request.getParameter("category");

    int units = currReading - prevReading;

    // Calculate energy charge based on slabs
    double energyCharge = 0;
    String categoryLabel = "";

    if ("residential".equals(category)) {
        categoryLabel = "Residential";
        if (units <= 100) {
            energyCharge = units * 3.50;
        } else if (units <= 300) {
            energyCharge = 100 * 3.50 + (units - 100) * 5.50;
        } else if (units <= 500) {
            energyCharge = 100 * 3.50 + 200 * 5.50 + (units - 300) * 7.00;
        } else {
            energyCharge = 100 * 3.50 + 200 * 5.50 + 200 * 7.00 + (units - 500) * 8.50;
        }
    } else if ("commercial".equals(category)) {
        categoryLabel = "Commercial";
        energyCharge = units * 8.00;
    } else {
        categoryLabel = "Industrial";
        energyCharge = units * 7.50;
    }

    // Additional charges
    double fixedCharge = "residential".equals(category) ? 50.0
                       : "commercial".equals(category) ? 200.0 : 350.0;
    double electricityDuty = energyCharge * 0.10;
    double fuelSurcharge = energyCharge * 0.02;
    double totalAmount = energyCharge + fixedCharge + electricityDuty + fuelSurcharge;

    DecimalFormat df = new DecimalFormat("#,##0.00");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill Generated - WT Assignment 5</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Orbitron:wght@500;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background: #060b17; color: #f1f5f9; padding: 40px; }
        .bill-card { max-width: 650px; margin: 0 auto; background: rgba(15,23,42,0.9); border: 1px solid rgba(99,102,241,0.2); border-radius: 20px; padding: 36px; box-shadow: 0 8px 40px rgba(0,0,0,0.5); }
        .bill-title { text-align: center; margin-bottom: 24px; }
        .bill-title h1 { font-family: 'Orbitron', monospace; font-size: 1.3rem; background: linear-gradient(135deg, #f59e0b, #6366f1); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .bill-title p { font-size: 0.8rem; color: #475569; margin-top: 4px; }
        .total-section { text-align: center; padding: 24px 0; border-top: 1px solid rgba(99,102,241,0.15); border-bottom: 1px solid rgba(99,102,241,0.15); margin: 16px 0; }
        .total-label { font-size: 0.75rem; color: #94a3b8; text-transform: uppercase; letter-spacing: 0.1em; }
        .total-amount { font-family: 'Orbitron', monospace; font-size: 2.5rem; font-weight: 700; background: linear-gradient(135deg, #10b981, #06b6d4); -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin: 8px 0; }
        .row { display: flex; justify-content: space-between; padding: 10px 0; font-size: 0.88rem; border-bottom: 1px solid rgba(255,255,255,0.04); }
        .row .label { color: #94a3b8; }
        .row .value { font-weight: 500; }
        .row.highlight .value { color: #f59e0b; font-weight: 700; font-family: 'Orbitron', monospace; }
        .row.total-row { border: none; padding-top: 14px; font-size: 1rem; }
        .row.total-row .value { font-family: 'Orbitron', monospace; color: #10b981; font-weight: 700; }
        .divider { height: 1px; background: linear-gradient(90deg, transparent, rgba(99,102,241,0.3), transparent); margin: 12px 0; }
        .section-title { font-size: 0.7rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.1em; color: #6366f1; margin: 14px 0 6px; }
        .back-btn { display: inline-block; margin-top: 20px; padding: 12px 24px; background: linear-gradient(135deg, #6366f1, #8b5cf6); color: #fff; border-radius: 10px; text-decoration: none; font-weight: 600; font-size: 0.9rem; transition: opacity 0.2s; }
        .back-btn:hover { opacity: 0.85; }
        .print-btn { display: inline-block; margin-top: 10px; padding: 10px 20px; background: rgba(255,255,255,0.06); color: #94a3b8; border-radius: 10px; text-decoration: none; font-size: 0.85rem; border: 1px solid rgba(99,102,241,0.2); cursor: pointer; }
        @media print { .back-btn, .print-btn { display: none !important; } body { background: #fff; color: #111; } .bill-card { background: #fff; border: 2px solid #333; box-shadow: none; } .total-amount { color: #111 !important; -webkit-text-fill-color: #111 !important; } .row .label, .row .value { color: #333 !important; } }
    </style>
</head>
<body>
    <div class="bill-card">
        <div class="bill-title">
            <h1>⚡ Electricity Bill</h1>
            <p>Generated via JSP • WT Assignment 5</p>
        </div>

        <div class="total-section">
            <div class="total-label">Total Amount Payable</div>
            <div class="total-amount">₹<%= df.format(totalAmount) %></div>
        </div>

        <div class="row"><span class="label">Consumer Name</span><span class="value"><%= consumerName %></span></div>
        <div class="row"><span class="label">Consumer No.</span><span class="value"><%= consumerNo %></span></div>
        <div class="row"><span class="label">Meter No.</span><span class="value"><%= meterNo %></span></div>
        <div class="row"><span class="label">Category</span><span class="value"><%= categoryLabel %></span></div>

        <div class="divider"></div>

        <div class="row"><span class="label">Previous Reading</span><span class="value"><%= prevReading %> kWh</span></div>
        <div class="row"><span class="label">Current Reading</span><span class="value"><%= currReading %> kWh</span></div>
        <div class="row highlight"><span class="label">Units Consumed</span><span class="value"><%= units %> kWh</span></div>

        <div class="divider"></div>
        <div class="section-title">Charge Breakdown</div>

        <div class="row"><span class="label">Energy Charge</span><span class="value">₹<%= df.format(energyCharge) %></span></div>
        <div class="row"><span class="label">Fixed Charge</span><span class="value">₹<%= df.format(fixedCharge) %></span></div>
        <div class="row"><span class="label">Electricity Duty (10%)</span><span class="value">₹<%= df.format(electricityDuty) %></span></div>
        <div class="row"><span class="label">Fuel Surcharge (2%)</span><span class="value">₹<%= df.format(fuelSurcharge) %></span></div>

        <div class="divider"></div>
        <div class="row total-row"><span class="label">Total Payable</span><span class="value">₹<%= df.format(totalAmount) %></span></div>

        <div style="text-align: center; margin-top: 24px;">
            <a href="index.jsp" class="back-btn">← Calculate Again</a><br>
            <button class="print-btn" onclick="window.print()">🖨️ Print Bill</button>
        </div>
    </div>
</body>
</html>

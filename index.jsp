<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electricity Bill Calculator - JSP</title>
    <style>
        body { font-family: 'Inter', sans-serif; background: #060b17; color: #f1f5f9; padding: 40px; }
        .container { max-width: 600px; margin: 0 auto; background: #111827; border-radius: 20px; padding: 32px; border: 1px solid rgba(99,102,241,0.2); }
        h1 { text-align: center; font-size: 1.5rem; background: linear-gradient(135deg, #f59e0b, #6366f1); -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 24px; }
        label { display: block; font-size: 0.82rem; color: #94a3b8; margin: 12px 0 4px; }
        input, select { width: 100%; background: rgba(255,255,255,0.04); border: 1px solid rgba(99,102,241,0.2); border-radius: 10px; color: #f1f5f9; padding: 12px 16px; font-size: 0.9rem; outline: none; margin-bottom: 4px; }
        input:focus, select:focus { border-color: rgba(99,102,241,0.6); }
        select option { background: #1a2338; }
        button { width: 100%; padding: 14px; background: linear-gradient(135deg, #f59e0b, #f97316); color: #fff; border: none; border-radius: 10px; font-weight: 700; font-size: 1rem; cursor: pointer; margin-top: 16px; transition: opacity 0.2s; }
        button:hover { opacity: 0.9; }
        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>⚡ Electricity Bill Calculator (JSP)</h1>
        <form action="calculateBill.jsp" method="POST">
            <label>Consumer Name</label>
            <input type="text" name="consumerName" placeholder="e.g. Aditya Wagh" required>

            <div class="row">
                <div>
                    <label>Consumer No.</label>
                    <input type="text" name="consumerNo" placeholder="MH-2024-001" required>
                </div>
                <div>
                    <label>Meter No.</label>
                    <input type="text" name="meterNo" placeholder="MTR-56789" required>
                </div>
            </div>

            <div class="row">
                <div>
                    <label>Previous Reading (kWh)</label>
                    <input type="number" name="prevReading" min="0" placeholder="1200" required>
                </div>
                <div>
                    <label>Current Reading (kWh)</label>
                    <input type="number" name="currReading" min="0" placeholder="1450" required>
                </div>
            </div>

            <label>Category</label>
            <select name="category">
                <option value="residential">🏠 Residential</option>
                <option value="commercial">🏢 Commercial</option>
                <option value="industrial">🏭 Industrial</option>
            </select>

            <button type="submit">⚡ Calculate Bill</button>
        </form>
    </div>
</body>
</html>

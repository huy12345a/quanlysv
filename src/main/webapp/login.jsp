<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
<form action="login" method="post">
    Email: <input type="text" name="email" /><br/>
    Password: <input type="password" name="password" /><br/>
    <input type="submit" value="Login" />
    <% if (request.getParameter("error") != null) { %>
    <p style="color:red;">Invalid email or password</p>
    <% } %>
</form>
</body>
</html>

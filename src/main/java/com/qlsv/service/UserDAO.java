package com.qlsv.service;
import com.qlsv.db.DbConnect;
import com.qlsv.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO implements UserDAOInterface {


    @Override
    public User getUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE email = ?";

        try (Connection connection = DbConnect.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String password = resultSet.getString("password");

                return new User(id, name, email, password);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}

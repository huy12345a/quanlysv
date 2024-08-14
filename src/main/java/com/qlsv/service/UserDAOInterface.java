package com.qlsv.service;

import com.qlsv.model.User;

public interface UserDAOInterface {
    User getUserByEmail(String email);
}

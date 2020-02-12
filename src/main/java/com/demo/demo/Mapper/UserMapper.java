package com.demo.demo.Mapper;

import com.demo.demo.Pojo.User;

public interface UserMapper {

    User selectUser(User user);

    User isExist(String username);

    void insert(User user);

    User getUserByName(String name);
}

package com.demo.demo.Service;

import com.demo.demo.Mapper.UserMapper;
import com.demo.demo.Pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    public boolean checkUser(User user){
        User u = userMapper.selectUser(user);
        if(u == null){
            return false;//如果账号密码输入不正确，返回false
        }
        return true;
    }

    public User getUserByName(String name){
        return userMapper.getUserByName(name);
    }

    public boolean isExist(String username){
        User user = userMapper.isExist(username);
        if(user != null){
            return true;//从数据库可以查找出用户
        }
        return false;
    }

    public void add(User user) {
        userMapper.insert(user);
    }
}

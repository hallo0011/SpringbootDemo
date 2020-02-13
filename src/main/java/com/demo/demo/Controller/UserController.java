package com.demo.demo.Controller;

import com.demo.demo.Pojo.User;
import com.demo.demo.Service.UserAuthService;
import com.demo.demo.Service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private UserAuthService userAuthService;
    @PostMapping("/register")
    public String register(@RequestBody User user){
        if(userService.isExist(user.getUsername())){
            return "用户名已存在";
        }
        // 根据用户名生成盐
        String salt = new SecureRandomNumberGenerator().nextBytes().toString();
        // 根据生成的盐和用户输入的密码迭代2次生成新的密码
        String newPassword = new SimpleHash("md5", user.getPassword(), salt, 2).toString();
        // 存储用户信息，包括 salt 与 hash 后的密码
        user.setSalt(salt);
        user.setPassword(newPassword);
        userService.add(user);
        return "注册成功";
    }

    @PostMapping("/login")
    public Object Login(@RequestBody User user){
        Subject subject = SecurityUtils.getSubject();
        //Shiro帮我们写好了UsernamePasswordToken，只要提交账号密码，后面的交给Realm，Realm交给SecurityManage
        UsernamePasswordToken token = new UsernamePasswordToken(user.getUsername(),user.getPassword());
        //只要一行代码就能实现登录
        try {
            subject.login(token);
            Map<String,Object> result = new HashMap<>();
            result.put("token",subject.getSession().getId().toString());
            result.put("rid",userAuthService.getUserRole(user.getUsername()));
            return result;
        }catch (UnknownAccountException e){ //处理我们在Realm中抛出的异常
            return "用户不存在";
        }catch (AuthenticationException e){ //当Shiro发现用户的账号密码不匹配时自动抛出这个异常
            return "账号或密码错误";
        }
    }

    @PostMapping("/logout")
    public String logout(){
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return "登出成功";
    }

    @GetMapping("/getAuth")
    public Integer isAuth(){
        Subject subject = SecurityUtils.getSubject();
        if(subject.isAuthenticated())
            return 1;
        return 0;
    }
}

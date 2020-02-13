package com.demo.demo.Realm;

import com.demo.demo.Pojo.User;
import com.demo.demo.Service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

public class UserRealm extends AuthorizingRealm {//所有自定义的Realm必须继承AuthorizingRealm

    @Autowired
    private UserService userService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        return null;//对登录用户的授权，现在我们先不写
    }

    //此部分处理登录
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String username = token.getPrincipal().toString();//token由控制层传入，获取token中存储的用户名
        User user = userService.getUserByName(username);//根据用户名去数据库查询是否存在该用户
        if(user == null){
            throw new UnknownAccountException();//用户不存在抛出不存在异常交给控制层处理
        }
        String password = user.getPassword();
        String salt = user.getSalt();
        //再次把salt转成byte将整个认证交给SecurityManage
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(username,password, ByteSource.Util.bytes(salt),getName());
        return authenticationInfo;
    }
}

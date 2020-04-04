package com.demo.demo.Service;


import com.demo.demo.Mapper.UserAuthMapper;
import com.demo.demo.Pojo.Menu;
import com.demo.demo.Pojo.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class UserAuthService {

    @Autowired
    private UserAuthMapper userAuthMapper;

    public List<Menu> getByChildMenu( Integer rid,Integer parentId) {
        return userAuthMapper.getByParentId(rid,parentId);
    }

    public List<Menu> getUserMenu(Integer rid) {
        return userAuthMapper.getUserMenu(rid);
    }

    public Map<String,List> getAllMenu(){
        Map<String,List> result = new HashMap<>();
        List<Menu> noParentMenu = userAuthMapper.getAllMenu();
        result.put("noParent",menuManage(noParentMenu));
        result.put("parent",userAuthMapper.getParentMenuId());
        return result;
    }

    public Integer getUserRole(String username){
        return userAuthMapper.getUserRoleId(username);
    }

    private List menuManage(List<Menu> menus) {//对菜单进行格式化
        for(Menu menu : menus){
            menu.setChild(userAuthMapper.getByPid(menu.getId()));
        }
        Iterator<Menu> iterator = menus.iterator();
        while (iterator.hasNext()) {
            Menu menu = iterator.next();
            if (menu.getParent_id() != 0) {
                iterator.remove();
            }
        }
        return menus;
    }

    public List<Integer> getRoleMenu(Integer rid) {
        return userAuthMapper.getRoleMenu(rid);
    }
}

package com.demo.demo.Mapper;


import com.demo.demo.Pojo.Menu;
import com.demo.demo.Pojo.Role;

import java.util.List;

public interface UserAuthMapper {
    List<Role> searchRoleByUid(Integer uid);

    Integer getUserRoleId(String username);

    List<Menu> getUserMenu(Integer rid);

    List<Menu> getByParentId(Integer rid, Integer parentId);

    List<Menu> getByPid(Integer pid);

    List<Menu> getAllMenu();

    List<Integer> getParentMenuId();

}

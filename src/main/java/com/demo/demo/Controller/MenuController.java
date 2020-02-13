package com.demo.demo.Controller;

import com.demo.demo.Pojo.Menu;
import com.demo.demo.Service.UserAuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private UserAuthService userAuthService;

    @GetMapping("/get/{rid}")
    public List<Menu> getMenu(@PathVariable Integer rid){
        List<Menu> menus = userAuthService.getUserMenu(rid);
        for(Menu menu : menus){
            if(menu.getParent_id() == 0)
                menu.setChild(userAuthService.getByChildMenu(rid,menu.getId()));
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

    @GetMapping("/all")
    public Map<String,List> getAllMenu(){
        return userAuthService.getAllMenu();
    }
}

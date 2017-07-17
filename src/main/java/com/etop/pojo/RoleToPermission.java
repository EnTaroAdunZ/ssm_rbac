package com.etop.pojo;

import org.springframework.stereotype.Component;

@Component
public class RoleToPermission {
    private Long id;
    private Role role;
    private Permission permission;



    public Long getId() {
        return id;
    }

    public Role getRole() {
        return role;
    }



    public void setId(Long id) {
        this.id = id;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Permission getPermission() {
        return permission;
    }

    public void setPermission(Permission permission) {
        this.permission = permission;
    }
}
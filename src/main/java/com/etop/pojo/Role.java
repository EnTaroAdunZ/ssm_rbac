package com.etop.pojo;

import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class Role {
    private Long id;

//    @Pattern(regexp = "^[a-z0-9_-]{3,30}$",message = "角色代码必须是3-30位英文和数字组合")
    private String sn;

//    @Pattern(regexp = "^[\\u2E80-\\u9FFF]{1,10}$",message = "角色名必须是3-30位英文和数字组合")
    private String name;

    private List<Permission> permissionList;

    public List<Permission> getPermissionList() {
        return permissionList;
    }

    public void setPermissionList(List<Permission> permissionList) {
        this.permissionList = permissionList;
    }

    @Override
    public String toString() {
        return "Role{" +
                "id=" + id +
                ", sn='" + sn + '\'' +
                ", name='" + name + '\'' +
                '}';
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSn() {
        return sn;
    }

    public void setSn(String sn) {
        this.sn = sn == null ? null : sn.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }
}
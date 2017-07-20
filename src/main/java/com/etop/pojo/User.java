package com.etop.pojo;

import org.springframework.stereotype.Component;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;
import java.util.List;

@Component
public class User {
    private Long id;

    @Pattern(regexp = "^[\\u4e00-\\u9fa5a-zA-Z0-9_]{1,14}$",message = "昵称最长不得超过7个汉字，或14个字节(数字，字母和下划线)")
    private String name;

    @Pattern(regexp = "^[a-z0-9_-]{3,16}$",message = "手机必须位于3-16位之间")
    private String phone;

    @Max(value=150,message="年龄必须介于0-150之间")
    @Min(value=0,message="年龄必须介于0-150之间")
    private Integer age;

    @Max(value=999999999,message="经验值必须介于0-999999999")
    @Min(value=0,message="经验值必须介于0-999999999")
    private Long experience;

    @Pattern(regexp = "^[a-z0-9_-]{3,16}$",message = "帐号密码必须是3-16位英文和数字组合")
    private String account;

    @Pattern(regexp = "^[a-z0-9_-]{3,16}$",message = "帐号密码必须是3-16位英文和数字组合")
    private String password;

    private List<Role> roleList;

    public List<Role> getRoleList() {
        return roleList;
    }

    public void setRoleList(List<Role> roleList) {
        this.roleList = roleList;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                ", age=" + age +
                ", experience=" + experience +
                ", account='" + account + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Long getExperience() {
        return experience;
    }

    public void setExperience(Long experience) {
        this.experience = experience;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account == null ? null : account.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }
}
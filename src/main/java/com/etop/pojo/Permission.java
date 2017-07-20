package com.etop.pojo;

import org.springframework.stereotype.Component;


@Component
public class Permission {
    private Long id;
//    @Pattern(regexp = "^[a-z0-9.-]{3,30}$",message = "权限标识符必须是3-30位英文和数字组合")
    private String expression;
//    @Pattern(regexp = "^[\\u2E80-\\u9FFF]{1,10}$",message = "权限名必须是3-30位英文和数字组合")
    private String name;

    @Override
    public String toString() {
        return "Permission{" +
                "id=" + id +
                ", expression='" + expression + '\'' +
                ", name='" + name + '\'' +
                '}';
    }

    public Permission() {
    }

    public Permission(String expression, String name) {
        this.expression = expression;
        this.name = name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Permission that = (Permission) o;

        return expression.equals(that.expression);
    }

    @Override
    public int hashCode() {
        return expression.hashCode();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getExpression() {
        return expression;
    }

    public void setExpression(String expression) {
        this.expression = expression == null ? null : expression.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }
}
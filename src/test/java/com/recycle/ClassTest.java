package com.recycle;

import com.recycle.bean.Carrier;
import com.recycle.bean.User;
import org.junit.jupiter.api.Test;

public class ClassTest {
    @Test
    public void test(){
        System.out.println(classEquals(new Carrier()));
    }
    public String classEquals(Object obj){
        if (obj.getClass()== Carrier.class){
            return "carrier";
        }
        else if (obj.getClass()== User.class)
            return "user";

        else return "";
    }
}

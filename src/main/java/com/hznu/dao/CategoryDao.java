package com.hznu.dao;

import com.hznu.domain.Category;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CategoryDao {

    List<Category> selectAllFromCategory();

    List<Category> selectRootCategory();

    List<Category> selectCategoryByParentCategoryId(@Param("parentCategoryId") String parentCategoryId);
}

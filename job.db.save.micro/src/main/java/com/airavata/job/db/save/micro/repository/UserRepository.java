package com.airavata.job.db.save.micro.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.airavata.job.db.save.micro.entity.User;

@Repository
public interface UserRepository extends CrudRepository<User, Integer> {

	@Query("Select u from airavata_user u " + "where u.username=:username ")
	public User findUser(@Param("username") String username);

}

package com.airavata.job.db.save.micro.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.airavata.job.db.save.micro.entity.JobDetails;
import com.airavata.job.db.save.micro.entity.User;
import com.airavata.job.db.save.micro.repository.JobDbSaveRepository;
import com.airavata.job.db.save.micro.repository.UserRepository;

@Repository
@Service
@ComponentScan
public class JobSaveServiceImpl implements JobSaveService {

	@Autowired
	private JobDbSaveRepository jobDbSaveRepository;
	
	@Autowired
	private UserRepository userRepo;
	
	public int saveJobDetails(JobDetails jobDetails) {
			
		try {
			
			User user = userRepo.findUser(jobDetails.getUser().getUsername());
			
			jobDetails.setUser(user);
			jobDbSaveRepository.save(jobDetails);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return 0;
		}
		return 1;
	}

}

/* 
 * Copyright 2012-2016 bambooCORE, greenstep of copyright Chen Xin Nien
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * 
 * -----------------------------------------------------------------------
 * 
 * author: 	Chen Xin Nien
 * contact: chen.xin.nien@gmail.com
 * 
 */
package com.netsteadfast.greenstep.action;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.netsteadfast.greenstep.base.action.BaseJsonAction;
import com.netsteadfast.greenstep.base.exception.AuthorityException;
import com.netsteadfast.greenstep.base.exception.ControllerException;
import com.netsteadfast.greenstep.base.exception.ServiceException;
import com.netsteadfast.greenstep.base.model.ControllerAuthority;
import com.netsteadfast.greenstep.base.model.ControllerMethodAuthority;
import com.netsteadfast.greenstep.base.model.DefaultResult;
import com.netsteadfast.greenstep.service.logic.ISystemMenuLogicService;

@ControllerAuthority(check=true)
@Controller("core.web.controller.SystemMenuSaveOrUpdateAction")
@Scope
public class SystemMenuSaveOrUpdateAction extends BaseJsonAction {
	private static final long serialVersionUID = -2075396511848454207L;
	protected Logger logger=Logger.getLogger(SystemMenuSaveOrUpdateAction.class);
	private ISystemMenuLogicService systemMenuLogicService;
	private String message = "";
	private String success = IS_NO;
	
	public SystemMenuSaveOrUpdateAction() {
		super();
	}
	
	@JSON(serialize=false)
	public ISystemMenuLogicService getSystemMenuLogicService() {
		return systemMenuLogicService;
	}

	@Autowired
	@Resource(name="core.service.logic.SystemMenuLogicService")	
	public void setSystemMenuLogicService(
			ISystemMenuLogicService systemMenuLogicService) {
		this.systemMenuLogicService = systemMenuLogicService;
	}

	private void checkFields() throws ControllerException {
		this.getCheckFieldHandler().single(
				"CORE_PROG001D0003Q_sysProg", 
				( super.isNoSelectId(this.getFields().get("sysProgOid")) ), 
				"Please select a Folder program item!").throwMessage();
	}
	
	/**
	 * 儲存或更新 TB_SYS_MENU
	 * 
	 * @throws ControllerException
	 * @throws AuthorityException
	 * @throws ServiceException
	 * @throws Exception
	 */
	private void save() throws ControllerException, AuthorityException, ServiceException, Exception {
		this.checkFields();
		String folderProgramOid = this.getFields().get("sysProgOid");
		List<String> programOidList = super.transformAppendIds2ListByEncode(this.getFields().get("appendChildProgOid"));
		DefaultResult<Boolean> result = this.systemMenuLogicService.createOrUpdate(folderProgramOid, programOidList);
		if ( result.getValue()==null || !result.getValue() ) {
			throw new ServiceException(result.getSystemMessage().getValue());
		}
		this.message = result.getSystemMessage().getValue();
		this.success = IS_YES;
	}
	
	/**
	 * core.systemMenuSaveAction.action
	 * 
	 * @return
	 * @throws Exception
	 */
	@ControllerMethodAuthority(programId="CORE_PROG001D0003Q")
	public String doSave() throws Exception {
		try {
			if (!this.allowJob()) {
				this.message = this.getNoAllowMessage();
				return SUCCESS;
			}
			this.save();
		} catch (ControllerException ce) {
			this.message=ce.getMessage().toString();
		} catch (AuthorityException ae) {
			this.message=ae.getMessage().toString();
		} catch (ServiceException se) {
			this.message=se.getMessage().toString();
		} catch (Exception e) { // 因為是 JSON 所以不用拋出 throw e 了
			e.printStackTrace();
			this.message=e.getMessage().toString();
			this.logger.error(e.getMessage());
			this.success = IS_EXCEPTION;
		}
		return SUCCESS;		
	}

	@JSON
	@Override
	public String getLogin() {
		return super.isAccountLogin();
	}
	
	@JSON
	@Override
	public String getIsAuthorize() {
		return super.isActionAuthorize();
	}	

	@JSON
	@Override
	public String getMessage() {
		return this.message;
	}

	@JSON
	@Override
	public String getSuccess() {
		return this.success;
	}

	@JSON
	@Override
	public List<String> getFieldsId() {
		return this.fieldsId;
	}

}

//
//  API_JCH.swift
//  JCH VCC
//
//  Created by Sami on 12/10/18.
//  Copyright © 2018 Sami. All rights reserved.
//
//
import Foundation
//var basePath                                              = "http://182.163.112.196:8084" // SERVER
//var basePath                                              = "http://192.168.1.93:8086" //Temp 86 Server..

//var basePath                                              = "http://192.168.1.114:8086" //GENEREL 86 Server..
//var basePath                                              = "http://192.168.1.114:8081" //Tester
//var basePath                                              = "http://192.168.1.114:8082" //Tester

//var basePath                                              = "http://vcc-demo.us-east-2.elasticbeanstalk.com" // AWS
//var basePath                                              = "https://aircloudpro.hitachiaircon.com/" // LIVE Production
//var basePath                                              = "https://cloudairpro.com" // TEST Production
//var basePath                                              = "http://192.168.1.185:8086" //
//var basePath                                              = "http://192.168.1.114:8087" //
//var basePath                                              = "http://192.168.1.114:5000" //Tester

var basePath                                                = "http://192.168.1.114:8085"
//var basePath                                                = "http://192.168.1.114:8082"



//var basePath                                                = "http://vccuat.us-east-2.elasticbeanstalk.com"//dev 79
//var basePath                                                = "http://vcc-prod.us-east-2.elasticbeanstalk.com"//pro 80


public let API_REFRESH_TOKEN                            = "\(basePath)/rest/auth/token"
public let API_USER_SIGNIN                              = "\(basePath)/rest/auth/sign-in"
public let API_USER_SIGN_UP                             = "\(basePath)/rest/user/signUp"
public let API_CREATE_PASSWORD                          = "\(basePath)/rest/user/createPassword"
public let API_USER_LIST                                = "\(basePath)/rest/user/userList"
public let API_FORGOT_PASSWORD                          = "\(basePath)/rest/user/forgetPassword"
public let API_RESET_PASSWORD_REQUEST                   = "\(basePath)/rest/user/resetPassword"
public let API_EMAIL_VALIDATE                           = "\(basePath)/rest/user/validateEmail"
public let API_UPDATE_USER                              = "\(basePath)/rest/user/updateUser"

public let API_THING_USER_LIST                          = "\(basePath)/rest/thing/thingUserList"

public let API_GATEWAY_TO_PROJECT                       = "\(basePath)/rest/project/gatewayAdd"


//public let API_PROJECT_SCORECARD                        = "\(basePath)/rest/project/scorecard"

//public let API_COMMAND_BATCH                            = "\(basePath)/rest/Command/executeBatch"

public let API_ADD_HOLIDAY                              = "\(basePath)/rest/specialDay/holidayAdd"
public let API_HOLIDAY_LIST                             = "\(basePath)/rest/specialDay/holidayList"
public let API_HOLIDAY_EDIT                             = "\(basePath)/rest/specialDay/holidayEdit"
public let API_HOLIDAY_DELETE                           = "\(basePath)/rest/specialDay/holidayDelete"
public let API_HOLIDAY_ACTIVE_INACTIVE                  = "\(basePath)/rest/specialDay/holidayActiveInactive"

public let API_SCHEDULE_SCORECARD                       = "\(basePath)/rest/schedule/projectWiseScoreCard"
public let API_UPCOMING_SCHEDULE                        = "\(basePath)/rest/schedule/upcoming"
public let API_EDIT_SCHEDULE                            = "\(basePath)/rest/schedule/edit"
public let API_DELETE_SCHEDULE                          = "\(basePath)/rest/schedule/delete"
public let API_STATUS_UPDATE_SCHEDULE                   = "\(basePath)/rest/schedule/updateStatus"

public let API_ADD_USER_TO_PROJECT                      = "\(basePath)/rest/project/addUserInBatch"
public let API_USER_DETAILS_BY_EMAIL                    = "\(basePath)/rest/user/userDetailsByEmail"
public let API_INVITE_USER                              = "\(basePath)/rest/project/inviteUser"

public let API_RC_WISE_SCHEDULE_DATE_LIST               = "\(basePath)/rest/schedule/rcWiseScheduleDateList"
public let API_SPECIALDAY_LIST                          = "\(basePath)/rest/specialDay/list"
public let API_SPECIALDAY_DELETE                        = "\(basePath)/rest/specialDay/delete"

public let API_SIGNUP_TEMP                              = "\(basePath)/rest/account/pre-signUp"
public let API_SENT_OTP                                 = "\(basePath)/rest/account/send-otp"
public let API_GET_EMAIL                                = "\(basePath)/rest/account/forgot-email"
public let API_OTP_VALIDATION                           = "\(basePath)/rest/account/validate-otp"
public let API_NEW_SIGN_UP                              = "\(basePath)/rest/account/signUp"
public let RESET_PASSWORD                               = "\(basePath)/rest/account/resetPassword"

// static json....

public let API_GET_COUNTRY_LIST                         = "https://geodata.solutions/api/api.php?type=getCountries"
public let API_GET_STATE_LIST                           = "https://geodata.solutions/api/api.php?type=getStates&countryId="
public let API_GET_CITY_LIST                            = "https://geodata.solutions/api/api.php?type=getCities&countryId="

// DFS IMPLEMENTATION

public let API_RC_Group_List                            = "\(basePath)/rest/project/gatewayWiseAddressGroupList/"
public let API_Zoning_List                              = "\(basePath)/rest/zone/list/"
public let API_ADD_ZONE                                 = "\(basePath)/rest/zone/add"
public let API_Assign_Address_Group                     = "\(basePath)/rest/zone/batchAssignAddressGroup"
public let API_UnAssign_Address_Group                   = "\(basePath)/rest/zone/unAssignAddressGroup" 
public let API_Zone_Edit                                = "\(basePath)/rest/zone/edit"
public let API_ZONE_DELETE                              = "\(basePath)/rest/zone/delete"
public let API_Rename_Address_Group                     = "\(basePath)/rest/thing/renameAddressGroup"
public let API_THING_PROPERTY                           = "\(basePath)/rest/thing/thingProperty"
public let API_USER_ONBOARDING                          = "\(basePath)/rest/thing/on-board-user"
public let API_VERIFY_THING                             = "\(basePath)/rest/thing/verifyThing"
public let API_VERIFY_THING_ONBOARDED                   = "\(basePath)/rest/thing/verifyIsThingOnBoarded"
public let API_USER_THING_LIST                          = "\(basePath)/rest/installerDashboard/userWiseThingList"
public let API_USER_WISE_SCORE_CARD                     = "\(basePath)/rest/installerDashboard/userWiseScoreBoard"
public let API_ADD_PROJECT                              = "\(basePath)/rest/project/add"
public let API_GET_PROJECT_ID                           = "\(basePath)/rest/project/get-ProjectId"
public let API_USER_LIST_TO_ADD_IN_PROJECT              = "\(basePath)/rest/project/userListToAddIntoProject"
public let API_USER_WISE_PROJECT_LIST                   = "\(basePath)/rest/installerDashboard/userWiseProjectList"
public let API_PROJECT_DETAILS                          = "\(basePath)/rest/project/details"
public let API_DISCONNECT_USER                          = "\(basePath)/rest/project/userDisconnect"
public let API_DISCONNECT_GATEWAY                       = "\(basePath)/rest/project/gatewayDisconnect"
public let API_DELETE_PROJECT                           = "\(basePath)/rest/project/delete"
public let API_USER_DETAILS                             = "\(basePath)/rest/user/who-am-i"
public let API_PROJECT_EDIT                             = "\(basePath)/rest/project/edit"
public let API_USER_UNBOUNDING                          = "\(basePath)/rest/thing/un-bound-user"
public let API_EDIT_GATEWAY                             = "\(basePath)/rest/thing/editThingDisplayName"
public let API_PROJECT_SCORECARD                        = "\(basePath)/rest/project/scorecard"
public let API_PROJECT_WISE_THING_STATUS                = "\(basePath)/rest/project/projectWiseThingStatus"
public let API_PROFILE_UPDATE                           = "\(basePath)/rest/user/profileUpdate"
public let API_DELETE_USER                              = "\(basePath)/rest/user/delete"
public let API_DASHBOARD_USER_LIST                      = "\(basePath)/rest/installerDashboard/dashboardUserList"
public let API_COMMAND_BATCH                            = "\(basePath)/rest/IotCommand/executeBatch" //not complete
public let API_PROJECT_WISESCORE_CARD                   = "\(basePath)/rest/schedule/projectWiseScoreCard"
public let API_ADD_SCHEDULE                             = "\(basePath)/rest/schedule/add"
public let API_SCHEDULE_STEP_VALIDATION                 = "\(basePath)/rest/schedule/addStepValidation"
public let API_SCHEDULE_LIST                            = "\(basePath)/rest/schedule/list"
public let API_SCHEDULE_DETAILS                         = "\(basePath)/rest/schedule/details"
public let API_SCHEDULE_EDIT_STEPS_VALIDATION           = "\(basePath)/rest/schedule/editStepValidation"
public let API_SCHEDULE_UPDATE_STATUS                   = "\(basePath)/rest/schedule/updateStatus"
public let API_SCHEDULE_DELETE                          = "\(basePath)/rest/schedule/delete"
public let API_SPECIALDAY_ADD                           = "\(basePath)/rest/specialDay/add"
public let API_SPECIAL_DAY_STEP_VALIDATION              = "\(basePath)/rest/specialDay/addStepValidation"
public let API_SPECIAL_DAY_UPDATE_STATUS                = "\(basePath)/rest/specialDay/updateStatus"
public let API_SPECIALDAY_EDIT                          = "\(basePath)/rest/specialDay/edit"
public let API_EDIT_SPECIAL_DAY_STEP_VALIDATION         = "\(basePath)/rest/specialDay/editStepValidation"
public let API_SPECIALDAY_DETAILS                       = "\(basePath)/rest/specialDay/details"
public let API_SYNC_THING_DATA                          = "\(basePath)/rest/thing/syncThingData"
public let API_ADD_GATEWAY_TO_EXISTING_PROJECT          = "\(basePath)/rest/project/addGatewayInBatch"
public let API_Project_Wise_Error_List                  = "\(basePath)/rest/error/list"
public let API_Project_Wise_Error_History               = "\(basePath)/rest/error/history"
public let API_IDU_Wise_Error_List                      = "\(basePath)/rest/error/iduDetails"
public let API_CHANGE_PASSWORD                          = "\(basePath)/rest/user/changePassword"
public let API_TIME_ZONE                          = "\(basePath)/rest/app-settings/time-zone"


/**
*
*Copyright 2010 OuterCurve Foundation
*
*Licensed under the Apache License, Version 2.0 (the "License");
*you may not use this file except in compliance with the License.
*You may obtain a copy of the License at
*
*http://www.apache.org/licenses/LICENSE-2.0
*
*Unless required by applicable law or agreed to in writing, software
*distributed under the License is distributed on an "AS IS" BASIS,
*WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*See the License for the specific language governing permissions and
*limitations under the License.
*/
/**
* This code was generated by the tool 'odatagen'.
* Runtime Version:1.0
*
* Changes to this file may cause incorrect behavior and will be lost if
* the code is regenerated.
*/
/**
* Defines default Data Service URL for this proxy class
*/
#define DEFAULT_SERVICE_URL @""


#define DataServiceVersion @"1.0"

#import "ODataObject.h"
#import "ObjectContext.h"
#import "DataServiceQuery.h"
#import "ODataGUID.h"
#import "ODataBool.h"
#import  "mProperties.h"


/**
 * @interface:Questions
 * @Type:EntityType
 
 * @key:QuestionId* 
 */
@interface parastr_thirrpModel_Questions : ODataObject
{
	
	/**
	* @Type:EntityProperty
	* NotNullable
	* @EdmType:Edm.Int32
	*/
	NSNumber *m_QuestionId;
	
	/**
	* @Type:EntityProperty
	* @EdmType:Edm.String
	* @MaxLength:10
	* @FixedLength:false
	*/
	NSString *m_Locale;
	
	/**
	* @Type:EntityProperty
	* @EdmType:Edm.String
	* @MaxLength:4000
	* @FixedLength:false
	*/
	NSString *m_Question;
	
	/**
	* @Type:EntityProperty
	* @EdmType:Edm.String
	* @MaxLength:4000
	* @FixedLength:false
	*/
	NSString *m_Answer;
	
	/**
	* @Type:EntityProperty
	* @EdmType:Edm.Int32
	*/
	NSNumber *m_AskUserId;
	
	/**
	* @Type:EntityProperty
	* @EdmType:Edm.DateTime
	*/
	NSDate *m_AskDateTime;
	
	/**
	* @Type:EntityProperty
	* @EdmType:Edm.Int32
	*/
	NSNumber *m_AnswerUserId;
	
	/**
	* @Type:EntityProperty
	* @EdmType:Edm.DateTime
	*/
	NSDate *m_AnswerDateTime;
	
	/**
	* @Type:EntityProperty
	* @EdmType:Edm.Boolean
	*/
	ODataBool *m_Archived;
	
	/**
	* @Type:EntityProperty
	* @EdmType:Edm.Boolean
	*/
	ODataBool *m_ViewedAnswer;
	
	/**
	* @Type:NavigationProperty
	* @Relationship:FK_Questions_AnswerUserId
	* @FromRole:Questions
	* @ToRole:Users
	*/
	NSMutableArray *m_Users;
	
	/**
	* @Type:NavigationProperty
	* @Relationship:FK_Questions_AskUserId
	* @FromRole:Questions
	* @ToRole:Users
	*/
	NSMutableArray *m_Users1;
	
}

@property ( nonatomic , retain , getter=getQuestionId , setter=setQuestionId )NSNumber *m_QuestionId;
@property ( nonatomic , retain , getter=getLocale , setter=setLocale ) NSString *m_Locale;
@property ( nonatomic , retain , getter=getQuestion , setter=setQuestion ) NSString *m_Question;
@property ( nonatomic , retain , getter=getAnswer , setter=setAnswer ) NSString *m_Answer;
@property ( nonatomic , retain , getter=getAskUserId , setter=setAskUserId )NSNumber *m_AskUserId;
@property ( nonatomic , retain , getter=getAskDateTime , setter=setAskDateTime )NSDate *m_AskDateTime;
@property ( nonatomic , retain , getter=getAnswerUserId , setter=setAnswerUserId )NSNumber *m_AnswerUserId;
@property ( nonatomic , retain , getter=getAnswerDateTime , setter=setAnswerDateTime )NSDate *m_AnswerDateTime;
@property ( nonatomic , retain , getter=getArchived , setter=setArchived )ODataBool *m_Archived;
@property ( nonatomic , retain , getter=getViewedAnswer , setter=setViewedAnswer )ODataBool *m_ViewedAnswer;
@property ( nonatomic , retain , getter=getUsers , setter=setUsers )NSMutableArray *m_Users;
@property ( nonatomic , retain , getter=getUsers1 , setter=setUsers1 )NSMutableArray *m_Users1;

+ (id) CreateQuestionsWithquestionid:(NSNumber *)aQuestionId;
- (id) init;
- (id) initWithUri:(NSString*)anUri;
@end

/**
 * @interface:Users
 * @Type:EntityType
 
 * @key:UserId* 
 */
@interface parastr_thirrpModel_Users : ODataObject
{
	
	/**
	* @Type:EntityProperty
	* NotNullable
	* @EdmType:Edm.Int32
	*/
	NSNumber *m_UserId;
	
	/**
	* @Type:EntityProperty
	* NotNullable
	* @EdmType:Edm.String
	* @MaxLength:40
	* @FixedLength:true
	*/
	NSString *m_DeviceID;
	
	/**
	* @Type:EntityProperty
	* @EdmType:Edm.String
	* @MaxLength:64
	* @FixedLength:true
	*/
	NSString *m_DeviceToken;
	
	/**
	* @Type:EntityProperty
	* @EdmType:Edm.Int32
	*/
	NSNumber *m_BadgeCount;
	
	/**
	* @Type:NavigationProperty
	* @Relationship:FK_Questions_AnswerUserId
	* @FromRole:Users
	* @ToRole:Questions
	*/
	NSMutableArray *m_Questions;
	
	/**
	* @Type:NavigationProperty
	* @Relationship:FK_Questions_AskUserId
	* @FromRole:Users
	* @ToRole:Questions
	*/
	NSMutableArray *m_Questions1;
	
}

@property ( nonatomic , retain , getter=getUserId , setter=setUserId )NSNumber *m_UserId;
@property ( nonatomic , retain , getter=getDeviceID , setter=setDeviceID ) NSString *m_DeviceID;
@property ( nonatomic , retain , getter=getDeviceToken , setter=setDeviceToken ) NSString *m_DeviceToken;
@property ( nonatomic , retain , getter=getBadgeCount , setter=setBadgeCount )NSNumber *m_BadgeCount;
@property ( nonatomic , retain , getter=getQuestions , setter=setQuestions )NSMutableArray *m_Questions;
@property ( nonatomic , retain , getter=getQuestions1 , setter=setQuestions1 )NSMutableArray *m_Questions1;

+ (id) CreateUsersWithuserid:(NSNumber *)aUserId deviceid:(NSString *)aDeviceID;
- (id) init;
- (id) initWithUri:(NSString*)anUri;
@end

/**
 * Container interface Entities, Namespace: parastr_thirrpModel
 */
@interface Entities : ObjectContext
{
	 NSString *m_OData_etag;
	 DataServiceQuery *m_Questions;
	 DataServiceQuery *m_Users;
	
}

@property ( nonatomic , retain , getter=getEtag , setter=setEtag )NSString *m_OData_etag;
@property ( nonatomic , retain , getter=getQuestions , setter=setQuestions ) DataServiceQuery *m_Questions;
@property ( nonatomic , retain , getter=getUsers , setter=setUsers ) DataServiceQuery *m_Users;

- (id) init;
- (id) initWithUri:(NSString*)anUri credential:(id)acredential;
- (NSString *) RegisterDeviceWiths:(NSString *)s;
- (NSString *) AnswerQuestionWithstrquestionid:(NSString *)strQuestionId stranswer:(NSString *)strAnswer;
- (NSArray *) GetQuestionToAnswerWithstrlocale:(NSString *)strLocale;
- (NSArray *) GetQuestionWithstrquestionid:(NSString *)strQuestionId;
- (NSArray *) InsertQuestionWithstrlocale:(NSString *)strLocale strquestion:(NSString *)strQuestion;
- (NSArray *) GetQuestionsByUserId;
- (NSString *) ArchiveQuestionWithstrquestionid:(NSString *)strQuestionId;
- (NSString *) SavePushTokenWiths:(NSString *)s;
- (NSString *) DidViewAnswerWithstrquestionid:(NSString *)strQuestionId;
- (id) questions;
- (id) users;
- (void) addToQuestions:(id)anObject;
- (void) addToUsers:(id)anObject;

@end

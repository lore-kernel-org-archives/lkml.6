Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeE3Nnb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:43:31 -0400
Received: from mail-by2nam03on0086.outbound.protection.outlook.com ([104.47.42.86]:33275
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750757AbeE3Nn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:43:27 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com;
Cc: brijesh.singh@amd.com, Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCHv2 0/2] Add new SEV commands
To: Paolo Bonzini <pbonzini@redhat.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1527274269.git.Janakarajan.Natarajan@amd.com>
 <69cd82ba-d60d-d3f8-37ee-ef4cd769f611@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <47120fa2-cdda-dc6e-d0cd-2f8803cc7982@amd.com>
Date: Wed, 30 May 2018 08:43:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <69cd82ba-d60d-d3f8-37ee-ef4cd769f611@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0201CA0008.namprd02.prod.outlook.com
 (2603:10b6:803:2b::18) To SN1PR12MB2464.namprd12.prod.outlook.com
 (2603:10b6:802:29::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2464;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2464;3:G3a8HiyCo7ddrrnzh9xtLrYdJaelPQ23jQUKRz47t2DfU5EYx7JoFeXtuMX0xIyeETnYduCWCz16ly4vyTvBxEWZPRT3ffn7HrluWsCpeygJrkEcrYzGl8S7K9bVJPa2Wj41sQ00u6UflKwlk0TYWJqvnse6wBKKnKZtkrD4f5pWSX95AAZfIHjjfHfdJNbnu3MtwBRzUSYTt+gFsG+WhzVniZU3PGbm2KOslpS4gQT5vO4SryGN33+motq6H0Kn;25:om8Ray6SuYzKbSIfG3dVgdHFca3TT/2DbB2jZLMWGUbmcR5AdF8qaXVC5wp5jmBYsYowWjrpiRD8SrMchtTniNSJfb+lbShofjKyXAuZ9gDueTevPdqRjAlqA7mYZFWcBDAws59o4olOnb7VJTiCGLw1jisGEWq9wR3yj0G8mFdEIfxl3pThL9Hh7StxMv6+5Kqzauub86juJZKuLIIBn2GuTp1R/li7V6a/7LK2Q74Pn69/Daxg13NsQeRk41KL+DViFhecqKcOz9HoXbJYlBMqxkf8ndMUaGG1yNuQcHIxQSBUvcpxzL3fmmoAv0pJQH117EhzILtLVTuBy1AlZg==;31:CakfJ2TsQj/Vt103jqCfQvTdNywxkpDphfGxMnF9AsLA0x8Ey646WlkLbz3voxkKRyemy5VX+F6pID9LCxyinyZAMbOGoJ2PApMqzDZjtRhExtYe68ZSNjwgnbss8GwpekLtfagF2Dz0tLVMN433Sm+evCWEVM27uEBgLAfyUrsyYvf6L8zMSGWl2BLPP69yoTRoE06wApUtXeOPAGh5uzZqdogZDagFX3u15F36yvo=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2464:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2464;20:5+ZilkfXcJ9+2OqS/zs4GJdcpAvaJINk/wUB4fJ0b/oHqRLmiilPAtv+MzKAU3PZcelRIoFLVRaZmw4nicDsCr6KI9tgUmt2OiODUIxeRM2tGS7u8MrMSEipn43ztl0kmbDjomUUhDEr+eZyF/Cm+PgB+Bn9nvVF5oOnU162qkLYz7nzzeTQ1XlDFBrkwfIfb15RPO6DJsrVxY/YiDTuB7d+qwVFh1UiuGn/RvBV7aUs2vNoXQ/C0ew1q151+gppiRHxaM8DjUwFIcvhyjB18lJO5Qzf9YYS6ApwYzPugPh5nTF3ZMzTaaEiCT6zBwc96N0En2szGjr6GuBf55M+JfKiVFMauGwMiscIeZOWckfWwsD+1PA+U73yP7zkGpOINnSlS7460BEBH1/1Ai4SkZHyeie2DyE3YN8UzKq+NnWVVnJRJcp5oBVgxt6t3uWSRHDjZAh46l+SSHuiFHSQ5WFZVbWHKKOzLsRdmHDEpFiVFGUcrSlNTO5/Eqdiy/A0;4:ENYk/65ZATy+6EWzYM20Fa/urLB8z1hQvoWigphMH2mSvKsIYcX/yqxKRYLvSMQepNLnAe5DQ3l3ewnXYa/qO75ocW1Ei7oYX3h6Re3Z2denrlOQG/YuZSQnHBqqHqTOBOUvp+Ppjnq+HF3TK/4bzsy5f+mj3YOa2oM2lhu/bLd0NCf5BM+zz7a2o3TYlehVKtYMztC5BddXlrWGdcfBwCqYDsoxQ8Qs+z6VYnXIXmz37kD+OnSF0fzAReeuT71CpoHWV+w9z0TzWt16dwTmGg==
X-Microsoft-Antispam-PRVS: <SN1PR12MB24642F58A16E3428150F23E9E56C0@SN1PR12MB2464.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB2464;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2464;
X-Forefront-PRVS: 0688BF9B46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39380400002)(39850400004)(396003)(346002)(376002)(199004)(189003)(65826007)(86362001)(97736004)(2906002)(81156014)(54906003)(110136005)(8676002)(53546011)(16576012)(316002)(6486002)(76176011)(36756003)(31696002)(52146003)(52116002)(3846002)(4326008)(230700001)(53936002)(6116002)(7736002)(25786009)(478600001)(6246003)(31686004)(67846002)(229853002)(105586002)(58126008)(956004)(476003)(77096007)(26005)(386003)(106356001)(23676004)(2486003)(50466002)(65956001)(16526019)(66066001)(186003)(6666003)(446003)(11346002)(65806001)(47776003)(2616005)(68736007)(44832011)(81166006)(5660300001)(8936002)(305945005)(486006)(64126003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2464;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIyNDY0OzIzOjJnWDFZcHJidVI2dGlSRzUvK25Wb2ZpZmRk?=
 =?utf-8?B?WXFwUU5MQlo0VzhoRzM3VWwxZXJHTnNoVklacDMxczloNFdnVC8wM2lycXQz?=
 =?utf-8?B?SFlkTkJkc1BKbEdOSTlBVHNWbWlGa292RHEzWlFKTEZtWWhrOFpDbUhXMmhu?=
 =?utf-8?B?ZkcwRFJWVTA3SmlkU3U5WjN6NlYwemMzQ3FyRzIzeUtNc2xSVWFtZ0RrM0dt?=
 =?utf-8?B?K2pxRVlPUG5Yak8venMrQXcrdTVMZ281d01RNXdTLysrYk1mSHAyZW0rSzd1?=
 =?utf-8?B?L2wyZGxxMVhleENxU2gxQzVubTU4a0hWajR3TnBKY2VpdVFKM3J1Q25XeHJv?=
 =?utf-8?B?QU8xNkMwQk96SVlzWkNZS3MxR1RmOG1UanJ4ZXlZQVk2Zk9yMGFwbnVMT2ps?=
 =?utf-8?B?MVhLL0FsRDVQaUY5UHJLbW9QcnBMVzdCT1c3UUVjSkpBWTFuZmEyR1RCWTM5?=
 =?utf-8?B?NG5GWDhtRW1tcjJERkVuaEEzRlU4b2lRNVhISk82VWVyblYyMTVVai80bHJY?=
 =?utf-8?B?NHRrdHg0b3dsMWVOZzc1MmRwSW0zMGthTU9hdVpTYy8wZGNEWE5Xcm0yTDR4?=
 =?utf-8?B?UEZLUSt0aEE2eVpwcnZMMDd2cTNJdVNsMUlTKzZVMTdhbCttVzQ1VU01c1d5?=
 =?utf-8?B?SG13WEl0Z2F5L1FPYjREZ2JXUHN0NlNiSHQrNlgySU81bzBFNkVTZHFYZy9u?=
 =?utf-8?B?b2Z6T29BaHlLamVYbDhlNTNMWS9Ka1VwWklscmR2NnJwVDdzN1NURzNSd1l4?=
 =?utf-8?B?SGl2QWVDK1kxUnYwZ2EyMTZFM29vMTFDbXlLOVU3cVdaMFNUcXZxbVVmNjc2?=
 =?utf-8?B?ZWJMTGRkK1FIN0xxNEZtbXVBN1lBNzBwQm5EQzJuSDJiZzJKdzd5cGFtdi9j?=
 =?utf-8?B?alZwV1BaME5YU1lxZzN3L0hLYlg3ZEluL0pobm5MamlWQWFnd0lHRWt4Q3lk?=
 =?utf-8?B?MTdWTkNmd3U1eU01a2RvU0pxTXB4S1lBSXRBZW5zd1pjWk9uL0NLN2hRTzVH?=
 =?utf-8?B?UzZDQ1VLOFY0dTVKSDJYb3VkZXJFdjFhc21pN1NmRm9PcGJKb2xuSjFjVnNL?=
 =?utf-8?B?RFNpNlk4bzdSWk5hbGZBcks5cGpWeWxUM3NjQ2tsWktXNU8zYTFDV1BZRTI1?=
 =?utf-8?B?bTIySkplUUVrYzQ5TFpRK0ppVlpOWFJzNHJYWmM3UVA2VEJIRDJFUmlyQ2VF?=
 =?utf-8?B?K3I3RHBNeVlDbFN6K0hHbHdMSW1VVWo0SzB1dE0vcEVWbGtrVGxObFZhWkw5?=
 =?utf-8?B?dXBOTmhSdm1jSmZiZEFxYnAwU2oxWnpGY0NROXNUR2xqa05iaWM4TjNXcElK?=
 =?utf-8?B?UGV6Mjl2U3drdEFid013WloyREp0NmFrM0ZhekRNUWN6MkZNWWJDYWRLSFVk?=
 =?utf-8?B?ekZLR3dId1hpV2VmSCtNS3Z1RVptWGU4eUxDNlhKb29aZ2FjUDMxVnNnWCtl?=
 =?utf-8?B?akdPTDN5QXlycURnWXlpTkNhRTN5aUVvYTYwV2s3dS9LWWcxQkttbm5jR2NF?=
 =?utf-8?B?WUk4ZytZR0UrTTU4VDVpN0YxbGYwUzJrcXQ5UWg1QVlUYmhPWi9LekZHblJM?=
 =?utf-8?B?S3d1ZUxBMStJVnhGMjZ0OGVYWkJGOTRDN29Xb3hZYllvcnJYektpaXpNcmF0?=
 =?utf-8?B?RG8yWHh3SUYyQ2oxV0JnbFZZYXk5Q1RWeUN5WlVtWFFCaXRwRms2VXlkSEdv?=
 =?utf-8?B?NzJWZmYrN0ZINzJZMXZNRnhOYTFRdktJek5JamJDMWdwcjNqTURmREgxKzVN?=
 =?utf-8?B?Qmg1KzVEcnFIMURneitxQnAyVm5jZ2VpTHZrV1FVRGV6ZEZhNVAxODgwT3Vk?=
 =?utf-8?B?dkxKOHowdTUxUDRRS0swNnRiUEJRZWhRdEl6aXcrUVRZMm13aTFYME9XbXJZ?=
 =?utf-8?B?dzdvTDZKZWVOTDFKV3dMd3BEZlBnYndod0Z4SzBxZFoydmZBT3VPa1lnb1ZC?=
 =?utf-8?B?ZktDNnlodDlNMWhBUzk3b2h3ZVBndVZyNWJIMHIxeVg3UVdqYVV0TjlvZVla?=
 =?utf-8?B?RitldjJ2allpS0plOFJvQ0lqcDVnSFlLem1TZz09?=
X-Microsoft-Antispam-Message-Info: jO6+lT7SUlBFarrm42IYYyANbhM4YrDEDbir72+j1lUNEWBseY6yOOx54CfcMvmV0RJ1dFSQAj7iFJt72+Eqj3vWrJK2yJR/teJBk721je41osl9Jq8MSCieybKKqt5fF0GYx5z0IcxLBpzqNG3vdau/KkrV4fKTNQwx2i15neIXobkOS5uw+Ar4EiRqQ75Z
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2464;6:0ETca0bzYOiVRoVGNIUBlEvn0C6kqSA+ycNLHIV60OMKxATsdkLbypFb0zeSrpgpJJPyqsCcan507OupQbb2TYwtUuiva78dwhnczS/Nzft13SeESMv1mnVBkoinqKGINKawtsuwlJta8W6td8qNosXiFVUNirigbxQWV5VMu3U8drf0vaF+uzbL/egHpRw5ElmHJeU+terKYvZITQn6tMZ2volHKvxdIPgbXBUl3N/wfFHmIthrqq05mDlKpAyw47RkBfxs2atcyMcv5JQzN6urdOsIQqGfbquw9+Qjp9TQQESEoDLx1v/FumZJCEwHoAdGjtSyP1ey6+pBH/RqW0WdBJHw3NSp1OnFDG4rQjbTl59ZM08/xa8aJC5+5S7ulG5J8GNy7/inYj3znY0jeE9MrJN16zQiBy6eoc6k/P/BceXEruUFxXTwzwYAMOi8KjqzDDfvhvhMRCSPY4AOfg==;5:+LcbXXpzS10depWN0Bp/5xVat+s50xxpyxYPm1gyNfZxtrnMHtclGqUUhAXtCOqEuHWzeUiG+3YwQ4F96jcJZ0w8Uj8nTxxVP1/JbBFM/Gq3lM2VLdt+tNzCnB+Xwy+RxwSYoG3pTy6c9iXYueVJeIn0gh/zFFUgC9VBQyCUJZY=;24:yrNwM9YgUIwH310epE++lV6+w64vnx/WpjERq0vVf2HLhNzVXDm+jWhSX0BeEa8jw/ffCmiK0JpT0tYN4lWlJpBUAk8DHQUFq+sBF4qBd7U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2464;7:drfIjWOk/i17Jjb0SVA8pOfEcy7RCs93A41WvVsZpX3ada6a2K622fqoKVqI479LFR+y4rrev/dbDx28it54H6GvF996PLr0pxIaeavq+ALKP0Er+bjDegcu3HqUtBh1IyDzCxyMo57iVQCaDZAkpBA3owQdj3xBRtwknZfhrbgXuP0zPU66tcBgLda2ArGFSBG7GnUPpet7i1T2iP183S6ZrlkQ3hTci2NWbWZFgILdapaIDDca3pUeupdcCJA+;20:uMsJlHu+AgL6J6J+EpdMer0Xn2iSJFtrWGGcYBx4Y0iOjaXHSwz5fL7sR8rG20yeAJ0NiJLA3HkZMtrGBKg7R/T7pXEePfWAnBulHsZN32DvUZ2AP9KDdPvQDafPWhHlZL0IXL2LCGxBWUR9AkoWdfWlgApdlFY4YPdRCYjEK7jGGZDAnXPOAKCEqB9C6+IBjjKYjoWdxWhtINrt53kx7roHf54U57fuGfvml9xxYYGkzJdb50Ge3krWSpqVt3ih
X-MS-Office365-Filtering-Correlation-Id: 13966d04-3a49-425a-e923-08d5c633511e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 13:43:24.6436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13966d04-3a49-425a-e923-08d5c633511e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2464
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/29/2018 01:46 PM, Paolo Bonzini wrote:
> On 25/05/2018 22:23, Janakarajan Natarajan wrote:
>> This patchset adds two new SEV commands, introduced in SEV API v0.15
>> and v0.16 respectively.
>>
>> * DOWNLOAD_FIRMWARE allows the SEV firmware to be updated if a blob newer
>>    than or similar to the exisiting build is available.
>>
>> * GET_ID allows to query for a unique ID that can be used to retrieve the
>>    Chip Endorsment Key (CEK) public key signed by the AMD SEV Signing Key
>>    (ASK).
>>
>> v1->v2:
>> * Added cover letter.
>> * Misc changes based on Boris' feedback.
>>
>> Janakarajan Natarajan (2):
>>    crypto: ccp: Add DOWNLOAD_FIRMWARE SEV command
>>    crypto: ccp: Add GET_ID SEV command
>>
>>   drivers/crypto/ccp/psp-dev.c | 143 ++++++++++++++++++++++++++++++++++++++++---
>>   drivers/crypto/ccp/psp-dev.h |   4 ++
>>   include/linux/psp-sev.h      |  23 +++++++
>>   include/uapi/linux/psp-sev.h |  12 ++++
>>   4 files changed, 172 insertions(+), 10 deletions(-)
>>
> 
> This is not going through the KVM tree, is it?


This series will go through linux-crypto.

Thanks
Brijesh

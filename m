Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbeECSJ0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 14:09:26 -0400
Received: from mail-bn3nam01on0073.outbound.protection.outlook.com ([104.47.33.73]:50976
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751019AbeECSJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 14:09:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH 1/2] iommu/amd - Update the PASID information printed to
 the system log
To: Joerg Roedel <joro@8bytes.org>, Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <152520429853.30928.9793486018349326103.stgit@taos>
 <152520437211.30928.8410126837908568791.stgit@taos>
 <20180503135706.nypxlwlt7jhqhhum@8bytes.org>
From: Gary R Hook <ghook@amd.com>
Message-ID: <526f3331-610f-9556-1d6d-f595d689b6de@amd.com>
Date: Thu, 3 May 2018 13:09:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503135706.nypxlwlt7jhqhhum@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [47.220.174.129]
X-ClientProxiedBy: BN6PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:405:6f::18) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1453;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1453;3:onXhIhHXqcLFVT3PuJE7VbL5c7AEirf0ol46imef6ENYQ83Z2/YU/IXBlwurrFjAC+sHwhCclql56mFP+mENI6Z9jpFEiPFFCI7bRbLgUEo/SDWz4DdyLt1n6NHOMglZsK4wzz5dHSXkZ7+EQdLVBGeI0+sY+pfMRySaZuxY6JGwxiFC5HoAUbDdBS3ZCNppfcYwCz1BWAuAB++BLbACM0Jcw1BMHdaZecbg96b6mNmxnzo+JZ4prjzbTkq/OHed;25:+XvB2FbDFOA8lnepVeoVoX2UoI8Y8JIT0qcI6KvhbdrkjWVig6EFSzWOC4y1B6IRWZNgF4ImEep6FLkOvloTAuoHboRYhAPqEmC14MrH7DsxeUshBFUVhvVhThrc1v5qWf9/UdwFydWUJs8Z+BRHDYk7uDdjDgya09e56JmasImPC8NINqnAxIoGavPT+vDmpvVelP21jxWNB1Dd3nitQOIO+lzGhjU2SBvFTMuZySU+jz5WCf5lGnBlIhkWHI/95ekMr5PgmBkYltdTtL64oAFgtT5zV7Od9ZyTQSxVyZjTYpGDs5EoxV0h+dH8dFlckAxTxhx7Bc9i84dDOtJcIw==;31:ttxf7bgFYHKN15Ij+EyBsJ8RrTsMvjXUji9cahrAivkTm3R0MaWeHjqJug/kz1hziZi/e8Vpbi77JNWfM/KZP1Mo5svfUL9v7P0RW8mawq5dyWj837tPdHvEqqnrekqcem/gpuZs8q7Af1dxVsTy+6UQfCJgaAWIdR04yFIPTRdGDKE4ZUhtwqVdMJAtCd/pUKKLyCWI+lbmETuvMGI07Xy8WXikjKAxt7lkbJYnXRY=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1453:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1453;20:Iz368rsz0cI6pjH7xehmxsr2mkrt34aAUh6OF8TfLO05sD+7RCBV1hLJR3Ru0zPS9gh+f1j/xtTKkaGRE95/dKqNmpZO36IgFy8gG11jApM0BTJGfQI+93s1CiffC2oe7Q4bY17h7fg/eLlsN9b9RtR+c+xzFY6oHMrViTo3L3A4Y2WLt0qHe00oRjCcIr/aIMi8fNrQj1hhbM3RplGBmqgWjKsRUQEXUCVHTzmprr3lSx+UJun+IOxOpu8TxNbmEvgOmp77igII4RGshy1f+FrMsqeHMfEecXX4LlisiWMV4s4ri+ZY66rK/vxtRaiRmqX4YL+VbRpCL20PIObwD5lN3lKpNwJiuurl+KGF3BvfLip/vR2yJkhJ0su6dYms3ZurzB41PdDw9A1xMcf+L5kdnMiWRSJR7H+fumjg88mXjtQXn4t1TqWGfVJSntszyWIjKPHrtWQPQyLoz+m3Plzsix1uqEocIpqmufNp5Tp6usMbYo7lzp62ihWRrAvy;4:bhrNCijm2mROb2PzWVKpQ6QNeAcRbdSF5IFaR7nSLqGhESommlwlD73fWSi1BBfzE2snzwTMOBBEzGhnw24zo8seNtPyeJ5e6G3YJyBNwkH9HV/cPJzQym1324FtsjtNzp6hrNwP1ax9NyNgSrFflFTxDZb1vdChnDW62LRgE5lGp2htEDSLMhpaNcEzy2+ryCD4A5xuBYe6SgM7m9dl1IvKKArjL9oRPGphwhd5xjpKQ5muiOgj7BEhwfxHFIWZIItXJjzvZw+RWtgr9E1JbQ==
X-Microsoft-Antispam-PRVS: <MWHPR12MB14535A17204FAF7F0B05DE24FD870@MWHPR12MB1453.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1453;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1453;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3846002)(97736004)(956004)(23676004)(28096004)(65956001)(305945005)(66066001)(52146003)(52116002)(65806001)(15650500001)(2486003)(446003)(11346002)(478600001)(4326008)(67846002)(2906002)(486006)(6246003)(7736002)(230700001)(72206003)(6116002)(2616005)(47776003)(53936002)(476003)(64126003)(6636002)(6666003)(8676002)(81166006)(81156014)(186003)(58126008)(105586002)(8936002)(16526019)(26005)(106356001)(110136005)(386003)(36756003)(31686004)(53546011)(5660300001)(65826007)(229853002)(16576012)(25786009)(316002)(6486002)(76176011)(31696002)(68736007)(49976009)(50466002)(78286006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1453;H:[4.3.2.107];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNDUzOzIzOjJZUXZ5STY0Z2lodXNVUXN2cUVrcVZseENV?=
 =?utf-8?B?VXBUU2h2U3UrcHp1YUNaemhIVWI2Rmx2KzlKNTNaUGt0OUplRUtMN0F3YU5H?=
 =?utf-8?B?WlZ1NDNZSkluV2t2M3hkRzZCMUNPRy80NWR3UXIvNlZ6azZYSWdXUzM0d1ht?=
 =?utf-8?B?QlhrQTJWWWgzY09ucEt1OEoyQ094OUZsZ29pMXJ5c1hOdVJVclhmNFNoK1g2?=
 =?utf-8?B?MGR6UitPQmtZb1ZvaGc4QmxzZDMzK0REc3A1Zm1NeTloY08yTEhEWDlNaXl1?=
 =?utf-8?B?YlhkRmExbFJlWTJVSG91WjllWlFydXkxWFA1WllxTWRQcUhZYlFTaGJVcVZq?=
 =?utf-8?B?WXU4dFZrM0FTdEJ3T2pLR0s5dkVIMzlBODNkSHdGbTdmdVhDMkRUZ0c3cEQv?=
 =?utf-8?B?Y2Q1cVQvS3NtOG1HUm1VaUtMMElzb3RQQnB0MVRJb3Vuc0t0WjdXMVRvWU9k?=
 =?utf-8?B?Qlh5aFUxWDhDQk1mR1hhK3dQWHR6N29tTXgyVHZFT3Yzd3E0N3RUbE9RNmJG?=
 =?utf-8?B?RldBaS95VVlTZmtCOXFEazlUemNMMWdmcFNDa2thMU5jU3hiaWw3akFNdk90?=
 =?utf-8?B?RDNhT2N5M3pIWEZQYTMxeXB6ZEpkRXRuaWZIWkQvV1FYMG5Xa255NVA0amZV?=
 =?utf-8?B?ZVUxNnZOblpUbUYwbjVRRUhHc2RaeVJGQWsrLzQxUWlWUk12N29BeHA5YlBG?=
 =?utf-8?B?citOaGtyc2RMWkJsaHVmQU9MdVBNYUh0WmdzYjBQaHoraHdFbnNjSTF0M1Bk?=
 =?utf-8?B?dm9BU29iaHJhRWRIcjBQb1pJYXluOHFzTmtLUlRIdkx3a28wTSsrdnRCTUdo?=
 =?utf-8?B?Q0xEYytZNEI1aDduQjRTOVRoS0dJdjJJYUk2TWR2TDRtQlFvbzcxd2ZwVDZH?=
 =?utf-8?B?dDRYUUp2U0E5dDlPZ3Q5QXVzaEdqMnJGL2J3V3B1NVNzQnA5dXNpTDZNZkxt?=
 =?utf-8?B?Rll5dWtaUGRGSE9IL2VwblU2YnZZa1grSlFQYngxTE5VcUdHTDhvNUIydGV0?=
 =?utf-8?B?SDVJdGhPeDBRcU9Bc25QK0hEdVErMnhBbG9xTzBzaURVT2RCUU9kSGxNcGVD?=
 =?utf-8?B?TGZBOU1PMXlReWNCWGY1cFlYMmlLdXpaV01WTk5ueDlUTktjUDhkR1c3S2Yy?=
 =?utf-8?B?aWRmc2NTKzA0dURPdTNha1hXdXRKTFVGQUdEa0dOQzdtWHZseXdGZkpPOE0y?=
 =?utf-8?B?MGZzOEZaMFFwSW1lZDF4SVFIWE1jdWQ2MDRPV0g4N1RPeHp1aklJT0Q0OVhD?=
 =?utf-8?B?U1d2dTJVS0w2b3lqaTduWG43SzFGeEd5R1d4WUkrM2FSNkdHcGZ1dXpMSlBO?=
 =?utf-8?B?SVZqOUw4T0UyMW04SDlhN0FZRFAzNTFGaU5ZZVBrY0pvK1FRKzVjR0c0WmtR?=
 =?utf-8?B?RG05blN0c1BxN2pJQzhqS3lvQnYvbk5hY0diU01ST3Mzb3JOREkwZWFBd3h1?=
 =?utf-8?B?eFJnQmxic2oxYlF5MWJ3REl3b21Edk1jOWdZUnpNWElMVTlQaGl5TDlPOEZt?=
 =?utf-8?B?WGxGaVg5TzBMVUxTaEZGa0F6M3dxRU9DaVB4TUJrSUNNSXBhVTNKemRoMXFI?=
 =?utf-8?B?cmNPSkFTdW5SMGdHRVVYSnFkcmFRZDE3VW9ub1hlRmhwb3FoOTVkMEtWSjVz?=
 =?utf-8?B?ZTFOWnUvWExmREl5UFQyekhGVldReGhNajNhYkJhd1NvcktqQlRmYWJvcU4w?=
 =?utf-8?B?QmZKVDBWMHRPejMvWVh0VFNpZ3JwVXF5Ni9veHlyOVlwR3RtK3N6SlB4THJx?=
 =?utf-8?B?QUV4ejBLWTcxYWhFck4vQWxCSWdkQ0VDdlJKYkl2UkZ0SmFBSDZQcWllUFV3?=
 =?utf-8?B?VmtWL1FTKzF3RXM4OHZwRVpCa0dmbUJmNERlNkc4Y1NCZk4xY25MSjFKblpE?=
 =?utf-8?B?OWlKYi8rNzUrV0xLdkhZc3pTNXFKeXZ3VW50SjE5U2s4SmZSbEFTVmhLSFJ5?=
 =?utf-8?B?SzJJOXpCK0dzMzA4Z0NyUnlmWmhhQnYvbm5kNS80a3d6dWRFSzVwZUFyV2Fn?=
 =?utf-8?B?bW5IdEVCSXRJYy83SHRONkdCekEyVEFwWmFSN1lMbWpzLzQ3b1lLQ3czaHNW?=
 =?utf-8?Q?48ZzhD3+L3AzrR3ikEqO0yJ9P?=
X-Microsoft-Antispam-Message-Info: ABDWYgqxT/NOyt0IIp8sNpvVxE+z+trc5gEWucQH8cEudwz74NqbUkS7pKespeZFRXxHFB6KqooO4VSvNum42P2Axh0MAXdJ6B2xYJy7h0lOXjYMMjIWKM17cTaAxLroSZwt/MX+rMLxf5JI3ik7TrhyIf83bNrb9oNilTO06csqAEIhn7KFr8fUFVte3W44
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1453;6:urT8omGgll7WVPJv9An3mjwUlhleAQ2XtpCIGa7xdxePFdWcimOdRaMBRK4ZqhAk8SECDwRom9rlHTH03O9Fcz8qpW/iwzdMnwzB5sazctj/6EjUNV29FGiWamJO2Alt9cTozAQnE3hlIvjQRhCHUCvDdyYtbd7wbffUtzXmfclRdDVvm2K6+CDsc6cwIxM2/mu/bcHdlzUeQIO/plZK548o75rXz3rYz4b28+gC2u4X1w32RpnpZUZ8cko6ARyt9ymkbglFdqaBNyA5xO2zkLv6hvPox03XVbpzmZoXJ8MYmlYeQMt+vZXTk+QERY0+Wm6dPNJKOfq08fPo+rzi2offsfLzZrCMfV8M9qmBUqbx7lDclLqnr1a4DBiRFr3/xKvW1hBkhr1kQ/KdiOnqR01OuaO3r+3nfFEErwd7m7RSRayPbbrYcfvs1K6d4Lf1uIq9yIH0sxKcqcg2oyW3MA==;5:o08HIWoppiwCj8hqZO8JDhVq9AlcbXTQ50nyj8vO9meZnstC3Yporz8PTbUnKeOQVTB9G6TLekjVAsHHnrtLg7nONeG7tawBfZlzPL9oeHjoKuJ6lHWi/wVtrb9tgqcnsmK6xuFRbvQKFs6rlEjxgv5TEnRHJRYloeV39VjLnno=;24:qtHmrQFuR9Ccfu1e31Zj4cvViGxkN/WBTNHv5unobc+SXT289wQUJMhHkX7FzQQEC7s+8h0JTVBFup2OCPrKS9G3UX46Vjqr/Dpsy6FsD2s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1453;7:z8evmVcgNhn7Lg7xifd5+51bFoqkSYkcS20mxQDJTNngsi9QETeTK3nQbYrzMw0btM4yOwrVhDmN6wR1fKI/nOty7q4CFcg4mOUklYPIQ18+mHYqpOX3wi0v2adAxyDrtyRlNjfYIIb5XVMFCaKxqa6UohAxYHcjjCccFmzLZcwg/fcgz3kHlCFRnQmG7tqSb/7eDiijfv5JbIEjODCoK7RRkn4JU5JR1LWVLimrCLV7OAfgx2VgE+mneoMmub1K;20:nRW1rdVy77zQJTIfn3nO51DtfQWzoFvwt8mzVpfXLfAwZkroRPMHDbOg6/axdUw4z4X2sMYvdY+2VlTtzXi7pR/bsORuQ4G5397k62uTSelz0QQ+JsOOuA2Ly2rJWJYzpTXPoqxiN8dJlhruY2Kx+d6G9bpLpLjJbrehwxEvYhcLGT8wxJq/1EPwvVNaArBg5VWgDHgw9aNuQ6PsWh5OQCHLZDfgL2VDFl8YNljAG90TdS9TSuQdP5T0jmhHZX5L
X-MS-Office365-Filtering-Correlation-Id: 5af4db66-52db-4a2e-6c89-08d5b120ffb4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2018 18:09:22.2221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af4db66-52db-4a2e-6c89-08d5b120ffb4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1453
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2018 08:57 AM, Joerg Roedel wrote:
> On Tue, May 01, 2018 at 02:52:52PM -0500, Gary R Hook wrote:
>> @@ -567,7 +567,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>>   	}
>>   
>>   	if (type == EVENT_TYPE_IO_FAULT) {
>> -		amd_iommu_report_page_fault(devid, domid, address, flags);
>> +		amd_iommu_report_page_fault(devid, pasid, address, flags);
> 
> According to the spec this could be a domid or a pasid, it would be good
> to make that visible in the error message, depending on the value of the
> GN flag in the event entry.
> 
> But that can be done in a separate patch, I applied these two, thanks.


Yes, I didn't quite get this right. Both values should be passed along. 
Or perhaps the entire event could be passed in and decoded by 
amd_iommu_report_page_fault()?

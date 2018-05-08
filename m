Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeEHEEV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 00:04:21 -0400
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:43328
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751289AbeEHEET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 00:04:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
Subject: Re: [PATCH v4 1/2] clk: x86: Add ST oscout platform clock
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <1525688013-9928-1-git-send-email-akshu.agrawal@amd.com>
 <1525688013-9928-2-git-send-email-akshu.agrawal@amd.com>
 <BN6PR12MB1809A66A78024F2E519A1A34F79B0@BN6PR12MB1809.namprd12.prod.outlook.com>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <82d294fc-d108-a32a-1ada-2763f40dac01@amd.com>
Date: Tue, 8 May 2018 09:33:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <BN6PR12MB1809A66A78024F2E519A1A34F79B0@BN6PR12MB1809.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: BMXPR01CA0032.INDPRD01.PROD.OUTLOOK.COM (10.174.214.18) To
 DM5PR12MB2359.namprd12.prod.outlook.com (52.132.141.12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2359;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;3:evKQb8HSM0bKstz95hTCItxwpfqFZXLAl4KVsKARolexIcdyuaLqnjHh3LIn1iuDhoztw3uMaiIpp4mi8sEVo8xQiUF+/bO0HYmFjZmdyzPf+nIXnD2a132+m/8LN3DXUGJcAQ4SMi1jdsY/UNJCs3LBn6UVO6+YCn0zWOARNw4R0qf24naMv1Z16r8wvjGZ0WbqkB7K5grHSACDYIWw4hz5TGUtrc/ga55DyPLjSvW8ErD//uMRVZQx/7AjB5rm;25:oikguBij2jHt+o9baq+qNZqV4qnHcF7cpwhXAQTVuOJt6ptY1Yyu8J3Ttv5b/e1o1phWjE7hYFW2rc8qfakiK5mZhn55K93FpthAHhu6DwUIXMFt1A/6RJdmXqmqY9dKVz9yaFJHhfkGFM+fkkxmcG3Z+9WpExap/gTCwePGUwwOkIDfOPOTfI63zVsU7aEgNRADZczGSivESq17fPmsnkK5M+wXFcsylGkZkzSppmnInsKaI8dUQTytmivXOQ8tRCiCsG1i4Ci2dZRyNRiK2XehSFpmX28tlRuzbJU13kt0FFb0Wgj2v4qu4lttd8OTPllwnG6djGwIJvVKkgbo4w==;31:C5Vg5Z5HBomQpWUHvx0G4Ckg8twtDwahEQ0UFzW0ew989EjtxVAuOF7i/IIC4KYajFziLYkd4jFr28J2+MIJ/VhCQcV6HvPY9hi6IrKzeR3dc+zyol2ozmFCQxPuS8cfCI8cXtfaIKV5SON0sXDWHHIEwY0QWV1XbyKqXJRaIdYuOYa6ubrOGjKTH2GoXYDSrpwMek3T9sq5wOE4rv8xYSBhB51X/ste1b6d3ZXKMgg=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;20:WysE10XO+YgL5FPpXPvvod/S+3EaLJgCKDdvI14pFTIT9TllrpsFRFIOLKUru0JqOVNzDTs7mcgnaKj5361N5Kl2a+gKEsrE6wV+Z2PmiOoJcGBk647tdF6ovUzlyxdV4WSAmEJ8hpv3jlfAOilbWEaFfy+hL5XRafnxKAqtknolwZ/9eazLJShjAFkSiX0DcYmXZXNcyEYd7CwReGfNzP0c3HZ7AH36F9bOw1zDVmPzUt2UPHT9Bl+ZVXk11IL/jJRZgfxRf4N9zHTSJ3oESynBxcx8pRxqAFa2uu8NNEQhYkz0TWQZ225Gkn5ns0MSiwNoNjsSrzbPctjDPWBvg3n4CbA58McsZhedtWaqpa5o3JPNiOmyracjFsZb0ZoxNVSnV+yuNcUQGnwQQa1MbEfR9+D+hT+q1dRE8+4khfddApAboOtGZjGqNH3b3vgupCdWQBx2eYzzMKV5UqJSVtfeNGEosJu0F/xulkXvqCPrgqTFP5uwN7kzfPEvWBY4;4:sdOV1frR7DEqM8+nFayZGYwJIK/s0IDOoBuAUDYMa4C7NdTW1FHbC0RgoNX7EsyJsMG7X2Kx1ntMOEZR1puGerXSoSW4AWaZJfe2OkF/wsxeM3lo5Hny6gU4hz9JZw0Whdk/DyylUOWjtb6tY0uUjGgSu98bUNQPUbxZoSCAwQV1jY48u4Ltm2npJNXrKx6pqS/L359SCnzfYE2A3cgVrB1G8k1QZqwTBD8Ju5g94yEY6pGYZJBYBLVjRGaYBW6H/kSVy/yiGEX4MpGD8ez7tecyYuGEBhthIPOa/0Ky/PNVmvmcX7iYvFOtT87+polgQdRnztIbKFCvROnPwSljPC3TRspPi0NSU5/As6T2tulJE08F+IuakfIOo2wrIVa5
X-Microsoft-Antispam-PRVS: <DM5PR12MB2359DB1115D7ADD139D549D7F89A0@DM5PR12MB2359.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB2359;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2359;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(396003)(39380400002)(39860400002)(346002)(366004)(13464003)(189003)(199004)(23676004)(31686004)(229853002)(446003)(305945005)(52146003)(16576012)(72206003)(3260700006)(7736002)(478600001)(2486003)(11346002)(6636002)(53936002)(52116002)(25786009)(6666003)(6246003)(386003)(105586002)(81156014)(8936002)(2616005)(76176011)(8676002)(59450400001)(81166006)(956004)(476003)(106356001)(97736004)(54906003)(4326008)(90366009)(6486002)(316002)(37006003)(36756003)(6862004)(58126008)(86362001)(66066001)(230700001)(3846002)(53546011)(65956001)(6116002)(65826007)(5660300001)(65806001)(47776003)(186003)(2906002)(64126003)(16526019)(31696002)(77096007)(50466002)(68736007)(26005)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2359;H:[10.224.118.13];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIyMzU5OzIzOi9ZbURyL2JUU2s5L3Y2Y0dTTUNiTG9ndEFj?=
 =?utf-8?B?QXVhSFZMUzFvcFFzNzNDSmRkSkNsWGFnV3JNcUZJK09PczVGZHcvdWczSjMx?=
 =?utf-8?B?bU1IQkhLclpvdnNieWJRSUFhbHlDU1dSRFRXVVBKR3lvTUF5Sms3MWhCT2dt?=
 =?utf-8?B?cThBWFV5Yi84S25senJoemFqbjNBbGt5QXN4TTMwclk5REt2RzZOM0htMHJ4?=
 =?utf-8?B?Qk0yTllYczk1VVU4b3dSVGZ6RXBsWDk3VTNzc0NXcnZRUkkrazd1VmZKMG1m?=
 =?utf-8?B?MTM1L3c5eFQ2YjdmN3pUanBCNlhjNm8zRmRhb1l3dGFNczRZcVdyUlJkT1Bz?=
 =?utf-8?B?bFdpMCtzM21VUTlwOXFidStzOGJ6TzZLWXI1eDE5eHZkUjE2VVNiaVJ3SXNr?=
 =?utf-8?B?bDZTZWI5RXhnQnhxMWhnRGpkdHY2bjZwYlpyazByZ3lndW95NG9xQ2JOMVk2?=
 =?utf-8?B?YmRoT1d1dFVGTjE2MFQzTDdzbDAvemFra2ExZDYyV0J6VktJRllNcmQ0UjlS?=
 =?utf-8?B?Qk14d1l1R3VRZDNja3JJalY2b0ZYVnh6a1EzcVRhSk1sZkFSQW1COExhSUVV?=
 =?utf-8?B?N0dPaVRFbVZMNHQ5N2drdXZicVFEZGJSd25QVUc2bmpGNVVnNDU0TUlxUmM0?=
 =?utf-8?B?VW4zWVdkdTYvaUQrSVlaaGI1YlIwNkM4K2pkSGFxVU05MzBHa0prd2tXQ2tp?=
 =?utf-8?B?RmV0NDBlMDc1M3Jab2sza0pTc2tOblNEVmdwVkd2TUxkb1hveS9ERFc4UGdo?=
 =?utf-8?B?NmYzeDZrNm9zWno4dWFiQzgyN0hJQWY4ZjNFMnJ2S0w1STRKNFhEL05ETi9m?=
 =?utf-8?B?WTBDb2gyYmtnWG52L3lDUDRmak1LdzJxZUx0ZmZEMSt4bVMyYWJVNkkvZ1li?=
 =?utf-8?B?RjBqNW9NcWpwdGVMbXg0NjhpbEVWUnlJNFFoMEo3TUVyRlkrQlp1ajdDRkt5?=
 =?utf-8?B?K0lDZDBpVkxpZFFiaC9LRDBTYXNrenBrS3I1ZDFuak9OenIrOXE5OXdPUitQ?=
 =?utf-8?B?b01kc1M5UHpTMVAxRXFrdFdHRnBPcGp1ZWZVOGtyS3RnRkgzQ1hneWFhU0hL?=
 =?utf-8?B?bEh5eFA2WGtCTW9nV1MyQ0xnekxLU25pQ3I5dWNJanpBWWxHV0ZMOGd5aGZO?=
 =?utf-8?B?VFBIVlEwL29QUjJZZFphRFpmcHVGNUJTMW82ZmNXZk11SnZPajJuUi9nQVRI?=
 =?utf-8?B?TG1OYWZpZm03OWtRRVlSMDBtZnh2emtFV2ZDUzN6aHZsRVhzNUlNazhzM0w5?=
 =?utf-8?B?cGdNTkd4YiswVVU4SFNrUVlWVytCSEJmd1BHTzZNUkE5YnJYWnVkbnI4SVZV?=
 =?utf-8?B?T3RPQlFlcSsyTFc3Ty85dnFlU3B6Z3dDQUFXdlZaOXpBZTFnTnRJN2ppbzhL?=
 =?utf-8?B?RTN5SzNndUpHOElmbnZySmpDWU9vTDVrNnZrM3VsMHB0ZWFxbG02SkFybTJt?=
 =?utf-8?B?ZTdHSXJacFRwVlJHUDUwR0xabUFnbmp6Ym12UVBqT1lZMWk5NzFrMURPVWxa?=
 =?utf-8?B?eDBUdWk4K2IxNXNoczF3d21UaFAyVXhBQWR5aUo2U2dzb3dpcnZmZ1B1THVx?=
 =?utf-8?B?Z3V4UnE2TEZWY0t0RlJsWGoxQ2ZJazVrVmlqbWJySHMxVGF3S1hUTTUyS001?=
 =?utf-8?B?YVdUelpYTmZGQTY5MTc5bkVEUWhBYmNpbUExSGpCci9FQ2JGaUdmcWJCb3pV?=
 =?utf-8?B?SUlBc0dFWXZ0Z3pyR0UzRGhiUlZ6N1J5NWFzYURaYnllRU5IRTFHUHNENzFC?=
 =?utf-8?B?VWV1NjRGd0pKMDNDOEdaUys2TlVWSkJwVzI5MXBQYTVXVHdaVVdCbUpXZ1BW?=
 =?utf-8?B?NFFMdXJpY24rZVczajdSR3VBRStQcXl0Q1g4UGVhVmRxMHJzcjk1RGF0T2Z2?=
 =?utf-8?B?YnpiNWl3Y2J1bWJabTY4Y1BjekQrZjhYMTRBTk5KZ3JxWWVWc2YyNGt1U3Ni?=
 =?utf-8?B?Rkdsai9aOVNiRS9qZng1L2R4MFJUeU9jd205R3BxaEIwRnNuZll0ME5LTU1o?=
 =?utf-8?B?RjcyeUxSTlVFejFKU25PL1ZrTElCM3VhQ0dWUnBLSjlKZUsyMDBzelpnNWVP?=
 =?utf-8?B?LzB0UDBRdjlQY2lCejJTVFNQS2xQWTI0VDlDZ3N5d0hOVFpTd0psL0pMclh2?=
 =?utf-8?Q?rD3R04pxezN9W3thUPdlvQROP24NmGeFm9YRFBtawDLh?=
X-Microsoft-Antispam-Message-Info: Rk9rEv8oah+jQpB7adI5PEuCdmkSsOqYaQKSjmlABTSPi5jx0gPi2kQwaQB32eSZ77zMjpDGdvtBmjlwUTsKlqc4jaxLTQDxKd1I9S6hMZfGf9boaIiZlnXjTXxRtE2AMCk9Vw6GE5CV2AZJs/dKCzYL3+oXEzmnobjyqGECVgWkEt1JrjRhSJySffj/YVJe
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;6:fRSzyS6zeb54DRwCk/RPyS75GVbbaZNVZGbOwFif6jGO1NrS/e2knabNfmj+5pwh7oNs58/YusFJbpleSbdtg7ax97w/5aTU8cNnp6vd0+7u9E8DTfoe+S8iTGjjHvYQxSlieXCMR+mrfImXJgyA40zyDg7BaCB2oyG5Gonb7qRBvMk7fXeMUDwkt2DLws4o+Z6s3U0TNOpIL1Z7vERUrpQVoh80BH3VstbakTh8liDEgINCuQ07hvyj3zH/HnLTEPPbdJMJIFLKdgWSDjluS7KJ/ZMr9E7q1nbd4bL6T+ar+g1+HMBiZMR0kFQTmm/JySB7pfjNTzLR6a7NZh0IiLtR3wZPUVf3FAy7Z9/W8cT3nEIfFD2SyIXqGXZtKCfdBSzW8eqR4w4USi0cCPETABCndYQILT2atLhO7LCLwqJyR/bwr8L30OJESHaS0f8O9OuReQvPm6Sej0crmff14g==;5:OICldvOsiSNk5K/TJqpQEcNXLItowNMNIrZKkN1sf85SY8E1mjOZjj0FhHfVb+CPDC+8/LpRhms2wpgzRFim/kJPzZkg1SKSKvetQ3ojeZKAU0PbjsvZCbvIPEbqLVy1F9WX/i88EHzeh4E0q6QUxcYvq5Za3Epdgp9PhRGD79w=;24:PF4pLFBiRa5FUALA4CKa2Hh/L7u501zlQLcd08B2vlz2b0HTAbVPFx2ceXrftC6cMxs1TPgdr8X5aIwrpk7mAyK+BMUETIKXO79+2bCmrF8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;7:/g7o9oGKsVX+FYdOfCazTZDVxgLBU6TqalI2xQ/aXPWwxQgulwqe/7eWaIT1MTLlkHHkWYNREtxyTEtTRKCvcrsaFWWaSsCiAkGi+6YdD9QtzHTvfNzpxZxGSIgkRH27iT6fFSZ8e9VLB5+SFR/veo+UZ/aPBwGq09xPQ6tGX+H/zghAg3wVhMw23t7EqPIAyLfpBb0USlFSIs9BOYe9X3d9a3J3CbT/bzuRP3SOBGRs5DZcOQuTgxbixfuKAJt4;20:nyU5SquzwWlEPpZDgE7KlR9Gn5tQv4nFAPN0qRlkyF+Vdmqf8Zz1iH4p+bAaybcy08EYXxtd6oNSwvzmXbmfUxOSG46K0jKGQPvIGQYa7OJa+EEtlrNAiAjqU1OGzquhEV3eSLOPMDK2/5iAFANntEtdHU8Q+GHx9gP3YAeF9pVnOZ5i+Je0OCUCW5Re0YJUMQ6xYcumafN34YAdaTGeukXXGXI+4FQP0TXFxvLuTLE2qcCQLW4b69zHvF7aYN02
X-MS-Office365-Filtering-Correlation-Id: 4382b461-1c2d-4c6c-d179-08d5b498c4bb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 04:04:12.6151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4382b461-1c2d-4c6c-d179-08d5b498c4bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/2018 3:14 AM, Deucher, Alexander wrote:
>> -----Original Message-----
>> From: Agrawal, Akshu
>> Sent: Monday, May 7, 2018 6:14 AM
>> Cc: djkurtz@chromium.org; Agrawal, Akshu <Akshu.Agrawal@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>;
>> mturquette@baylibre.com; sboyd@kernel.org; Koenig, Christian
>> <Christian.Koenig@amd.com>; airlied@redhat.com; Liu, Shaoyun
>> <Shaoyun.Liu@amd.com>; linux-kernel@vger.kernel.org; linux-
>> clk@vger.kernel.org; rjw@rjwysocki.net; lenb@kernel.org; linux-
>> acpi@vger.kernel.org
>> Subject: [PATCH v4 1/2] clk: x86: Add ST oscout platform clock
>>
>> Stoney SoC provides oscout clock. This clock can support 25Mhz and 48Mhz
>> of frequency.
>> The clock is available for general system use.
>>
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> ---
>> v2: config change, added SPDX tag and used clk_hw_register_.
>> v3: Fix kbuild warning for checking of NULL pointer
>> v4: unregister clk_hw in driver remove, add .suppress_bind_attrs
>>  drivers/clk/x86/Makefile             |  3 +-
>>  drivers/clk/x86/clk-st.c             | 85
>> ++++++++++++++++++++++++++++++++++++
>>  include/linux/platform_data/clk-st.h | 17 ++++++++
>>  3 files changed, 104 insertions(+), 1 deletion(-)  create mode 100644
>> drivers/clk/x86/clk-st.c  create mode 100644
>> include/linux/platform_data/clk-st.h
>>
>> diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile index
>> 1367afb..00303bc 100644
>> --- a/drivers/clk/x86/Makefile
>> +++ b/drivers/clk/x86/Makefile
>> @@ -1,3 +1,4 @@
>> +obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
>> +obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)	+= clk-st.o
>>  clk-x86-lpss-objs		:= clk-lpt.o
>>  obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-x86-lpss.o
>> -obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
>> diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c new file mode
>> 100644 index 0000000..8a7795c
>> --- /dev/null
>> +++ b/drivers/clk/x86/clk-st.c
>> @@ -0,0 +1,85 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> Should this be MIT?  The original license was MIT.
> 
> Alex
>

We are adding SPDX tag, while license remains same GPL-2.0

What I have read is this is "to provide license identifiers inside the
source code that could be easily parsed by machines and would allow
checking for license compliance of an open source project easier."

Thanks,
Akshu

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeEIErg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 00:47:36 -0400
Received: from mail-sn1nam02on0068.outbound.protection.outlook.com ([104.47.36.68]:36992
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750777AbeEIErb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 00:47:31 -0400
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
 <82d294fc-d108-a32a-1ada-2763f40dac01@amd.com>
 <BN6PR12MB18094F5327A8DA2F560383E6F79A0@BN6PR12MB1809.namprd12.prod.outlook.com>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <1a90185b-cec7-f9aa-c273-0f0f5f381b82@amd.com>
Date: Wed, 9 May 2018 10:17:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <BN6PR12MB18094F5327A8DA2F560383E6F79A0@BN6PR12MB1809.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MAXPR0101CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::27) To DM5PR12MB2360.namprd12.prod.outlook.com
 (2603:10b6:4:b4::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2360;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;3:PC/h9srNrtYiquhYgZ6Vp5dGgDbaLTRxfZR699oZqrTWyx85xm9thBnwuP7Ply942w2vK7PYtCG8/tUGQYVTYLnMyruxqif3RHBm+t2TqzQj71le1IBVcKVadNRi4DCdkunZZqAaTP+1WprjA7udOy6BUoWjr+FKzvGl8WxvKtcF0C5muiVYS9yPKUFaIkao+k0RKFAIjRd+pJu6O9d/K5yg1Jjd6SFKNaVGxFeWrBE15ccVQKw8EcmP4D0EJDpn;25:QUszg5RtM6bENfszB/uI/xJvyIo8/FCoiKPYq+maY18cN5xyhm2c2N+DremcIDEi6j1klfcStCNhLI5obz6Jo1Ld7H5ihCAzokvuPcTcj5BEzYvpwV50x+nmVjWjuNFMm/FHJUyeEIRiPPd4JHa+TG17H71o7igv88EV7wXkt2VQzlry2/ZCLfaAH9bafNkZSNDhwOurAXKYqn2Q7oKvNaq3y7jBg9wHsv5c5FO6uMPz9fxkRU1sz9JklbRmEiudPPjWcULx7h24rRJSmGC4EOksKNbSOXyF6eEQtiGdUwfkxA26/XeR6S724n4FDNnnvbifI3BtPT473nAi1xgJTQ==;31:6YOGs5ewehpOi22xYav0JhR5W3vXCLT/1uu90Kxpqw6cU4OxFxKEmdu92YEqC6bzJg+dbaxg0ym3c9RCvi3jGtRS1L8lGmIGOEvbF89mJzbsjKpR1O3WVbItZryXWcfiuE6trQqxjAl/U8JQHYK3CgSwD/8hUWK6nMi+gGVXbkdsSv1GT9Je9XRQgn/G14DQrkE2MO1tTdDffpeGM+kmB97pK6VJm/BBRdmaCRNWtpI=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;20:45lPV+wgtJ5bGqn22IRprsDDsd3Yvcie5cqnUZhKBxG2xR5n0+HWZGxe59KfFo5I/5a7Ab8M8OY/NadEW6StWg38aOhCEn2ndJv6DZtphy0jeHWNA0LNDTm58ueUQr52Pf1FmZ2yRkXAiujgME6aAdtzhLXDDJyCCIg95+4PcqmXktO9b7yTnpRdi2hcFcnyAXvtAFqfxCd3bQj3YX3qkKyq2yOlf8sr4nJqlMAjCJ+DssoKbyxxX+YGqETrisEFpLvqghFmPTQsslhb/OAZCLg8LjpWz2ruzyy3D4K6hm29/WptqUPGepG/YKRZuPryxRYApDEGIjIr4P1shjHZfgu0CEVFruBUh8h6XNRFbQEy5/ctQV/ivGNY5XxG7Z+cmC8B6RcmW4isse4P6VLliY+jvkGCkFx0y458p8SNygMUmjCkUgpr3AYEWc4OWmCryrb9GPdwEnz7VSJrmWk9vMR/bVJvnBEpSx32sVaU9vf+9RC2rh9BzYzYTD7HeSCb;4:g2kqXaxFYJvzNo3/5bJdi9PKvVIh66LAkQ5LRWHv85CS/v6crgA3spfYTGZYyRdUxzuXJoLY0lMLgCaCL//T1vwDAjTaMpr5tJT+eh8/rjIR2iKQckicyP6fKpjJZUgYb/bE6DPFhTePWZS00Chx6nkWsFsxgwH3LtG1I8b5jmCsqPgH9qcWbEUiCoePcW8Icjr7pc4nn9B1Y87EYoNmd8B+LcBhP8uoBu6MmP6H0BdBuuW3TUaFBL31t9g6sanCHMtb6Lw47e5S/RtFFXgNzHAGQhzZs7Z18wvLzx1Ffkt/F2fmniYEQZG6yjiafGoHBsAy/pgcIM5OnyZ9faZrIBnzVx31oWenfknTC6UM2aLElXSW6tmU2Va/58VPn3Fo
X-Microsoft-Antispam-PRVS: <DM5PR12MB23603432D64B811E69CC10C4F8990@DM5PR12MB2360.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB2360;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2360;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(39380400002)(396003)(376002)(366004)(346002)(13464003)(189003)(199004)(31696002)(65956001)(50466002)(54906003)(16526019)(305945005)(86362001)(76176011)(3846002)(58126008)(6246003)(23676004)(52116002)(2486003)(7736002)(97736004)(52146003)(37006003)(6116002)(6486002)(186003)(64126003)(386003)(53546011)(77096007)(59450400001)(81166006)(8676002)(81156014)(4326008)(53936002)(316002)(16576012)(93886005)(26005)(8936002)(2906002)(2616005)(230700001)(486006)(36756003)(229853002)(956004)(476003)(6862004)(5660300001)(65826007)(6636002)(6666003)(446003)(106356001)(3260700006)(105586002)(65806001)(25786009)(31686004)(66066001)(47776003)(72206003)(68736007)(11346002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2360;H:[10.136.128.133];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIyMzYwOzIzOjVGdElpVUwwQkE4dDBUcHBaaXM5Z2YzRXZ2?=
 =?utf-8?B?UUlPYitWOEpla0NOY1NYd3lRRHk0U0Q2bHR0MTZFWjhpTGhBS0FVZXNLK3FX?=
 =?utf-8?B?d3JQQjlvUDh2UUhud2VzeUFlZ090NU5zVGhnVEh4TEQvakwxa3FmMFlzUWFM?=
 =?utf-8?B?dmprell4bTQ1eGhxQkNYR28wU3ByRzVxOE1wWlI2bDdEWnByUURXL2krcEVi?=
 =?utf-8?B?djYrOVZWUnpkVzZjbjRvTERNamNSS1ZmVU5lamoxQ0hYajRmQThWK0lTbE1p?=
 =?utf-8?B?ZDdZYVRZeFI3a3kxOWpDNWcydS9XSytqRy9MdjZGK01sdmRRK3IzRDdCQXNP?=
 =?utf-8?B?RjJ1a25lcDNXbDJpcGxWYW5SMWVHWEZIWVo1enJodGFLakNjdkpZZUpXS0My?=
 =?utf-8?B?VE1rU2twcmtXbHdIM3RyNWxBcUV4OFIxY3FVcGh3VDBWTk5PZ1Vxa1ZoektX?=
 =?utf-8?B?S0FHMkJMZ1ZkMDRyWGNYQy91bUNLQ2lVWDl4UVN3eU5SSGNBRXJSbU9UZE9F?=
 =?utf-8?B?c0JMLy80Y1ZrMzJSOGVNR09KQWFCMzRHMHpjM2xCUCs4UGFPU1dNblZENCtT?=
 =?utf-8?B?Y3podDNtVEJ5OXFGZHlscllzaHVaeU5mSmpBSk5YeW5wZWxDaSt4bnpaWFlz?=
 =?utf-8?B?VzlRUVp4UkRZbzdRc0ZLQmtJcThyc0MzUXpnUDZ3dmV1czFtdFN0K1RVWnJW?=
 =?utf-8?B?cGdKUjg0a0NwelpCcjg2Y2JuR3FVOFh4cGlwcGpiV0FsbUFFZnUzekJwZTA4?=
 =?utf-8?B?TjJML2s0MjlzWWVXZERac1RSL0x4ejNJeU5vbGpQM1BNVkRVZEpJUUthYWVi?=
 =?utf-8?B?Zko2cHlqSkJkNmdvWDZnNGVBNWRhNmd3SFJVKzdjWWhXV2l4MldEeUtBZHd0?=
 =?utf-8?B?VFFFSzhKN1ZrVWpnVHVQbU5CamRGQmNPR0hhVjAyeURxTDlVaVlwL0Rrb0p2?=
 =?utf-8?B?ZzJOMmM5b0RqTFloNFhUOE5ZU3FVenlYMjdIbEx4UU9ZQ2hCT25yK0NsRkpO?=
 =?utf-8?B?VGNZSjFrRmdzN0pCSXRqZ3hqakFjbFhYWDIxUzVHQnFqMEZiMUo2TEJ2QnY2?=
 =?utf-8?B?d05Rd08rSUxtWkdWYVVVU0JQcDh5TU51dXNwT01WZWRuL0xYZFhFUHU3R3FR?=
 =?utf-8?B?QkdBb1VoVEdkTW9TWEJiR083MUE2OWl1dW9WeW9saWl5YWxrcUxHU1N6QUhB?=
 =?utf-8?B?VDMvZGEwZzRHNG5BdFVldUJGckpJSW9VNzZTZnVYQjZCWjl6UDl4RWpUT0VC?=
 =?utf-8?B?cDkyU1Vuekx3K1E2NndjeW1EK2xwZnNKTlUyVWpnbGlrSXR2akhHTDJqaVdU?=
 =?utf-8?B?K2hkR3FHVHl4N2krVHg3ZWhySS9WTTRreTFSdmNmNEJub3ZNU1F5ZEJhNFpk?=
 =?utf-8?B?Vk9uVDZaNlNjSE1vY3hjOGRMU2F6QzdOUE1jNkZhOElEcTliMFJPWGpjNXRn?=
 =?utf-8?B?clcwQm8ybzAvSGF1ZTZGL1VVQ0VHY1JLY3VvZS9wdElhdU9lSnoxR1V0a1BG?=
 =?utf-8?B?bkJCbEx6QnpzMzNwSUxJSGRscGRCVStHTFVqaHdXM0V0Nlh5L3JhUTRRbnVa?=
 =?utf-8?B?U1plSXpaNVNIT1FHSGIyQ3lMSExvU1p5dDdMYkUyV2Y4cDR5T1FRSzl0Rjhs?=
 =?utf-8?B?b05BMi9NMHowczNJM0Nja2JNUjdxQjg1eUhpQTdrSDdzdGpOSVR1ckt3VFJl?=
 =?utf-8?B?ckk4Mlk3bzArNHRaQjRpNFFsZVlWZThyalhhMExpL01QTXIremgzZHBNVjRn?=
 =?utf-8?B?dEVZM3pLd2xwS2tKdUhmV2wzUTJ1bEk5WmFPZmhabWFIdlFtazJ5UTJaRnBs?=
 =?utf-8?B?ZWdOQUp2SzdEaW5FYW4zMjNlbmJ3Y3FZbklCT2lLMUQ4QmUxUzhORGJQSzQ5?=
 =?utf-8?B?cUU1cmd1WnRteUxxNnQ0YktkeFdaMkNJZHc4L1dRcUw4blZ1cmdJdlp1UkhG?=
 =?utf-8?B?d0E5ZHBvcTd2SlBTYS9qVGxtdUg5elBESmNLUHNsTzhWSWJVMzBhSzVwUlpn?=
 =?utf-8?B?RWlDdjJzdmRpdHUvSFd4R0dXRjJwVmk3RUxJWTdTK0YwOG0zKzFheEpSdjhp?=
 =?utf-8?B?WVZUT1I4ck1jcFI2ZDVGWnJiQzQ4Vm1mRXFWekE4R01ZdVpjOHUrL1lzUUhW?=
 =?utf-8?Q?N2mPVnRLQ7/EjVDcodc0wdATG8Ya8eZLo8klc5Sa4sEN?=
X-Microsoft-Antispam-Message-Info: SW7SrsDXBhBbMNvHYKZI9PWM+8ryWIMsOUUxGXGHhOZOPbWpMeqtivs2PLdx7klZWU19DsDZfD7xLBBxsG9hCeBLfEVq/QIdZMd6w3qtTopuBMrufWzy7s60uSVg8dBeQYonQvVZ1N1JvZxnqvYOKpezqczX3TA4OFJ+mWnhJTPgyfXSHp8Mkvbb3AOWiDDW
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;6:uPymuG6V4pgoW5ejRJ7YsOO+R+euY+YBd3YNtH/XqNj0qbkWL5e45758MeBJDpTOM3WIEk+pnhriBR9tEn4WxmVtl7ezxcTn9YQ/RqjnZmVDYtiDJ/FohB/uftYPMTyzymNlajZqdeOyu6WQlQp/S2f7lwhkcGuWX9CpTxcSYy5Paa7u6YjKjYLJtAo1M3sJY+pB5taiChQ+rCL6dd07E5wwvrW9X+Z8DwxyzQCsMaoUSK6OZ7GEQtbD8aNbzjir+vj1a2uQTC5DupkvLbQSZFxtmWVRVK1yJB2X+kDcAaWW60hSRMvAe+r/J+mwOejv2qQsMM/gCpFXAgvcin1MH2xk0VJpSXq18Y1xFOIPqRD0Uh7RNRaxAxfimUmRjBTFJP9JwtWaQ3dT0EzODO+5Egb+g8dEH5oncZJaPhvidKbhJLXHBzDju9skCUdPLJ+jnOUu8xF/pFMyd4/5LMKRWw==;5:gAHN2AmHez86rqmAexQe/DcLBj/RckmKjHml736vc8AdapmGL4/1QOHCUzb+99jeWcGTGzVjXBewR114NOfVMjPICPfC/bVsWIbPhzlG8RmT3VLU9GByNqAwLKRydVMCayHdguvg1v2RtD/+9Qq8pNuewKWU4lua/TWZumYl+ns=;24:oymtbHney/z0xbbKDNgJCEmLg+IZCnnXEZOlIlEzscmz6d6+0dGDnAYfjSNekEVXtvMlID6Vf8oHHGj00WgAZsbHk0S7N6mCFLYuDve6Jgs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;7:pY82bxo5D0Pl1jroXB8Rd9CskDbwVamxv234vn3xes3Ur24iZXBwem7OKvhceq8398LE17D3qLI0tPRu7a24cEUWud0GEQLoeDCtYE95aFH6fPtPM80saZ1qjsx9CUHdPIXfCQ9lu1wCqtU/1DhLT4LUQAxFAMg6LMQ2hw1VKq1j1MGVE+3RNkc5mx6uR02fXQKuxgpZN/ag7S4lWMcYwMN4fdyq0SmDykx5wdXlWmlNS2gmq8FHG8SV+9xvfZHD;20:cHKB0Ae6YVMv4Mq/Kx/AyVORJD/cqOjQzC2AaaxfWrNrKP0uJv0TbZ2k0pLjtomJgdJTa+4qJKQG0usbbQf/QL7XzdKEBntUzbN/F8gRpoMeWBOMKx0btxrhygZdK0hr8X+QNtpOelLsrpgO2DYIyFTdB7QkRCJ/r/G1BhBBqkoWMHk62rhyrwBz3hzPqbAORnTHL6hz4/uPNxiMLiaO96mFWVWJldBUn+qBUIPZEqscNuYirH8oqDC+/27USpge
X-MS-Office365-Filtering-Correlation-Id: 6f13c672-9b3c-431c-4f4a-08d5b567f7b8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 04:47:25.0148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f13c672-9b3c-431c-4f4a-08d5b567f7b8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/2018 9:08 PM, Deucher, Alexander wrote:
>> -----Original Message-----
>> From: Agrawal, Akshu
>> Sent: Tuesday, May 8, 2018 12:04 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: djkurtz@chromium.org; mturquette@baylibre.com; sboyd@kernel.org;
>> Koenig, Christian <Christian.Koenig@amd.com>; airlied@redhat.com; Liu,
>> Shaoyun <Shaoyun.Liu@amd.com>; linux-kernel@vger.kernel.org; linux-
>> clk@vger.kernel.org; rjw@rjwysocki.net; lenb@kernel.org; linux-
>> acpi@vger.kernel.org
>> Subject: Re: [PATCH v4 1/2] clk: x86: Add ST oscout platform clock
>>
>>
>>
>> On 5/8/2018 3:14 AM, Deucher, Alexander wrote:
>>>> -----Original Message-----
>>>> From: Agrawal, Akshu
>>>> Sent: Monday, May 7, 2018 6:14 AM
>>>> Cc: djkurtz@chromium.org; Agrawal, Akshu <Akshu.Agrawal@amd.com>;
>>>> Deucher, Alexander <Alexander.Deucher@amd.com>;
>>>> mturquette@baylibre.com; sboyd@kernel.org; Koenig, Christian
>>>> <Christian.Koenig@amd.com>; airlied@redhat.com; Liu, Shaoyun
>>>> <Shaoyun.Liu@amd.com>; linux-kernel@vger.kernel.org; linux-
>>>> clk@vger.kernel.org; rjw@rjwysocki.net; lenb@kernel.org; linux-
>>>> acpi@vger.kernel.org
>>>> Subject: [PATCH v4 1/2] clk: x86: Add ST oscout platform clock
>>>>
>>>> Stoney SoC provides oscout clock. This clock can support 25Mhz and
>>>> 48Mhz of frequency.
>>>> The clock is available for general system use.
>>>>
>>>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>>>> ---
>>>> v2: config change, added SPDX tag and used clk_hw_register_.
>>>> v3: Fix kbuild warning for checking of NULL pointer
>>>> v4: unregister clk_hw in driver remove, add .suppress_bind_attrs
>>>>  drivers/clk/x86/Makefile             |  3 +-
>>>>  drivers/clk/x86/clk-st.c             | 85
>>>> ++++++++++++++++++++++++++++++++++++
>>>>  include/linux/platform_data/clk-st.h | 17 ++++++++
>>>>  3 files changed, 104 insertions(+), 1 deletion(-)  create mode
>>>> 100644 drivers/clk/x86/clk-st.c  create mode 100644
>>>> include/linux/platform_data/clk-st.h
>>>>
>>>> diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
>>>> index 1367afb..00303bc 100644
>>>> --- a/drivers/clk/x86/Makefile
>>>> +++ b/drivers/clk/x86/Makefile
>>>> @@ -1,3 +1,4 @@
>>>> +obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
>>>> +obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)	+= clk-st.o
>>>>  clk-x86-lpss-objs		:= clk-lpt.o
>>>>  obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-x86-lpss.o
>>>> -obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
>>>> diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c new
>>>> file mode
>>>> 100644 index 0000000..8a7795c
>>>> --- /dev/null
>>>> +++ b/drivers/clk/x86/clk-st.c
>>>> @@ -0,0 +1,85 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>
>>> Should this be MIT?  The original license was MIT.
>>>
>>> Alex
>>>
>>
>> We are adding SPDX tag, while license remains same GPL-2.0
>>
>> What I have read is this is "to provide license identifiers inside the source
>> code that could be easily parsed by machines and would allow checking for
>> license compliance of an open source project easier."
> 
> My point as just that the original license on the file that you first sent out was MIT so the SPDX tag should be MIT rather than GPL.  E.g.,
> SPDX-License-Identifier: MIT
> 
Oh right it should be MIT, will change it.

Thanks,
Akshu

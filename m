Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbeBERsP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:48:15 -0500
Received: from mail-dm3nam03on0050.outbound.protection.outlook.com ([104.47.41.50]:27790
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752925AbeBERsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:48:06 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com;
Subject: Re: [PATCH v4 3/3] x86/kvm: Expose AMD Core Perf Extension flag to
 guests
To: Radim Krcmar <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Len Brown <len.brown@intel.com>, Kyle Huey <me@kylehuey.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@suse.de>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Kan Liang <Kan.liang@intel.com>
References: <cover.1517333237.git.Janakarajan.Natarajan@amd.com>
 <f481ade083edd15c0f5850babaeef378ab06ffce.1517333237.git.Janakarajan.Natarajan@amd.com>
 <20180205134321.GD27896@flask>
From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Message-ID: <1ab1c7a9-a55b-2903-50c7-444886ac1bfe@amd.com>
Date: Mon, 5 Feb 2018 11:48:00 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205134321.GD27896@flask>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:3:c0::34) To CY4PR12MB1367.namprd12.prod.outlook.com
 (2603:10b6:903:41::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea510128-2d8a-4390-5199-08d56cc09bf3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1367;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1367;3:EFerNi9wCYMFR8YFfE1IJEKObfvuhuu5skz5S/ZWU0vgxa1whXo5sorj1AORUkc5BpKqFJiUmEO+HEAdyEoXtooAyZKHoQ5VJD4PLq7+hGTp/rLBZMHmFzoniNJW4kTOo3WfXmjZKyvT1ZTZL84UM0x3kRoAXpFDKMVIGi6bqeOXGuV7ZEyN3AWhcj5wobBARQ4lGxlhdyZuIgn4Ig8igdBhMxBuBU7aYNw90qr0GhjqLxyEmC8/9bs8B08FeLLS;25:woPWIWxkwPgHfOPLO9J7Oaxz0Txt/QIZKUBUFDdXlehZ0ftQ84sPGqqA4zAgpIqxqWr00GTPu6BwYWMNpNLFtTCWG+r0juXvxMOXgEol5sHAHZJ/rk9QV9JO94jeP7Fbm09FUlO9s6lhCDG/F+Pe5Ej0E7O/qHUYGsa2WGE1Aoll7utcWT9dlbG7car1RY39n8uz3uo9eRmrxLp7p43LKJ7jFJYw9L7nZPCdBtLQBTpL1OfnyjNjNVpsd2gVgKZqWpKXu5KmEhzd2KleJ48+fpG0zWykcY9x3Gc9KI3iQnWs/VdHvDcNAEp6x8KziqSpnxQkQ7u3dAAtPx3r+ILOzw==;31:EBWrBlaSVWKjaer/C3feZ2u3GkkDRTbmbtJpNOTUubFJjjPDF9rDBQ2qSSZRvtAQRnACGEI4xrHffR1HW35hK4OKAuFGL/ya+u2a8SiDgro10BF3YD90vFK/zzzCqsrQBGRD9NJ7QAfHVJqYfbSGa0o9Qx6LC5aRbZN6gmA1w2WIQlIHq2JHLTqYXFnMB/qQAAf8a+UEHLDjdegS+wY8TrP6jJ4z+8Lv2GHSp8kzlag=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1367:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1367;20:YH/N2t0Vse6rzQGgwzHl47COwXspUwUnVYPZp7BKqxXoIZcRbwjjV5ubStBW4eyPDDdotpB+MOR4kHZYNWxZd3f0N0vSm3L9GAW9vvWvstYn9XS+U1fAOtSVq3a6+uAecDYuZZWUiBxDOdZM+3nSrDLCJOZXXewEXLSmWqt510h9E6twH9GkBDMV6omiOqYpW1Js9TJYAYfBA6DEm9LGVWJRXVu7O8VEAWtZahS0XNC4FPo0XEfqsDUa8EB0EVgQG8GvRpLbfoN14/xAfZdz8jblCH4SywuJUz6ULJS99gmpe/cfxWtOjQcVodVVQDwKK/gwRkOssSym0VkOLHRa3dPkUueX3SOYF4BE/hw1CFvmq7Ju/wAeYehiqzwZKcEirZmhIUPh9oLcgEGt0us1WU90e05+MSKwMCb0dp6IF4Q7SQikhcOKSCiWcav8F4O7mZBax9BZz1LHpsDL6pfflvNRs2Ly78B+4LMLOh07AlnAkz26P5ixvfLiu9MmruG0;4:AIaMsTvjYIHdwO3IJMLvJ25DbNPXCatq2n5CzAGeZH+Q2VNUsDI128+P76QVgQ5rgzE8rQ4XrlQOAkrwD/yUrZ4cUxJH5KWTgzXY0kpGEBhXRBduwzGMoDcYlfJkGiDVFu/BYFetC4ciYCW/QxH0AklcJ1z6LexvOo9p2280tAup9CD6E4IpOHycd9P7msaDFeW75MESdIc1HLNztv1v7G6e3B+BfDsCS2n2zwSr+8tibqJX0Z7t5vSOsC0Io7JLzcldpp7LBl5y+T7fJQNY6x+TNk5a+o1BgBHbwQHWKG0+PKTmm8IvPc+AJdck8WwL
X-Microsoft-Antispam-PRVS: <CY4PR12MB1367074179583C5C55257C94E7FE0@CY4PR12MB1367.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR12MB1367;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1367;
X-Forefront-PRVS: 0574D4712B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(396003)(39860400002)(376002)(366004)(39380400002)(189003)(199004)(377424004)(65806001)(7416002)(52116002)(2906002)(105586002)(81166006)(81156014)(47776003)(31686004)(26005)(86362001)(106356001)(54906003)(4326008)(58126008)(72206003)(66066001)(65956001)(386003)(478600001)(16526019)(6666003)(67846002)(25786009)(53936002)(6116002)(3846002)(76176011)(316002)(77096007)(53546011)(2950100002)(8936002)(186003)(6246003)(230700001)(68736007)(97736004)(83506002)(8676002)(6916009)(52146003)(229853002)(64126003)(31696002)(16576012)(50466002)(6486002)(5660300001)(305945005)(65826007)(36756003)(23676004)(7736002)(2486003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1367;H:[10.236.18.253];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMzY3OzIzOnBLdERsVGE0dmRyZVVBdG1GbGpERG1HWkFN?=
 =?utf-8?B?NkpQS0RUa3kwb3E5bnNwd2REVGtuY2ZjTFBjb1BGOWhUZHZFNW5jMmExRzBu?=
 =?utf-8?B?Y0xVQ25hN1NVUWlmR2o3b1pCc1czdlArNXVXV3pVQjFtTjhTM09Yd3M3YVha?=
 =?utf-8?B?K29ZSVU5ZmZySlE0TTJoRU02eEliYkJ2am9va0ZOQnUxVituVHpsYmpJRWdu?=
 =?utf-8?B?bUhSQm1xa0hIWHFjS25peDU3ZjVuYzc0NHc2a3FSMGVQU2c0NFRwM1Vacm01?=
 =?utf-8?B?VndiS3VhVURCZU5tMWx2R1BhdzI0dGRYeXU0T0xuMHFZMDFoMk1jVlh6YjlG?=
 =?utf-8?B?L1FmRUlYOHBuVWlRRVZwMERudERnV0E5ZzZWazVZVGhVOE10NDV6L1lsSGlT?=
 =?utf-8?B?UjVicEd3ek40bE9MS0U0aXNlWC9DUmVxTHpuUFRWWC9seEpZU3NHYWR4d0h5?=
 =?utf-8?B?WFFURmRwUTkzS3d4VHA0TDlVQ05yRkIvdHI5VGNiL1I1aVZJajIrQlI2OHMz?=
 =?utf-8?B?WjZ6bTJmMUZ0R0ppN0xVcjFqd2JDcXMzczloZk04SEwvWU5OeHRQZzNZeWY3?=
 =?utf-8?B?UmVaQ0lnZ291TWhnV3RMVjU0eDJoNjdiYmVXK0NlcGkxTjAyR001b1NmQW1B?=
 =?utf-8?B?aWY3QTZhamFLd0R2a2VrcEE2eTFKNlZhOURPQ3VZQzNBUUZvRHVETWRkb1hx?=
 =?utf-8?B?aG9uYmpLUzB2WWovMEk4ZVRGTHpUa1FJUUI5YzZVUUpDYVAvYzhnQ0orR2k4?=
 =?utf-8?B?Q2tkaE9tNm5LckF6Y20rRm82YW5SYWFOOXVJSFQrcW40MDBmWTFXTWw5ZVBa?=
 =?utf-8?B?ODQ3RUdKclZIR3dodzVDRUV3S3RIWS9UemxaMUw4VHNQM0hwNFJNU2JnNjE4?=
 =?utf-8?B?d1krS0pQUE9vSVdDRVl4S29aUS81d1I4L2NacjFIOFp5ZE9PS2pZTGxSUEV2?=
 =?utf-8?B?d0p4bTFrdDdFTCtBUnVJaklNdnVIWllRQWxreWRaK2tBTy9FZGVyOHlpckJF?=
 =?utf-8?B?WU0xS1R5R2ZFUkpqUUs4SWYrb3dxd2J2SmF0MGpJMnFUeGlmRzFneVZoWW0y?=
 =?utf-8?B?c0VWNlNScDR4T2RZclNlbjZtM0tLSHJnRTFxVk1DZ1I4UWxKcFRMeVpINWlW?=
 =?utf-8?B?ZGIzYmZBUDVsY24rU21JZFd2MkxjMC9ZRkVUQjFZSTdiMmZrUVg4OXZBd3pK?=
 =?utf-8?B?NlRWWG1qZkhpRW1OckFRemg4RHJmandSRFNzVWphZkZPVW9BUnRtMTNPenJQ?=
 =?utf-8?B?OGUvMTBHd280N1hTZW0wK3A2V1hFUXFSc2V5YjNrSy9kNG5oczc2ZHJjazVp?=
 =?utf-8?B?ZThkTEJ5VWwzRGpMVHhURklnSlFvN0N0WnhXOFErSUhCOUVwaDJld28wWDQw?=
 =?utf-8?B?c202Q2tHRnh5Q1VMR2pnTWZPcDU1Q3dWclRvY2JHaTFPOUkrUGhJTFJlN1dC?=
 =?utf-8?B?MTNHWVlPSFM0Q09nQlJMS1VmVnBTZGVIZ29LUmEyTWxSYU5Rd3dBY1k1WVZq?=
 =?utf-8?B?RXc3cG1IOTAwNmVoREQvdkw5Z3AyUXl3N1NNWTlaVmowSTdhb0hlV3ZRQ05M?=
 =?utf-8?B?MU5YcFM1ZE5SNExUbmlrTjM1M0NJOTVzQ2lVc245TVBXb05ZTUVuSnEyU0NR?=
 =?utf-8?B?b210TEU2TnM2UCtOZCtXM2QrbzdDK3J4Y2t6bzgrRE5kTmFHeVJwbkFtVEZZ?=
 =?utf-8?B?YmdYYldtK21RWXY1Zlc4SXdoaW1SdG9pd1hrb2p5MUlzWlYvM21OajUvcUdx?=
 =?utf-8?B?aEltamZURFVRNFdyaHdtTUFaMDY5ZG9rSUpwYUVEdnc0cVB0ZE95Ynpnakhx?=
 =?utf-8?B?Z0M5K2NEWTBNWjV1aDQ1S2hwc2dsSzVDellaZDYzeXJiUGM0akdzazEvSElx?=
 =?utf-8?B?Y2h4aFV5RWNPNFZLR3VvLy8zcFEycEI5dkpKVnRpYllOZlY0S01nL1BtKzBs?=
 =?utf-8?B?SnZtenpEajJ3SWkvWkNGalJjcUN2TnFhdC9Kb3JFdFFEU0pORGNvRHlKRmRR?=
 =?utf-8?Q?AjL8XS?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1367;6:BDM270Nsxkeh0PcqcVBJYP0Osz9Y/xZUIwjK5rttR4C+C674w19L1RoaW5PIjV2RppOorFxxHt0s/nKJQylNXol7UBXFiwNwGC+pBNcGoMTnwq4s3fEM5mK9r7RRGKmqe1M2EV3bawwv/8UIripjzknqkDQ5q8O152k0T0eeS2+c1rDp0CLFLTD9cRT4PAQDYiwzI3b16kx/oUSsy0FZ2msKSRkeZfGcs47ja6UgBT+Y0j4PnlzZejmFmRO9iJFbeaGz8tGeOIZLhWin498oUfcc1xJ7TLl4K9501rwHNe6okKJOGckvKXjySg/0E2pWgglZnlNqBR4NvqmaMtuq86ChiI63h4sKlj2lxGcuIc0=;5:YYt9UYqIrp0nYtuboZOjSIQgmB+jWK6MoAy2T5H3XdhcUbjqw0HuFlhGMAJL6MMroZ4OTDs7Gsgwf3hj8upT2hYleQ9iYtgKpm27R355rX1JWmk56FyzkUgbtCjMNlSDrVSnFr1r9SOdKaJfYIuGsjI02EPDV7HDyfuAf+W+brM=;24:nt0e9BxDNgMPIB0cHYZa0VZ89nIp/NEKC7ksY9fA06272xSwR7g2Y98a5MzOhTuv6XEm6lr/zTd0tqwkSKVvrzJZmqZLsvYtWDB3WeuUd2Y=;7:8TGSW72+AoLJC5KezTshKFbuSuzvtXsHqkeDxMlFI53/M6FM9zgC/BI8LjEhjwqszNcZf5LdizGBBGyxkgKO3eupjC5emG4bOpIMfyGZmcPYnMAsL41umjyd1LEWTnrEr+r4Q4juhwzn5Zv+b4TBAkeg8U2dRh9BA2IHZNmsqrbCBGPDKo7OzMLFJDGCjgzngD0YglyEwWqHJ0QA2tEbHLRsnH93h3Nz/30B6ILiNcryZ14Z2Xbc2cmkWpAsfklp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1367;20:8NLhYSvzNbt5ZGE8pMghqPR6x6quHAwiBMpyb5Q/WzCyLl8pgPOd6gX8Os5AAjWe3nnsn6M+aR8KLESkPYt0kqJbXC+/DOSWK85GPWYgWWSI2KrLVKJRElOc0lbAQN+jleAC6TDfjWoIsdPylq7zlZ/ab2etIDmqk70FaRuO7NOaMp6OxFV/3obbIQ8M0522oslRrLtR/aCSuljjdOluyu2YguF49aZ11N+myDql54rhovC4Cx/y/ob5QFjlrjfB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 17:48:04.2478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea510128-2d8a-4390-5199-08d56cc09bf3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1367
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/2018 7:43 AM, Radim Krcmar wrote:
> 2018-01-30 11:32-0600, Janakarajan Natarajan:
>> Expose the AMD Core Perf Extension flag to the guests.
>>
>> Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
>> ---
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> @@ -365,7 +371,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>>   		F(LAHF_LM) | F(CMP_LEGACY) | 0 /*SVM*/ | 0 /* ExtApicSpace */ |
>>   		F(CR8_LEGACY) | F(ABM) | F(SSE4A) | F(MISALIGNSSE) |
>>   		F(3DNOWPREFETCH) | F(OSVW) | 0 /* IBS */ | F(XOP) |
>> -		0 /* SKINIT, WDT, LWP */ | F(FMA4) | F(TBM);
>> +		0 /* SKINIT, WDT, LWP */ | F(FMA4) | F(TBM) | f_perfext;
> You can just say F(PERFCTR_CORE) here.  The conditional features are
> needed when there is a runtime config option for them.  We are
> automatically masking features that the host doesn't support,

Okay. I'll send a v5 with the changes.

Thanks.

>
> thanks.
>
>>   
>>   	/* cpuid 0xC0000001.edx */
>>   	const u32 kvm_cpuid_C000_0001_edx_x86_features =
>> -- 
>> 2.7.4
>>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CWxBDT9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 950DB60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeFFOMe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:12:34 -0400
Received: from mail-cys01nam02on0073.outbound.protection.outlook.com ([104.47.37.73]:10976
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751533AbeFFOMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:12:32 -0400
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics performance
 regression in 4.15 and later )
To: Gabriel C <nix.or.die@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>, alexander.deucher@amd.com,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@amd.com>
Message-ID: <516cddbe-73c2-01f3-a552-0d9fd75ce63a@amd.com>
Date: Wed, 6 Jun 2018 16:12:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2a02:120b:7fe:4fc0:8edc:d4ff:fed1:3069]
X-ClientProxiedBy: VI1PR0501CA0040.eurprd05.prod.outlook.com
 (2603:10a6:800:60::26) To BY2PR1201MB1111.namprd12.prod.outlook.com
 (2a01:111:e400:5a75::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BY2PR1201MB1111;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR1201MB1111;3:lXrYyRqXR9v7+B7q8sv7/GCU5f5JBT8JXs/wNaS0bLS+cOh8H5xvHOAZgDM2z8+eRsR+B9DQT6nW5ASTd4zMnwkbsgOI2/LuVAydky/BMDupocdF1D5e71Bf91WbgdJXVKsbC9HoNF5tuGnR+cNl1qj8ZLzfypTidOjaMVFVCxwEadFc+cj57iTA14cWmqSnvPNXatNMC+bE8NNv2KL5nFWhzjzGQe9Tc2hEFArlRhnRYbpVLluQemxWjG11g+em;25:vU5iQJmXIkKUxtRQFm2m3uCu12o0j5CqVS7Cx0ML0Nt2z0eaNWn6WUAHTdfXXl0/4fSrG6GoodpUgkbyE97hYtUvv71NEjbp8reyH+78b68FzHGAhqcUs8QUrVK0mYJsJYGLO+Ur5yoG0o/Stje5pyIp4qckczOmXK8xMkuroepb102E3ofXm05UbkR2biWPrXK2s+AMr64w58ahAKwjQCDYE+1vAc7DIjbMzT9fQKY+STVXQZF3rOjY0KzCtpXLaeq/ob/Pb52u7imdI45vHno+Ntu0pXDWu2KbpooqaLSdJRmQY/3eipZ1iYDJIoQN/ecfnzsG9/3r3qVY0Tfg8Q==;31:Zp8Dc+rV0RwRHwIIkDDeXQO9XvAfx9b0vtGkvBrPgRwoC8pjD4kUAJzjKQWglZikJKVhZfxRxV5sEm5nxnuskniAnTj6d9NrLNtAznvMebHWSxTFJF8Q/tA2GfptHqT/i+mCimdLN1YE2nKSAAqTbk+t23IAJV70WOf1FGkX1zBh3x1fJlBwD+4U9Pguifj4q5OmOWbb8v/32DhulomU7JHZ7URw2THVJ0QfqMYvxKw=
X-MS-TrafficTypeDiagnostic: BY2PR1201MB1111:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michel.Daenzer@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR1201MB1111;20:jwsm4BoQuP0zECQeEvZ5SYR2Mn/WeewRsQAlUSpRDhHWD8qZHHe6fENXqsp9iWnsg4Cwmz78ouVLHFpdJdu+D4Ng8OwDcecgXUi/2rcY2zX134yFrAWm4jXALPI6p1WjHIPOwktL7okZ/5HH2MzvVL3ig7MJjfh530lv30RIt7ZfnK2FAh7e8doDBIlYIONmorNUDJ86Fs+ZOCCG/5qBfwtwDh8up5wS9kNM2dClWqNqBiJKmtRZ/Dp0Qq59KANuiJDfnOBe86MaMJ0XVkttQY39ZIUkKe5Xs/NP8r0AOQBClKE4OKDfqs8L2X9rCK0u7BhEFZf1cIeQtz7FxuPMoC7WH3VHPZWREXf+PPrrlJYfjRTW91ii5IHjOB6xSPHDeEZfuE0qSu/Mh+lH7liMrxLfv1Pcgd7Qk/x7LO+Bh5LqqJpzP9836aFvUm7RAILNZEjHXe9j5l0rovzCByDRNmLcFZftN5q9EQ2o99amGnR4vSXau4oY7Wz8gZcI+Kvd;4:pvem7oHjQkcCAA6B+OhH10RPSUqZSdIjN0XHBkbTX8etp3KE3MoHDOYntp3JeEgAEvFyECUZ9z86VedirpJanS37nWCgicTo7+6pDcioFXxCZVts6dLQzeHKS5gSQzabt9hPZVkw663R8baUsO7j19Kee5ZEQyJrfSaDtILLi7XvUnHKBF2sApACu19jzU0blF7uSbDY1UTnkTmszDq3JQbgnCluVgK7eTiCQZA96FFVv6XQxOkJy1YrHPqL4ejZRXc31DJihNBJ13eeQlJXCUniuK1Tm3oqPJXGP4woEo16xGBQMxRr37Gc7n9JzBObud4KFW9OW98tbdrWjzz0Sck5mi7sM+0VpMwTp4RGFPchjhxQ9Fy1fKnblZu/WtMsIqLIwP6bMpkbKSYIzk3F3i4puj1UM0eeCPSoesf1i+4=
X-Microsoft-Antispam-PRVS: <BY2PR1201MB111116F3D87E6F46191D7B8496650@BY2PR1201MB1111.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(95223839027130)(20558992708506)(85827821059158)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR1201MB1111;BCL:0;PCL:0;RULEID:;SRVR:BY2PR1201MB1111;
X-Forefront-PRVS: 06952FC175
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(39380400002)(396003)(189003)(199004)(7736002)(4326008)(25786009)(31696002)(8676002)(86362001)(476003)(2616005)(81166006)(81156014)(2870700001)(6246003)(446003)(11346002)(53546011)(23676004)(106356001)(52116002)(52146003)(2486003)(229853002)(52396003)(6486002)(2906002)(76176011)(105586002)(16526019)(46003)(31686004)(386003)(186003)(72206003)(966005)(6636002)(316002)(39060400002)(54906003)(58126008)(67846002)(6306002)(64126003)(6666003)(478600001)(305945005)(8936002)(65956001)(65806001)(68736007)(5660300001)(53386004)(110136005)(36756003)(486006)(65826007)(47776003)(1706002)(50466002)(97736004)(53936002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR1201MB1111;H:[IPv6:2a02:120b:7fe:4fc0:8edc:d4ff:fed1:3069];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyMDFNQjExMTE7MjM6UUNrN2trKzVoSDZJUTZWNEZ1ZzZkSHpU?=
 =?utf-8?B?RzE5TTZLNXFNTDI5akNjTSt2dmw0SlM0cHhpdmVCOFNNRG0rTWZQUXJVeUFo?=
 =?utf-8?B?cndvbUltODRydWRwUW8rejZIR25KNnFZQ1JETDZoeXVWZGV1UVBnS3BDcCtr?=
 =?utf-8?B?NGkvUi9ZblNkQk9EaU1JNk80NXR5MVZtT1FnVzI0OG1hK1VxUWtFYlRwL0pF?=
 =?utf-8?B?NGowbHVwMTN5bGpldXQwVzNFK3lhRVBrNlVXdG1jdE55R1dLVC9oRnIzajdo?=
 =?utf-8?B?NzdodlN3NGNya2REdkJNd1JEOGxJV0VWQm1QMHQ4MjFTdUMyUHIzaHlEMVVU?=
 =?utf-8?B?ekJaOXBBak5NYWE5RnJCWmhKWm4xeVNKci9abm9YTDBZeTdBTzhtLzdIdG11?=
 =?utf-8?B?a2VWUjYvRFJaYTZnS2tlWHY3eXNBTEZhZnBGamFGNlJrVi9PbUpvSDdKNlRw?=
 =?utf-8?B?Vy9kR1UzRnR6Vk51L2tTd01ZNDhsdXBVdzRuTVdBWElxeWJlSkRSMm5rREFF?=
 =?utf-8?B?eHRXSzhlZVNUK2VPdmcvT0RvbmJWaHg4YWhhdldObmJ2ZE04eEZjaXU4Q1kw?=
 =?utf-8?B?Q0N0dXN5cHNzWmVNTW5ma1FCc0x6ZUxzTU1CT2NlMkE0WXh6YytLbzRRaWRk?=
 =?utf-8?B?YjROK3ovakpkaisxejE1UWJHTmU0QWpLQlM4cGFnRng4NkNxY3ExbCtNamhh?=
 =?utf-8?B?WFk4VEw2ekZjTlFqb2kvOEdqaW5XR3RIcFpxeWN0dFVRUHAxY3NNR2NvSm1w?=
 =?utf-8?B?RHJvOUlyU3NVcEIzaXNRaEtwdGpmd2JaQmRQb0ZZME9TdnJjcXprb0xxbHFn?=
 =?utf-8?B?MC9NcTc5TW5hY0JxemJqS1paaSt4WlhMWlZJZDB6Z01XVHQxUTBuRERzYmpM?=
 =?utf-8?B?TTZtSFBDNm1vZ3lRVDNPQ0EyOWtKUjI5ZG1LQ2RpdlNZbU82T3REbzgxTlc3?=
 =?utf-8?B?K3RpZEw4R3NQRUw0cGpjSzF2Q3Z0KzNVSSt0aDJUWWZGeHFUdFRnT3pqWXhS?=
 =?utf-8?B?eU95MUo0dm9tOXo4Yk9Fc21RdFhXNmdlSW9xeVRJenY2aGk4dGc2TTNza2ZH?=
 =?utf-8?B?YW9vVWZNdS9xTWlodWtURG5oSTExZ3liVnZkTG1qSVZidXBPOS9BK3JTSGQ1?=
 =?utf-8?B?MmhhR0swY2pPa3RLMHZxZWNjWGY4R0VyZ2c5SElQbUE3Qmx0b3gzTmgwR21O?=
 =?utf-8?B?YU92dTRxZFBlK0krcDdzZ3NlcFhWSmxCWGpUUDFoYmhTNllzNmEvVGRtUXF0?=
 =?utf-8?B?ZTYwcXEvNTJEK1poNVIrVWRjZnVnRTJRd1JkTEVYYzBSRUwvSzE4K2N6eXRF?=
 =?utf-8?B?SVNEdnVuQUs3c1BreEluN2Vmc25NTUo0dGxSZ0RTaUJ5Nko2VmNqQzFxcFg0?=
 =?utf-8?B?UHRMME5oeFJaUER1aDFKeVl6WEgyTytxM1NsbWZUZGwvU2QrZUtlS3VKY0ww?=
 =?utf-8?B?K21nM2U1VkFKeUhBZVRjWHZ0eS8rcytEUk9rVnNwaHNBVVVDaEl3czNOV3hu?=
 =?utf-8?B?MmQrQUNSQUVIM0VCWnlRSlA5MlhOdDFnVUpxenJSRmxlNmxGdWJ1MWxKTGdC?=
 =?utf-8?B?NllFa1ZwRUZVZUJBcXpLNG5SOW5vM0xiOTMrZlRoaDJnM1pIaGxmWnJ3NkVJ?=
 =?utf-8?B?OFhUOStpRnNXUm9MTGs0bHRIM0hCbXB2M2FiUHFBQkltWnRiazQyQzRobkt6?=
 =?utf-8?B?THUyWUVQa1dkWEswUHJZVkpXQ09STm1XRVdod2NnRDZRZzVZdmQ4ekVnNjRU?=
 =?utf-8?B?YklxTnJBM1JkMTVwYjBUaDN2SzRaVmt4L1dwR1lZaGIxb2k0TzErTXlSTm5S?=
 =?utf-8?B?bEg0VUEwZnM5VXBzd0UzWWYzZzQ1Z09OQ0NSUWU2NHRud08rVkEwYldOWVZZ?=
 =?utf-8?B?V3hMS3lDV05lOUM2a3c0U3Vma3NjdHpvWVo5aDlOZGhYanUrWnNoMlY3dTJI?=
 =?utf-8?B?SmVRQTQzanM5RzJ5aXN2VXc0MktvTUk4RWtWcjRDTHZ1Z3I4SjZCOWxFVzZ5?=
 =?utf-8?B?K2xwUXRBeHZQeWRsUGtZOWk0WmJ3dHJWM0R2ZjZBOGhVYy82THhKaFRCdmZD?=
 =?utf-8?Q?znQa3s=3D?=
X-Microsoft-Antispam-Message-Info: 1GU46+Ak3KwQJaTmm7glN2C42++I4FWX1NyI/mmGkzCetlEbW78bAoPZ5VEHIGqr1fHd8XR2Oom/N0bRlAIb/rWzsp8EpZbwqfbtACVSqyIW5gPR4VeHps0O0F9vpZV6ztoVU/Bf0mzk33wNmYCQfedevBzPAKlp88s+6GPQsWtjAL3QFeX/L6JnWkfKj6ce
X-Microsoft-Exchange-Diagnostics: 1;BY2PR1201MB1111;6:EB3W3D4qse1glWpysuNAJdaWZ/GY6xOZGqnPQIUGSmkAXW+Jugrht85N/u4xpaeeM4mha57PYLahlzPimnSXutIaL6BoziTIVMD04VKDoywA9rHOW39wMf0Skt1+2TAPpucV1/qd8TcGcAE4Fb2ROswGkju2eO+sUuqeDj5pehwr8+0/ZRKJFub12nZR+LzuqFN0Ii7qSkZMkbn/1KdKAMf09odUWSFpQB6PlNeu7v3VfN/0MwEnVkxizA52ufIdier83I+I7yuOAB7P67iZi1VHv4hRqxeksW/yeOKRuYQ2aHAnp7+VYdZNeWcK9Gs4cVbJeaNJOvlkmISYWpvAdH+bcSUy9WIvNNeOeTTMp5wycKwRdOEbHa+zswXXx1QC12KOMjbfq+/jqlHbC3O+Ot6PCTA3YBynbBkNEYImp+htbpeUvA/erUcs/90M+EKDdhMrfXF4/iqqXg9lK22MFQ==;5:/OTyt51mclY21QTJniqxOZXwTJY9pXfQBnoMKL3I5o1wsgUbrqOEgOzBFLSmQXbf098RQ09nSi4Phfo504dqW972UHSe6Isbn6mRiOCiUngfkmEMDo59T2tFAcS29kh0mcFFGVynPbz+yGj3ezoHPjWRIHx+CoZjO/X65s/3BUY=;24:VKbD7IjwlhojuZJsGYq7WGsnp+HgKsdo6JqR5njWpW4Nd3I2rMpPAxX+VRBGPBTwO1w0RcMHpqZGtUUGf2Gp0jJgH/rfRrtIQgylTsr6NxI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR1201MB1111;7:VbJq5QYaQc+5Xy/AjJSp8ehTMFuAvSSvc8CLQgz4l0oISvHBSXdbOO6heRoAZv+Y3jhnx2yXuRDr2ISn44boSZzdac0WNRz+AMfDMLlCOPBbhjuYuHQ17Z6zuOC2+rPjBXtQgvUcB43JcVGviQu+hul1dST3goye/clsH6NyGQBUKgcFbjInRNW9l4OPOqFOIcDOveyPp4Oct+xb7Dos1KXKTmVknAw17DCJI/kCMMdlWoxk34kV3wgQEPh5CqOl;20:w+p/QmiHx58siU25xYQhn8nZl98STm1Yq/jrqTQF7g6RyCsNtfHFziBGEwXA+DLmwG7bdY4FwtEs1XzhdO5FDP8RNfOtKovdM9dLokVex0fK2B1T16eUQQFPh/ZLMSpOTlrg+aCZym4jOd0spYN06AQzWA3I7Vl8ZtKc5DGhafrZ14s4JhOoplwdCIIeZUapHc6NqGDIstIDEAMmjlEsKixCu8xf3pNKtC9dUbngcHq4WaCLvpgg0uSwRP9rptsx
X-MS-Office365-Filtering-Correlation-Id: 3674d074-9928-4691-18f3-08d5cbb78a73
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 14:12:27.8361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3674d074-9928-4691-18f3-08d5cbb78a73
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR1201MB1111
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-06 03:33 PM, Gabriel C wrote:
> 2018-06-06 14:19 GMT+02:00 Christian König <christian.koenig@amd.com>:
>> Am 06.06.2018 um 14:08 schrieb Gabriel C:
>>> 2018-06-06 13:33 GMT+02:00 Christian König <christian.koenig@amd.com>:
>>>> Am 06.06.2018 um 13:28 schrieb Gabriel C:
>>>>> 2018-04-11 7:02 GMT+02:00 Gabriel C <nix.or.die@gmail.com>:
>>>>>>
>>>>>> [    6.337838] [drm] PCIE GART of 2048M enabled (table at
>>>>>> 0x00000000001D6000).
>>>>>> [    6.338210] radeon 0000:21:00.0: (-12) create WB bo failed
>>>>>> [    6.338214] radeon 0000:21:00.0: disabling GPU acceleration
>>>>>>
>>>>>> ...
>>>>>>
>>>>> I have the same Issue now on final 4.17.

Please file a bug report, and ideally bisect which commit(s) introduced 
the issue(s).


>>> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-iommu-sr-iov-off.txt
>>>
>>> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-iommu-sr-iov-on.txt
>>>
>>> Also nothing else changed in that setup just testing kernel 4.17.
>>
>>
>> That has nothing TODO with the driver nor the original bug you reported. The
>> problem is that SME is active and that is currently not supported at all
>> with a that hardware.
> 
> Ok .. so are we playing now kernel an AMD Hardware roulette on each release ?
> 
> SME was like this in kernel 4.16.x here and all worked.

If that is true, again please bisect which commit broke it.

All the reports I've seen before this indicated that at least amdgpu has 
never worked with SME (which BTW doesn't mean it's never going to work 
or that we don't want to support it, just that as far as we know it's 
currently not working).


-- 
Earthling Michel Dänzer            |                  http://www.amd.com
Libre software enthusiast          |                Mesa and X developer

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752847AbeCPGw6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 02:52:58 -0400
Received: from mail-dm3nam03on0042.outbound.protection.outlook.com ([104.47.41.42]:55568
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750814AbeCPGwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 02:52:55 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: "Wu, Aaron" <Aaron.Wu@analog.com>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lennox Wu <lennox.wu@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
        Al Viro <viro@zeniv.linux.org.uk>, Jonas Bonn <jonas@southpole.se>,
        "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>, David Howells <dhowells@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [Blackfin removal] [PATCH 01/28] Blackfin arch: Remove Blackfin
 CPU arch general support
Thread-Topic: [Blackfin removal] [PATCH 01/28] Blackfin arch: Remove
 Blackfin CPU arch general support
Thread-Index: AQHTvGxZWNy3iHg0jEOTkeJ3xAhtjqPSaqsg
Date: Fri, 16 Mar 2018 06:52:48 +0000
Message-ID: <649EF91064D35D40B9C93A225BF41674ADE2BD45@NWD2MBX6.ad.analog.com>
References: <CAK8P3a2PFSJa5UKHrB14zz8siRCpUzkL5hffTM8ku5ep3pUjCw@mail.gmail.com>
In-Reply-To: <CAK8P3a2PFSJa5UKHrB14zz8siRCpUzkL5hffTM8ku5ep3pUjCw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVhkMU1seGhjSEJrWVhSaFhISnZZVzFwYm1kY01EbGtPRFE1WWpZdE16?=
 =?utf-8?B?SmtNeTAwWVRRd0xUZzFaV1V0Tm1JNE5HSmhNamxsTXpWaVhHMXpaM05jYlhO?=
 =?utf-8?B?bkxXRXdaREV3TldVMExUSTRaVFl0TVRGbE9DMDVaREF5TFdKalpUZGpZekJp?=
 =?utf-8?B?TlRBMU4xeGhiV1V0ZEdWemRGeGhNR1F4TURWbE5TMHlPR1UyTFRFeFpUZ3RP?=
 =?utf-8?B?V1F3TWkxaVkyVTNZMk13WWpVd05UZGliMlI1TG5SNGRDSWdjM285SWpFek5q?=
 =?utf-8?B?QXhJaUIwUFNJeE16RTJOVFkxTmpjMk5UUTJOVFF6TkRRaUlHZzlJblpEVEV4?=
 =?utf-8?B?a1VXZG1WR1Y0WTFjMk5tNXVkbnB0WWtwYWNHMUdNRDBpSUdsa1BTSWlJR0pz?=
 =?utf-8?B?UFNJd0lpQmliejBpTVNJZ1kyazlJbU5CUVVGQlJWSklWVEZTVTFKVlJrNURa?=
 =?utf-8?B?MVZCUVV0M1FrRkJRMGxKVjJScU9EZDZWRUZTUTJseU1EQmtVV2R4ZUVWTFMz?=
 =?utf-8?B?WlVVakZEUTNKRlEwRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?SVFVRkJRVUU0UVZGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZG?=
 =?utf-8?B?UVVGUlFVSkJRVUZCWWk5VWRFUlJRVUZCUVVGQlFVRkJRVUZCUVVGQlNqUkJR?=
 =?utf-8?B?VUZDYUVGSFVVRmhVVUptUVVoTlFWcFJRbXBCU0ZWQlkyZENiRUZHT0VGalFV?=
 =?utf-8?B?SjVRVWM0UVdGblFteEJSMDFCWkVGQ2VrRkdPRUZrUVVKd1FVZFZRV05uUVho?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVVZCUVVGQlFVRkJRVUZCWjBG?=
 =?utf-8?B?QlFVRkJRVzVuUVVGQlIwVkJXa0ZDY0VGR09FRmpkMEpzUVVkTlFXUlJRbmxC?=
 =?utf-8?B?UjFWQldIZENkMEZJU1VGaWQwSnhRVWRWUVZsM1FqQkJTRTFCV0hkQ01FRkhh?=
 =?utf-8?B?MEZhVVVKNVFVUkpRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGUlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlEwRkJRVUZCUVVFOUlpOCtQQzl0WlhSaFBnPT0=?=
x-originating-ip: [10.99.30.215]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(376002)(346002)(39860400002)(2980300002)(438002)(189003)(199004)(13464003)(2906002)(7636002)(50466002)(229853002)(478600001)(2486003)(23676004)(72206003)(53546011)(33656002)(5250100002)(76176011)(7696005)(59450400001)(110136005)(2900100001)(2920100001)(966005)(106002)(39060400002)(8676002)(6246003)(246002)(14454004)(426003)(575784001)(8936002)(86362001)(6306002)(106466001)(26005)(102836004)(316002)(55016002)(186003)(5660300001)(47776003)(436003)(6116002)(55846006)(356003)(7416002)(3846002)(336012)(305945005)(2950100002)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2611;H:nwd2mta4.analog.com;FPR:;SPF:Pass;PTR:nwd2mail11.analog.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC016;1:6ZIWs57mLU6WKPoPzqOPywAAAXMI9HgiqTu2S/Z/6mAcQweJ6FVa8FPaywiSZXoXr4Qz4WGi7hGLH4ffUlNUcGpIZOmRh8or/0P7yHd5EFAuXapZ4VrLBTDRD0+qMItB
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 487116da-d98a-49ee-e9b2-08d58b0a89e7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2611;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2611;3:eBwBVCvO4JknGKK7deJoz2OUBzMOvVkwn1Ro9R/jolKN1JbE4vf5z/BxJ2NdBA6dysyQNW8NyKZt41abPaw6+6bi9TxKuYT0swEuA5rYQjSbR39y9aDsmTP4DrGimro2WwGEBCvoUxvk59XFVlREabM6Bj+fk/KhRWxNSdM/5Q2J7qG4d6upgw2yqVdbq5eDR5uLWZdMgsksAFRLJU/OvFLgXePW7ybx7guqW+F7lWOJ6iUdMiOnt/XDcNMqeVNv/sBkqTwEs/kKj/tdZuGNXBeOiMqprrOE3X+MFRoYB3nauuG8dshPygAo+N91Nheq52rikAgw3XXlmadckO1aLA==;25:muZI/lIpZeaMm5SHkP4WMMZUYQ7DU/nnbltnqlV/XbPNxg0g7HRnBtMCl6Zwz/EZilUK0vbEMF5KP8+zONmMwYtroi8XaofJuLsl7AhMNSXLyaFSp8nFq4f13i+CtpWr9dG7Dx3TKGtt5NDJP7v1b9ppcK1HWTQCLHoGjxq+UwN2NhuMQ6gVK9Ry6Bba2W3bHjZXM0i0HqlwTtNg4CchjcKdQtT/QVvfX+hGWmyf1e9JJ4ScubXsA+a78NY8LMsZzfNzmRdTkLsDbZwSx3jbGY/8g1Yeafglz6ObsCYfxYWjf+tWxhhFCLVHIED07Nj78dLUJlbX0U7e39YNEw8zpA==;31:GQxyoa1HLMzXgArZPEjpxD0oBuJG8xQmm2l5/6fAYAEG2mtHr25oQ8QmcOdH8IaMUYgb2ibG1jwE3PoaEZQrnXVlExg7fg9wG3q1dW75WpC+ki2tfBnUXP0CUW5jAc1naUnstCC9TiTuCOkmTHWpnqSuJddbuVlkpiWqICCqPq0WJZIY2Ngb+nxDwnRhIVFKFf56uW8Q58mRURGncY048r3I7THDyn80XNx+cZ6wmNM=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2611:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2611;20:v6r7/fkc9cUExTCg3JsyMNIvzKWrLwZyBVQ9TbeyGDnjVeVNgG7szUuroYAW5AnEHfQwGwLnGfcqcMyg4dwWiqTStxTE+Gbdh7pIU08obNBFEo6xqg0QnT6DtwVnxHKxEQQaRJMBTWVnvDgderbw3LL9ZwglxkAif0AOt4t8pLfEVJiNomlFkoCl/bQJ0eBHWk1Al/wSqhYWg6Dx8gwcDKdFw2mknCdQHpqz2Vxbb+PSrwSAw6lYw2R1MAI6fLrzSC9cnoclU4VNQBMaRjt28Xj2Q0/dPwtxBKtx+sLbdjO0g0RCDm6BxTtOI9cbDK2+nQ3e8usEr1o7uUwOi32YB6tNoWfOwuiD5TNgV3OMg8qQQmsbHqvxpMmcZ9wBAghrZECJa9206dQn6uurkuSGRv/EcGAdwOvsjkUoHqmoDQSXsqTumAy7i028UaaLL7jWMCEfPRKH99syhVg69B7/r4/nVQB6dlgglpJp96H+k6P/ji1ZIx0mHpN7i3AX5mMJ;4:sXPFpajLhcnm/HaI5M275voXU8O6HE9cdCPr4JabS+XTuEjlpl7XPusP9I02XpiKWIFsr4B6lKXBhktQBjDM46pfLmDCD4JEmDPW0jXL4Brslw/p9hl6OLKTlfGjZvBQpw8cn102QzjWY9uwdfxKLk8fXQE8W2zkLpPXahna5uIlEt0qfbx84lnw/idt0NKfaxmTRfzzFUjl0PUSp+8BzkwaM9y7k/dAEjrj0A0K1/tet42w36iOBTSkdwul/Wvtx4Jh/3jM8EpKsf8Q07qb13kuGd8/8ifuaTF27m+R7RxvXIQKuWUIYl+0rirn9dlVQIgDebC4CnMfUbg6N2mnnfBglWOrV9SwWdfobZFPiElt4fVrY9KeX6/T01NvkTJMznz4aB2h1oj02oX3ky0u0rPuYWTZdoNCALc+mCv9AlI=
X-Microsoft-Antispam-PRVS: <BN6PR03MB2611D04E7FDA9A782A2B20A1E0D70@BN6PR03MB2611.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(253656608321460)(9452136761055)(232431446821674)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR03MB2611;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2611;
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAzTUIyNjExOzIzOnY1bWMyRVA1dzZ1OXZLNk9Ob0Frd21QK3Jl?=
 =?utf-8?B?ZTdSNElVQklnVmhyb0wxYlRLcENQR09qSXNjaWc2dGM5UUxFMjZGdUhVTzhI?=
 =?utf-8?B?R1lxdnJqeEJpQ1drcXQ5WkNVL1JaYmM0cjRxOHJ2Nk94aTZZSWg4TXZvVTVo?=
 =?utf-8?B?SHlwWTdKRFVWbFlVY2VDaUJWbERyS3JxbGFJb0FDZFpKQUk2S01XdEpIYlNJ?=
 =?utf-8?B?blE0bVdIbEE0SnV2QzJQaVRyUUdvaGNwdy81bnpVcHQ2YWVaTExMNVlDNjJY?=
 =?utf-8?B?bEJmNGsvVWREZnh3Y0FMM3ZzWnFQdkxpazhwRkR1Q1l3WmxlVlZLS3E1SHBF?=
 =?utf-8?B?MkxLOUZ2QmhQNGpSbEhmUEMzUjFQdzlESGg5dmM5bXFCNUVGOTIvRlJjTU0w?=
 =?utf-8?B?aldQZmcycnRVWHd6WGFXVmticUVPdG9BbzR6b1g4YktYeHJ2dTZEOUV2V1ZJ?=
 =?utf-8?B?Sm5sWGFzQk9hVEc0YVcxNnVlamFscmhkSW9jQWJFN2ZrRGhtOFpUOFpkSTNR?=
 =?utf-8?B?bnlUTDFmMkc5cjBjQmwwWjV1N0ovT3NJU3FqdjUvTzlIZGxMSW5OcHJiS0Q0?=
 =?utf-8?B?MUduWlVweVYxVDNXUk0yWm5WV0tSc0NDTW1uNGc4T3RQUGlWUTE4cWxkVzZq?=
 =?utf-8?B?dlM2UzlodlFhSVgyVm1YMlhJT3oxMDVVaHdKcUk1RnZ6NU9wRUFyZDhON0VR?=
 =?utf-8?B?TGZ4YXI0bklMczBZWkplRzFNYlE0Y0xqVnhIUE0wSkl0UTdTUzNBdFI5ZVJV?=
 =?utf-8?B?enJucGJRdXEvSEFjdHdUSjdUdGFYQVA0Mjd6TWxIdGVFYXRmOENZZHF4UzBD?=
 =?utf-8?B?cGR0MGp5NUdvQ2RVUVQvbFIxK3R3VEdFMUQvemtpU1VPZlg4T0JLVWt6b3Fx?=
 =?utf-8?B?UEh5c244Q3F0N2RCd1NqV0sveWUxanZLNDNnc2dIeTdHWmVKaFZxem5ZOHpK?=
 =?utf-8?B?b2xkT00xYmNHVDNVK3JlczlPT3JCQ2dxK2lERHIxZFlqR3c1YVNaWUNaNlhE?=
 =?utf-8?B?Mk5CaDBoT0tzUTdpUi9YUWJBamdrb05IQ1Rpbm1xdjV5MVgxaUFtVWlkbUNC?=
 =?utf-8?B?ODZqa3RRVjVmSHhuNGF6b2psTXZkQ1RXOXlYVDdkeEg1WU9iZGxSYXNUSW9i?=
 =?utf-8?B?WTZJaHFVb0Q4Q0R4R1piaHc5ck52anZ4SGJrQUlsekRlMm02SWFJdElEUkRI?=
 =?utf-8?B?NlExdFNkZDlTSDQwZGs2ZWU1WWlFakVjVUJ4eG1NN1NDNmpSNTdDTjlQNGhy?=
 =?utf-8?B?OVJMSlp3Q3hrS2xCVG5OWnloTnhKV2dWd3lGYTNQSzhwQnBGV2p0WjdxTGtN?=
 =?utf-8?B?QXRJb21mMWIzMEw1QXZsWFYwekRtT3RNVElZS3dYSjRoZ1RTZXllaGkxZnN2?=
 =?utf-8?B?N0VXMTR4bnNPdVkyWVRmdXU0ci95RUE3MjFwMEtHSGYveGJSNHR0Z3JVcnFO?=
 =?utf-8?B?NmIzUnFNckJDZXFDZDVqaGlrZDBHbko4M08vcUluOU1XRk5WQ0gxNWZHTU1P?=
 =?utf-8?B?aG1FOStDeDJ2UVBrZ3EvS1lpWHcvZDNFQkw1S1B6dTNWZ01JQTl5Q0NvVTV4?=
 =?utf-8?B?eHl4VkVsakFTSEdoS1k0SUNYNFVvWmErSjB4ckJQNUJxcTA5QWU1ZGdSeGQv?=
 =?utf-8?B?ZUx4cjVZVGlYL1BPeXgrYkdqeWNTTlpEVHRERnRVL2ZWaE1Sb0ZDRUhacHM3?=
 =?utf-8?B?SnVmSlQ4VlU4dCthNjB4ZDFKV0xDQnAzUWduTzM3VE5xSWgwemRkd0M1VzRu?=
 =?utf-8?Q?/BKnrEtgDaBHo3c20O2YDO1U91JSQalpu7Eec=3D?=
X-Microsoft-Antispam-Message-Info: dHCc9DMgtAH8JRsYThNXHztSw3iuFoT++23z4U9EELEm1O5Ooz7tpndQALgXTlJkKl+gNaX9T5HvTJcdgP/q1WH9SnyJYtrNqs79tXTkpP3z3sY+1AA9d0RCfZLl74lgXZB5b3F8sOd1Y8cKrvg342V3Dm6Hy+PCkRWCRU5plFbXXxIzauDJYZUOBaN1DpWp
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2611;6:INTJVdxsAEezOLRWx5W1A8yAJQDwXR7WJyVXiqN42nlqREsBfxKkn6yAdExceIL5drH4IplNQfXPcx7mytJ8p1FUWFDqM3q+k52+3Tv/zYPFBWNR7LypcMMS7NXNNYS2+fFaHKWQ8BPThcvTN6a8uHLd75YljBojPcvtpdmLSltim5d6uFqlH+zPbQFAR6+XTEXdFnHI7aTjVNSjmcc3Ds3EEpg0BpjeeG3X4ZPSaDylyHgZpCI6/1pFb8UppJCI96NUEHXFyZuW/eBGCHbQ3gf6cs/f8hbkhOmsjdjih1nY/QVUqJx/c/VOfMdDiO9TxYm9NwbgKboN4cyxcdT+nS48+4VNbuVixbfPwxeMsNk=;5:K59ORpWBkP5LfaTnz3SZqaPIzw5vlzr4nwdULsC8j6S7PfAI/It7U/mMChk6c6yaYWr2v+Y0DzKNxGa5Q+eBs/YK1OJc3wG9ah4JpvVu9IYNUaF+10i8Ppr9LRhJpULhk7KrlnWR3BSBVAvjofGYFSHJOy6fGPHTHykWFaWywIA=;24:uxLLy8yfqnH6+ynFQ8rtsynapwGZA4yNGA1YfqMNsbI+kk5kQ26wcRQeIsQugMaWQiZaAT4EKvsmTIz0lw+1ZaYGAIJmnpEGknreGTRN7wo=;7:2Fqyq0obhJEdpZmSWuuKmjzO8SIRaWTSrCQCyTRV1nYTDMnRFKy1Cs1MsjNmMlzYEvFpE6GmM3i1PChO0q4NlHspyN+AuMrBmxwiQyKzeoPLl8t/8xH3bntX8lEnTDiy0AvOXQ9LySkDqeHvKOXzYnZ1FjG6egki9spTUKVzaN6a5B9JU0OLx5uLMUrhQODc1WV9BydRP3OBXi0P4dWVlDuk7bsBcLrRhXnQijsG8vBgzG4teKDQrTqdy5eQTEqe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 06:52:51.9596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 487116da-d98a-49ee-e9b2-08d58b0a89e7
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2611
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2G6r5au024037



> -----Original Message-----
> From: arndbergmann@gmail.com [mailto:arndbergmann@gmail.com] On
> Behalf Of Arnd Bergmann
> Sent: 2018年3月15日 22:46
> To: Arnd Bergmann <arnd@arndb.de>; linux-arch <linux-arch@vger.kernel.org>;
> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Lennox Wu
> <lennox.wu@gmail.com>; Guenter Roeck <linux@roeck-us.net>; Al Viro
> <viro@zeniv.linux.org.uk>; Jonas Bonn <jonas@southpole.se>; Stefan
> Kristiansson <stefan.kristiansson@saunalahti.fi>; Stafford Horne
> <shorne@gmail.com>; David Howells <dhowells@redhat.com>; Peter Zijlstra
> <peterz@infradead.org>; Wu, Aaron <Aaron.Wu@analog.com>
> Subject: Re: [Blackfin removal] [PATCH 01/28] Blackfin arch: Remove Blackfin
> CPU arch general support
> 
> > Signed-off-by: Aaron Wu <aaron.wu@analog.com>
> >
> > Remove Blackfin CPU arch general support
> 
> Hi Aaron,
> 
> thanks a lot for your series. As you know, I've had almost the same patches in
> my tree already, but now I've cross-checked the two versions, and found small
> omissions or bugs in both. I ended up staying with my version, as that was
> already reviewed by a number of people, and it had the conflicts with the other
> arch removal resolved, but I've folded in everything that your version had that I
> was missing, see below for the diff between my original version and the new
> one.
> 
> I've also added an 'Acked-by: Aaron Wu <aaron.wu@analog.com>'
> to each patch that we both had.
> 
> I hope that all works for you.
> 
>        Arnd
>
 
Hi Arnd,

Sure, this works perfect for me. May patches  are there as additional reference,
exactly what we discussed earlier. Thanks very much for help handing/merging this.

By the way, the patches email get bounced from vger, I may give it another try on
reset of them except this arch one so more people can help to review/comment
rest of them, mostly drivers. 

Best Regards,
Aaron
   
> ---
>  Documentation/driver-api/usb/writing_musb_glue_layer.rst |    3
>  drivers/misc/echo/echo.c                                 |   73 ------------
>  drivers/misc/echo/fir.h                                  |   50 --------
>  drivers/usb/gadget/function/f_uac1_legacy.c              |    2
>  drivers/usb/gadget/function/u_uac1_legacy.c              |    2
>  drivers/usb/gadget/function/u_uac1_legacy.h              |    2
>  drivers/usb/gadget/legacy/audio.c                        |    2
>  drivers/usb/host/isp1362.h                               |    4
>  drivers/usb/musb/musb_core.c                             |    2
>  drivers/usb/musb/musb_core.h                             |   13 --
>  include/linux/cpuhotplug.h                               |    1
>  include/linux/fb.h                                       |    3
>  14 files changed, 3 insertions(+), 248 deletions(-)
> 
> diff --git a/drivers/misc/echo/echo.c b/drivers/misc/echo/echo.c index
> 9597e9523cac..8a5adc0d2e88 100644
> --- a/drivers/misc/echo/echo.c
> +++ b/drivers/misc/echo/echo.c
> @@ -115,78 +115,6 @@
> 
>  /* adapting coeffs using the traditional stochastic descent (N)LMS algorithm */
> 
> -#ifdef __bfin__
> -static inline void lms_adapt_bg(struct oslec_state *ec, int clean, int shift) -{
> - int i;
> - int offset1;
> - int offset2;
> - int factor;
> - int exp;
> - int16_t *phist;
> - int n;
> -
> - if (shift > 0)
> - factor = clean << shift;
> - else
> - factor = clean >> -shift;
> -
> - /* Update the FIR taps */
> -
> - offset2 = ec->curr_pos;
> - offset1 = ec->taps - offset2;
> - phist = &ec->fir_state_bg.history[offset2];
> -
> - /* st: and en: help us locate the assembler in echo.s */
> -
> - /* asm("st:"); */
> - n = ec->taps;
> - for (i = 0; i < n; i++) {
> - exp = *phist++ * factor;
> - ec->fir_taps16[1][i] += (int16_t) ((exp + (1 << 14)) >> 15);
> - }
> - /* asm("en:"); */
> -
> - /* Note the asm for the inner loop above generated by Blackfin gcc
> -    4.1.1 is pretty good (note even parallel instructions used):
> -
> -    R0 = W [P0++] (X);
> -    R0 *= R2;
> -    R0 = R0 + R3 (NS) ||
> -    R1 = W [P1] (X) ||
> -    nop;
> -    R0 >>>= 15;
> -    R0 = R0 + R1;
> -    W [P1++] = R0;
> -
> -    A block based update algorithm would be much faster but the
> -    above can't be improved on much.  Every instruction saved in
> -    the loop above is 2 MIPs/ch!  The for loop above is where the
> -    Blackfin spends most of it's time - about 17 MIPs/ch measured
> -    with speedtest.c with 256 taps (32ms).  Write-back and
> -    Write-through cache gave about the same performance.
> - */
> -}
> -
> -/*
> -   IDEAS for further optimisation of lms_adapt_bg():
> -
> -   1/ The rounding is quite costly.  Could we keep as 32 bit coeffs
> -   then make filter pluck the MS 16-bits of the coeffs when filtering?
> -   However this would lower potential optimisation of filter, as I
> -   think the dual-MAC architecture requires packed 16 bit coeffs.
> -
> -   2/ Block based update would be more efficient, as per comments above,
> -   could use dual MAC architecture.
> -
> -   3/ Look for same sample Blackfin LMS code, see if we can get dual-MAC
> -   packing.
> -
> -   4/ Execute the whole e/c in a block of say 20ms rather than sample
> -   by sample.  Processing a few samples every ms is inefficient.
> -*/
> -
> -#else
>  static inline void lms_adapt_bg(struct oslec_state *ec, int clean, int shift)  {
>   int i;
> @@ -215,7 +143,6 @@ static inline void lms_adapt_bg(struct oslec_state *ec,
> int clean, int shift)
>   ec->fir_taps16[1][i] += (int16_t) ((exp + (1 << 14)) >> 15);
>   }
>  }
> -#endif
> 
>  static inline int top_bit(unsigned int bits)  { diff --git a/drivers/misc/echo/fir.h
> b/drivers/misc/echo/fir.h index 7b9fabf1fea5..4e0f365f0577 100644
> --- a/drivers/misc/echo/fir.h
> +++ b/drivers/misc/echo/fir.h
> @@ -27,14 +27,6 @@
>  #define _FIR_H_
> 
>  /*
> -   Blackfin NOTES & IDEAS:
> -
> -   A simple dot product function is used to implement the filter.
> This performs
> -   just one MAC/cycle which is inefficient but was easy to implement as a first
> -   pass.  The current Blackfin code also uses an unrolled form of the filter
> -   history to avoid 0 length hardware loop issues.  This is wasteful of
> -   memory.
> -
>     Ideas for improvement:
> 
>     1/ Rewrite filter for dual MAC inner loop.  The issue here is handling @@ -
> 94,21 +86,13 @@ static inline const int16_t *fir16_create(struct fir16_state_t
> *fir,
>   fir->taps = taps;
>   fir->curr_pos = taps - 1;
>   fir->coeffs = coeffs;
> -#if defined(__bfin__)
> - fir->history = kcalloc(2 * taps, sizeof(int16_t), GFP_KERNEL); -#else
>   fir->history = kcalloc(taps, sizeof(int16_t), GFP_KERNEL); -#endif
>   return fir->history;
>  }
> 
>  static inline void fir16_flush(struct fir16_state_t *fir)  { -#if defined(__bfin__)
> - memset(fir->history, 0, 2 * fir->taps * sizeof(int16_t)); -#else
>   memset(fir->history, 0, fir->taps * sizeof(int16_t)); -#endif  }
> 
>  static inline void fir16_free(struct fir16_state_t *fir) @@ -116,42 +100,9 @@
> static inline void fir16_free(struct fir16_state_t *fir)
>   kfree(fir->history);
>  }
> 
> -#ifdef __bfin__
> -static inline int32_t dot_asm(short *x, short *y, int len) -{
> - int dot;
> -
> - len--;
> -
> - __asm__("I0 = %1;\n\t"
> - "I1 = %2;\n\t"
> - "A0 = 0;\n\t"
> - "R0.L = W[I0++] || R1.L = W[I1++];\n\t"
> - "LOOP dot%= LC0 = %3;\n\t"
> - "LOOP_BEGIN dot%=;\n\t"
> - "A0 += R0.L * R1.L (IS) || R0.L = W[I0++] || R1.L = W[I1++];\n\t"
> - "LOOP_END dot%=;\n\t"
> - "A0 += R0.L*R1.L (IS);\n\t"
> - "R0 = A0;\n\t"
> - "%0 = R0;\n\t"
> - : "=&d"(dot)
> - : "a"(x), "a"(y), "a"(len)
> - : "I0", "I1", "A1", "A0", "R0", "R1"
> - );
> -
> - return dot;
> -}
> -#endif
> -
>  static inline int16_t fir16(struct fir16_state_t *fir, int16_t sample)  {
>   int32_t y;
> -#if defined(__bfin__)
> - fir->history[fir->curr_pos] = sample;
> - fir->history[fir->curr_pos + fir->taps] = sample;
> - y = dot_asm((int16_t *) fir->coeffs, &fir->history[fir->curr_pos],
> -     fir->taps);
> -#else
>   int i;
>   int offset1;
>   int offset2;
> @@ -165,7 +116,6 @@ static inline int16_t fir16(struct fir16_state_t *fir,
> int16_t sample)
>   y += fir->coeffs[i] * fir->history[i - offset1];
>   for (; i >= 0; i--)
>   y += fir->coeffs[i] * fir->history[i + offset2]; -#endif
>   if (fir->curr_pos <= 0)
>   fir->curr_pos = fir->taps;
>   fir->curr_pos--;
> diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c
> b/drivers/usb/gadget/function/f_uac1_legacy.c
> index 04f4b2862256..24c086bcdeaa 100644
> --- a/drivers/usb/gadget/function/f_uac1_legacy.c
> +++ b/drivers/usb/gadget/function/f_uac1_legacy.c
> @@ -4,8 +4,6 @@
>    *
>   * Copyright (C) 2008 Bryan Wu <cooloney@kernel.org>
>   * Copyright (C) 2008 Analog Devices, Inc
> - *
> - * Enter bugs at http://blackfin.uclinux.org/
>   */
> 
>  #include <linux/slab.h>
> diff --git a/drivers/usb/gadget/function/u_uac1_legacy.c
> b/drivers/usb/gadget/function/u_uac1_legacy.c
> index cbc868d117af..5393e5c37a4b 100644
> --- a/drivers/usb/gadget/function/u_uac1_legacy.c
> +++ b/drivers/usb/gadget/function/u_uac1_legacy.c
> @@ -4,8 +4,6 @@
>   *
>   * Copyright (C) 2008 Bryan Wu <cooloney@kernel.org>
>   * Copyright (C) 2008 Analog Devices, Inc
> - *
> - * Enter bugs at http://blackfin.uclinux.org/
>   */
> 
>  #include <linux/kernel.h>
> diff --git a/drivers/usb/gadget/function/u_uac1_legacy.h
> b/drivers/usb/gadget/function/u_uac1_legacy.h
> index dd69e408a3d9..5c1bdf46fe32 100644
> --- a/drivers/usb/gadget/function/u_uac1_legacy.h
> +++ b/drivers/usb/gadget/function/u_uac1_legacy.h
> @@ -4,8 +4,6 @@
>   *
>   * Copyright (C) 2008 Bryan Wu <cooloney@kernel.org>
>   * Copyright (C) 2008 Analog Devices, Inc
> - *
> - * Enter bugs at http://blackfin.uclinux.org/
>   */
> 
>  #ifndef __U_UAC1_LEGACY_H
> diff --git a/drivers/usb/gadget/legacy/audio.c
> b/drivers/usb/gadget/legacy/audio.c
> index 7b11dce98b94..dd81fd538cb8 100644
> --- a/drivers/usb/gadget/legacy/audio.c
> +++ b/drivers/usb/gadget/legacy/audio.c
> @@ -4,8 +4,6 @@
>   *
>   * Copyright (C) 2008 Bryan Wu <cooloney@kernel.org>
>   * Copyright (C) 2008 Analog Devices, Inc
> - *
> - * Enter bugs at http://blackfin.uclinux.org/
>   */
> 
>  /* #define VERBOSE_DEBUG */
> diff --git a/drivers/usb/host/isp1362.h b/drivers/usb/host/isp1362.h index
> 87c1ac97e538..650240846ee2 100644
> --- a/drivers/usb/host/isp1362.h
> +++ b/drivers/usb/host/isp1362.h
> @@ -6,9 +6,7 @@
>   */
> 
>  /* ------------------------------------------------------------------------- */
> -/*
> - * Platform specific compile time options
> - */
> +
>  #define MAX_ROOT_PORTS 2
> 
>  #define USE_32BIT 0
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 011c8ca7de42..13486588e561 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2166,7 +2166,7 @@ musb_init_controller(struct device *dev, int nIrq, void
> __iomem *ctrl)
>   *   - initializes musb->xceiv, usually by otg_get_phy()
>   *   - stops powering VBUS
>   *
> - * There are various transceiver configurations.  Blackfin,
> + * There are various transceiver configurations.
>   * DaVinci, TUSB60x0, and others integrate them.  OMAP3 uses
>   * external/discrete ones in various flavors (twl4030 family,
>   * isp1504, non-OTG, etc) mostly hooking up through ULPI.
> diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
> index ac675b1a34c4..8a74cb2907f8 100644
> --- a/drivers/usb/musb/musb_core.h
> +++ b/drivers/usb/musb/musb_core.h
> @@ -414,19 +414,6 @@ struct musb {
>   struct usb_gadget_driver *gadget_driver; /* its driver */
>   struct usb_hcd *hcd; /* the usb hcd */
> 
> - /*
> - * FIXME: Remove this flag.
> - *
> - * This is only added to allow Blackfin to work
> - * with current driver. For some unknown reason
> - * Blackfin doesn't work with double buffering
> - * and that's enabled by default.
> - *
> - * We added this flag to forcefully disable double
> - * buffering until we get it working.
> - */
> - unsigned                double_buffer_not_ok:1;
> -
>   const struct musb_hdrc_config *config;
> 
>   int xceiv_old_state;
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h index
> 5b211fe295f0..8796ba387152 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -29,7 +29,6 @@ enum cpuhp_state {
>   CPUHP_PERF_PREPARE,
>   CPUHP_PERF_X86_PREPARE,
>   CPUHP_PERF_X86_AMD_UNCORE_PREP,
> - CPUHP_PERF_BFIN,
>   CPUHP_PERF_POWER,
>   CPUHP_PERF_SUPERH,
>   CPUHP_X86_HPET_DEAD,
> diff --git a/include/linux/fb.h b/include/linux/fb.h index
> f577d3c89618..0c20da7ab35f 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -571,8 +571,7 @@ static inline struct apertures_struct
> *alloc_apertures(unsigned int max_num) {
> 
>  #elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) || \
>   defined(__hppa__) || defined(__sh__) || defined(__powerpc__) || \
> - defined(__avr32__) || defined(__bfin__) || defined(__arm__) || \
> - defined(__aarch64__)
> + defined(__avr32__) || defined(__arm__) || defined(__aarch64__)
> 
>  #define fb_readb __raw_readb
>  #define fb_readw __raw_readw

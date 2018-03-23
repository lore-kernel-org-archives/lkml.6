Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeCWO6y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:58:54 -0400
Received: from mail-bl2nam02on0044.outbound.protection.outlook.com ([104.47.38.44]:36552
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751531AbeCWO6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:58:50 -0400
Authentication-Results: spf=none (sender IP is 129.98.127.170)
 smtp.mailfrom=einstein.yu.edu; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=einstein.yu.edu;
From: Maurice R Volaski <maurice.volaski@einstein.yu.edu>
To: Willy Tarreau <w@1wt.eu>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Did kernel 3.11 never work?
Thread-Topic: Did kernel 3.11 never work?
Thread-Index: AQHTwrRxo/jE6/QgLkSKKNwiuRVesaPeK1QA//++JQA=
Date: Fri, 23 Mar 2018 14:58:46 +0000
Message-ID: <8BF385DA-7EB8-446D-9005-64509D7C7CB8@einstein.yu.edu>
References: <E513F076-24D5-4F67-A204-D2E6E1135FDE@einstein.yu.edu>
 <20180323145428.GF15012@1wt.eu>
In-Reply-To: <20180323145428.GF15012@1wt.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.c.0.180314
x-originating-ip: [10.49.98.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCBAFC174124634885967B0BBC3D4A3E@yuad.uds.yu.edu>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:129.98.127.170;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(376002)(346002)(2980300002)(428003)(189003)(13464003)(199004)(229853002)(50466002)(4326008)(436003)(336012)(26005)(186003)(102836004)(6916009)(2906002)(478600001)(76176011)(23676004)(2486003)(316002)(786003)(82746002)(58126008)(11346002)(966005)(6306002)(83716003)(47776003)(446003)(88552002)(105586002)(356003)(5660300001)(86362001)(8936002)(109096001)(53546011)(75432002)(6116002)(7736002)(106466001)(33656002)(2900100001)(3846002)(6246003)(305945005)(246002)(8676002)(781001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR0401MB0995;H:smtp.einstein.yu.edu;FPR:;SPF:None;PTR:aewexcph01.yuad.uds.yu.edu;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT062;1:S1wzsoy8fMKSqqxRenpb+MvUWlRmZT4f1IuL1Nm5VUo/w0TrCgp9+eGhrfOG/ryOAchoR2QeGfqlXXNlXyjSNdniXvpdPIluXSCYVBKvlVhK+Pg17nx5dodcDE1HQ/ic
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33c6cea4-2970-4e60-6afa-08d590ce9515
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN1PR0401MB0995;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0401MB0995;3:KHAK/4GWWGhx0P0ZyBBU7yOofjnRBSaHiLj8JGV2hOrAOOgXx0EPzLkj5O1wEGEPgVb1CdpZdpdXaW8Tw1eGjYposWpTRFawHUfvAC3NA1hRpjXKbgAmzVbniW3LFFkKJRw6R8aw0LTy0rgBVQq267YruHZSaGIT1ZYJAMOjuUM5DUD36zJ2IkO8UrtN56Wi1bnedu22xM2FG6WDFxc3g2gLSCYCs7mdI1PINuS4f4pgfuZYw5WxsNna+0YaCC72wn3nMn8uMvc3+K5F8dDj9DFlT5+u0TM+k3qy3uXKy89dTvQsM8SI3zNjTmNMRQk9txR0BjU2LdqDhPPNJHM9YBvGTMxeHiWPHMdpow5madU=;25:gc2r1m1bkLcbNFeKSFrsVOqa1Dtt9Uq6zXoN9MQ4Ps/GpdxQ0NhOrRiwhCMdo9BaWCjevh2FQTdiiFYdp+K+Vvr1qt4V9KMYECovHYL2+fboEb07P5ulU8POwLCoRV9KmWkRhHQZcDg42Q1qSmo5WAZrmUUYaGwHb9XgsDIsvYtvYFHAfRW1mPe+RmFhteoOdn5aQ78V55K562CsyywqyP3+rCTFDrOaZQ6akSixYq2URx7QjdJCsPUIWNWONGC9cAVR/erFNUk2aSa0dUXqu0Y9lt+n484s4CRHE5yf50tKneERrYguBgQip/byvv84MxgoaqYYWO2ypO0wveCr7w==
X-MS-TrafficTypeDiagnostic: BN1PR0401MB0995:
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0401MB0995;31:4xndoPwSTAzxvTpHCZdWh9aSTJ0w+vU4633hxHYn+sJaPlC2A8IqHCp9P3n4RpjIbgBFZ75zU4Go19hcigU6ntcozE3+VYTPA+DXHzONoyEcTBzMe3faKKVODMc5Xg8/BgSu1GYvp1ocE+qbenmChKBliqVm4RKkb0MyTgglkH7RTygnWmPm6S9oTHZ52hJVm3igPBdJ14FUuVxhC9rILsZZqMDyw4PgRR7E2btEm5s=;20:xfhxhJeXM5/If4SCK83lxtuIMJ8O5UcPVfAOVZ+v6XO+86a/5j2QgAz8wQh0RfHHi+j/RRG2YFe+osy8YJ6y5BWpM7SloLkToq5qV8AyNhMaR0frXl43fl236NDRWMDrOsjQzBbqItyAlXnngMz9kqSV/9Xc8cNCVxONs20md5/fTn24WZUMiLKTeYYI5PXkA3M1SccoekHnQ2yalNbuklC4SYa03F7cebg2cDuUImd6vV4O7z4Xgt4h9NOSTrAwuvVi5rg6NzofhAj/WNAG8S6j4Ba6DrFExWiwl5D0IDjWLJ3LDe3bRG14xtAUuUc0bcBPYq71DozhrBnAFTAvCcUYVddDxwgvi5MwsgbARUQBHaubtwy6XoTDxDboDwqoY6l8fbjRGJVN3IfZYEufO+mLdH/AlxN2T5QIxc+SrzdbEdqVT1sINTh7mACU3F/iSt/g6f6HfA5+esLJeKU28ngp4zJWDaXiFQOV6uEAVlVzrecVavs7DqxOTI8cHD6P
X-Microsoft-Antispam-PRVS: <BN1PR0401MB0995CB5BECC9FF9A2ED0D791AAA80@BN1PR0401MB0995.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(150496076066914)(5447422754597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93003095)(3231221)(944501327)(52105095)(6041310)(20161123562045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BN1PR0401MB0995;BCL:0;PCL:0;RULEID:;SRVR:BN1PR0401MB0995;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0401MB0995;4:PWCLtQsYPcTcH4mV1JNEMXPF2NIO77mAFwy3PHFWCYmw5wgH6Ru7bvgSwHm+c8w6dqv1OECUiEoBj+M9aLFjaH3FxL9gVeQ2Zo4o9Njgcq0ssf/lqMmGGaEGhAy8G8WI397XfzVRQaUL9ID76kV9ErH4i/DLViUe4PRM9jo4EWeW5yz7eEkDlR+Pden+KmAHktKbEpVVlqBZL4/KL5h5iUq5/SKH/CYLarozjBFZwlolT6MMAkmi6hiDIxi7GPeHaex0/GuvGEP2iiH349Y4cp4hD3hhKAi5kCv18YhoE7ZiOUl6An6I2pjwet3LQxPB1CzGpO3PXBd6p2oJz8KtYuWtRga1JCjys4ML7CyAqOBFbNV/EK8Cx1lPr6aVsg9w
X-Forefront-PRVS: 0620CADDF3
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjFQUjA0MDFNQjA5OTU7MjM6VFVvR2Urd0Z6NjZCTkVzZjBKQTNkakRS?=
 =?utf-8?B?Q2tNZHhEcXY3NzdCYXJobk92N3c1WU4wUFZZV0xiQ01CV29KVk1qMnFWb08z?=
 =?utf-8?B?VWY0bm8wM2tRR0NZNnJsOGs0QVdJdFM5b3R5dUFBcElYYmM3cjFVd2I4amhQ?=
 =?utf-8?B?WlBxUXJlU3RPVkg5Qi9EdUxkaTcwTDlXT20zNnlHSUJkL2g0cnY2Q0p0dk5h?=
 =?utf-8?B?N3QzcUI4T1FTWlVleURoNzdKZUhWNGMyeGFERU40bmRxcVlNTmNPR2xxVFR3?=
 =?utf-8?B?ckM1UGZkbUFNV1RtcENPbVY5eFZWYXNZYmdWWXJvWUJIeTRLS1gwUFBFbkd0?=
 =?utf-8?B?WWc4Ukg4WStaYm5uazkySUdCa2d1M0ppOGdnanNrSE5XRG4xelhwQ1RGbEpK?=
 =?utf-8?B?djZvWlN3UUVuRUpUKzRHT2UzQ0VkUjNsRXVadG9mZC9ZVEVncVcyV0JpUXli?=
 =?utf-8?B?K2IzSGJhN2lFM2s4MWtXSU5vUnFkc2pWN0c5TS8raCs1T3FjUjRVWUVtNC9O?=
 =?utf-8?B?UWFNUTZxU2taeUIzaEpYMU5ZK0s4UVdPY0N4ei9PU1RRTlI3dUFXU2JuRW5T?=
 =?utf-8?B?a3hqU0E1M0h1dUlSMUkzUVd3R3l2VHZPd1VWY0RPd096MEM4NzBOSVR0K084?=
 =?utf-8?B?ZVZ3b1dETUhFMzdhdGpDb2ljRGtWZkE4NDBsR1dXWDRUWGpxR0hLMmw1WXRw?=
 =?utf-8?B?NWZzaU1LZDRGQm54Qlh3RVgrYWdTZUlDcnhFQ0dSbUxhNFhnSVZBelBzcFpx?=
 =?utf-8?B?Z2NvZkhYcTRmSFdsMlpMdjUvRXBLeHlCdW1sTEUxOERIZVJla1hxNDI3aGtN?=
 =?utf-8?B?TFJTY1g4R1ovYzUzcFBmek9zZWlYUUpVWEVyNjhKb3V4eXdkOUFzZHJtWVhQ?=
 =?utf-8?B?VFAwUkRBS0FyVWR5cStMOXRQcWRVaEpqdk9Na3c0L25WdkM3eU9wZGhpc3Fr?=
 =?utf-8?B?SHpka1creHBjcDBlaDBUdlhqU1Y0M211dzNEQ2o3MzlvV01Cb05nVUd4Rkdv?=
 =?utf-8?B?bFFycHZocVRRb1BoRzFZWVJ5UTROWWpRMzBsOEd2S1FBbTdHcjFvMEk4empD?=
 =?utf-8?B?OWFRbzRUR2creVlmTjAyUU9TemljcVhJVWlhSkZ2NUVObC85a0NyOElLRjZB?=
 =?utf-8?B?ZDNTU3JjSnMvNFlibEZwTFJVQldNQ3VJYmhvL1lpc24wWU1vODhjclhEOW9y?=
 =?utf-8?B?RTMzQWNkNFdHMWI1VWZPL2UrVWR2M25FcmJBdjJhck0yQ05BQzJwNjA2MEI5?=
 =?utf-8?B?UzB2VUw5Q3NBRkR4aDkzY3dFZVgxbkpyNjN1TWFWa3BBeUFhcC9wNzUzUTRh?=
 =?utf-8?B?VFc0S2lobkRwMkhnZTJvd3Y1a1Q4b3VBcXZVempseFViWm0zWmp4VVgycFdO?=
 =?utf-8?B?dGYwSzlJMjdQUE4xQjZheWZTWkhuTWxVZzVYZHQxekF2SWpPaG1vTG9tNTFW?=
 =?utf-8?B?TWpKT2d6YlA3ZlQzQWF4eU13V1pwMGJhSE5HVlNKVXpCUkVQYXBPZ0VNcURZ?=
 =?utf-8?B?cEUyUnhFQlUxbmovY3Z2NXVzUmRIa0NCaHpGLzVBWGlLOWlDL0tHZHp1RE82?=
 =?utf-8?B?ZHQxakdjVTJWcVpUZUhvZmpycFNJYVdCMmtQOTc3bC9xOFpsY0dTckVxZitw?=
 =?utf-8?Q?+6wcWdw+AzWlwGJuJpVz6N?=
X-Microsoft-Antispam-Message-Info: vh2K/I+ExbGsJ1Qk/NkDME9imS5zdSfUK3u1gxBhm3A95KI0x4cJbL8re+rdvS/N88goJwIPyw9q/0jdrUOT/5NGg9c9XUIC+/5/sZh371Qt3T10D6vbX0IMkx8MFVa8eUgkQe9KeKSoruD1jp2Y3TULp9xwGg1CPxUrUMFoP8KWNhj6GYO7qlPy+ZntmAOO
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0401MB0995;6:mpru2tOOMU6RTiXiKLqTPJ5bVnWdiC7ZNB0AlH56Ng5MxAXVJU5RNyRw+2KCS3v58hoJGu4bUBvotusd0OK5zEtXMSlbNqJZTU3gELAiC+8rDRJhd5koMhSdXMzv8WUHpgtljKYSqQzfommKcfUObaYs3NQCoOApWFfBuNkqwF1k2qI55CJwi/1Jb0wbfHHUxJCGRctJ5mE0u//CNg8RtSJ7grmVNcDXtReNJA/B27vFhAFOgoP1Q9LXTnBnGfD1G8/k19m5uj3siHDtoQBb1VGm5dmcRMvvbTJKfTQZil/XwtgJVFaqtD+0TyclTtAUM0f5NMW7f8TIWB5qKf1a/GSAcV2sqNBANzWhuJlmVmrCtHw+2Ou5ReN2EEw7G68HkK6UpEjwrY4NLEgy9O09xAfCLNmmXY75EPUTidug2a98krkv+AxyrYPyI1EyQhH1/FhGNF87SsBJsfVxQb8ckQ==;5:ZxWT0u2ca28RMAZpukqoU7mtjtWFAqQIPFliaZusqyOP89rzeINU77JFbLxW/DKneWBQ/iIFHpPan1rbUXAxpn9UxZ+LDQOT8zVuyL4/x2CvIHuLH4s4/RvKkvDV1r4K6S9M6ZyVitt+ToXIWj12+wArCPXObl3QSjFHcWGyVHE=;24:tDlDgu4xNg0Vhd4WvLQEh2hOUzVUPFLx+2smK/+xmk1GJmy/4d6YNw0plYXpADSwF+wqujwmkW0uWKZR2Dm5h38VMyVuhSWuGIFb7R3j2qI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0401MB0995;7:jmTYwA2htDnXt5+B1N/hpp/zPuFJEMa3e62vIbNp9PW1rK2tYZH4lXHjF70jCZFdWzISZfUFnbT3VBYRUJiNYhkU70fpYD8Pg4Ll8zXB5Pf1Nrf+1vwGSCjsGTFOMX1+9UwZayy/E1oYNgHVFlZU3aSQIy9lWdE/EroqLyX1SF8bobOqQz0ubiGbtI0XS9W4SSWEj6JfexOBJ+gblI/UWSq+y9CmOolZxudCpDjCZpMHwz1V4RqSqWxPb8Lhwlam
X-OriginatorOrg: einstein.yu.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 14:58:47.8227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c6cea4-2970-4e60-6afa-08d590ce9515
X-MS-Exchange-CrossTenant-Id: 04c70eb4-8f26-4807-9934-e02e89266ad0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=04c70eb4-8f26-4807-9934-e02e89266ad0;Ip=[129.98.127.170];Helo=[smtp.einstein.yu.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR0401MB0995
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2NEwwqK001148

I'm trying to build a computer with network diagnostic tool, https://software.internet2.edu/ndt/ and it requires patches to the kernel, https://www.web10g.org/. The latest kernel for which there are patches, 3.17, doesn't compile with the patches, so I had to progressively retrogress until I can found one that did.

﻿-----Original Message-----
From: Willy Tarreau <w@1wt.eu>
Date: Friday, March 23, 2018 at 10:54
To: Maurice R Volaski <maurice.volaski@einstein.yu.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Did kernel 3.11 never work?

    On Fri, Mar 23, 2018 at 02:37:17PM +0000, Maurice R Volaski wrote:
    > I am trying to use kernel 3.11 on VirtualBox or VMWare, but it hangs at boot
    > right after the message "Booting the kernel". Under VMWare, VMWare gives a
    > message that it received an instruction to halt the CPU.
    > 
    > I have tried different editions of 3.11 and they all are affected the same
    > way. Does anyone know why this and a way to fix it?
    
    Not that many memories about this one, but why would anyone try to
    figure what was wrong on a kernel that's been dead for 4 years now
    and after which thousands of bugs have been fixed, possibly the one
    that affects you ?
    
    Willy
    

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751802AbeDFILP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 04:11:15 -0400
Received: from mail-cys01nam02on0061.outbound.protection.outlook.com ([104.47.37.61]:4800
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751389AbeDFILJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 04:11:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: AMD graphics performance regression in 4.15 and later
To: Jean-Marc Valin <jmvalin@mozilla.com>, airlied@linux.ie,
        alexander.deucher@amd.com, Felix.Kuehling@amd.com, labbott@redhat.com,
        akpm@linux-foundation.org, michel.daenzer@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0fc52163-936e-7ec2-7d43-3a021ec205f8@amd.com>
Date: Fri, 6 Apr 2018 10:10:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR02CA0102.eurprd02.prod.outlook.com (10.170.249.31) To
 BN6PR12MB1716.namprd12.prod.outlook.com (10.175.101.13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d12fab46-dac1-4fdb-a0ba-08d59b95f389
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1716;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;3:2AOH6+n/F28JskMZigLMMEbHLP/9QplKOgZdqB8GfZj+7dLJue4PhKGkyHOtUvgxfgLWiT9g4ynWK/bxu1pZu47RjpZLR70igjnyvFlC0OfcBaXJtvs+qA8PwVBbLPC19uR9CUROYzV3gm2kpWJ+DNbEIdyZxsbJaT/oM6MNe/iSen8mNY1FFCT99IIlAPRYmLSoWDs7B6AHGl6vAWe3qyweoGyMbpQ/rQhEAxDD1IaMC7535MrLkvbHX1F8mOOH;25:L8P/n7A1GblbinstHy+DZnPGFZb/PeCmw8KifMpRGTKpR8yQYoajTXdwG/ed1NSr2tYqzFsMNikhn0R/Z8FBy6nBIN1oaaABkF50TZB+NwkhM/JHxcBU0A8Lnhnw1bSxbCkFw069QVYZUE0WkvM5HmqvgYPEx6R5M5YeLCQBtFWjRedt4XfSf5uZE5VL8twPhG0TtJnwjiAbK1nAEGZCKF39pcprWPFh5kQdTBRrK0UDiJc0xR5ZSVBdOa/Qb/Q3LAqtIlOGyLbyXRZHFbuJp9IS8OBZx0W3wT3D4amHbVA4rslnXbhJxTa9Rt2YkrQDcH8j49ES+CRmQw7eQyQrEw==;31:FInp93lymOyZ2LetFoxzNzgghMoeLU6TpruQkVuoNtWj8RNArXRJyIKZCSVRFEmWKcZpMlm/2b5uFgMu1ff9viPosfpsGJIgsQdhCEubN0lnxSQxA6505UACJfGvr6iboyHuBQSw+yAfX/hPaeRiYZkWLq3Y2WglwBMSsn0oMvClaJBFiKvYIGTlH3E0a2KIvvnd4aor44vOwX+v+PBJBVeMNlGrCr03kxz7DvTyvtY=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1716:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;20:YOoS2He27sGv0OIiVIt8LJYAC4ZY3Hv9Fz30RH19dRvfTccFdPpOqI8N8bPHxIjIvgzuZX4ZEerrd3sDficYS1XJP+6ZXph4JEwA9ANffalaRlArlrM55cjlKHHovh+kTEc0w+IoYYD+f6g0HT6QWDI/44x+5ZkFhhdcvRgimAdcztpITPtHErZv2JpCloQmvlLu4U5Tw8VVncaKfRGVx34Ttzn9m6vBHKqXda97vtjfHdZiGPJFy5itWRctkJXVC0WT2wzEvTGPuFrDnJwpixd10t+VkzPhk3b/xqosmWdRQf5rTOpd9/uwA6kNB3Er5Bobg9BJNYPCu2OE/xJUdmwOt/zz8BKvT5Duw2eHxLXSDr7WVAG3sEQX3CwZhqzoH5BL0WGaWSzXSwXsA/Xh3L6MNAb2q+GszEROyyGZOQFd8Lmqgmw7mDIvo8aGfBuwdv5W4viKAjWC3wIW6ESSDtaNf9L+G5q4e6cF0r9FjT7sWDFfmnhYqS1felc7eMnO;4:6v9YrfNESoClgQshYfkOD3cn+VG4afeiItyDDnjp8Ejrc9sHdCIRDQcs4fjsKiDMvMZBDEci8XsZrFnMs1Jy5t0klZfRiyGpqkH017s7X/PavRwC62457MmL1KNt8AWAd3maPLJZjyg3KGo1xEnGt86xq/jLBlmYLrq71Q2+1xmWg0Y9gSarBXddUXkbwAmoSGD8UPJ0CUIXJBtJHm6Xc1yxIjeGUXlQclQtZzydWwiRkHrQOjbMlhnoboz8MW9BXe+DcQ01jqO/ahQyCWdu0SRdF6ZDiig82QZYJp5VAgDhxj342VO/XGAO6oZGf5wwF+Oywx7rws+w96Kn92onpwQlY5d1tz/QE2u/yKgRpQg=
X-Microsoft-Antispam-PRVS: <BN6PR12MB1716684CB9685D3D2DFE05F483BA0@BN6PR12MB1716.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR12MB1716;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1716;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39380400002)(366004)(39860400002)(199004)(189003)(52146003)(2486003)(52116002)(23676004)(11346002)(76176011)(2906002)(6486002)(2870700001)(67846002)(476003)(966005)(47776003)(31686004)(65806001)(6116002)(1706002)(50466002)(105586002)(97736004)(52396003)(36756003)(446003)(65956001)(46003)(6306002)(8676002)(53936002)(7736002)(305945005)(316002)(65826007)(486006)(81166006)(64126003)(58126008)(5660300001)(2616005)(25786009)(86362001)(81156014)(6246003)(8936002)(229853002)(72206003)(186003)(6666003)(68736007)(16526019)(478600001)(386003)(31696002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1716;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE2OzIzOmVaZVhKSkN3VDIzV0NpS0FPeXEwLzRLRWtM?=
 =?utf-8?B?SmkwOTJHek9qaHlGQTExbGRha2JWSldtcnFIRG1vYmFuajVYdWJuTmIzZEYx?=
 =?utf-8?B?cnA3NnExNjduRGxvZWVXWFRUaENzUVFIM2FaZllIZFZqQnhmaGpxZ2tIU0k2?=
 =?utf-8?B?YlJ1MEkyWUdTY2lMOWYxZ21tQjFSYUx1NzdVRWlQZUxyL2JjNXNTQTA1cFVp?=
 =?utf-8?B?a2NWQUd5Q2dvTlhnSmhKMTluMi95VmdpV2tXVUx2UEJrcFQyR2YzUDltSW40?=
 =?utf-8?B?YWtsZ2FLeXJLclNwQ3M4alpucWJ1T2xYRmpmVFYzWGNqNVZUdlVieXJGZ2V3?=
 =?utf-8?B?RTYvRURhWEFmRkhFNlNQdmhacmQvZkc3WHd2UTlsb1JzRDBFOHNtOEx1dG9l?=
 =?utf-8?B?YlNwc3pyVnFzc3NNcmhzcC9wRTdJR2dPU3BER0l5WmUxM3dINkViZGFJbWZs?=
 =?utf-8?B?UFB1bmpaVzEwSzY1VlVNYWZ0S082alQzU1dXd0I0akFpbUxPVDZNSG1kcUxC?=
 =?utf-8?B?ajd1aU1mRzQvREk3dk1sK2F3cy9zWEVNU0NnZHF6ZUg3dVVidENHN0ljbVUy?=
 =?utf-8?B?ZTFPZmhHbnF3LzZDWGxJN0hOaFh0eUxjb3g2TzVQQTJHeHFVSHlUR0ZTWDRS?=
 =?utf-8?B?SEdzcUUzOXV0ejZtYkx0dnhZSEhJNFlZRHNpM1JUSDd1MGN1NHB1L0daNmtn?=
 =?utf-8?B?K0RWQ0gvVGFLRi9IL25Ha3NrZlNWcVFVSVNWZ1JpZ1JoaUdCdDdmdGZhYlRi?=
 =?utf-8?B?VkdkK2hLcFBhNzdYaWlTVTZ5eEh3UjZ0UDZQN2JaWS9XSGxxSS9GWW1KM3c3?=
 =?utf-8?B?ZEl3NGFlZkpBb2dBenFGMzFyQmkrVUJhemhIVFlVVC9Dei9YN3hxTkh3ZUxm?=
 =?utf-8?B?YUJsL3JzZlBZZVlaS1cxaVZUMThJcmpuMXhJR1RuMXRIZGx3OFdDYUNJTlVD?=
 =?utf-8?B?VFZwek9FOVhiWXNEYXN6LzBMMTZEUUpWZzV0YTV3QXN4dzNsSi8ycXR6dytL?=
 =?utf-8?B?TW1pN1ZsUDZYRUxPcEhmdmxKcEhoMGFhZWIyUERHNGVpVEtFWTlkQlVsOXFT?=
 =?utf-8?B?WG0vdXB2VVVsS2lsVG02UnhiUmQ1Y1BsRUhFTDYvMTVuVEV5OU96QTQ4aGx5?=
 =?utf-8?B?RjgrMUUvYkIyNnNES0syblNkZUI4ak1FR280NEQ0R2V3Nlk4UStJVGo2alI0?=
 =?utf-8?B?UGtnSWVrM0R0TjFaYy95NlE0RWpVMHNYRHRkbDhQZEp6Tk90VXNkV2pZQVVz?=
 =?utf-8?B?NnpWR3M2WDByc3Jjb3V2TU5Zb29XdThGLzZYdTRaMzNOVEhWZUNlU0VGQjB3?=
 =?utf-8?B?eW92Slh0MVgzQ0c1YUJoVkdHZXZicTVsRmp6WmRYOFJxTG94SzNhWVpHTTFU?=
 =?utf-8?B?Z09ZMGVYRnFXK05OZVZYL0JUL3FNU1p4b0VmQUo4NGxucFJCVi9LYzBrT3RH?=
 =?utf-8?B?RlNLa05IOUdWcmlXcUNjTmhOUWZ4NWhQcGlpczJ4NlBNOEdYZFpXMkNKUGZi?=
 =?utf-8?B?WVlJWWRIMGJjNTljeGFCREVBcFR1MDNjQmJuOUNzY3B1NFlKNlNCMjBHZlNx?=
 =?utf-8?B?UEFjR3p1OE9Ub1U2c0xmS1dOQ2w0dGl5YlZHMFRJZVZVU0hxeHdTVnpoT1lO?=
 =?utf-8?B?RFFpR0xMM09FTXdHQUV4MjhlZDd0dkYvdTZWVWo1cnY4SWpGS2RBRHdEVzhT?=
 =?utf-8?B?VU1IVHhBSEdXN0tnaWtaUW42cmo1WnNab3pORi9mNkxhamhYbEtUaU5JZmo4?=
 =?utf-8?B?R0tCSlhWVXliajZ2K3NlcFp4MWlPQ2VDbVhRVEU3TFdYeitBcnFWQkE0akw2?=
 =?utf-8?B?ZnRxOXRZZ2VQSGM0U3ZiaDBNVzdWR055UHhwOGt2TWNvWVE9PQ==?=
X-Microsoft-Antispam-Message-Info: w+1WxNK1aeujG8UTW6Q99E8JWezuuAr3J7TdX/1mBplVOkdXF5+XdWg9Wb3/cTLAxvdoXEmeUAvfP66N/DZrjHLz9vgjRx1tQNNPBFjqfQ2yHcdu2bX52IuNV5/Wi5KL1SKR7ot+es7MvWDGTMaZEUxbNN+2FO6fksvxoM5m8z9l6XgONqZqzlNI+E96kf++
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;6:2xpikPFj+02yVmEo3mtIKIuOpAciLYu2rjBMe+PB4geQfIxeHbRnnPceXkB2k4rgnDTwL2YNfJ66U5zE+tNfEvIZDkUC+S50l7Y0dKygo7VTIPFGxvOQ22ncJyJbjWlmgqhFrieNQ9PzbbSKZB01pAY2RxY/SRXuuZBSGdtCagh0HRN5aDbcb+ItfyvQNBGU4w/B/+m0oiIAEjvsuXI9bILYs8lHCzMrPcPfOOWTC+a5WCSvx9q5xMmg3nBnBZ02DiVzrcX5EKL2UndMk5shHhGVpRHc3UDo9sg7u5Hg4gUJzZcruEFnBTw6fL8IyhTA9NNMRQPDY13jx4KvTeZ1mn1JlgE7YJb1+wET6GwQNTLG01TdlHBb8rbp6K6vvLPWcMr02PICJHgjI4Cwre1BLMHgMHuZE5kwB/47s2yLPWeIg7puLZg+bYvOgmK1F9ljrmUXVhnMXm0/VNpGpqzeCw==;5:PlEwFXiCW3cfwhD67EuVZPj1BBmGODVAtMnbdkiren+38e7t+MKaQS3XnginziX5OaigEVcYozoftOF+5Fg5BC1Y7NaSqkJi5GfsWTSuPg5u2wwt/hzU3S8YlGAJOBTWxoQdsGsW53trw5RX4x32v+Y8zTZz/GxYZeT0f5oXZVg=;24:pw9MLfJfeib86V7CVnZx60jmzz4A7S7yvu/fUfj2a7VRMt4RDwi3yq+VvdBqjBYk9VNcbCchGf8DSNx2Wn2mrYn2r0r+9XPAJ/fxAOHqJqM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1716;7:JquaMMjSv172ObIvQHT+Gw6vaQbRC2oeqfD/iNqdchoyN3kl7ETzfYEi62hQ16WEska0FVqs4mjev6cXlR1jf4gIirUSy54GapXGcVFhI2hP3AZhY2KIF5u/mYQ9rSuWK7f/+8Ybv6EP6yCHxehNu/fc03Tv2F6pIhie1e9IoOZrpH7EwKH46a+rjr/I3vT8i3UOtKE/UAmUm6kH3qPxucQtCWwd1O3iaDVarmpto1jdZPefcmXVY5beD5ZWS5Kg;20:lbqux8pvd7AD80QymplWiQzrrUuJu1rrBHlRbqzeRr+HUEfAbKEpnUXM6/dfv3t9yNdH4zxBY6e6yTgDDk2EfMHAk9thCF8RAbBCfcnL6lYokTEqSBNyK4wB5fBn76wTZMdf0YGS9dO90hZDqmf7HcUhH/Wv+xXIGhPHfENb9ANSuhEigM+NFYrZ9vOfCbHHgTPDY+yv02Ne/cnGv/qnHFQK6Jteh7OBFtWOErxKmLqVi1BFyYCCmA+MjcNVVOMS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 08:11:06.2022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d12fab46-dac1-4fdb-a0ba-08d59b95f389
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1716
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

found the bug reports.

Here is the original bug report from the kernel: 
https://bugzilla.kernel.org/show_bug.cgi?id=198511

And here is an fdo bug report where we tried to investigate the root 
cause, but didn't had time for that yet: 
https://bugs.freedesktop.org/show_bug.cgi?id=105038

Regards,
Christian.

Am 06.04.2018 um 10:03 schrieb Christian König:
> Hi Jean,
>
> yeah, that is a known problem. Using huge pages improves the 
> performance because of better TLB usage, but for the cost of higher 
> allocation overhead.
>
> What we found is that firefox is doing something rather strange by 
> allocating large textures and then just trowing them away again 
> immediately.
>
> We mitigated the problem by avoiding the slow coherent DMA code path 
> on almost all platforms on newer kernels, but essentially somebody 
> needs to figure out why firefox and/or the user space stack is doing 
> this constant allocation/freeing of memory.
>
> There is also a bug tracker on bugs.kernel.org about this, but I can't 
> find it any more of hand.
>
> Regards,
> Christian.
>
> Am 06.04.2018 um 02:30 schrieb Jean-Marc Valin:
>> Hi,
>>
>> I noticed a serious graphics performance regression between 4.14 and
>> 4.15. It is most noticeable with Firefox (tried FF57 through FF60) and
>> causes scrolling to be really choppy/sluggish. I've confirmed that the
>> problem is also there on 4.16, while 4.13 works fine.
>>
>> After a bisection, I've narrowed the regression down to this commit:
>>
>> commit 648bc3574716400acc06f99915815f80d9563783
>> Author: Christian König <christian.koenig@amd.com>
>> Date:   Thu Jul 6 09:59:43 2017 +0200
>>
>>      drm/ttm: add transparent huge page support for DMA allocations v2
>>
>>
>> Some details about my system:
>> Distro: Fedora 27 (up-to-date)
>> Video: MSI Radeon RX 560 AERO
>> CPU: Dual-socket Xeon E5-2640 v4 (20 cores total)
>> RAM: 128 GB ECC
>>
>>
>> As a comparison, when running Firefox with 4.15 on a Lenovo W540 laptop
>> (with Intel graphics only) the responsiveness is much better then what
>> I'm getting on the Xeon machine above with the Radeon card, so this
>> really seems to be an AMD-only issue.
>>
>> Any way to fix the issue?
>>
>> Thanks,
>>
>>     Jean-Marc
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

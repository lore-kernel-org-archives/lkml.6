Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XIQHlB7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56AFB60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeFFMTv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:19:51 -0400
Received: from mail-co1nam03on0066.outbound.protection.outlook.com ([104.47.40.66]:61760
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750864AbeFFMTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:19:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: AMD graphics performance regression in 4.15 and later
To: Gabriel C <nix.or.die@gmail.com>
Cc: Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>, alexander.deucher@amd.com,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        michel.daenzer@amd.com, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com>
 <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
 <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com>
 <312ed341-7052-a61e-331f-d1e8fd5b477e@mozilla.com>
 <d136f940-d807-d2f7-30a7-8617f130912d@amd.com>
 <77866d66-2728-8295-d7ee-9975dbf64b99@mozilla.com>
 <55e1712b-6567-50c5-3789-53dd1ccddb94@gmail.com>
 <CAEJqkgiOR3aCGoNquVeEyC1BLMBPmXNjgrmjNeeE9UVfzcJKzg@mail.gmail.com>
 <CAEJqkgjfhmjwYo74xivsfgvoPQUFh2dFeXFwtEKoN+DXG1riMg@mail.gmail.com>
 <CAEJqkgiVdeBf9konX4OJi59dYp4y_b+J02ns=yf-D6tjtZ7P1g@mail.gmail.com>
 <52eceaff-987d-4c1d-a2cb-73b28e48c01c@amd.com>
 <CAEJqkgiBZ6G+tXWULYoGKqq3BsgvH7TrqkFbhtRL4JnGM+dLuA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <89d91028-c800-b6db-38de-4ece84e5effd@amd.com>
Date: Wed, 6 Jun 2018 14:19:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkgiBZ6G+tXWULYoGKqq3BsgvH7TrqkFbhtRL4JnGM+dLuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM0PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::14) To DM5PR12MB1724.namprd12.prod.outlook.com
 (2603:10b6:3:10f::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1724;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;3:y287bHJ+xiYc8UTuh+nrIkuc3+A+MxieJBxB5HSHcj7hIXhg2aAHS1iyk/8bV77+ODxXJDEp0hMQ47KLq1Zf5HWlpgfBDUSduyUfXCG6TTtBH2pait4v9RQPTcE9FRs9x0Y/+X5Gd8XRgx5gCxNq4EHJugfc01YnlsR4MMj9STG+rg4HwLJPg92zO/wC18inEPBlrkhj180Puaw1RLY1yGjapY1nz91Rpz7fhsreElQO58L+4/K82xuyrQrAuFS9;25:OFhTpwyAI+HkIPHWemtI+fPY6GOD5LHR+K20dgFrlaYwfJYflDdA3oo5UAgh+kmZOG52cKRDEmlJbGSGhlL6+V5xruGLPxEObNOAGNOuNzgP08tivDaoWJOpslyo880+HNaQml7RPzLznxbxyhUn0N9R5YCesd7qAGCavTAP+vmR+xAXUblyZZ0+plmKfVGJinQiB5Bx5Iqmhbr6pVPKXVTlJ9jgDN5IX9GmzoNZpbN2yaDchHstxbDnc1a3alZxShlGvtJtNKKZrquW1bASMDwL4+3C/VWSzqSf6EGHRDUQUyqKwSerrUJ3oT+CUsFyrZaB01PEDCIjkM2FZJL13A==;31:4jkvMkBgIx4m6wXRHkOQz5Eh8PQ/LSPeQ3YwFoA9+vSWF16QovxEy6bcK8qFmwVwCsJ2hpYpFXgHN4kz736wP4niv5SQAtz1NPMJkLiAR6b4E+hDvp3R5DmlT4dJV2zRS4lxNKOAi5ZRH745feVDDT3sHZ7TTG2tqKV/zH/H2Oxww2qA2bbnWPp/W4hX/1YwvgD38QaaOoF1YJkq6f+6dQ4MIBoOTXyZx1OCuLyOA3k=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1724:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;20:62n3qXKkSl/VxeuoCQIdDQDKnDrsiNgA4T87ECE5hbi9K/B8resmlzCYTK+oaCi+u6fCx/Zm2KlZSZycl51OJ/z0pTdoqoCB6Ps/3e/kmUmF0mT6yRfRIdXGcCSi/7KroeS+BZuBoq1qqz7ePQh6KmwbQ5IzG1tbjDjs39FG55WfiwUS43E/+kMme2FKVTTuq6zSYv1RlfqBm1Rj8x9e1ob1SADZItK1PfDlQCLWBjEnonqeKZLihmMzW2jxDbzjah0MKRti+zh3Gy58NUuRyxH3QF+cY65RlGtDxfQTc1ljfDprmDmy6vUSFbQTDF7sMxb53xIZjA6Tch27nfv0WU+YSaEM8Mv7hZIsQc5ofaGskYVrd36Tv84nJIEwz309bdb5lYZfVLTgZNKVdk1eSNmAbm4gLB8AjrUpGTAbLE0+LioKE+Q4wwYMXPFmao3GRdT3wiULD5MyNcxrHJCj6ihMS5F2yU9OV0FP5hZ2mvSWPDNWjP/YRruXVPbF1tpA;4:d82Gz4KtSJEQF2QoYSG56NqTM1dg9PszQl3GZfvQH8P4HvlB/o5qJexUUEtHB7IozYxEcP1ieshL1uhWj8VjFJDCKDlVD3JYjZaEJjcNZzUoYz3a4ryGfLXBm3Vo/3YuI5lS+nRACizCUq/EkBHLnSOFPoCOxS8poED9N3fNGYqQgt/kZQiWuNHTEv/ndiSyCdmj+4Q9SDa1bIw3hU3sLP0b7kOZ+dcyhCuPbd9IcC0HVTEN/D2kjRnU+6918OiA/u6vt1FP21x/oC6snISpVi9PDpfyThPO3VSzyWvmGUEw1eIivr/thHo/h+r8AQYI9th5hhaT432xt1fROJDgWw==
X-Microsoft-Antispam-PRVS: <DM5PR12MB1724EC6C155670069CF15A4A83650@DM5PR12MB1724.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1724;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1724;
X-Forefront-PRVS: 06952FC175
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(39380400002)(396003)(366004)(189003)(199004)(8676002)(305945005)(229853002)(2870700001)(2616005)(476003)(93886005)(2906002)(8936002)(6246003)(46003)(36756003)(31686004)(106356001)(52146003)(23676004)(39060400002)(81166006)(316002)(2486003)(16526019)(4326008)(186003)(64126003)(11346002)(6666003)(67846002)(68736007)(52396003)(81156014)(7736002)(1706002)(105586002)(6486002)(54906003)(52116002)(59450400001)(446003)(6116002)(72206003)(486006)(6306002)(58126008)(76176011)(97736004)(65806001)(478600001)(65956001)(47776003)(86362001)(50466002)(31696002)(5660300001)(25786009)(386003)(53936002)(65826007)(6916009)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1724;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzI0OzIzOjYwV2tNZFplSkRuVU55ZnV2Tmc2M0RSRXJQ?=
 =?utf-8?B?aHhFT3lnc1M0Y0lEWWczQ0g5STF4cHd5bjE4T1VLYStVOEI1dDAyVmJrRTVZ?=
 =?utf-8?B?YS8ySmFTd1JQcklwaUVsUmF4cjF1QWVIckVoMHlEbENLOWU5WmpuSEx4TURZ?=
 =?utf-8?B?RjB5c29xUG04alRxZkExcUFJYzhPSUZHdGFKWDl6dWdOQUdvckx6RnJ1R2Fo?=
 =?utf-8?B?M2xmbmtrOS9OdnFEK0JYN3dMNW5xTjJOYXE4ZGpSQkdhdXJXM0YxOWJqTUlX?=
 =?utf-8?B?VmJiYXdaektoV3RQRmJVQ25DUWlSeG56K1pHU0pTRTBrQjIza1FOdHFKOFA5?=
 =?utf-8?B?RjViVXJYUE5naG5ldEJwTVBxZjA5ZGpTYUpyeVlpM2hxRjhHT2U1OWg5MG13?=
 =?utf-8?B?WUkyKzhlZldaMWh0RjJRZk1BdFBhblA0M3lJVHlXaFAwQXhSc2VSNTRVWEI4?=
 =?utf-8?B?NXRVUTlvVTVyZ3huanp3Z1V2VXh5dUFJM0dwVzJxKzdIUmplNng4eXRocVJj?=
 =?utf-8?B?L21TeW1sc2hnTFZ2blYyU21US2JHc0dDNjNuOVlGYWFkelVtTitOVFd0WCtU?=
 =?utf-8?B?R3FPVGZmS2p6bXZLWHczbEpCRVNXVUt6OXNLRVBidXVSWDlZandZS3ovZmEz?=
 =?utf-8?B?bkpYZm1SdzJyYmV5STNxSDNKaUFFU0dRdWQwT3ZGenducUhHNERIdHlJUmla?=
 =?utf-8?B?Tjh6Z1FEMXBFYnppM2EyNFhyRHk0Q0ZnS3VWZ0wwYUgvcUFPMGZjL3FtcE9q?=
 =?utf-8?B?SFB0MU81ZndMVHZ1Vmc0L2pYaGNRTUNucGhNY0FLYlpqVlY3Y2pPMS8yeld3?=
 =?utf-8?B?TGdldWx2Nzlpc1JRVHgwdXdybTB0VVhCcUhrenprNFRsZlNJbSs3YWVqbStP?=
 =?utf-8?B?dm9wMzVzNUpxVmJScjhESzErQkFDMFhUeW13RFNraWVoVUNlYkxnem14TUhy?=
 =?utf-8?B?SGRQd3hGM0JMY1JycHpYTTZpZGVqcnNWMXdtZDRqWHNVUkpyMnk4MXpES2hw?=
 =?utf-8?B?SktYNEpJRXp0b2F2K0UzUEF6eVhYT3I3bU1TWmU4Mk9WSFJsZDdEUWFqSVgw?=
 =?utf-8?B?UVh4dWhsK01qSWYvWkdRNGNnbXcvclNCYnJpYUNQK2xlVkxlSkxqRzVKUVJD?=
 =?utf-8?B?a0JQVjBaVVpsWm1rRHJiYzFjNlhoV2ZpSTBmblRSR2s1OVUvQkVnaFlvWjFW?=
 =?utf-8?B?dStjOEhBUzlXcnhVYnhtU3BpNzdIYW9CNXhuT3hFckc1a0JYR2VYSEtUYWdT?=
 =?utf-8?B?WW96aDI2ZGtTaStUWEhnTnM0SkRPRnRtaEhWdE05WkdlU09NanBscXhINWFa?=
 =?utf-8?B?Sm1Fc3lKb011eG9hVE5Mbmt0YkRhL2RqYzFJTHRrdVgrakRlZ2pOVzJqNXZS?=
 =?utf-8?B?NUwzWDBoc3E2aUVyQ2YycTVIWUI0YjhacTBWWUhseEV2ZHlVN29RSVY3c2pR?=
 =?utf-8?B?ZVV4NUtNN1Z0d3lrUVJtUHZJcmMxWGZGZndqTHRnTkg5eTFtTkQ4TjlkTFFD?=
 =?utf-8?B?WW1OTFk5NnFvR1p1aWMrTDRWeGc3WURaYlAxTzJnWnZqVElUalFMTGFWMm1a?=
 =?utf-8?B?d3FYUXd2UWllblE5NUt4MTVrNWtycHRLUlFTSzJNUDJJeTJoQnRiQmwrdEVy?=
 =?utf-8?B?RlRyeGFFNzBsRzlGVkhLZUZ1NjI0VmpPVElxeXU5ZXJ5ZnUwczc4bU9KaFhH?=
 =?utf-8?B?SDhISVY2OFVPYmtNTnJLK3l5aUdpZjdBMENxVndxeGJoa3lKZ0MrNStLcDZu?=
 =?utf-8?B?b3I1bmlIaW83WUdIa050RzlHQ2FZeEppUTBKZ0EzTjdkQy8zRE5xOE5JMTFH?=
 =?utf-8?B?MWhGWDlaUXpZYUJKQjVyQmI3cjlQQkZBRGJOSndjRTFnSVBJYlJsSGtnYUpW?=
 =?utf-8?B?aWFIdWQ3b0xEd2NwN3lLaVhLQllKbmpBZTlUWGRuNU5Kemcyd256MU1xbTdt?=
 =?utf-8?B?YmZ4d1A0a0s5RklZT3ZleWxYRmZwalljZzVnR0I2bk9SRy9OM0NjaXFYUWhW?=
 =?utf-8?B?cHVET2x1UE41d2w3dXg0bkFSZno4MzVvV0RMQT09?=
X-Microsoft-Antispam-Message-Info: 6WZaLw3K9I0OxklFPL+fK3j9HP3fpB3dCYZ/EpweeJ0bi4kwkS8M3ywF9kx46PKr94cnpM3lfxc++M1qBVM7IvjlmFRe9R1dKbqBjorQRL+k9OVPJAHAXZ1V4yqICBZxc//+kb5vM1MafbJLkyDrY51lvFfhfQjX7WPOJpKvVjEdWIzjPV2SHTrWB3gmBA12
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;6:prt+mHMivtLlQABzlUiUcT8dxfJuMlzSvSBG0438TiJ+CBk92x8IlRBBfm4dCDpMs92DLEnPjRMLGT7wxcbyrq1nZxeEDnjsIUe+b8caPLSw8p+hR1I+SCGk+oX4bnHljACFl6lrx3/DpTuwh6ZulzVGHalSe29P7i8KX5H4Q2fId88oF+iSZqH+jCioYHX+ZrlXcVDZlV02zd7m3iq6cRcaEGP4NtUCoiPHYCOfBIFRhSzTBY3xBC5MCVgumdbn8Ec+imD2gVe+rFXLaPJVUxou0rj7yuK/w4op67cu2iMjTpOXhmR+393tWGbP0YErccy9ToVKKj4NeZwulei6NXRub/PXKeFGB12NCuvNkVOkcNzrW0WiZ8c0vJIrTpSaohSs7zXPv/CDa9ZTFrLHOtWD+TIM/aQSyIeGNT5UCluVsw0eim5CwX0a31gNTTJqPSu4Jhy6BKw4o/W7MCo27Q==;5:ra0pgUTkMwmTOy/J7wzWpdQkmIo84txEuMTey5saBKyXYGi/vfZgFfIe8yLJQOpXgBKKjZYZ1zrGCgkBUTPff9IKMBUdQ9IiaYpDyxBmICdgngu4Ms7w09FS7bx9ydx/5e9DBC1DXOmhgkkt8U5oPdywBhraD53nW0AM6Q6EXts=;24:q/WczEbno1xDJW+VKGXGiDILqPtzgRB0PNn8E4rCib0HuA/G8FaWrcLheqXAWJieXqwLbX+syPBb9vl5timsawlExxsh8OHQetjallj6xsc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;7:vzgA3wiLoA0PB8R4G8QUBSU+4xWLSgfQyxf+dIMhr7R8guHTtURFBHDUF+bXVpGh9rMPPYaroIgwajEx2WBxhop9ADs9PsGBHnwrbZN3joK2BEmEM0lImNoED21c6ZCs+k6EKKAyLpuvzWfsRwALmEio3jaX4GTO1XUT+ZfdVI2/oXw2a9uMALMADKZGBbjPCzqjmSTKC7wSHu6USwj+8Uz+ofL1dhLbTLl1ypQim6AQZXf6qq30cbBv6KBmQFw5;20:YlseplIJC/VlK5juil5XXQyIYQmnStofiAorLPSDLMLf4NL1dTMdkkqw06BT7MTIpGJWIdzmzny4quDrxEaP9eUsYkjTq/1NGBro1C8aqH5RJ+2f/H/Rxdz3abVaYBJ++3vA1zoZwRC0D8p5mPF+zRttmTm6oiYSp7IHi7mTZf0SWKMC70moQNxHwxDOTIi+Fof2vf0z4uvxPaldEItYgxOB6wMdHpOnrgaiVsmtc9JhrpigyXRNQ3Kp2HA33ejy
X-MS-Office365-Filtering-Correlation-Id: 15f7dcf9-2ca2-46cf-05f4-08d5cba7cace
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 12:19:44.4019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f7dcf9-2ca2-46cf-05f4-08d5cba7cace
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1724
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.06.2018 um 14:08 schrieb Gabriel C:
> 2018-06-06 13:33 GMT+02:00 Christian König <christian.koenig@amd.com>:
>> Am 06.06.2018 um 13:28 schrieb Gabriel C:
>>> 2018-04-11 7:02 GMT+02:00 Gabriel C <nix.or.die@gmail.com>:
>>>>> 2018-04-11 6:00 GMT+02:00 Gabriel C <nix.or.die@gmail.com>:
>>>>> 2018-04-09 11:42 GMT+02:00 Christian König
>>>>> <ckoenig.leichtzumerken@gmail.com>:
>>>>>> Am 07.04.2018 um 00:00 schrieb Jean-Marc Valin:
>>>> ...
>>>>> I can help testing code for 4.17/++ if you wish but that is *different*
>>>>> storry.
>>>>>
>>>> Quick tested an 4.16.0-11490-gb284d4d5a678 , amdgpu and radeon driver
>>>> are broken now in this one.
>>>>
>>>> radeon tells:
>>>>
>>>> ...
>>>>
>>>> [    6.337838] [drm] PCIE GART of 2048M enabled (table at
>>>> 0x00000000001D6000).
>>>> [    6.338210] radeon 0000:21:00.0: (-12) create WB bo failed
>>>> [    6.338214] radeon 0000:21:00.0: disabling GPU acceleration
>>>>
>>>> ...
>>>>
>>> I have the same Issue now on final 4.17.
>>
>> Actually Michel came up with a fix for the performance regression which is
>> now backported to older kernels as well.
>>
>> So the original issue of this mail thread should be fixed by now.
> Ok , will test as soon I get the GPU to work :))
>
>>> Also I played with BIOS options also which does not fix anything but
>>> changes the error message.
>>>
>>> IOMMU && SR-IOV disabled the error changes to this :
>>>
>>> [    7.092044] [drm:r600_ring_test [radeon]] *ERROR* radeon: ring 0
>>> test failed (scratch(0x850C)=0xCAFEDEAD)
>>> [    7.092059] radeon 0000:21:00.0: disabling GPU acceleration
>>>
>>>
>>> While I could workaround SWIOTLB bugs in 4.15 and 4.16 , 4.17 seems to
>>> kill the GPU with no way
>>> for me to make it work ( at least I could not find any workaround by now )
>>
>> That actually sounds like something completely different. Can you provide a
>> full dmesg of radeon and/or amdgpu?
> Sure here from boot with IOMMU/SR-IOV ON/OFF in BIOS :
>
> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-iommu-sr-iov-off.txt
> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-iommu-sr-iov-on.txt
>
> Also nothing else changed in that setup just testing kernel 4.17.

That has nothing TODO with the driver nor the original bug you reported. 
The problem is that SME is active and that is currently not supported at 
all with a that hardware.

Try to disable SME either in the BIOS or on the kernel command line.

Regards,
Christian.

>
> I can force the GPU to use amdgpu if you wish and post dmesg's too.
> Just let me know

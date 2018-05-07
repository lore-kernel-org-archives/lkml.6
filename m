Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeEGKGl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:06:41 -0400
Received: from mail-co1nam03on0062.outbound.protection.outlook.com ([104.47.40.62]:14803
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750881AbeEGKGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:06:38 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
Subject: Re: [PATCH v2] clk: x86: Add ST oscout platform clock
To: Stephen Boyd <sboyd@kernel.org>
Cc: djkurtz@chromium.org, Alexander.Deucher@amd.com,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Shaoyun Liu <Shaoyun.Liu@amd.com>, Dave Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <1525336264-29243-1-git-send-email-akshu.agrawal@amd.com>
 <152548720041.138124.2994178054788686137@swboyd.mtv.corp.google.com>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <dc8e9d34-a3a6-b149-f885-f1f3ea35b93b@amd.com>
Date: Mon, 7 May 2018 15:36:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152548720041.138124.2994178054788686137@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MAXPR0101CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::18) To DM5PR12MB2358.namprd12.prod.outlook.com
 (2603:10b6:4:b4::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2358;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2358;3:j+e5Tf2jtXuT3hjpPLY7Pei1VBFcAjj1WesW6TbD9THlvX/lHRKonvEPYDpCx1MJ5y0EqNg3s8fc7iIgzYSkrssCUghWUrTzMhnIb8dy+cs3CiJpdQZutk7ahBK/wKVtxNbjD1ShKgTeROlDO8RgWW+cZz7MV22Xj18tLphXkJQtYjNMZsMBsk05EoMAKvWGMry1s0Qmz3r/xPfRCjkF/ecK7kjys2CQ25MUaGcOQU4phOR1nTEMn1yvnHpdOt+3;25:q6IREkY0zB4zXXX1nuc8+Hja60qyuSyWxuk7DBKSdIXbGy5qPY+xGFi7muXycxFDJrkNxQK+9JEQs/Z73Lt7e/SRpVwQSXdBnbOfZsk4H2IHc2pssN5G6tspQ+nG4KbYULEDFEXzLM0O4L1qkf6rXULGmMV8juZlCJAP8ChMWaW172QMZzgJPy0GYwvWODOcNUuKvMguCaC6oBal+hg0fqtemLxRd0YVz8Vfyj5GlZwmNcW/gqGKKYGuN8qW/9HXXcxTlwtBZwklVTH2nt0qqiUI6VHzaG+Ma/o0AWZ+OG6Nb1zR/JYPrY3sCz95/LJEGV9k+4n8D5HQo+rhyQxw4Q==;31:E64B3LM0WW7ElU5YBBDYTQGMKgTKCkf+TRyko3owl+uU9TUTrThoFJBpI0ry5BLggbwpMDLuKmR9Vmt612Af7bNlzYID77Nm5otVgTeDudP8A/pkNwhwWR+eVccgYCeKbk50cv+kgHJbHX60T0Qf2E8qJX/mZYfGi+14HL9iY51JR5Uu7Ex3YRPYVM14glEKOOHhhSZmpxr5y+azlbEtWHFpk7DauPwmWoxhIDBZ63o=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2358:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2358;20:agDyoNbmW++i3puad8RCP3rQV7MMMe6nDXRz0D0OubQkvbguJoLbre3y6IPR00OJRSkrjdXIv6PN5aSqRuJSr5y474Iu1nF1v76c+TpAYuHTtxkDdi0YrH34tlmrasYyY5Zt0Rcsg4r1vM/twfXbZezQr8Fk/zl2g/HL3gqMpRu+qjtgYkFcY3S0oiCp5rAM7Vw/lzAB7U3p/QEu+cJNPm8EhO/pDx94vZRbs7hhHyQd2SSfpL4Oo2jMj8Ynxaucn/qbXHClCxi9HmvXbRQGMrOfWtWeMei8Gec9aKWAVhFNjSycllXHTOzueiIHc0ly/iHfrgPyrhtWfnpplafWUNJY/0CyPkFFYDYDDUr59FIg5M28k6Jdh5tCOmpCkBZcLZ+Le6RUd+y3x6A+SCUQ0h50Y5P5AGGkaf+95jISH9sdYCW2Vl3alVrmQGstyCOrgP+MpBrUnHb9RMNAp9wgVKXwKo5rQtHL0gxECeLZ4747p+4KpRphqQr22bjaIEEI;4:2ZwhzCqW1qFbOvt7u8QOBGdaK+sbW6YOpeE2kbGz4MJ9H08l6DrUwMtTPirWPX3xoZt/3fntba7LFVQWrfKK2HYbEsttSDaelqblasOMpt+WMsiaGJ8fXEa2b9MaL4GBwp2EsH3hIFJuhZa4q3piQl3+hqkUb7eRyQqj8ewkuTiuL5v3MxgOpdEVf/n6Pcw0fYJPSHk3eUz0wGCLPvZPza8yEADQZR4L+/rfgPvb8+uPx5yRLIwVmPsLrinNIDDNiCibZiadyoSqZSl2Y1HC1A==
X-Microsoft-Antispam-PRVS: <DM5PR12MB235852A077918EBD03B179DFF89B0@DM5PR12MB2358.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR12MB2358;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2358;
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(39380400002)(396003)(376002)(346002)(189003)(199004)(377424004)(186003)(64126003)(26005)(50466002)(7736002)(4326008)(105586002)(305945005)(77096007)(54906003)(106356001)(31686004)(81156014)(81166006)(8676002)(8936002)(58126008)(316002)(16576012)(6246003)(53936002)(68736007)(97736004)(230700001)(6916009)(6116002)(3846002)(478600001)(6666003)(65806001)(66066001)(65956001)(16526019)(72206003)(6486002)(47776003)(229853002)(486006)(36756003)(86362001)(11346002)(956004)(2616005)(386003)(52116002)(23676004)(52146003)(3260700006)(2486003)(31696002)(446003)(5660300001)(59450400001)(76176011)(65826007)(476003)(2906002)(25786009)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2358;H:[10.136.128.133];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIyMzU4OzIzOm1UTUpxRGs2cm1rbk9GNm5vc0t1QjRCYnUx?=
 =?utf-8?B?L0hrZ3BDQVlVeDBOalB2ZGRTM3RwWmVRQWtac3MvWVFPTE1RS29ibzdqVXF5?=
 =?utf-8?B?TEcxZ2QxeUNtcnMyckVzNE9ZeGdPcExJdllWRDZHaGJVbXBZbHZpczQvSG1J?=
 =?utf-8?B?ZnU4bjlNcHdHVk1kajVsN1R3aVBjdi8zYlI0b3hmTXZwNDNHRDlveWhYMUJR?=
 =?utf-8?B?b0FSWTR4SitELyt4WWkzRnpEUTFxUlp5OFVucFdaNmRybE5vbnpEZU9BWHBX?=
 =?utf-8?B?QjF2emthK2Vyczl5aVBlOHRMdHJ4UFRnTk9ad3F6dE4ydTN0bUo4MFhMWURF?=
 =?utf-8?B?SHIwazViZTdqc3N5S2pVRU0wNUNlQ20rZGN1Z05CTzdDSmlxcnduMDBlRlE5?=
 =?utf-8?B?Z0M0Nmd0NXJYbnJGallQS1JkcEsyQnM5OVNQd2JaQWRHcUdrQ1FSUnAwU2pT?=
 =?utf-8?B?UnQ2S0RWbk5aelJBalA4RWF3YXNLeGRGVmZ3Z1pkQ28yYmVYcTRYQXdQRWJY?=
 =?utf-8?B?TE1IL0tZdjFPWnlkT0dVYWRyTkNSbEZXaXJvd1NNM3UvT3pCTUt6RmMxWUV6?=
 =?utf-8?B?Z211OHJiREd4K0txTkczRGJRRWI3b3BTMFlscjNCb0NxUGVMSi9pcmE1N0hx?=
 =?utf-8?B?NDFxS3JDSUlKa1J1YnAxeFlzS3JiZDljUXhJYzk2SEQySDYydVF0b2ZJa21T?=
 =?utf-8?B?VGJWVFdRbWp1cUpUaGc1MUZSOUV1VG9mZW5FZWJuUVVtM0c5bjYvSlFmYk56?=
 =?utf-8?B?U25lUFJaZDM1ODdGRlVJVWU5QjhKSnNwMEVxWXErcFN5dXg5QjZoK3d3QmtJ?=
 =?utf-8?B?ek1Cc1NDdGxnNWdpZ3JQWllXbm5oRDM3WjhvMWdpbGNjWHZJTHIwMW8ycDk5?=
 =?utf-8?B?Y2t4cWxMeXJSQW9wSi9Fek03MXJHQzJOeVFBdThCL2s0YUpqSFJaU1FLeEtz?=
 =?utf-8?B?VWJ4NTkrM3BvVTNRL2NRdVFvSlFObVNhdXBDUnIrRzcvQlZnRHVmeEgrRnBG?=
 =?utf-8?B?NHRHNkFJY3U0cVFLd2ZseGxWOFdTQXFSdUM0QWRPREtrelZsREFEd01vWnB6?=
 =?utf-8?B?Wlp2eU8wNktZcElmSllyQzF3d2dPdytyK2hwSWoyVHdleWN4WjFRdHlrdG5W?=
 =?utf-8?B?RGFBcXJxK2Q0Z21sRHJGNXlmNnVVK0p3UEx5OGVkS3dseGx1QVNaU21tWjVi?=
 =?utf-8?B?ZERRK2NQQkNub09kbndkMFE0dHZORTUwaVB2ZWpxcXVxeU5aOXhvSW1nY041?=
 =?utf-8?B?YWdrTUdXQTE2TFQ3WGpZdkhVajdZL2NmUFh6ZGcrdUVGbERrVkx3VFA1Y3pZ?=
 =?utf-8?B?VHVaeGxKS1ZtMzNQNTEvWDl2UTBCc0VwK2k5VTY3dHJIWHpaSHB2Z1dBakp4?=
 =?utf-8?B?ZUdIRmU0eTVXejd6OHZlT3hWTkRYSGl3d0VMdFNJcGJqMlZ0ZUtXODQwbEpk?=
 =?utf-8?B?b1pzUUhPU3lQdVVZVDVReXlPVHFBOHdoMXVTZVUySk14ejNMOUV3UFZNTHlu?=
 =?utf-8?B?anhxb2wxUVp3WWd2WlhuK0laZDFYa3JrdTIwQ08wNm4wYlozeE95b2tlbGdC?=
 =?utf-8?B?bVBYemZnOGdZYVBQTEl0VmxzYzYrSm9SZm11NFJ0MTQ5bG1DUkxEKzNMQlQ4?=
 =?utf-8?B?dXFqNFRnc21MbmhGVFVoYkdBMGVIVnBwZ0kraXRLWGxQQ3pJVElJVmFLdnZk?=
 =?utf-8?B?Y3VoWEExdGVtc2theUszRzVQRDZVRFBocXRPbzNxMUhIeXN6bWlyS2RZSmpy?=
 =?utf-8?B?cjJpV2JxRTdiUktOdXc4NHlXcXRvTGpGTnd1ZEIyaWp2dml2SSt6YWUvT0J1?=
 =?utf-8?B?Y3JubU8zNEJNUnh3Q2pORFBSaDlMOUE3LzF4aUlVSWtHY0lRQTVyUDdrS3Ja?=
 =?utf-8?B?V21IOGJKdlB3REQvMTdYZUJXZzJoYXZzT1g5emwwZ212STdERDB2MzFEVEYy?=
 =?utf-8?B?NDl6SWk2MTh0bTdlWUlmRDZmUU1WaDR3a3FUWTd1VmR4b2JJY0JVRDhBQmlr?=
 =?utf-8?B?MDhHQmNvbWJ3ODZRWkhURkNHOHVocDM1cDVsdDJUdW5qZmNrdlM0Y1o5YVpq?=
 =?utf-8?Q?rs/S6M90MUXC94d9eJkbiH6MD?=
X-Microsoft-Antispam-Message-Info: WzTrsciXPGBYr4QiX3PphnS7xKj1q28Rh+zSKtMB0XsGuQXzDxPf65bPkaamLOahdHccN/I/87MnV/RGaaOXS+6wfFzJIE+mWo9FgysHOQWMRmdVgrIg3RiWFFcLzWr62yTEoZE4bpKgnkdgG5QUsRqpPd705feIVQuNoouQGQbjb2MuEW57Nm7OGq+HVUG7
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2358;6:W4XFzlTCU2rPXhvU2boZ4c7GWEF5eWqoW+i4EKNuOBAauus39pr2mVe4medn8vcsAXt6E/d2BX/UOQ6QwroGuSXIE0CxSQDmq8FnupuhBP66heopVcD6C9pGVOMR1uX9D28mG+DOInIMNsgMswkmWDPlNzACxtkTnFnfJBj2xQqZXZMUY0bjS0jsL/yGuTBgYV1un8BEfKNC+nnAoNK9HvEoB+dJ0PxIQXZ2Eonfs4DNWdILxkveZaTdIzkTcRbaTHfFfPv95Pe3wlv1lUTknTgVUckx8m0OMtUrjTO216i0E7scRQASsotWkyizp+HQQdV0U0icQwCS0ONegdgSpK+tWtV7sG/zlk+cKti1k0JUdPHunFpmhXrmRCHsO7CSUz1sw2eAXEVwsuDm3ZznaESzKwNS1CxbD2sIYsceaa3P3Kfkn+oALywJdooFPBYvo6lxxBVeLqrxaHfVrmSU1A==;5:lERxpiBKo9ILH/bvKvgvZLQZFar5CTHbdxp7nknY6Af0tw7dbNht1X2gAoth/4+1gJvc10zEr2zJIVGTQB+cwzA8nu4msa7BOGVjJIFqaFZ7SNpF0OPArfjYvHsO6mlItpGSzasHTPh6QDBWNlip8FbHU91FaANMZrEXm+n1rl0=;24:pPPeUcOoi/LMa+SPabx2k+HbdcS8sfmYXm6ygrqUooZ/PrycJfa/zgf4nS1H8aCU117+0Av+kw654kdskQGqveRa+HyHoamhdfBOy4vSvGg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2358;7:1+pmHpcogvAWxpfcvxs36bqQEN3KvUDlKCc1zrJXE0Kc2j/65oNuso+w4KHL2+r09Y6OAi8dAFCZkXiGZW8EfScRTQXx9dxUPPGSWlQBB9tQJSHhK6Tv9kj5xRLRQz/ulrXlSoeEnPjZGSVnZ4UFipKtzhbHrdzUTK8lmqM8IijVF+JNNUqOYhH9QXrrDxS/cc74NiU3vUjRNLdLnsVMN1ADfnyEHr6feemerJ+cR5lwymaXroiEI8RxWJ3XS24W;20:SDx2VXKOB10riyazqXrDkm0e9xqHYqcCSGY5lc9h22k6BBBTZg8UrSit/FOv8PUb+XsTKYhKo3bayqiFYBAL3Z4SjL/AW7a2VGutMX1ydi97QmR9g+wOFaP8jQANh+43mlZ/KElbpKy3a4Xd7jm0a2VoztUpvSsQtT0WmeEQKOoekQgw/lUYAnKZkc1tfCjk7gjSSTc6cH9nfbu3pVUUHAW4gdDS2yaiiOY17eSORwKjiZUboBOPF2otN2gALL48
X-MS-Office365-Filtering-Correlation-Id: 5a3a0b8d-adb0-49e5-8ec3-08d5b40237b6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 10:06:33.2937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3a0b8d-adb0-49e5-8ec3-08d5b40237b6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/2018 7:56 AM, Stephen Boyd wrote:
> Quoting Akshu Agrawal (2018-05-03 01:30:26)
>> diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
>> index 1367afb..2aee002 100644
>> --- a/drivers/clk/x86/Makefile
>> +++ b/drivers/clk/x86/Makefile
>> @@ -1,3 +1,4 @@
>>  clk-x86-lpss-objs              := clk-lpt.o
>>  obj-$(CONFIG_X86_INTEL_LPSS)   += clk-x86-lpss.o
>>  obj-$(CONFIG_PMC_ATOM)         += clk-pmc-atom.o
>> +obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)  += clk-st.o
> 
> Ok. Can you sort this by kconfig? Or by file name?
> 

Accepted.

>> diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
>> new file mode 100644
>> index 0000000..d8c283c
>> --- /dev/null
>> +++ b/drivers/clk/x86/clk-st.c
>> @@ -0,0 +1,86 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * clock framework for AMD Stoney based clocks
>> + *
>> + * Copyright 2018 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
> 
> One point of SPDX is to avoid this boiler plate multi-line license
> comments. Can you remove this and just leave the AMD copyright part?
> 

Accepted.

>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/platform_data/clk-st.h>
>> +#include <linux/platform_device.h>
>> +
>> +/* Clock Driving Strength 2 register */
>> +#define CLKDRVSTR2     0x28
>> +/* Clock Control 1 register */
>> +#define MISCCLKCNTL1   0x40
>> +/* Auxiliary clock1 enable bit */
>> +#define OSCCLKENB      2
>> +/* 25Mhz auxiliary output clock freq bit */
>> +#define OSCOUT1CLK25MHZ        16
>> +
>> +#define ST_CLK_48M     0
>> +#define ST_CLK_25M     1
>> +#define ST_CLK_MUX     2
>> +#define ST_CLK_GATE    3
>> +#define ST_MAX_CLKS    4
>> +
>> +static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
>> +
>> +static int st_clk_probe(struct platform_device *pdev)
>> +{
>> +       struct st_clk_data *st_data;
>> +       struct clk_hw **hws;
>> +
>> +       st_data = dev_get_platdata(&pdev->dev);
>> +       if (!st_data || !st_data->base)
>> +               return -EINVAL;
>> +
>> +       hws = kzalloc(sizeof(*hws) * ST_MAX_CLKS, GFP_KERNEL);
> 
> Fix the kbuild robot errors please.
>

Done in v3.

>> +
>> +       hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz", NULL, 0,
>> +                                                    48000000);
>> +       hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz", NULL, 0,
>> +                                                    25000000);
> 
> I'm not sure why we even keep these pointers around though. The driver
> doesn't expose them as clks that clk_get() can find so they could just
> be local variables and no heap allocation is needed.
> 

Respining the patch with change to unregister clk_hw in the remove callback.
Will pass these pointers as drvdata to remove and use them to unregister.

>> +
>> +       hws[ST_CLK_MUX] = clk_hw_register_mux(NULL, "oscout1_mux",
>> +               clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
>> +               0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
>> +
>> +       clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_25M]->clk);
>> +
>> +       hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1", "oscout1_mux",
>> +               0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
>> +               CLK_GATE_SET_TO_DISABLE, NULL);
>> +
>> +       clk_hw_register_clkdev(hws[ST_CLK_GATE], "oscout1", NULL);
> 
> Could use devm_*() here in case you want to drop this stuff on driver
> removal?
> 

To achieve the same what you have suggested, I would be using remove as
explained in above comment.

>> +
>> +       return 0;
>> +}
>> +
>> +static struct platform_driver st_clk_driver = {
>> +       .driver = {
>> +               .name = "clk-st",
>> +       },
>> +       .probe = st_clk_probe,
> 
> suppress attributes here to prevent unbinding from sysfs?
> 

Accepted.

Thanks,
Akshu

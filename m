Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB53C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DA1208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Qq/XJaHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DA1208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933216AbeFUNcC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:32:02 -0400
Received: from mail-db5eur01on0128.outbound.protection.outlook.com ([104.47.2.128]:53432
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932755AbeFUNb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6QTZc1ri/wJRsUaozV+vwCALaH0YZXnF67nmVfLqqQ=;
 b=Qq/XJaHmAdl44/XmsPQqVZBqLrcZmzapDRjXXGhi2Vq3bCFyEnDgLVwDNWKiK3Wfbo3w34umZ24zsuR3lE2W6CE7HddFBccvGugRcpOajCd0OKIFB0NbXOxrzKDM3TK2CsUI2Td2VztFIJzwagVgYRVpl9dwM5VLQ6CnY3Msuhw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 AM5PR0201MB2451.eurprd02.prod.outlook.com (2603:10a6:203:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.20; Thu, 21 Jun
 2018 13:31:55 +0000
Subject: Re: [PATCH] drivers/i2c: SPDX-License-header information
To:     Mawanda Henry <mawandahenrynaco@gmail.com>, mawanda111@gmail.com
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180621123652.GA8426@sesnaco>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e81dac58-6807-c2d0-ebdc-2f5965f22560@axentia.se>
Date:   Thu, 21 Jun 2018 15:31:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621123652.GA8426@sesnaco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P189CA0034.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::47)
 To AM5PR0201MB2451.eurprd02.prod.outlook.com (2603:10a6:203:35::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5998fe47-0535-426a-5c9a-08d5d77b5bb1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;3:qJnEwF4mJnslRiQ8Bjqyhd4O8u4NDRMYcJe2YgfvGW9gibnoJfoyiU89AZOFVNh8JM7bykny4e0ql79vVSxVceos2r0oCQ9vnUwIDz7vnnXATRCKtlgV4Jh2ntf7RwJDB7dVFvPpkiJfxE8JBOjicdJt0Qu+g1uL91Gg6HwtjHtEWyh5GIqFqjhRJTllz/ppSPfJvXxeuu7pCYhe9J9Ir9IK96zP7AVdnL2ddI0jxFL5uawJbesEtd8wVwr6cDAN;25:AFJNN0sHSjC68g54zLD3qGW7bUrWQmdWQEHmjYwy21vfphAWXB0COqQVIQABmLHBc6GEIuJyvHujuLU4OKaV6gDOyGRoG4qP0koJinS3TjkAvKkgBURNcfdAWHPpKtuWLUu5lhzz4DAMP/A1KAmrvaPyNE7mBIVaFC1atCQ0ebpL89+8Xx18UE+QUO3yie9Ax2LZ7UhxTxp8tvU6Hd6I7r1Cmp+dAXRCfDqEFJBeosjK1AQD4liq7Ao82iBlv7Hwa0ddnE98e723BAsdfSysq6P3wfbW70Y6hu3Io/BiFwoLbF0mYd9qMnX75YdWZeqWHIoCTCI60WRi/ur1mdv7wA==;31:rKFJA2UIo1ei+Vk5UQlh7j/cO+yY/S9BbaTJTNZZSxZ52FhuepnJrnFInr/uXE7PEfhH69GVMf2Zas7M2C6OhqV4h06iL6XNtLxDPg1E7ddrTb+bPUAhHG1ws8SDT+GT0nXaJHQ7cMYeK58Xm/UP5y4QKb4OrLdjWbhbrYXVFAiMT2dufZGN08PNneTqdWa5MzaQJhbC3SFvr22+irLBPIT5QkBrnM/7IvyA5RUkjsg=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2451:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB245149C59F271D7815EB0307BC760@AM5PR0201MB2451.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2451;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;4:Hi/MJU/NlN3S2mEExQZwHNkioL6PS0C5wl8P8pEuAVQ0ppOXCCuw+9w+7wkvLmYn5+zr45cEYNhScejLtfNkGUjIBdoV+8uMai9SvMjq6q/VbV4kFzP0iao5nh8MnIZ0FB2LXU+eJCRJ27bpgo/d3HiOItz5WjgCBtgDTDxNNA90/GHsAfgQGqyhvOG19FOvE8lxchTHVW+5Tmt/8lW+0O6us+hnplD4iMpDH9PSDeBq/ITx4DITrzoL5/5RjWdVrk8KUBZS7vEX6OQxIBIPv+OMEX8kl9/djk6RKlfXHvUZvcYI2kskZtD/8OB31YrB
X-Forefront-PRVS: 07106EF9B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(376002)(346002)(39380400002)(39830400003)(199004)(189003)(117156002)(305945005)(106356001)(476003)(65826007)(31686004)(6306002)(6666003)(105586002)(4326008)(31696002)(230700001)(486006)(2616005)(3260700006)(53936002)(86362001)(39060400002)(25786009)(11346002)(956004)(6246003)(446003)(229853002)(7736002)(50466002)(74482002)(81166006)(6116002)(8936002)(52116002)(8676002)(97736004)(81156014)(6486002)(478600001)(23676004)(52146003)(47776003)(2486003)(68736007)(36916002)(16576012)(966005)(66066001)(65956001)(65806001)(58126008)(64126003)(59450400001)(77096007)(53546011)(2906002)(386003)(16526019)(186003)(26005)(316002)(76176011)(3846002)(36756003)(5660300001)(2004002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2451;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NTE7MjM6UWVHSVlvWGdUOWFsSVkyaHdSVmt6UkR4?=
 =?utf-8?B?eGZ5WXJNaTdYSFd0QjFlbGlhTUxyRGxkZFRVRy9qS0hNRE1pdDNwSEVYQ25M?=
 =?utf-8?B?QWFXRVVPTFdJMEU0S2xpTTdKeUxaR2o1cUM5NWRhMm82bWE5bE9TWmRmTlhP?=
 =?utf-8?B?QUIyK0cxYXpkQ0Q4MWpab0ZMQUVWVDh3SFpORHZrQmY4MUd5Uzh3dFROVzdD?=
 =?utf-8?B?WVRIVGxHeWJBRWtWT3VMMjlzYXVRNWdIZUNEcjdmcm5MTGNmZlgzK3prdnFG?=
 =?utf-8?B?bk5nRzJDbDE1aENQYmxWVkl5eWpvOXU5KzVac29DdVJsamwwMDdFeENSMlFt?=
 =?utf-8?B?ayt0YkZhK0g5ZUNEYVRHRlRtV2RndldFVzNBNkRjcFIreTJzT0YyNS93Wk1Z?=
 =?utf-8?B?QkZoQWlHQitiS3I2dHpnWkFUbUhDdUNJSzVPWTFyS25mY2ZYR2dUNThoQTVu?=
 =?utf-8?B?VUduMXVkRHoxNjVZY3psVnVkV2h0azlGRkpoazRvdllmUVltZWZjRmp4dWdY?=
 =?utf-8?B?VFpxZjd5VjFQVlRhOEgxMjJlalYwbzVlWlNlUDYyOHRncDRTNmd0WVRJeG9v?=
 =?utf-8?B?amQvZEN2Wkg3MmJHNkMzanRIc3piYnpDcFUyWCt4cW9rR2FhdGNTZXAwU2FD?=
 =?utf-8?B?M1VlMnNsMmdWZUhEYmFRby90NFIvMEhYQVN5N3hoakpDV1kvdC8zOEY1ZnRE?=
 =?utf-8?B?QXRTek0yNzRkWGpyVklVaDhOVXJ1ZDZzR0lUak1kV1Y4NnhWdFpBSzRLQU1U?=
 =?utf-8?B?aHl3V2d2RTV0SEJBV0xFelpkKy9rMStMRzRrNk13a3B3aDQ3NXk4NE4xaHlD?=
 =?utf-8?B?T01oRG9kSjRQUXUrb1pFSkJ2S2dxU0tSeWtaM2JNMDBBV2FKRFJ3VGpnZHFi?=
 =?utf-8?B?YnEwbVRUT1k2N2NvRlRpbmZZeWVtREcxemY5L0M3aERHT0l0d1dwemw1ZWxG?=
 =?utf-8?B?K0txVThWUzdNeWVPYzF5d3BnZDArK3RNby9VZlV1RXVjUTVqZ2swbUVmbkxB?=
 =?utf-8?B?RElVd3c4QU93Yy9pdWZ6dSt1ci9MWklLb2hkWkdZeENnWjBkTVFOSnpCbFh5?=
 =?utf-8?B?c1JXNHFGRkpMM0xQVzRmZ0syRWZYSVN4VzBMdUd5N0pYblRHZ1V2MHRKcXBp?=
 =?utf-8?B?M2Y3Z2ZmYy9xRk9NZ255YWFEZHZyVk1Wb3BvcFNYc1UwNk95dEFGbWtUUFJn?=
 =?utf-8?B?VUpGSEFTOVFkSDBUbTMrVzB4b1hsTmdibzNGazdhMlN4cThMb0NMRzFrbGhH?=
 =?utf-8?B?UkRtR2VwSUVEU0hJN2Z1TzZ5MzU5UTFLZkJ5SzArVHY3VXZEMDdyMkRaVHlH?=
 =?utf-8?B?TWgzY3VCMjh4Tm5GQUhyWFdIQlZ6dFp3L2FZd2VqZ0t2OTVNNzQ5YnVtTGtq?=
 =?utf-8?B?ODdUTnVrNUYzL0JTakRNWUNBMGlIZmVmdkpvMm56N1lqOFhyT2xxK3FST2RC?=
 =?utf-8?B?SEZEeFBtNER1bWM3dVc4bS9vVDNEQzkzVzJ5ckZzVit1WlN1VGF0eVNvVGRu?=
 =?utf-8?B?U0NSbG9YcjlMb2J0NklUNVk3elVYK1ZCMUxxYXJ4TUlmMHRqM2pnUGZUSXNZ?=
 =?utf-8?B?S0tYTWlMNUFSWWE5aUVHRDllUHRVOU9xUWdHeEJ5UWdEMzBLSDJwMyt2eHJJ?=
 =?utf-8?B?THQvWGl1cURQWVgxb0tpUTBsZitqdi9TL2JmN0l1SHNBd1Z1R3hZOEdvMWM5?=
 =?utf-8?B?NGZrNGRESXBaajQydmZ3SUJIdGhvZVVSR0ZyZVJMTmFVUTd6SDg5MTh1R1RL?=
 =?utf-8?B?VzVlL1NOVlJDUXlZU1NKZ1ZBaVlYTE9aTUYydmJPZnhHWnNKOTJveXV3YW1I?=
 =?utf-8?B?eDF4L1hRK0pETExPZFJhOStXQ3JaQzgxZ0F1UVYxdTZVSzlMZ0svYW9wSXNZ?=
 =?utf-8?B?UTBsdGRRRW01MkFLMzE1clpvZDJncjZqR1lUcndzc0dCQkp4eXZSbk80WDJa?=
 =?utf-8?B?V21OajEvWmJaN08veHQrREpRQVZJNUtZSTdrdldTT1ZOcy9mRzFhYUZYYUI0?=
 =?utf-8?B?VWVXM2F4Rk5mK1ltVnhvYks2K3lKcU5DQzBLZThucndMSDV6bXZ0M0FCbnBE?=
 =?utf-8?B?aEx5WnUraFNkNEM4S0ppQndicG51MG1YV1JvMm9EeGVQZCt3Y2F5ZzVXUU51?=
 =?utf-8?B?Q1lacC9hMWJyelhzcXNtb3lUUzc5amxOVTVmNE5mTE1PQ1NxL3NWZzZ5R0ZY?=
 =?utf-8?B?dmd3eFE3SVBTOFdKUE9jTDVoTnU4b2c9PQ==?=
X-Microsoft-Antispam-Message-Info: rxKRi8uvjo+RJ0bMrMOStIOwh/Mrrt4kL6OIgEIy6+DweVIkpDbHC//sudpkl0J3hLTdp3HHoRK6fUPxZCfcumb5bU2W8QOIrapg4v1j11wFEciLbbwnOpsFHsyXBMvewHIHH1jXA04EsDAzMA50gKdOYU8y3+/1w+3NX0YH2l5d0mesXwb0YwUfnPnqUDX05xr1MmwKJskHn+Gqjn2Th/Dd8iOs/vAIhrgA6/OVFF7YzgePWwEkzzFfQ4BKc1UNGyTpzTPHCE3y2WAoVQyX4+d9e1R4IDY5VEFW8FldfTAlx2k4vklD6vDPMJ8BuZFp
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;6:71HO5RvTc9ue5jAjDMQCAeiZQZM18A2ZnJoqU2Lfqk/eHiLcSbZwvC49H/OAWua6N5M7LVGqdS/OwcUrgkRFG1X5TJr9sivwk6uuscx/vcW+HohotUbXaTgtkTy0RufBMhcLw6+yJoaGobVjMcDvCpQmVg0b2ZMgZjCM/HFfiYUvSVL0+OKym5a1y3szPMm4+Tc3pE7dsHikkuHX2JzHGXN6i10oXFh31kn9llFebCMoCPrWjGEc4Lh6UOTiZdyHfG53NHzrl8MVfjzsjqyHbcXSTbVdA+53kvFFEjcpPzwQAFE4GdO5Umv0/t+uisuq+HF8fLtyxiihVjKeWE7Mdj5W8/9l0h4kxwT0Ee/6wBym6Pk54hMk7nYGRHJrJkQvxtdOHellnigov+k0SuCghsI0Bal8YjV1YpEiqhKH7lq8jyN1rmKjCM9sWfrEywAGu1l1H+pfr2qGNZYd5zIfgw==;5:m25A15TuczDWe0jixufmU2uoe4U6OTW6NA0TtyHyF+0W1xQwwPWdtUd89SWB7KlSMA+MegIYF4oCeL3/iR6HfJ+fN38TbUM540BhG6JIlZC0qpKiTKnGGkQ/vfq9kAOGS6MW8fy4n8Hpnj98dHtBVluvk0P/1NIWcBODYTRPRrU=;24:lp84nr9aYmqVkYDp3K+94ZPMe4SB3naVAiX1YhGxmFr+RJ6t9VE/CVzMDSEpMMI9AzVfOlEUDeUC3HTuFB17+V1+T4mL+tlml+L9I4uaOyY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;7:oopF5TWDV+chNnpzUdB0qRUgQF8ugx51YzZs8h1XodJRvaJYS6VKMQkMaMB1YwgV9llpOwuVEu2L1mOgrovULaKZGzhYvAFEBJOkxMiNPP+dmr86rl9nt4qCt4BabFJWe3TXnH35gvhDkLShMs6uw+cQQgHVuOYq6iBvrIc2vJXtsjS5gAlXm+EWfgOPxlQxQqRACtyKaBKwB8/zTfFOEy4oAXjEvAl1tiGsfYvO52lUkzL0dkQlO8aLBvJz49pe
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 13:31:55.8342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5998fe47-0535-426a-5c9a-08d5d77b5bb1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-21 14:36, Mawanda Henry wrote:
> SPDX License header included to easy developers and machine to know the
> license governing a particular file
> 
> Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
> ---
>  drivers/i2c/i2c-core-slave.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 

It is customary to make note of the patch revision in the subject. In your
case that would be [PATCH v3] for this patch and [PATCH v4] for the next
iteration. Speaking of the subject, a better subject for this message
would have been

Subject: [PATCH v3] i2c: slave: use SPDX license information

Also, when doing multiple revisions of a patch it is valuable to record
the history of changes, so that reviewers get a reminder of what has
happened. For a single patch, this space here, just before the first
"diff" line is a good spot for that patch history. For a trivial patch
like this, this is not super-important, but still best practice.

> diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
> index 4a78c65..d2cc8fc 100644
> --- a/drivers/i2c/i2c-core-slave.c
> +++ b/drivers/i2c/i2c-core-slave.c
> @@ -1,12 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+

Apparently, GPL-2.0+ is a thing of the past. Should be GPL-2.0-or-later
according to https://spdx.org/licenses/

>  /*
>   * Linux I2C core slave support code
> - *

I said "line", not "lines". The above line should be left as-is.

Cheers,
Peter

>   * Copyright (C) 2014 by Wolfram Sang <wsa@sang-engineering.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License as published by the Free
> - * Software Foundation; either version 2 of the License, or (at your option)
> - * any later version.
>   */
>  
>  #include <dt-bindings/i2c/i2c.h>
> 


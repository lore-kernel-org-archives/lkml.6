Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB5EC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CD721A0C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="qfzp92EO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CD721A0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932902AbeFUSYG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:24:06 -0400
Received: from mail-eopbgr60111.outbound.protection.outlook.com ([40.107.6.111]:8064
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754065AbeFUSYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFtpJBTX8Lw3PoKm6QNFpEf0pfSZsUmRHzKWRx/5pYs=;
 b=qfzp92EOV9f0QRSVa13aTAkpVhDXHUyHlkWkYJ0IHiuoPbgzo9NX/vU6z+eJlmX4rQ151g/f8EO4+ionLAdmjveEIxoSwzwkR1KCHpnn3JFQGPtoPMYkUbyrdh3dfCmnVHhz88pU/1c6Fivj+1PPxxcK9zQ79cMRCynxkNoE+QU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Thu, 21 Jun
 2018 18:23:59 +0000
Subject: Re: [PATCH v4] i2c: slave: Apply SPDX Lincense-Information
To:     Mawanda Henry <mawandahenrynaco@gmail.com>, mawanda111@gmail.com
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180621160530.GA20061@sesnaco>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <02958ae6-e6c7-5483-5797-c4de5515ed15@axentia.se>
Date:   Thu, 21 Jun 2018 20:23:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621160530.GA20061@sesnaco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0902CA0011.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::21) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7b857f8-b4ee-4f4e-2151-08d5d7a42895
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:VYifLOB2avRQKGg5qO7KgH15C58IFvFY2JO2cOIEjCH65j9aD01WvhLFqF/bL6ZtkQXWPSxT4tUVX7VKuDUoetEDMx/gQl9FNGouV7ZTwC4xu4qpRu4z9jzSWG+d69tgP0RtrbEB3S1+JmknSbJXWVvvkMagyE1l6WrT6H5wiNZsEn0GzhmWsjROWBEfrAIXUANbvCMHfd1aUR5XtVs2pei5bMWGRTO1cPU1bgI5VQf1AI4gaq2fuCG6zOyf8S4x;25:Ol0PmfdNIxB/fOHjxOUO6aEfUqmr7pZxmoR/EANFaj4s6t21I74L3lucJKZpF1raLrbzu5QkWit0b2R45tt/KYU/1zLm8uXQwOuTW7VlbnNzNOV8dnX/Ibo1cMkp0AIPWmCV2+g5/tVz/NrHv4Q4byQOdyHpN/0cgM3l9r8ITpsUxgThs5knp9r1VLF7RguJmh0qfZjclCetXlzwC6FvA/z1kzV64qWFagyiyOnROnsVFYcys9Jno9FXhFMt7GXhC2abebcYi9ye3CcBHkp74pear4G8uPhRb3SmzKIi3WJPC2rAyCOI5Mz2l/AJaaeuz2QaYU0V3iadmsFt/zYzaQ==;31:EN0XyNuY2i4+QbahL/TX6zE47YTjDnR7IO/WVdZEJotj/PKmW1sMFnYDSiosjG0anGQY67DfUZWYk+S21eGgrdA0wjMDQabqMb8LGaNioRrT6+cvXCuBg9UZ7hoTf4axE842FWTK2/vDd6M7meK0FCMia9VdjjVaBWbhfLh19h2rE2GWf5el6lDkdNfx9zrtQnrH249L8tq7S/VGFE0ju6Tr/bpHwmSObgExHYvPysc=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB24640CD6FEC468859F84C3F5BC760@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:06KUCjIKoASnMmgbEq3IxFY9jxaFmG3etsgihOPTBvT+OcKNTeKNvFHSWL1P/oX/Z9DUXp943SlzF4uq1HyGEQ02fGuoVSkxyYJPS3S0y+o6aBT7rEeN1/0iu8aBH5JbJuCs3VD+sksUNGRA8Y0MTj+WuHyjZVqalR9GEJwj5PDag+HT26e7fmOikFpyIKV9lieIPRpJ89xU/Y82ludKabk6OTv+VpXNxS2Ot6m5P+EBzriva/cC+LODmA20YROp5ALwjTx/PODPDPvBHdmbaSab4ERU+GZG2K6ITXKFMBBvPmm+M6SZH2z1RHrkm+5a
X-Forefront-PRVS: 07106EF9B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39830400003)(366004)(39380400002)(346002)(376002)(189003)(199004)(64126003)(6486002)(305945005)(74482002)(478600001)(7736002)(6116002)(97736004)(3846002)(50466002)(230700001)(229853002)(8936002)(81166006)(81156014)(86362001)(8676002)(2906002)(68736007)(16576012)(76176011)(4326008)(39060400002)(26005)(25786009)(36756003)(6246003)(53936002)(386003)(3260700006)(117156002)(53546011)(65806001)(316002)(77096007)(6666003)(65826007)(106356001)(47776003)(105586002)(52116002)(476003)(36916002)(52146003)(66066001)(65956001)(31686004)(31696002)(186003)(16526019)(58126008)(5660300001)(2616005)(486006)(446003)(11346002)(23676004)(956004)(2486003)(2004002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjQ7MjM6c0pXYjE2MWhmaXE1UU1pWG43R0FhWmJD?=
 =?utf-8?B?NndvNll0U3FzQWlyUmRvaWNPRUlQSGFlOFNDN0dzMTBMWGhEd0JPNFhHOTRs?=
 =?utf-8?B?M1BmSG01bUNMNnpFWFJCL1FweXN0MEFndTlYN0VHd1FhQWlmdysxNjBnb1dh?=
 =?utf-8?B?MUIyYk10NXZkNFE5TzU5YzVYaGl4MWFBcVo1cHlsVVdZdDdtQjhDKy8vTVhE?=
 =?utf-8?B?bjJwMjNjQWkzTVFhWWkrMzdaenVXd1JZcXYrM2JTWktRQ242RjhsOFJweThO?=
 =?utf-8?B?cUhLaDA4Sm9RakNpbGM3YkkzbWdQQXpTWVJlMnRFUk1zN1JJQklZOFFJRk9G?=
 =?utf-8?B?TWROTy8wNEY5dG5MLzQ5SzE2Q3JXVWFWVmZkYWd2RTV0anRrU0ZWcnBmUDBj?=
 =?utf-8?B?dGUvSGZBZUlMdExyRzk2UEJIOXdEMnlsWWlZUWVHZ1ZmaGhDTXE5RDdBb2tQ?=
 =?utf-8?B?elZYdSs2YmJBNXNWd1dyb2xEaDVYcUVna21wRXU1c3p4dFlGcmZYRFZsSG4v?=
 =?utf-8?B?NHJ6SzhnakhyNGxib2d2QW5pemJGZzVqWUpmYkQzWm95bjhzbmpIQnI0SFpa?=
 =?utf-8?B?bENTenlkanN2SXc5dUVjNHRxMlk2Q0krY0R6Um1WK3FrTWZJc1BEZlg4dzNU?=
 =?utf-8?B?UG01VnNoMWI3V0JDM01WY280ci9uUC9sazNVSHYxdnZ1RWJRY1VqK01qN0ta?=
 =?utf-8?B?ZDRLMzJoN0MwZVpLMWtsMlZCMlkxcS9MSmhOWWNsUkJtWGZVWGZUM245YXBY?=
 =?utf-8?B?RWhURGFGaFArU1lZMGUvYzVCZ2pHSERrOHlEMXN3OHNDTmg2U09GUG1ncXpO?=
 =?utf-8?B?eTVzb0Vuc045Mk1OUGI5MGRtVFpTdXJFUTEyR1pqdjdTM2MyWFNwK2RzTFB3?=
 =?utf-8?B?Rm5xSjhJTDVXZlhPQS84K01mT3Y4anorSDN0YU1uZExzbFY4RjAyelVsa1hs?=
 =?utf-8?B?NEU3aEdYcndCNUN5YTN4UDJpMW01bVQ2dTd2ZkVQUUdyNjBlZmlZU1k3NUZt?=
 =?utf-8?B?R21Vc3pGL0hsZDBESnRZM0pCUGMyMU5hZGFadjhldWJCSnRWUmY2VXUxSFZR?=
 =?utf-8?B?Qnl2OHFBWVJOV3ZJUWNPY0RvbUNpM1JzNXgwMUFDVFlGOHhwRmhvSW0zTWdW?=
 =?utf-8?B?UGU1clRrYy9kb3NoK0U0SmFpaExLT3NLN0MvTGNjZDc1V3hEZUNWT3N5WEE1?=
 =?utf-8?B?T3MwN2p1YzFyTnpGOU1tUENIc3RmZ2lMYkp1UzJiejF0VTBheDZVKy9BbzBJ?=
 =?utf-8?B?ZmlDdFd1cEZGTklvTHhNM08wSFJ1cmpzYkR0bTY2aldzY29XYTBCbHEwQkpr?=
 =?utf-8?B?NnpmRyt0RUw0dWZlRjlOZVEvNTZmUnhDSkQ0ZktnL0VFcEhja0cza0NSL05v?=
 =?utf-8?B?SUM4WmRSREpLaU91WlhTTURHdFFXUW9yblRCNkk0SlFnVnN4QmdtL3RNdUFW?=
 =?utf-8?B?RnRBNUVRVE5XR3FZZXZLZStqNFc0dUx3T09jczF3dFBUUFpISEYxeloxR1hi?=
 =?utf-8?B?azB5OHhyRUtSU1JlOVJ3eHI4UTk3RE93a1RDYis2VVpMUW9mUzU1N0VtaUVy?=
 =?utf-8?B?R2xGcTRZKzRzdi9YSDd5NDVjRFRPelpEeXVsU21rUzdYcytRZnROZGJaczdT?=
 =?utf-8?B?d29qdlNvMnJYQ1V6V3VHR0s3K3ZIT0wzK1ptWmF6Qkpnd005dkNOT05GWmMw?=
 =?utf-8?B?MDVzcWV6QmhCbEZnbVFPUzJTWE9sa2tRZHh4cmpDc3hENnZxY0JhQmNsbkRh?=
 =?utf-8?B?aSs5R0NVNXB2eWtiTzc1NFlRbm83Q1JJbDYvOGZTUysxeFdOUjRqL1RrQXc3?=
 =?utf-8?B?RXNJVmJNZnQ5c0JCM3dGNERybkN5alRJTXlpSUlmWkFXTWw1OVhFTlQxM01P?=
 =?utf-8?B?d3AzN3JQdGJHb0dHV0YxbUtFNTVVQVFSaUUrdFp5eDhTcTNWOStqQ09jamJI?=
 =?utf-8?B?WFhORWdYejFhSWI0OHBFYUpTNnhnUWsxT3RybXAxYWttTzZJa2VzVmllVDFh?=
 =?utf-8?B?REVJVnJpRHc2dklicSsvWm5nRW5naEpVUEpNb01QWGU0Ym9wcjE1OVJBOHVT?=
 =?utf-8?B?dEMzR2hKUUZYdUNJZjhoZGo0WEMrUElhNVJSbnd5dXMvUWdDbjByaU1nZWt0?=
 =?utf-8?B?TW5rZz09?=
X-Microsoft-Antispam-Message-Info: pFzcOAgvZvpG63dd0cQzIdCoiJI17Z4a5Wyl86ZvrchoYwjjeTzSoDGefS4nd7fn7mwnufj/Se8hlmg8TXM8xpfEy3wV2KL6JkHifVIJGfZxRPir1sAPlNpvmhMxaAK5s4Ef4It+XJCUe867bQu/EASuii/6d6eCHYn/pz0zlxxXtjgTmlJ7Q8L9lY2XhJPQNIlw4PqqGeMdWiJc94SzhyNefXX0qyX8WGSkCNXiIrqSfAdyrxEyaG3diVt0TaodZ/ua+RTTErbPVEJOe5LncZ9SbWtvmVG/zaJO+ncaSrdRvzMt11q963pGAuNRar+FLdZS7oSzgpVVxpR/9Zxk3Q==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:C3KO0JFwkCCnnPD5wab3j81cq1o494Bk6IaXJuac2WNB+jRM96MLoUHBvcxucgvG28eYsdeENYSVyWyGX9pMlcauu3/bt2qjN6ebJhZ7d3gX2U13If2fU2Y4qNVvbdU/J5WC2exZUWTngoZp1j7ZKVQxWd3CBJlWFN5xMRqQ+3a9NOPT0ucXED9Ldshp0EHaoCzuJhSEM/FDHoYDI0JpD4+Hk2olG53kYXe1jUPEeIPB8p4KN+UvjkG1I2cSxQBPGFu0WzLsO55JDBGscoIIQOXtorsglPtxzJ6p96XIxHFFj8ym693dl54+bCJxHscaCXvUngzu6//uYovfTGYq8Irc28vEsBD/sHJUDMFKCx6gjFYzZzNeSPLLKYLMKKYuv54Z2Sx4MnoyExgdXhmyxk4AtIJ5XFV2v72DphcfBUUK+5hECoL43bTz+G3J6l7XeZCC+g9/A50q+lkvAmrKmQ==;5:N3mQ6ptANYp01uMmsmQDqF8w7o1mi9k0pNMvMnvOP+QpKX5GJgejZ2Cirq7gnKb7jhXMLyscA1pEMN5akm1OirRXqHAuio/Zp3OrjYLVOpWvPFBebhXNxpQ9tlmaOlzn3zlqmhsB+ao1bhLz4oEgRSlBkfRK/AaFVDltA5fs2q0=;24:6RJGnvysA0SHf5GnuRAoUXMcr1xviELjW7/EApKRQwVhdf2osqVH7ORMfwob51qkmaSQXBoA4rtkcPb7HXz2BOkg/3nlUOusi2aMrKR1KIA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;7:mY7dwanySgp/raBoHpOl6/oMWccn2zE/JsQXFbfSHXAOL794n/QrBEHx74iIXLZNzhzDR9hAp6onatOn3+lO5vQsgFi/qkNt2NlPckUcLX7sn1qROIY9kv+MImCNiq6NZ1AGRt3TQnzTXR0qEAUsSZ6SfGhPM7e1VloFoEBKUD0iQt6l6UsNsSqyBNVQr5wwS0Dmlv0ZP5Qrr64E9PHCVjtvG+0tAcro36aog6mZ/y7agYZNcDrskjpXuF66o4if
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 18:23:59.3888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b857f8-b4ee-4f4e-2151-08d5d7a42895
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-21 18:05, Mawanda Henry wrote:
> SPDX license header eases work for developers and machines to know the
> license that is governing a particular file
> 
> Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
> ---
>  drivers/i2c/i2c-core-slave.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
> index 4a78c65..6f56e65 100644
> --- a/drivers/i2c/i2c-core-slave.c
> +++ b/drivers/i2c/i2c-core-slave.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+

Why did you not change this to "GPL-2.0-or-later"?

Also, you now have a spelling error in the subject. Why did you not use
the subject exactly as I suggested?

I will not respond if there are further issues with this patch, this is
getting ridiculous...

Cheers,
Peter

>  /*
>   * Linux I2C core slave support code
>   *
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


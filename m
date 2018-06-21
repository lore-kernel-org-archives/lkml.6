Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2554EC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A8920836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="qsHnOvBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A8920836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932964AbeFUKJp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:09:45 -0400
Received: from mail-eopbgr20119.outbound.protection.outlook.com ([40.107.2.119]:48765
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932677AbeFUKJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03zpPEIKNs6KswEw1LSStKCUB/nP5UH0PXBnUoVBhFs=;
 b=qsHnOvBiBOgjv+Zv5+lNyFPlfOIciU/A1EPiaaxvhP4OeBCu3i3SI0f8YEN8Y0vuZDdQbvMg0AaqNSuET9dd1Qt1imsby8qgwLl5EWEdFWnQis9HO2dJi/iLnMxbQPvNF8Z44MhCyGMsi4fIbzhwt17xhGHc1+Bb5hpemxcP2Dg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 HE1PR0201MB2457.eurprd02.prod.outlook.com (2603:10a6:3:81::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Thu, 21 Jun 2018 10:09:39 +0000
Subject: Re: [PATCH] drivers/i2c: include SPDX-license header
To:     Mawanda Henry <mawandahenrynaco@gmail.com>, mawanda111@gmail.com
Cc:     linux-kernel@vger.kernel.org, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org
References: <20180621100255.GA5564@sesnaco>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <6243f83a-017c-11d4-2efa-f2124fcb8ed6@axentia.se>
Date:   Thu, 21 Jun 2018 12:09:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621100255.GA5564@sesnaco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR09CA0084.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::28) To HE1PR0201MB2457.eurprd02.prod.outlook.com
 (2603:10a6:3:81::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bec505a-01b4-4fd6-f71d-08d5d75f1997
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2457;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;3:ZfT6WK1pA3DwwStbFQ7QiZCMci2SjRLzabr/ewSH149qrONdghaIsDOeA7ARmTGcGlSa8K3AdKPjTiiZJYsQUr2+jV/FYHto7CBLbtrBXP4F90a/pRqrT0rVppl6oIImQV512oOqsHgmAtnoFds38QmwQ0nQYrNG/g65Qcbtr4RvGV32dtXWL65g5kWE5IR9YXtbrvONp4C0+BJGZTC7eYzetbIGtPkuzuh0lzI7iwuv6mQQPfKIDM5YYbWoHQFA;25:/PE82XUfsUTLnuFrl6x4zsEUpa/t8z4QtGd4PNrqzzYvK7lMmyW7pOdO8B8FI0rR2Gc9b/YW6I3AEi44bR31SOQHj5uoMZJd8eT4Zo8tE6IZcwksFfLuA9GxmMXgUYC8t6M6KWuO6EI3Z8fHR60ezcXFGcKnI5aO2iLxojK0G2w5LIGfvv518HnsXO0T4kABDF3WXxd9eb34HLR5+89p0kx58bItkCfUMAiNE9odA6E6roL2CzYeIkpTIK8rdWXK7R+ANx7xoOvK4kXZNVeG30rZZzISv2xcnBaQ0TJeZpsSB+Tl7odF/D0+VqkmprIcd6+mFQZI7EPBV0i0dWC++w==;31:FV5y5HDthKBUxOq/S8j0kHWpABbh1hObBJgEG2gE3BX3UJigqcEWawGtDeDI/VVki+3h0PWLsaAEhmCWGT+wzn301zesFcPNAoLMWRK4DfXd/RTElFMbNcohNF0OJ+9bAS788C4NRdxooR5G6UZnpDcOv+CjlZ67iRV1ohrTh5selqT7Co4TnfbQcUhI1yhdPZzaHRzYQk6jkYB4r7Iv43KQprjVMsxYKA29Iwb+7RQ=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2457:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB245799B07F8CAD757290036BBC760@HE1PR0201MB2457.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0201MB2457;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2457;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;4:sWHaCAS/K2y8C7fOsZw6699wdFVIe/QQXCU6/1LmsJMSSAH3wR1DvpJzRUjt+DAyxYBuDd2b771BvTUmbiL+QDl1ZHzdS/LWlKkoqOclEN24FYC7SqEcNQC5aWyt7MY4DpMffT5l3uYb6ZyqGUYSeJ4a/fFEa3JNGBeG2Uh4WINfvBEBEmqRiS8/8BJSaPTvcL7IKIUu/YTNw8FR4xvH0gODo7/LoxeyoZB/+yukKSS0NTw3zZxO0QVLNEcY9P59lvnCNlei6yjwmSg+atKizDXftGf3Wvu2cOA7tWjX2J8BjInrypSHahnrQPLtLuWU
X-Forefront-PRVS: 07106EF9B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(39380400002)(396003)(376002)(366004)(346002)(189003)(199004)(5660300001)(58126008)(305945005)(31686004)(39060400002)(66066001)(106356001)(229853002)(11346002)(6246003)(65956001)(47776003)(2616005)(105586002)(6486002)(7736002)(476003)(53936002)(956004)(3260700006)(65826007)(16576012)(64126003)(36756003)(65806001)(25786009)(4326008)(446003)(486006)(316002)(86362001)(31696002)(8936002)(50466002)(81166006)(8676002)(23676004)(386003)(3846002)(2906002)(81156014)(77096007)(52116002)(117156002)(52146003)(53546011)(2486003)(74482002)(36916002)(6666003)(230700001)(16526019)(76176011)(97736004)(478600001)(6116002)(68736007)(186003)(26005)(2004002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2457;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTc7MjM6aDk5VnRIVmNIclA1dkpRWTZuZS93SHNP?=
 =?utf-8?B?eXR5ZlE1cW1XQzgxdGhQN0RkdDJmUFEreTJiSGo1aHBWeWp4T3FIUHlOWlhS?=
 =?utf-8?B?SStWd1piczBOcVdsaFdxdExvMytLNC9XYndPUWlKT3NYTGxlQk02N284SmZl?=
 =?utf-8?B?UDZqUTRYQUNyS1Nkald4ZzZ0SmU5a09NaEFSaFpOY2J3WHMyZTRWanEzUnhU?=
 =?utf-8?B?ZCs4ZXZYQnZMaWlBcUUvWGwrb3RjY1BaZXo2bjRFSGx4YXdnQUthQk5MQ0xW?=
 =?utf-8?B?YVIxNFE3NU8xYzljeTRXMlRyQ0sydXJ4N1RBb0Zyd3ArRktrYnNMRGZraXNa?=
 =?utf-8?B?R2NnaGNvSGNJT0Y4dHkrM2hJM2NPZDdvVnhscUxib2pId3NIeFFyL2x1dWZ2?=
 =?utf-8?B?STU0eFoxb3cya2ZITG16SXJpam5qNks5eWVwQVpPWWxDdGRuYUd2SUxHK1Iy?=
 =?utf-8?B?NDJMUW5COEsxVkJvK1l5dlZyQ0ZLVFVoQndLRm1sdTJpZU80WThtODRjMGpn?=
 =?utf-8?B?WFVzdDhJMU1STmk5VDdhaXZUYW8yV2N5c2ViTTUvU3FmMkdFT0lYOThpTlM3?=
 =?utf-8?B?cG9ITmp6alNLOU5YUzVKYUNXSUl6YkZQdkN6eDVWUUxWSWN1MzkxNHNLeTNx?=
 =?utf-8?B?akV5bkFnSzd6VldRbHNFUDVLOExVbzlLQ3dXdmlCQ21yd29WRWQ0VU5UVVh2?=
 =?utf-8?B?cmEzVEJYZTVjb2hrNzFiRXdNY1NINjVIcWhOTUVwTmZ3QWZpNlcwb0diYUtN?=
 =?utf-8?B?ajNNai9sV0ZqdFNjOGFwY1JDU1Vzbjd1M3pHL1pYZG9XSFVIYk5XSklkM0kv?=
 =?utf-8?B?ZjI0K0ovZHVkOCtsQVdwZmc0TXU4SVlKamxFVFh1WTN4VVJ5anhaVWZrY2hP?=
 =?utf-8?B?NnNYanM0NGRCd3NVVHdPVlROcURkUStuK2lyQnBSK2ZMVDEza29vdjA2VXd3?=
 =?utf-8?B?MWdiMnRacVRaZHdpNzY3ZzM0SWVQdXpsWXN6Nm9KWEo1blBXWjBvd04vd0Ra?=
 =?utf-8?B?NmNZRHQ2TGFZQXJSZU9XN3VGM01Ob2RIVW9yQ3dLb0tBOFY5bHNaZUVZTmlk?=
 =?utf-8?B?VEdHRGZRYlJ4cWhDeEhZVG1SZEQ2ZTFiU3IrUXhwVUxlbWdibE05VEc0MGdO?=
 =?utf-8?B?OHEvUGJQclQ2S0liVUNIdnRHMDdNbU4wdFVyRnZlTkRtbm9qWEJLSjdqaWZ2?=
 =?utf-8?B?WldKTmNaWlRXU3NHOEI3bEZEdDRHRXBPY2UxNm54aGpSNlU3R2JhVm1lQUtq?=
 =?utf-8?B?RkI2OFg1QWowVEt2ejN1anRxMzBOOTd0OWhCdkUydFVRMVl2MU80cnlDRkJN?=
 =?utf-8?B?aXZhTnhZOWdXV3FqWG5JbUthUHRjSUpDem9jMjZjaElwaDJZVG9IUkRXZVhi?=
 =?utf-8?B?bzhYL0FNb1daZ3hHTXJTdkVpblhqcDNWOC9GNHJwUGZLVkJJdmhvb2VsWTh5?=
 =?utf-8?B?S1liQlVTZEwzeFRUYVVJbWFTaXEyVkVNeWcvNDVva2pJc01LN0JoVTYwR3FL?=
 =?utf-8?B?c0pjVmRuaUpDbDJhNUpBQ0EwWmxSR0RzWTQza1ZLV21BZ1ZPaEViRWdZRlNu?=
 =?utf-8?B?aFNYM0FJRlJTcHpFcEhTbFNvOU96Wk9hRVZJbDNaUnBDaDg1OTF3ckpubjNr?=
 =?utf-8?B?R1lFcXhsTk0xcE9DQ2FMT21vSGozejZ2MnVDOUtWZUVWU1BiT2pNcnp4ZDY4?=
 =?utf-8?B?VU9ETzBiQ2hMM2hGdGxJdlkxMFlLMTNYOVVJYjRFZFphMmd5eFA4QmVCMVFM?=
 =?utf-8?B?VW4vL1BJZy9jU2Z5aVl4SWRjUkhTd3BwTEtBZmVPZ0VXUnpTQnBvRWpLZCs3?=
 =?utf-8?B?VlhSRXhxeTlIRjNnWDVLdHJKdXlXYlMyOG5IUXF5MXAyQ1AxYVozOGNKMENv?=
 =?utf-8?B?VHR5RUVPcko2MFluQ3M2bUJJZTVDejdKSVRMWndGVFNTelRlR2Z4WFI1bXh3?=
 =?utf-8?B?aDBYTGt6bGp0cHErRG9wQmlUQ24wSGEyaG85Szg5cDUxMFRPTVpGUEpZRGJM?=
 =?utf-8?B?czVIaTRwcXlUbW5DWjRyVkxpdkRpaDJRdEVrM0VJUlAvRGFBUjZmbzdWUkYw?=
 =?utf-8?B?bG1UNHVpZjZMYmxGUExhMytMQlR1STFDcklXeWw2SEhZT3VacVZWaDJHa3Js?=
 =?utf-8?B?Z2xudz09?=
X-Microsoft-Antispam-Message-Info: 8k0AjdiDISHA3lo1nsMYWOotRR9NVmIPPoHAh/Q7ms3aKmq5u16KjI83c20W5ViM4jN3AoBhZxLsJbP2TLn77RDGWNpoCtA5Y9PTKZtpCBaccDWPZ/pzHhrtjKvRYK1x/pa3kSryxfyvctMKxCZLzI0wHb5bys2LUH9QgBkBvBqtjVmfEXIuUMwiWnHbOLcrdh9c2k2bLrKTx2r45jH9f1/5IRHT+avT0qK5mi8zuZFet+MVZqwzqTHh9y5JsDqSFm5aPlY/PmI7c3G2mr225i8CJdwh53iomFLI/GD2hUjX12Cn62x+ngS6gCRYbMS1A1D33OlgFckXJLYBZRLoqQ==
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;6:TdbQdvws+L3Y5+GsDDIWgjoy0kIWin5aF29TX/+cwI3e8ImDZFG/wpt14SIeGlE4dVbU09v5uuLDZ02e0WUbaxhtvV24ULIvHvthyOAwY9cDJjCwAxIWgseqcIPvpTbhCaaM0s6RfnEuefhAweUeZT+PgKPuFgVUu5EHS3mOwbTGjQtZs39rd4aIw7wf+IjyXxzDpNI5AGP6LS29S3GeSkuEQGqpsoPnLwaOAGxrPEY2PXmrHVidxyodfc5DiYRxCGPhdU7d4Pt/63/n96FwVysnU60oHRy1Cv/0Ih8ch2MQJa8aNzRm58pADNK8KMvYGDFuFYZ8IwOQvkZCVf4p9ZDtIL28H3k+txH/yiAq49t5s028wawLb9R5Sht8DYcnjmKLBvCrmOZtkHNY9QGRDVUTdA9bY95Gbv89/ekM+k4tsV9iYFZhbQh/SEoSVuDNYFP0nmQkJh8dWVmSvEY/Zg==;5:H/wCGAcgDm4SnK+9MgTtoeIifDzLbcfFmgHxcXzhjHwZN3SUxD8Zf0X1oJ6sa7xTHgMVc9XFsrQ0sfBsahNMeoEexlJIkSuWhi+5FODd81rXvISA9yAjjTEF1Fiw0410gojPQt4NmWQSAk3PZb9dYe61CZfvMCb4NG0EGC3Q4Qc=;24:+9tV9C7p1xWu7u2/k2/3pVxFiQAMmYtfi4F/vFYBJS7cTsyfI+84LXczWNuaMXfo605o68RozGMJNj3CTItP0qfLf2yXmq/b30CgYdJjOP0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;7:5v/ecSsOKKkb/Q4KkQPCbtY7b0nKeoQb/Y6Wlr7pvwNX5Hopn3NP6G/chKbXjoNToyXo7YBRChrKgNc7GMM+sgUtZWoE6QRiBd9WGzKo9CUcVeKu/XwCwvjHKAa+wPAYcor08OzWP855DMknNRnnyPD1B87Og5Nd+z9lYQAh6pcLXfRD/nnBvvmmeDkIPzD9ZNlvyBa+WWuRrw1AKQbuAROp5P94J+jNc8cm+zW/JvmV9DmkX7moF5MhsMXoJwN1
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 10:09:39.2328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bec505a-01b4-4fd6-f71d-08d5d75f1997
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-21 12:02, Mawanda Henry wrote:
> SPDX license headers makes it easy for developers and machines to know
> the license that is governing that file

This patch appears to be on top of the previously rejected patch. Please
remove that broken patch first so that this patch applies to a clean
tree.

> Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
> ---
>  drivers/i2c/i2c-core-slave.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
> index 883ca836..fd6a405 100644
> --- a/drivers/i2c/i2c-core-slave.c
> +++ b/drivers/i2c/i2c-core-slave.c
> @@ -1,13 +1,9 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Linux I2C core slave support code
>   *
>   * Copyright (C) 2014 by Wolfram Sang <wsa@sang-engineering.com>
>   *

Also, the above empty "*" line should also be removed.

Cheers,
Peter

> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License as published by the Free
> - * Software Foundation; either version 2 of the License, or (at your option)
> - * any later version.
>   */
>  
>  #include <dt-bindings/i2c/i2c.h>
> 


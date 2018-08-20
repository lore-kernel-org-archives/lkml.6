Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07CAC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFCD20C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="YA901yAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFCD20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbeHTNx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:53:58 -0400
Received: from mail-eopbgr20112.outbound.protection.outlook.com ([40.107.2.112]:38393
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbeHTNx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfHHR88Yzj/7EINZR1/T3Ai+L9e7mx/7jO2reBTXDSU=;
 b=YA901yAwajx9BHJvE3Nt850UZ1KKY4bVO96M+0XHfJs7WEpfxbrnfX0kOnaoCyk4B3AkDF94s1C/w7NwlAtHQmHWs/F3CeRzwXo3SU0w9JqWSgSv9d09Dh5pbVcy5Jk8oTWT4aD0KWaVN5e9i0sQfOjgYpanupwywoDbLCaTn8s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 DB6PR0201MB2454.eurprd02.prod.outlook.com (2603:10a6:4:34::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.20; Mon, 20 Aug 2018 10:38:47 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH] mux: adgs1408: use the correct SPDX license identifier
Date:   Mon, 20 Aug 2018 12:38:27 +0200
Message-Id: <20180820103827.24639-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <209EE0F380CD554C95B3E2532952872D29ABC204@NWD2MBX7.ad.analog.com>
References: <209EE0F380CD554C95B3E2532952872D29ABC204@NWD2MBX7.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: PR0P264CA0018.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::30)
 To DB6PR0201MB2454.eurprd02.prod.outlook.com (2603:10a6:4:34::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab506eb9-a005-4bd7-321d-08d606891cc1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2454;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2454;3:cnSUXZ1qh8pJI+GD9HjdFqX+acX1LviqafaRKJw2WJ4vMnAnAyL+MU7L/QChkDnuYmHzMkkowfdac0I/O6+qWK80xSeUPjhqnMIBrqNpoNsJdDRqyArhjEUUEj918/rPeQ0AyXQj/bDdXPyqWmP/Ojalt3a15wwFhMVeV2WlTLlJwiY3JhfjWfTqJfM1jISQi5Ki76BFxdmPc/N7wuVNQyfXljvsYXXTJal4O7cM6yQC95OIHqjIvzEsruYprt+Y;25:8V0vQLMJSyJghoYySFvR2EVqfH0uJf4TdfHgcxYVutSmmBWZPLWOshwfBA2SS0OcazOT4VjaEcOedr4WEdR91EsE7wuc1pMeiGWJBJ7J1Bjaf0CS5M2+g9JlaVAbiuZnNB9eo3WkSJohcQim1+dPt75VoD1O14DrZpC5xjGenC6w1SsUuo4jWzkhsFJbvhumjChdn7f7nnQEXvzb+ERGq1hW1bPj+/IbCvLNRGA+ZmTxCg6yDCubHw3Wnz6kFLFIQ/I4HEms8MeBgC3bfT4pAANsWRLX59zMQbJKGUppnLldfwJHKC8A/lEj69KgNoSMXYInNGObqlMy/6C9HjvSRg==;31:TdaZJq+EhWIrIC7Emrjd17v157Ks3R7alRA2ejZ1FltkLMNGuyBooPXxX54C7qTAoJ97Ey63cVuS4g2B8z7QbCXh1lOEYNMeeEdePtnG4vUpRhJBTqB3DF3MNW1B6KMft08bauL22nMq+hemCm/6Ybk1VMtsdDY5EbyNE1TqbkWlQM5QqQjWQ5NBGgLaf1fGOZieqKPKGoAQn80mMP23/VEnlUDAWPsKwaBpGqlQ8Nk=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2454:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB2454E2E537F26E43855C5E13BC320@DB6PR0201MB2454.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(201708071742011)(7699016);SRVR:DB6PR0201MB2454;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2454;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2454;4:0jfDVru7gFxiAWfyCBWoUopcFuQUqXdcBFedNBRVJQ50nzOCsso1bDlFohCsYqid80Q3023HoavSk13aUAJvAf8Mqm4BlaRMmDZGOg2k7KX2paGiVExJw7iWxKmw1A3LUkzBMA1HrKsc9x83tiHz2oRFNrmZ1dGQQhUjzcJP0kcoAFKwL935xUbvWgq8ccgVrDfKFi8xYQZ9f9/VVJunrS7j3B9usR70SANIPUfBwTzG76mwrAnG+XiaVn1i9IVIvHHPXl9dXN2RC/z7b+VFfw==
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39830400003)(136003)(396003)(189003)(199004)(2616005)(476003)(66066001)(486006)(47776003)(11346002)(446003)(54906003)(74482002)(478600001)(16586007)(86362001)(76176011)(14444005)(316002)(6512007)(956004)(51416003)(6116002)(53936002)(3846002)(16526019)(1857600001)(186003)(26005)(68736007)(52116002)(36756003)(8676002)(81156014)(81166006)(5660300001)(2351001)(2361001)(97736004)(6916009)(6666003)(6486002)(53546011)(1076002)(50226002)(6506007)(305945005)(386003)(25786009)(2906002)(8936002)(4326008)(105586002)(106356001)(48376002)(7736002)(50466002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2454;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0201MB2454;23:3uFxPhd20Jg67mp54lYf23j2f+XNa6OsInM1cX4?=
 =?us-ascii?Q?Wy06TixL2paLU2USU4oeOh9QGLNNXm09jucNUxMmPBVKOTKWR8QHiFhN30lc?=
 =?us-ascii?Q?THGkirRn2HyaoL1PseGjn/ctl24jOLYVmgDARZgMM551hGMftHgDcP58TbwN?=
 =?us-ascii?Q?t6Mkfvr/eMGfZ2504bmFSms6vBvXCQvWJ9llF5uFMkVui9Rlt0fm6gqoiKIS?=
 =?us-ascii?Q?l4BSA11qLrpTGICsCdISMLcTA3Hn8zDVpqKIvVTw/NoqizaLQyin/xVRuju3?=
 =?us-ascii?Q?68TJRqmKRhX5tAoiPfA7CHrWjJ/4yEdzxGXsjXhKe0A0RIpzPqPx6Mu7ymXm?=
 =?us-ascii?Q?CC5U2b1JhOgI0C9mTWRcAy3RpVjI1mKdXVNJpLUhOSZGJsij91nr4/Mx2QBA?=
 =?us-ascii?Q?HaL5jorTPxDC6lsPk3ofZTrtLP6p1l+XVp6wm00ZOrBtQQHSPDrp3tUgq9Ch?=
 =?us-ascii?Q?2lSRkAdehvxZL2UFanFPqxfJ6X8t6ER+POaziJwJwhegfjrU+9RqxMp23KRJ?=
 =?us-ascii?Q?8BzTAjkgJbMEKUzXIF7MBxaaV1CRUC1Dra4CWGxDxmAuAWdr9a0irBK9yyV8?=
 =?us-ascii?Q?8uGX35h2KMbFNZMawS4Y8uhYQQHIFgX44QNdUqeaQiTemw3RqU+bC3G95iDW?=
 =?us-ascii?Q?FdQqnwOv5/ltxtlHoOtDBxc99v6i7tLuuHCElJoz13cgG2EQ3LsWpFdPohzx?=
 =?us-ascii?Q?2FhwCAWOKIDFMSw+CoL//86QcUzduv3h4owpV6A9IE89waR7zqO9ZF+oZVH7?=
 =?us-ascii?Q?dAhXYALSseGUFqsqbVVfAVC0ux/h/swxhlDaSCjTwXEqwnPa2yXzrmL4cYNH?=
 =?us-ascii?Q?FzIJwmmxdrYfdyKpzLs3IvB5AYe/ieUR71lYxXYJO52UegUwgPO1+Twfoy8P?=
 =?us-ascii?Q?BomXyhNHst+Ed19kzzXOVgWz+mhvMU8eJfqAxhFumFqb5V6vYMQjSF90IYsp?=
 =?us-ascii?Q?gtwROHBg7TF+OF9NxU3aoWghGl6/dfD34kyGNhFnRiFX9SBnpV3ChQqK9mHx?=
 =?us-ascii?Q?RjtCIMX25VUbm/wuzifw7ekXtDUZwwua8Ew59axOxqvmaqHbqH3ErePs1vQS?=
 =?us-ascii?Q?2sr5jfcP5AO2ybl0igrPgFKmBrEmqFhh4JglQaMg0ui6NDVJzqlUhkWXgQIy?=
 =?us-ascii?Q?JZkrnUoiP0LgCAoLqQaQYMCo2AriWcQhK5prOomOzdpV6yfG0rPAygfmDdRA?=
 =?us-ascii?Q?5Y1Kdrw8SGB+H6YVJYuzaMx6eTenWzgOuvtQhMcUG1ZZbajk56fA29pv2FN5?=
 =?us-ascii?Q?DDEmIhnVKfpdZ60tyM/cCRW4Mjfq+aNhnnYzZHZOJY46HtJy3HKR2zlXiPVo?=
 =?us-ascii?Q?2p3ypaa/o1RONqavUg8ST2+8uToORvIYWd2cHlzfVhWzfeZ4Bl3tIo6ij2UX?=
 =?us-ascii?Q?N7VwJqw=3D=3D?=
X-Microsoft-Antispam-Message-Info: a5jnSYKRxgrYr1AWwppRDI2IpeEzaZ8V7tL6QSCMyHJMVnl88+AYY7uLYO56LsrOhwwFB0uIYEbTtKNCXba9z8Ti+8BuOYrc7ifMoLe9a4iLBttJ9xtWzz3XsU2RCLfgLCts8DofQnrKnQuRlZm/KFW68U+7PMUEb7CRsHZv5yE5R4bZXjoAEmPixKcBh01qXEapWcaWW74PpukMar5O7N+3WT7/2ZfrpcPPi90GwTdLd+hTjSpyQRy1cWP9VXPAefq8Wdh1+w/N9wdonGFdqr/FcVPhtboAkBI36yvtykqlNF6eb9TOhLiy0I4+iRMrl/wkoR8S+FEmhctmsEd+3OIcSVhYwIthQw5I5koKmeM=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2454;6:46uiGPURrHNrdC2qFMstFL7/3IOvIWMUhkzXyKSeV23dAFzkpfTGmp0c+6teSHyJVvmEOs/QQab0ZbXkrx8KJjBMqIAM34LnxFlJJf3Ny1UQwSiy6YswjiodnXXhznG/GdjfQSGhEiA7SsBG+69tY8cnlFKAF4T/J4lapF63I738MYkd478BpGwtL9BOaqEppWXuDTb9HQD+9TV6b4qLZoAaTsyX6OfV2fPW/1j3JXs5Xti1HF2Ht13C3PkBG4ounVepd0JXRc9slohvjm1pER4BGv6wCvufvr3j0M8AdaZMAM6hyg1qYb76w67b4PzqFOufgVPkV/ieZ9fR8libRn6HvI18qLURiNHxW0kKbOlynihqKDZt5aiPfNZhx96s5JNmN66DvvNtH13Vjc2M1FSqTQixPT1rIcite15tOzOpQ3buwHI321Jua+1PETB657cdZhBLcrpK1LWapq1kUA==;5:gKrRu4PfQcKxK8G1wQ1N++rqkwWr+P8qZUCSvZ1s2/6MbJN2iYon6wLETlYSsbwbBuHA+96MKNykKuA1Vu7yS5U6YAA7S47gBFd/7p3DBDzPTfIV4WN6GQm7LOT+TFf1CvObhTKaXXkg6Xl6xUSLjkLgoc3QrUhyXUFsoRaAfk0=;7:mauFhhx/GA0TOzMl/5pOa5rLkZOfd57OHVHJS4r3nBbmxYZXAgezirmyxqf6Ie6lG7SZ18UXbM1Ce0e0YZD7tbGhPw/kCT3f9V1RPdQQ6sescrL9D3P62DlnO3842a+j4K7bhtLr4JXRZuqJss1QXxI16EV/G18bsygtrFvArCBHBFtyxqx887y40gbRlJV+rdyTNvj4uPGvYa6VDtjKN49+gqQKfyplF96JK7pquUoNLN7Nzg1txHQoaeVPjYvS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 10:38:47.9400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab506eb9-a005-4bd7-321d-08d606891cc1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file is GPL v2 only.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/adgs1408.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

On 2018-08-20 12:16, Caprioru, Mircea wrote:
> Peter Rosin wrote:
>> I just noticed a discrepancy in the license annotations in your
>> driver. The SPDX license identifier says GPL-2.0-or-later, and
>> I assume that is correct and that MODULE_LICENSE("GPL") without
>> the v2 specifier, as in this patch, is the correct thing to do?
>
> The file should be v2. It might of slipped from the final version.

Ok, so I read that as if it should be v2 *only* and not v2-or-later.
I.e. the reverse of the original patch. But since these things can
be sensitive, I'd like confirmation that this new patch is what is
correct...

Note that MODULE_LICENSE("GPL") means GPL v2 *or later* (GPL v1 is
not on the table), while MODULE_LICENSE("GPL v2") means GPL v2 *only*.
See include/linux/module.h for details.

Cheers,
Peter

diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c
index 0f7cf54e3234..fe0377bb83eb 100644
--- a/drivers/mux/adgs1408.c
+++ b/drivers/mux/adgs1408.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ADGS1408/ADGS1409 SPI MUX driver
  *
-- 
2.11.0


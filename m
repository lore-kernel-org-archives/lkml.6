Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4298C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F04521534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="YiB5a2i9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F04521534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeHTNdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:33:20 -0400
Received: from mail-eopbgr00101.outbound.protection.outlook.com ([40.107.0.101]:17408
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeHTNdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GRPdsz7NIv274OBie6d2wse+i47QwnyBeg7SkesBPs=;
 b=YiB5a2i94nO6HKsihK9fKTaK119FYK/NzDvJIsuCkHPOx7lTn1iYRVyuuj1ILkPMq4bnvcYPZdmCIxNVWi3b7rs4EaSooApF0PrWPNWlFgltJP9H5NcJHwkmNyO8+SvxsQn5DhsYVeyaMAzwTF5yrUBxGDRC4iffzScY2HCvXUE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 DB6PR0201MB2453.eurprd02.prod.outlook.com (2603:10a6:4:34::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Mon, 20 Aug 2018 10:14:21 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ASoC: atmel: tse850: switch to SPDX license identifier
Date:   Mon, 20 Aug 2018 12:14:09 +0200
Message-Id: <20180820101409.23328-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0312.eurprd05.prod.outlook.com
 (2603:10a6:7:93::43) To DB6PR0201MB2453.eurprd02.prod.outlook.com
 (2603:10a6:4:34::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3c273b0-76e5-44f6-f643-08d60685b2cb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2453;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2453;3:JiCu45EF0BI9PeHQby9kvuA7Rd04b4ZzEXP1q2NRVKq56pZY6qA0nbe07TFi9Mb2tCIUpC8CNEybTjFO8zmB1xOuqb+hRE+RuOX+FXOvW5+IUG/XhvWBu0KP0g56C8U+K2guoxA7rh6/swpGJF4BCkhuw/p9XSA0Hrk48jPgQ35uZtozPiwhWAKsUAwf8xWz96t5LxJRyn9z+WxjryOmxVxkP4/8XTxp9UiqwJKN/tVXJIGNmF47jRZILOaKrc6e;25:4NItmsIWVOCiNP+AEQh1qVeRl/ql5cFyOENYsoIvvfsqEogYZSAbnyPhvPU4IRABMs96osi1OlbTjf8fbHzprdYCOsLLd/BHd6NauYt+sWO6tYPYeLm9oyzreoVo30lGTb85939rtVnVDnzqlSDrR0r7lmgD6nXh66XvETATF4MRUuPLy7kUn/cMt26i2uZ0wsgIZzy4aevmGjsC5scMjvnEZrwnKcAI40nQX7kDy1MYJG+y4DM7q/OI9BvybzbDfyQQ62F4Q/IHy+oeAMxbkd41TFPLo8fc8P+10hzqEtqEEuGj5lFNRJzK8ztrm/s/tB9/Q3s2FD62QLwJ+hAaTw==;31:vqtcNpR/kxc0yt6R6ryIymZ19NTQURQsP8sqAoJ47ASdZTnxBUY5QbhdRcI6OSvmItVwTyeTLUwiVfF55nhNulMQbeyTC5lFs/tAJ0og/9dyse3qOQkN23w1qIjG8KleBOtMP1QZRyd6jro8BqfYZzy/sVKUaBApgU5iQskANYupRuiCXubzIxIQRdVKjupDFX4K8uVjG7hGngstoIh8210Qmd2gdJj579nO1p9/dPc=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2453:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB2453B665CC3FFD649EEA12A0BC320@DB6PR0201MB2453.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699016);SRVR:DB6PR0201MB2453;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2453;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2453;4:uVOzWD+SqwHtMuWwgldNvM9QhaR0yCw6wnsxa6Ib1mSfpfjGtzj1Zua3e1ViGz7jAE+Y1tx9AkWE/JqHNKKMxy+ujHo8tkPD/gJ9GsSp6HRgF1GkmQSOPm2B3pzAbMuuSkTQqoJla+J8CgmcDVBBTwCu4gDgbGLEmHbDOVLnq3vqFr2iwlM4zuLRUfeFHqBL5DtBqZYUtwCVmNhq4Hfw7e0ZfKg8PAR4ULerQ80hxxNNLcSDnPh1DHAC+odvfeOCtI+ZjoVFz7iEZD8OmHzSdQ==
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(366004)(376002)(346002)(396003)(199004)(189003)(97736004)(305945005)(36756003)(7736002)(8676002)(81156014)(81166006)(2906002)(2361001)(478600001)(74482002)(66066001)(105586002)(106356001)(47776003)(2351001)(5660300001)(6512007)(3846002)(1076002)(86362001)(6116002)(1857600001)(186003)(16526019)(48376002)(956004)(486006)(53936002)(50466002)(2616005)(476003)(51416003)(6666003)(52116002)(26005)(25786009)(386003)(16586007)(50226002)(316002)(4326008)(39060400002)(68736007)(8936002)(54906003)(6486002)(6916009)(6506007)(2004002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2453;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0201MB2453;23:+0xa1yyLJXP4KHjtuv4QmLTCI910r3/nZASO/gs?=
 =?us-ascii?Q?wH9nOBl87uvKox+dcCtu7aRiIAaqadN20U7pzHXk3hKDodi6hVzorK3lauim?=
 =?us-ascii?Q?g4/QnpxzgyWYbfm4+4bi6EbpBWbmYf3NnD4Cn37tSJZF6B4H3QprAL6NXU/g?=
 =?us-ascii?Q?iYtQdrX51dFsOBH/BLAbkCv28hYT+0cvlGX1TxiT492g/eJsmqJdjae2tWcX?=
 =?us-ascii?Q?YixPe3TvETVkXkOWNpHM8VsPgCSEKQ1Oem5aEoArC+XxlsYWNbAJ2Fe3PsPF?=
 =?us-ascii?Q?4k1KSjXRE0bIRIw0QofktOza46v8JlFypv3NIUmPP887kvyz9m32sc/h2Gd/?=
 =?us-ascii?Q?2Ddgp99YJA9r5gsf4ibMQu7J+JUm+sR54+++X7fUr+WMEmlWZ58vqGmiJ7fo?=
 =?us-ascii?Q?idHRDWjX3as0fdWDxrTm39xAjRvz53qV1cyS2WU/Z4wXN/okvoUNOvbnmgrR?=
 =?us-ascii?Q?QI5a4qVGM/QgxNEi2tyrhW5sqNEkmCcx2cxDcV/PrwOPHrvUQiwxy3vXtAOf?=
 =?us-ascii?Q?Ld6PhWjXrYQkhP+dpzVBDxRK79cX/3hTIsjBuotgdIsPSp/EH0pemr16uMVV?=
 =?us-ascii?Q?eXbp5Cw+n+QaD0IWNcatTD/o9neI+74G7hLnp5sHaACn4t9I6iP091enf2ws?=
 =?us-ascii?Q?SmTUy0TVjdFBD8kXUkCjSNeHSfByT16DLHhw2rI6tk1MahK4KC+qjfHgWIu2?=
 =?us-ascii?Q?q98NHfFOoj+47brsq/V5MozWDnFlcF6rySS8Jxv6EGf/oJBRonZMlzaZbeNy?=
 =?us-ascii?Q?jdeXYaB0BaIvUSMYiQzRcmF16iLUzXmpwvM5s5leeaobtFichP/FtAwntPM2?=
 =?us-ascii?Q?PArbTGSSMYBSRx1iRu/gu7OGlR5BxDLGAIo+LImbTSthvJ2eGaeo83mdZ71Z?=
 =?us-ascii?Q?N9NPaPDlbzRHnQ4kRRlC/ORPIKSWOpy+6Nah/rxwjVBJWgl0uahj2TKv7V7p?=
 =?us-ascii?Q?KJWl5EWy9LCrHGxaxKjHjr74zR2/EYE4QOLtyzRUdzm56JhJ9cE9m7ZoqnAx?=
 =?us-ascii?Q?Qs3BOUthdfQyBq2klOelv/DsDU0uWFmI+8tvmTeUWjtkr5YgEKtDUkNi8Bcb?=
 =?us-ascii?Q?lqEosLkgzMxp8ifSY4Zr6LSTVN9dtwyZkbEb5IDJy7ECBFWaXUVv+qaXegKa?=
 =?us-ascii?Q?DrxMK9YWTdy/VrD7JoGgw/WzoT3827w2dVph2Qbn3JZXtmk7tTdIQCgVMkOS?=
 =?us-ascii?Q?oaBkuSQUy7lygxveePocxFFrGRMnMZfYJP4989niuY7F6iNqN1a8BkO9++UF?=
 =?us-ascii?Q?CG1K7c/lEzaBJ9b0IC6T1TgkWgy/jlfoV9qIwzIkYFHqEq8Cco49cxcPr87T?=
 =?us-ascii?Q?Ajw=3D=3D?=
X-Microsoft-Antispam-Message-Info: H3VRPzcMA9w7fumvGCQQ86n/s6SFo+RYoCAABf6Ykw10WQDTAoFnaTkTVXiSX7sCtlN/wxHBzCK9Ia8jyp6t2mCcy9lScqMaQDFjhULuwujlNetIK84Ch2B+Yi42y9jC7sEw42BMb6vrdZoXVUr6ItI8W9AMkePrddQrygaH6ZSs9y14ZKylb1QxD2OapDiWcz6whs8kLJmth4Dgh05uBMTq0W94Mzt7LvtZyQT3sOv4EVnzFQt3DKAMAv618NmuLo9bECmiA3D2lvDNwYlulEmCqCjjS9XHAsCLkD5OVYHiDsoBw4krsPF2Cr8CQNtW+LiXAyrSRAnX0MxsE4/IRRHxjyrDbC6eejeijKQresE=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2453;6:57CbapFY8ozl1kNP0VssXWfpsOjEG4YvBmkbBzGRMFjzgAqU96oyXlO3VdF2uvduafJGRq0zil6fcu3JxhRx7QkNDJOipcMLl28oacDbv2rAdlEjNNQ5Z/ToYlQN/TR+TH9w2ni6kWrHwVsg7m/ZuEu1qvFTpGCnB2fep58GxeEmiU5bgvQuBMuw16X84NSK1mhqFIov0C3nxwgpZfppsJnoAnf5FF6gKwuGWQCdYUxZ8u8668MyMLpA4xwyE8tWUfMVOaaa+Zu4n9ZVYyh29FKcsV47W8fwjbgRD2VUobpEFP1da4s+Cdv0gqhMurjlTswCQrbZkAAdAjau1Q8kyXKCRa2zED9lamQbW/S7hbFap2sKOK3ttgey3Wl9TAoeKk43NGA73SmjQejmUJ24mrfHaPmLr+rhE1JQpPB5PiBpqjLergLxSzp6lRIiuO1g+BmuNRVtC0sg018EAkG6QA==;5:Q6rtUTunMxoZY4xL3iI5yTBBI8FMcR2OrL0Dwuxa0JtQy6/Q4jqfJvJyL2jGbx1ipuef7Zf62mlX0t+eS5aEnr7iUiCdeF1jHtBQqgspvQdyAM0R2CA/MUKNc1QavBL2CR8LgGKZ0PRMshBN1hhzvbYMh30Ckp9XfP5MkxcDoQA=;7:oMTXr+VN1fphzOkaEsuvDScGB6uj+oeYI/xIrNLpFqsoYrpcN2Ve2STQhLd4ORC29vHtd14ZXXzwix0Ev2DHluPNOfRX87Bk0P7JJmd5HSwxRnr5P0lIay0gvQ1wf4rZkMZF7DgPpX3g/u6+PzSETDSGwchn4XK+riHwNEmnAT53LAR9FbGLhAf/hGcOjO5h4R+LELnMyIud4oloGPbA0+eRfje/K/gqLXGmcUv8JSVSux/7Msdo5/NFcqcfbL9l
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 10:14:21.0784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c273b0-76e5-44f6-f643-08d60685b2cb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to // comments in the leading comment, drop the boilerplate
license text and use the correct MODULE_LICENSE.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/atmel/tse850-pcm5142.c | 78 +++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/sound/soc/atmel/tse850-pcm5142.c b/sound/soc/atmel/tse850-pcm5142.c
index 3a1393283156..214adcad5419 100644
--- a/sound/soc/atmel/tse850-pcm5142.c
+++ b/sound/soc/atmel/tse850-pcm5142.c
@@ -1,44 +1,38 @@
-/*
- * TSE-850 audio - ASoC driver for the Axentia TSE-850 with a PCM5142 codec
- *
- * Copyright (C) 2016 Axentia Technologies AB
- *
- * Author: Peter Rosin <peda@axentia.se>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-/*
- *               loop1 relays
- *   IN1 +---o  +------------+  o---+ OUT1
- *            \                /
- *             +              +
- *             |   /          |
- *             +--o  +--.     |
- *             |  add   |     |
- *             |        V     |
- *             |      .---.   |
- *   DAC +----------->|Sum|---+
- *             |      '---'   |
- *             |              |
- *             +              +
- *
- *   IN2 +---o--+------------+--o---+ OUT2
- *               loop2 relays
- *
- * The 'loop1' gpio pin controlls two relays, which are either in loop
- * position, meaning that input and output are directly connected, or
- * they are in mixer position, meaning that the signal is passed through
- * the 'Sum' mixer. Similarly for 'loop2'.
- *
- * In the above, the 'loop1' relays are inactive, thus feeding IN1 to the
- * mixer (if 'add' is active) and feeding the mixer output to OUT1. The
- * 'loop2' relays are active, short-cutting the TSE-850 from channel 2.
- * IN1, IN2, OUT1 and OUT2 are TSE-850 connectors and DAC is the PCB name
- * of the (filtered) output from the PCM5142 codec.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// TSE-850 audio - ASoC driver for the Axentia TSE-850 with a PCM5142 codec
+//
+// Copyright (C) 2016 Axentia Technologies AB
+//
+// Author: Peter Rosin <peda@axentia.se>
+//
+//               loop1 relays
+//   IN1 +---o  +------------+  o---+ OUT1
+//            \                /
+//             +              +
+//             |   /          |
+//             +--o  +--.     |
+//             |  add   |     |
+//             |        V     |
+//             |      .---.   |
+//   DAC +----------->|Sum|---+
+//             |      '---'   |
+//             |              |
+//             +              +
+//
+//   IN2 +---o--+------------+--o---+ OUT2
+//               loop2 relays
+//
+// The 'loop1' gpio pin controlls two relays, which are either in loop
+// position, meaning that input and output are directly connected, or
+// they are in mixer position, meaning that the signal is passed through
+// the 'Sum' mixer. Similarly for 'loop2'.
+//
+// In the above, the 'loop1' relays are inactive, thus feeding IN1 to the
+// mixer (if 'add' is active) and feeding the mixer output to OUT1. The
+// 'loop2' relays are active, short-cutting the TSE-850 from channel 2.
+// IN1, IN2, OUT1 and OUT2 are TSE-850 connectors and DAC is the PCB name
+// of the (filtered) output from the PCM5142 codec.
 
 #include <linux/clk.h>
 #include <linux/gpio.h>
@@ -452,4 +446,4 @@ module_platform_driver(tse850_driver);
 /* Module information */
 MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
 MODULE_DESCRIPTION("ALSA SoC driver for TSE-850 with PCM5142 codec");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0


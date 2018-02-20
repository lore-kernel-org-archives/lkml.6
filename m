Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752744AbeBTPzs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:55:48 -0500
Received: from mail-sn1nam01on0058.outbound.protection.outlook.com ([104.47.32.58]:3536
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751921AbeBTPzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:55:46 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Daniel Baluta <daniel.baluta@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <linux-kernel@vger.kernel.org>, <shengjiu.wang@nxp.com>,
        <daniel.baluta@nxp.com>, <mihai.serban@gmail.com>,
        <cosmin.samoila@nxp.com>, <linux-imx@nxp.com>
Subject: [PATCH] ASoC: codecs: ak5558: Fix style for SPDX identifier
Date: Tue, 20 Feb 2018 14:53:10 +0200
Message-ID: <1519131190-15046-1-git-send-email-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131636157429192788;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(39380400002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(2906002)(8676002)(68736007)(47776003)(16586007)(104016004)(48376002)(81166006)(81156014)(50466002)(5660300001)(106466001)(305945005)(8936002)(356003)(105606002)(6666003)(498600001)(54906003)(86362001)(110136005)(85426001)(336011)(26826003)(26005)(1857600001)(97736004)(4326008)(50226002)(316002)(36756003)(51416003)(53936002)(956003)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB472;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD029;1:qDUbgAdNMRWL4g3ArFaynXPhgK+e4dENAjP6uA6Nw978/W5ZJMcYKUF6BjlnHbayn4a8D/LhTrfCNUvOBOfPMFCy1S3ORH4zqfle5Edt7H/7pQCD45eh/Q9cHymT8f8b
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da849747-b806-4d96-b6f3-08d5787a659e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BLUPR03MB472;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB472;3:qdWZwR16Ebr8qQOqkeqi9LZ/DHzOzGm7Yvqs0hBQe1eAA1PhLeAatmtlOZA1EXgNhPSFZePj7JJfRFzo+ssnJ8ZAQngLo2STH6FQ9FIVHxGFOknGluSOHG/TnexJtH0vUK062PQllf6oUEgJFWMMbOuMzPYuscHo/PEOZ+fcir35szWdieQ46TsIM6gxLzi/NyD+kHEtfHiL6VY+st4jz+99b9vDltSrdikYPsaJTmiCh8eo2830SSqG3g9JipfPwnCgA6oIRiDQ7PJf11FdfdPSy9k0tw+xHZZgzx6i7/vTvzsD8feWKxKv6aLCldzXdBAETHCy7sGa2PqA0XvGiEg+LpLU0fW0sIp/BUVr6NI=;25:Gz/VgX0AbxHhpuG98CaqSMpLa37pqQldBcBn2y+9S7ymCMNFLQ01kq/jiAJ0XK3a+TBXr0uGq+rho+e6PTcODCMAy4w2RqSCxfYXqnWvvQ5nMUAnCQ1VtbS7ZOtWn2dazGcMdck5exvECmY7qQ0EAp+ITd88IN4BvIvEUVCfU9oWQrjHidhfP7GM3WJk446whqvKj4PbgjiM0zPzJIwOV7N00DUpJPrN15S0IG6WtFnUc6UWctDH9TOS8I0wuciX//SzUVlHP6uNuy4VLHMWo2Q7nBpxBKVFFKpm0YzAMPW7a7nupHfYJNqYFxUaALM+YvPYCN6T5MeUp4yqojRC7g==
X-MS-TrafficTypeDiagnostic: BLUPR03MB472:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB472;31:8YzfmtMqJu52sn+sTVGGYsNF8eglI0kZmPKL8N4RvG587wEOX5ggG+vicfDbGQjYjDfU7cClq877WprbJkpazKX/EbiOanBQMhRKs3IDhMBEBwSybz91oOfDb+xKjD5CQ777+FGzxnUfinpnga/HYOpesPMvy4Au9BOcdBQi0oGIa5eB6SEOl9/ji2mCPCEqTaOq9C32MATuvSefBEcShDRopl5yEbYumPlPXE2HymI=;4:78BdF2V/pCOGiqg71AT9pdUtgUkXCGzB2OYIFQI5gueiFJlXhJwRN+A7DxEGL7/wnKbzVUp8V5mXTor90sneg7YcZ17IT+IKY9/CM6XOyZZvuGj6ffKIo+IiMTHDsBsGyDMU5+mde58SR5Krmd9uodNc0nBWlMToxOc2mRh25AsBDeJROKL0Bs7JbEp95Fj5MBaAVA5Rd2i0JQmXc0b9SvVg0pgtUsZI8VwzfE5b5QnaG7u+dSzKxQ9jxVnD5zOox5r6eMoJncUPBwr7FAg2CzbgAT026SZDruQsn/XrTglTpbXHEJqCfoDJ7emPitHA
X-Microsoft-Antispam-PRVS: <BLUPR03MB4722B57C2C4A9656FB896C7F9CF0@BLUPR03MB472.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(10201501046)(3231101)(944501161)(3002001)(93006095)(93001095)(6055026)(6096035)(20161123565025)(20161123563025)(20161123556025)(20161123561025)(20161123559100)(201703131430075)(201703131433075)(201703131448075)(201703151042153)(201708071742011);SRVR:BLUPR03MB472;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR03MB472;
X-Forefront-PRVS: 05891FB07F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB472;23:txa3lewkiyDv3CSf3xfbQ793J1Ad8oTgsYkV6l+pYP?=
 =?us-ascii?Q?6WRcvGXrDvhgpNhyMiPdYQPPbbO0o4bxHHimY4Fo9oKnyv0BWbBWjt0HgXyc?=
 =?us-ascii?Q?ncvEf9YNNJjjPICfgggtb4nfbye7jHuAmTticNKIOOixmBIBdYmAyJevwDrs?=
 =?us-ascii?Q?vm7TyEWjPdZ8yBWYIx0XlLNUpdp4qG2AA6bC3nYaMQ4L1NbTpj6b+uEFjNq2?=
 =?us-ascii?Q?D/QTAOtxnhq6lDJOE++OsLkMAf3qSbTzHNplAjRojbs99QlouoPi0FKkWMsq?=
 =?us-ascii?Q?s3OqKInduW1UVg6QAt+PIO4V4lfOxujlzgNYxx77+ool8I5yUjmw/lxHC8Zx?=
 =?us-ascii?Q?63/v0sHWwg11khm15WaIp6irqvNj34MApjc3Ts1CQKb6uyNppXqq3xzPrMSk?=
 =?us-ascii?Q?rv1ShvLiMLJn6DG/5iD8YAAeBsROymZ6OnaMNE9yX+X7nQRtJGQMXQ9vC9jU?=
 =?us-ascii?Q?uvJ23OxYipgoiegmmAArCTPdvyIvqqq6o82qecNrpoS1Oy3qrvlvskFqtqjR?=
 =?us-ascii?Q?65YfdrbbImHL2YZQ0k0RiZmYgEWD/v/nUuANpKr5Xxf6lro1LkWuKQVzkd2/?=
 =?us-ascii?Q?X+eTFIngq2eVhThyumLvSJJLm0Dsghi0bLMFOBsl/YjKsfteZQV1NE3ybgKb?=
 =?us-ascii?Q?Clp7ugoCrShebniVnNSYpjo0i1ed83STui2oQdpmzE/iGltOIIjUIAJdN08J?=
 =?us-ascii?Q?f1loDYPH0r70mSQYfMrzHs1fuaTqwO/FIQUxhERbakEXGVl4lYEzrubpHoQ2?=
 =?us-ascii?Q?HuYu3+v8Td9vNE3cOxX8qhayiB5TuxPZCpjzZgv2ff2zOaaHOBXtQp5NNfKC?=
 =?us-ascii?Q?bqk9XU/Ues8k/4sNr1smHrORYjGw/ZSQ9jSgWygolZCYx9/52DQMFYowGdOi?=
 =?us-ascii?Q?y2E+sf5Pz82AjqVkUSgwmE5KvXrp1gmJJQpBbw2ZhW+o5GikG8cwz5opgcGj?=
 =?us-ascii?Q?uAJVzPDOTKScu7uuFrXj7xaiNK5NXDAsBnHnME0lcqs0H06ISalloCN7smz6?=
 =?us-ascii?Q?PNlJarc//D4YXFXCED1DmlIw2qdTNT65zMy4rcyy1zO0RNfhJB908vY8wuwB?=
 =?us-ascii?Q?n+5E96Zsm74hoANLbGJIhSe9XD?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB472;6:DSpzbTokVJ/eZIwD0cHlfcF6EJW+LxnTLKyaQdvoBOPZekgLCUfEaiIUkEGaErqXWY2GN7os/mkpa9TlQ5SrmOCDAGG38m7cAVrOQZiXTFAjUJxhRx0ZIi8b82AM+UVgc51dK2TFns8fG9tsNtHDvd4x/lEviPpdtA6+NCavCkOVF54Q7ZY7ZYSZKxdAKkTzu1pukTPatwTMS7yQdCMhk6zOY0MLpoEatypnniSl9CCipKYDzajoUW2+9W3eAb0AhNnklk2HOyZME8P1zYZkn1Xc7qlUK1YVH5MMoFvOfykzI5nrdI0MCDojcXhRBdydkAk3KhIrjXog6BAwcOuWJpgZbkoB/eNMrrORZikavv0=;5:bIQGWvqFMi4fjNu3CEPoBjab3EjqRbKPPZbvGAYoxo6UH48V2NiC9i/1U/VF39GDxWHv9U8OdFWUoMrkhcvJs8w/8eBzurJcHYNQvNr9lRNb5Mk06Meizz+15o2IgDM1H9J4EDA29GN00RDkEvnv0aEggmnJmjjbUKTmpSp8va0=;24:6sAIPukuulNmqo9hbYBfU6AK3YJ2cBaEMDjDiq7qJSz5CYD2Vn+nJDiSe+2yqY/LtymRGthnFzjB9dDvBJMY9Vjpspwm5kRxczN5deXVd08=;7:6onxzYAvdvyAKN3RZgAS6+t5gagKc0rYM6RuDAl9c+y62PaVJySMJDsRSgfqfIwdgPWsW/MIc0oJFcepOAUNjHyADYkMalqs/VXnic6SEfOewxuvw0kvlXt7vxM4EAhIlId/rYQW1gU9peAlpyDQQ5EIq7/MpQnglv86XtuXyWZBZTkPpxmSMiroabr7ZIja6bo+9jVeK8USrhPSdje2PQYy7/aER3tF9xw+AkEzlst4X7LVqXPbyEgNKApPhNMA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 15:55:42.6384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da849747-b806-4d96-b6f3-08d5787a659e
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB472
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use // for .c and /* for .h files according to:
Documentation/process/license-rules.rst file.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/codecs/ak5558.c | 11 +++++------
 sound/soc/codecs/ak5558.h |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index f224831..f4ed5cc 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -1,10 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Audio driver for AK5558 ADC
- *
- * Copyright (C) 2015 Asahi Kasei Microdevices Corporation
- * Copyright 2018 NXP
- */
+//
+// Audio driver for AK5558 ADC
+//
+// Copyright (C) 2015 Asahi Kasei Microdevices Corporation
+// Copyright 2018 NXP
 
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
diff --git a/sound/soc/codecs/ak5558.h b/sound/soc/codecs/ak5558.h
index 7c9e373..6105908 100644
--- a/sound/soc/codecs/ak5558.h
+++ b/sound/soc/codecs/ak5558.h
@@ -1,5 +1,5 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Audio driver header for AK5558
  *
  * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
-- 
2.7.4
